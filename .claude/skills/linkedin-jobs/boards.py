#!/usr/bin/env python3
"""boards.py — 회사 채용 보드를 직접 긁는다. LinkedIn guest 검색의 반대 축.

LinkedIn guest 검색은 광고가 상단을 먹고 키워드 한 번에 10건에서 끊긴다. 회사를 정했으면
그 회사 채용 보드가 진짜 목록이다 — FuriosaAI 는 LinkedIn 23건이었지만 Ashby 보드는 56건,
Telechips 는 채용홈에 82건이 걸려 있었지만 실제로 열린 것은 3건이었다.

    ./boards.py probe <회사슬러그> [...]     어느 ATS 를 쓰는지 찾는다
    ./boards.py list <ats>:<슬러그> [...]    공고 목록 (TSV)
    ./boards.py sweep <파일>                 회사 목록 파일을 통째로 훑는다
    ./boards.py body <ats>:<슬러그> <공고ID>  공고 본문 원문

지원 ATS (전부 인증 없이 열린다):

| ats        | 목록 경로 | 비고 |
|------------|-----------|------|
| `ashby`    | `api.ashbyhq.com/posting-api/job-board/<슬러그>` | 본문·게시일·고용형태·isListed |
| `greenhouse` | `boards-api.greenhouse.io/v1/boards/<슬러그>/jobs?content=true` | 본문 포함 |
| `lever`    | `api.lever.co/v0/postings/<슬러그>?mode=json` | 본문 포함 |
| `workable` | `apply.workable.com/api/v1/widget/accounts/<슬러그>?details=true` | 본문 포함 |
| `greeting` | `<슬러그>.career.greetinghr.com` HTML `__NEXT_DATA__` | 목록만. 본문은 `body` |
| `kakao`    | `careers.kakao.com/public/api/job-list` (슬러그 무시) | 카카오 공동체 전체 |

**지역을 1차 필터로 쓰지 않는다** (2026-07-28 GLG). 후보는 사실상 전부 서울 아니면 성남이고,
지역으로 먼저 자르면 진짜 자리가 목록에서 사라진다. 회사와 직무가 먼저다.
"""

from __future__ import annotations

import json
import re
import sys
import urllib.error
import urllib.request

UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36"
TIMEOUT = 25


def fetch(url: str) -> bytes | None:
	req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept": "*/*"})
	try:
		with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
			return r.read()
	except (urllib.error.URLError, urllib.error.HTTPError, TimeoutError, OSError):
		return None


def fetch_json(url: str):
	raw = fetch(url)
	if not raw:
		return None
	try:
		return json.loads(raw)
	except json.JSONDecodeError:
		return None


def strip_html(s: str) -> str:
	# Greenhouse 는 본문을 이스케이프해서 준다(`&lt;p&gt;`). 먼저 풀지 않으면 태그가 글자로 남는다.
	import html as _html

	s = _html.unescape(s or "")
	s = re.sub(r"<li>", "\n- ", s)
	s = re.sub(r"</(p|div|h\d|ul|ol|tr)>", "\n", s)
	s = re.sub(r"<br\s*/?>", "\n", s)
	s = re.sub(r"<[^>]+>", "", s)
	return re.sub(r"\n{3,}", "\n\n", _html.unescape(s)).strip()


# ── 어댑터 ────────────────────────────────────────────────────────────────────
# 전부 같은 모양의 dict 를 돌려준다: id · title · location · type · date · url · body


def a_ashby(slug):
	d = fetch_json(f"https://api.ashbyhq.com/posting-api/job-board/{slug}?includeCompensation=true")
	if not d or "jobs" not in d:
		return None
	out = []
	for j in d["jobs"]:
		if j.get("isListed") is False:
			continue
		out.append({
			"id": (j.get("jobUrl") or "").rsplit("/", 1)[-1],
			"title": j.get("title", ""),
			"location": j.get("location") or "",
			"type": j.get("employmentType") or "",
			"date": (j.get("publishedAt") or "")[:10],
			"url": j.get("jobUrl") or "",
			"body": strip_html(j.get("descriptionHtml", "")),
		})
	return out


def a_greenhouse(slug):
	d = fetch_json(f"https://boards-api.greenhouse.io/v1/boards/{slug}/jobs?content=true")
	if not d or "jobs" not in d:
		return None
	return [{
		"id": str(j.get("id")),
		"title": j.get("title", ""),
		"location": (j.get("location") or {}).get("name", ""),
		"type": "",
		"date": (j.get("updated_at") or "")[:10],
		"url": j.get("absolute_url", ""),
		"body": strip_html(j.get("content", "")),
	} for j in d["jobs"]]


def a_lever(slug):
	d = fetch_json(f"https://api.lever.co/v0/postings/{slug}?mode=json")
	if not isinstance(d, list):
		return None
	return [{
		"id": j.get("id", ""),
		"title": j.get("text", ""),
		"location": (j.get("categories") or {}).get("location", "") or "",
		"type": (j.get("categories") or {}).get("commitment", "") or "",
		"date": "",
		"url": j.get("hostedUrl", ""),
		"body": strip_html(j.get("descriptionPlain") or j.get("description") or ""),
	} for j in d]


