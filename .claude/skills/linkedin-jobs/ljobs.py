#!/usr/bin/env python3
"""LinkedIn 공개(guest) 채용 검색 — 로그인 없이 공고를 긁어 추린다.

	search  키워드/지역/기간/근무형태로 공고 목록 (페이징)
	detail  공고 ID 로 본문 전문
	rank    검색 결과를 키워드 가중치로 정렬

출력은 TSV(기본) 또는 --json. 제출은 브라우저가 하고, 이 도구는 후보를 좁힌다.
"""
import argparse
import html
import json
import re
import sys
import time
import urllib.parse
import urllib.request

UA = ("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
SEARCH = "https://www.linkedin.com/jobs-guest/jobs/api/seeMoreJobPostings/search"
POSTING = "https://www.linkedin.com/jobs-guest/jobs/api/jobPosting/"

TPR = {"24h": "r86400", "week": "r604800", "month": "r2592000", "any": ""}
WT = {"onsite": "1", "remote": "2", "hybrid": "3"}
EXP = {"internship": "1", "entry": "2", "associate": "3",
       "mid-senior": "4", "director": "5", "executive": "6"}
JT = {"full-time": "F", "part-time": "P", "contract": "C",
      "temporary": "T", "internship": "I", "volunteer": "V"}


def fetch(url, tries=3):
	req = urllib.request.Request(url, headers={
		"User-Agent": UA,
		"Accept": "text/html,application/xhtml+xml",
		"Accept-Language": "en-US,en;q=0.9,ko;q=0.8",
	})
	for n in range(tries):
		try:
			with urllib.request.urlopen(req, timeout=25) as r:
				return r.read().decode("utf-8", "replace")
		except Exception as e:
			if n == tries - 1:
				print(f"# fetch failed: {url} -> {e}", file=sys.stderr)
				return ""
			time.sleep(1.5 * (n + 1))
	return ""


def txt(s):
	return html.unescape(re.sub(r"<[^>]+>", " ", s or "")).strip()


def one(pat, blob, flags=re.S):
	m = re.search(pat, blob, flags)
	return txt(m.group(1)) if m else ""


def parse_cards(page):
	out = []
	for blob in re.split(r'<li>\s*(?=<div class="base-card)', page)[1:]:
		link = one(r'href="([^"]+/jobs/view/[^"?]+)', blob)
		jid = ""
		m = re.search(r"-(\d{6,})(?:\?|$)", link)
		if m:
			jid = m.group(1)
		if not jid:
			jid = one(r'data-entity-urn="urn:li:jobPosting:(\d+)"', blob)
		title = one(r'class="base-search-card__title">(.*?)</h3>', blob)
		if not title:
			continue
		out.append({
			"id": jid,
			"title": re.sub(r"\s+", " ", title),
			"company": re.sub(r"\s+", " ", one(
				r'class="base-search-card__subtitle">(.*?)</h4>', blob)),
			"location": re.sub(r"\s+", " ", one(
				r'class="job-search-card__location">(.*?)</span>', blob)),
			"posted": one(r'datetime="([^"]+)"', blob),
			"url": html.unescape(link).split("?")[0],
		})
	return out


def build_url(a, start):
	q = {"keywords": a.keywords, "start": str(start)}
	if a.location:
		q["location"] = a.location
	if a.geo_id:
		q["geoId"] = a.geo_id
	if TPR.get(a.posted):
		q["f_TPR"] = TPR[a.posted]
	if a.workplace:
		q["f_WT"] = ",".join(WT[w] for w in a.workplace)
	if a.experience:
		q["f_E"] = ",".join(EXP[e] for e in a.experience)
	if a.job_type:
		q["f_JT"] = ",".join(JT[j] for j in a.job_type)
	if a.easy_apply:
		q["f_AL"] = "true"
	if a.sort == "recent":
		q["sortBy"] = "DD"
	return SEARCH + "?" + urllib.parse.urlencode(q)


def cmd_search(a):
	seen, rows = set(), []
	for start in range(0, a.limit, 10):
		page = fetch(build_url(a, start))
		cards = parse_cards(page)
		if not cards:
			break
		for c in cards:
			key = c["id"] or c["url"]
			if key in seen:
				continue
			seen.add(key)
			rows.append(c)
		if len(cards) < 10:
			break
		time.sleep(a.delay)
	rows = rows[:a.limit]
	if a.detail:
		for r in rows:
			r["description"] = get_detail(r["id"])[:a.max_chars]
			time.sleep(a.delay)
	emit(rows, a)


def get_detail(jid):
	if not jid:
		return ""
	page = fetch(POSTING + jid)
	m = re.search(r'class="(?:show-more-less-html__markup|description__text)[^"]*">(.*?)</div>',
	              page, re.S)
	body = m.group(1) if m else page
	body = re.sub(r"<(br|/p|/li|/div)[^>]*>", "\n", body)
	body = re.sub(r"<li[^>]*>", "- ", body)
	body = html.unescape(re.sub(r"<[^>]+>", "", body))
	return re.sub(r"\n{3,}", "\n\n", body).strip()


def cmd_detail(a):
	for jid in a.ids:
		jid = re.sub(r".*?(\d{6,}).*", r"\1", jid)
		print(f"===== {jid} https://www.linkedin.com/jobs/view/{jid}")
		print(get_detail(jid)[:a.max_chars])
		print()


def score(row, must, plus, minus):
	blob = " ".join([row.get("title", ""), row.get("company", ""),
	                 row.get("location", ""), row.get("description", "")]).lower()
	if any(m.lower() not in blob for m in must):
		return None
	s = sum(2 for p in plus if p.lower() in blob)
	s -= sum(3 for m in minus if m.lower() in blob)
	s += 3 if any(p.lower() in row.get("title", "").lower() for p in plus) else 0
	return s


def cmd_rank(a):
	rows = json.load(open(a.file)) if a.file != "-" else json.load(sys.stdin)
	out = []
	for r in rows:
		s = score(r, a.must, a.plus, a.minus)
		if s is None:
			continue
		r["score"] = s
		out.append(r)
	out.sort(key=lambda r: -r["score"])
	emit(out[:a.limit], a)


def emit(rows, a):
	if getattr(a, "json", False):
		json.dump(rows, sys.stdout, ensure_ascii=False, indent=1)
		print()
		return
	print(f"# {len(rows)} jobs", file=sys.stderr)
	for r in rows:
		cols = [r.get("score", ""), r["id"], r["posted"][:10],
		        r["company"], r["title"], r["location"], r["url"]]
		print("\t".join(str(c) for c in cols))
		if r.get("description"):
			print("\t" + r["description"].replace("\n", " ⏎ ")[:600])


def main():
	p = argparse.ArgumentParser(description=__doc__,
	                            formatter_class=argparse.RawDescriptionHelpFormatter)
	sub = p.add_subparsers(dest="cmd", required=True)

	s = sub.add_parser("search")
	s.add_argument("keywords")
	s.add_argument("-l", "--location", default="")
	s.add_argument("--geo-id", default="")
	s.add_argument("-n", "--limit", type=int, default=25)
	s.add_argument("--posted", choices=TPR, default="week")
	s.add_argument("--workplace", nargs="*", choices=WT, default=[])
	s.add_argument("--experience", nargs="*", choices=EXP, default=[])
	s.add_argument("--job-type", nargs="*", choices=JT, default=[])
	s.add_argument("--easy-apply", action="store_true")
	s.add_argument("--sort", choices=["relevant", "recent"], default="relevant")
	s.add_argument("-d", "--detail", action="store_true", help="본문까지 (느림)")
	s.add_argument("--max-chars", type=int, default=6000)
	s.add_argument("--delay", type=float, default=0.7)
	s.add_argument("--json", action="store_true")
	s.set_defaults(func=cmd_search)

	d = sub.add_parser("detail")
	d.add_argument("ids", nargs="+", help="job id 또는 공고 URL")
	d.add_argument("--max-chars", type=int, default=12000)
	d.set_defaults(func=cmd_detail)

	r = sub.add_parser("rank")
	r.add_argument("file", help="search --json 결과 파일 (- 는 stdin)")
	r.add_argument("--must", nargs="*", default=[], help="전부 있어야 통과")
	r.add_argument("--plus", nargs="*", default=[], help="가점")
	r.add_argument("--minus", nargs="*", default=[], help="감점")
	r.add_argument("-n", "--limit", type=int, default=20)
	r.add_argument("--json", action="store_true")
	r.set_defaults(func=cmd_rank)

	a = p.parse_args()
	a.func(a)


if __name__ == "__main__":
	main()