def a_workable(slug):
	d = fetch_json(f"https://apply.workable.com/api/v1/widget/accounts/{slug}?details=true")
	if not d or "jobs" not in d:
		return None
	return [{
		"id": (j.get("shortlink") or "").rsplit("/", 1)[-1],
		"title": j.get("title", ""),
		"location": ", ".join(x for x in (j.get("city"), j.get("country")) if x),
		"type": j.get("employment_type") or "",
		"date": j.get("published_on") or "",
		"url": j.get("url") or j.get("shortlink") or "",
		"body": strip_html(j.get("description", "")),
	} for j in d["jobs"]]


def _next_data(html: str):
	m = re.search(r'id="__NEXT_DATA__" type="application/json">(.*?)</script>', html, re.S)
	return json.loads(m.group(1)) if m else None


def a_greeting(slug):
	raw = fetch(f"https://{slug}.career.greetinghr.com/")
	if not raw:
		return None
	d = _next_data(raw.decode("utf-8", "replace"))
	if not d:
		return None
	queries = ((d.get("props") or {}).get("pageProps") or {}).get("dehydratedState", {}).get("queries", [])
	ops = next((q["state"]["data"] for q in queries if q.get("queryKey") == ["openings"]), None)
	if not isinstance(ops, list):
		return None
	out = []
	for o in ops:
		oid = o.get("openingId") or o.get("id") or ""
		# 근무지·직군은 openingJobPositions 안에 있다. 없는 보드도 있어 전부 방어적으로 읽는다.
		pos = ((o.get("openingJobPosition") or {}).get("openingJobPositions") or [{}])[0]
		place = (pos.get("workspacePlace") or {}).get("place") or ""
		occ = (pos.get("workspaceOccupation") or {}).get("occupation") or ""
		emp = (pos.get("jobPositionEmployment") or {}).get("employment") or ""
		out.append({
			"id": str(oid),
			"title": o.get("title") or "",
			"location": place,
			"type": " ".join(x for x in (occ, emp) if x),
			"date": (o.get("openDate") or "")[:10],
			"url": f"https://{slug}.career.greetinghr.com/ko/o/{oid}",
			"body": "",
		})
	return out


def greeting_body(slug, oid):
	"""그리팅은 목록에 본문이 없다. 상세 페이지 __NEXT_DATA__ 에서 뜬다.

	`props.pageProps.dehydratedState.queries[*].state.data.data.openingsInfo.detail` 에
	본문이 있고, 같은 자리에 `docsInfo`(제출 서류) · `questionnairesInfo`(서술형 문항과
	글자수 상한)도 들어 있다. **브라우저로 폼을 열기 전에 여기서 읽는다.**
	"""
	raw = fetch(f"https://{slug}.career.greetinghr.com/ko/o/{oid}")
	if not raw:
		return None
	d = _next_data(raw.decode("utf-8", "replace"))
	if not d:
		return None
	for q in ((d.get("props") or {}).get("pageProps") or {}).get("dehydratedState", {}).get("queries", []):
		data = ((q.get("state") or {}).get("data") or {})
		data = data.get("data") if isinstance(data.get("data"), dict) else data
		info = (data or {}).get("openingsInfo") or {}
		if info.get("detail"):
			docs = [x.get("name") or x.get("type") for x in (data.get("docsInfo") or [])]
			qs = [x.get("question") or x.get("title") for x in (data.get("questionnairesInfo") or [])]
			return {
				"detail": strip_html(info["detail"]),
				"title": info.get("title") or "",
				"docs": [x for x in docs if x],
				"questions": [x for x in qs if x],
			}
	return None


def a_kakao(_slug=None):
	out, page = [], 1
	while True:
		d = fetch_json(
			"https://careers.kakao.com/public/api/job-list"
			f"?skillSet=&part=TECHNOLOGY&company=ALL&keyword=&employeeType=&page={page}"
		)
		if not d or not d.get("jobList"):
			break
		for j in d["jobList"]:
			if j.get("closeFlag"):
				continue
			out.append({
				"id": j.get("realId", ""),
				"title": j.get("jobOfferTitle", ""),
				"location": "",
				"type": "",
				"date": (j.get("endDate") or "상시")[:10],
				"url": f"https://careers.kakao.com/jobs/{j.get('realId')}",
				"body": strip_html(j.get("introduction", "")),
			})
		if page >= d.get("totalPage", 1):
			break
		page += 1
	return out or None


ADAPTERS = {
	"ashby": a_ashby,
	"greenhouse": a_greenhouse,
	"lever": a_lever,
	"workable": a_workable,
	"greeting": a_greeting,
	"kakao": a_kakao,
}
PROBE_ORDER = ["ashby", "greenhouse", "lever", "workable", "greeting"]


# ── 명령 ──────────────────────────────────────────────────────────────────────


def cmd_probe(args):
	for slug in args:
		hits = []
		for ats in PROBE_ORDER:
			jobs = ADAPTERS[ats](slug)
			if jobs:
				hits.append(f"{ats}:{slug}({len(jobs)})")
		print(f"{slug}\t{' '.join(hits) if hits else '— 못 찾음'}")


def _split(target):
	ats, _, slug = target.partition(":")
	if ats not in ADAPTERS:
		sys.exit(f"모르는 ats: {ats} (가능: {', '.join(ADAPTERS)})")
	return ats, slug


def _emit(label, jobs, kw, show_body=False, deep=False):
	# 기본은 제목만 본다. 본문까지 보면(--deep) 「AI 를 쓴다」는 문장 하나로 전부 걸려 노이즈가 된다.
	pat = re.compile("|".join(kw), re.I) if kw else None
	n = 0
	for j in jobs:
		hay = f"{j['title']}\n{j['body']}" if deep else j["title"]
		if pat and not pat.search(hay):
			continue
		n += 1
		print("\t".join([label, j["id"], j["date"], j["title"], j["location"], j["type"], j["url"]]))
		if show_body and j["body"]:
			print(j["body"])
			print("─" * 70)
	return n


def cmd_list(args):
	deep = "--deep" in args
	args = [a for a in args if a != "--deep"]
	kw = []
	if "--kw" in args:
		i = args.index("--kw")
		kw = args[i + 1:]
		args = args[:i]
	for target in args:
		ats, slug = _split(target)
		jobs = ADAPTERS[ats](slug)
		if jobs is None:
			print(f"# {target} — 보드를 못 열었다", file=sys.stderr)
			continue
		n = _emit(slug, jobs, kw, deep=deep)
		print(f"# {target}: 전체 {len(jobs)} / 걸린 것 {n}", file=sys.stderr)


def cmd_sweep(args):
	"""회사 목록 파일: 한 줄에 `<ats>:<슬러그>` 또는 `<슬러그>`(probe). `#` 는 주석."""
	deep = "--deep" in args
	args = [a for a in args if a != "--deep"]
	kw = []
	if "--kw" in args:
		i = args.index("--kw")
		kw = args[i + 1:]
		args = args[:i]
	targets = []
	for path in args:
		with open(path, encoding="utf-8") as f:
			for line in f:
				line = line.split("#", 1)[0].strip()
				if line:
					targets.append(line)
	total = 0
	for t in targets:
		if ":" in t:
			ats, slug = _split(t)
			jobs = ADAPTERS[ats](slug)
		else:
			slug, jobs, ats = t, None, None
			for a in PROBE_ORDER:
				jobs = ADAPTERS[a](slug)
				if jobs:
					ats = a
					break
		if not jobs:
			print(f"# {t} — 보드 못 찾음", file=sys.stderr)
			continue
		n = _emit(f"{slug}[{ats}]", jobs, kw, deep=deep)
		total += n
		print(f"# {t}: 전체 {len(jobs)} / 걸린 것 {n}", file=sys.stderr)
	print(f"# 합계 걸린 것 {total}", file=sys.stderr)


def cmd_body(args):
	if len(args) < 2:
		sys.exit("usage: boards.py body <ats>:<슬러그> <공고ID>")
	ats, slug = _split(args[0])
	if ats == "greeting":
		# 그리팅은 목록에 본문이 없다 — 상세 페이지에서 따로 뜬다.
		got = greeting_body(slug, args[1])
		if not got:
			sys.exit(f"본문을 못 떴다: {slug}/{args[1]}")
		print(f"{got['title']} | {slug}/{args[1]}")
		print(f"https://{slug}.career.greetinghr.com/ko/o/{args[1]}")
		if got["docs"]:
			print(f"제출 서류: {' · '.join(got['docs'])}")
		if got["questions"]:
			print(f"서술형 문항: {' | '.join(got['questions'])}")
		print()
		print(got["detail"])
		return
	jobs = ADAPTERS[ats](slug) or []
	for j in jobs:
		if j["id"] == args[1] or args[1] in j["url"]:
			print(f"{j['title']} | {j['location']} | {j['type']} | {j['date']}")
			print(j["url"])
			print()
			print(j["body"] or "(본문이 목록 API 에 없다 — 공고 페이지를 직접 열어야 한다)")
			return
	sys.exit(f"공고를 못 찾았다: {args[1]}")


def main():
	if len(sys.argv) < 2:
		print(__doc__)
		sys.exit(2)
	cmd, args = sys.argv[1], sys.argv[2:]
	{"probe": cmd_probe, "list": cmd_list, "sweep": cmd_sweep, "body": cmd_body}.get(
		cmd, lambda _a: sys.exit(f"모르는 명령: {cmd}")
	)(args)


if __name__ == "__main__":
	main()
