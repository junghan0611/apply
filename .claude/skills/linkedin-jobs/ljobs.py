#!/usr/bin/env python3
"""LinkedIn 공개(guest) 채용 검색 — 로그인 없이 공고를 긁어 추린다.

	search  키워드/지역/기간/근무형태로 공고 목록 (페이징)
	detail  공고 ID 로 본문 전문 + criteria + 근무지 추정
	rank    검색 결과를 키워드·지역 가중치로 정렬

지역이 첫 축이다. LinkedIn 의 `location=` 서버 필터는 광역으로 번지므로
(`Seongnam` → 서울 공고 섞임, `Pangyo` → 화성·천안) **넓게 긁고 좁게 거른다**:
검색은 "South Korea" 로 하고 `--loc` / `--loc-exclude` 로 클라이언트에서 자른다.

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

# 본문에서 세부 근무지를 건지기 위한 지명 사전. 카드의 location 은 시/구까지만
# 나오고 그마저 "Seoul, Seoul, South Korea" 로 뭉개진 공고가 많다.
#
# 한국어는 지명이 다른 낱말에 통째로 박힌다 — 무'신사', '신사'업, '분당' 처리량,
# '고양'이, '시청'자, '일산'화탄소, '성수'기. 경계 없이 부분문자열로 찾으면
# 무신사 공고의 근무지가 "신사"가 된다. 그래서 두 등급으로 가른다.
#   PLACES : 조사까지 허용하되 앞뒤에 다른 한글이 붙으면 버린다
#   WEAK   : 위 규칙으로도 못 막는 것들 — 행정 접미사(구/시/동/역…)를 반드시 요구
WEAK = [
	"분당", "고양", "구미", "이천", "전주", "청주", "시청", "성수", "사당",
	"일산", "광명", "안산", "중구", "강동", "신사", "종로", "하남", "과천",
	"군포", "의왕", "김포", "파주", "동작",
]
PLACES = [
	# 서울 자치구
	"강남", "서초", "송파", "강동", "마포", "영등포", "종로", "용산", "성동",
	"광진", "동대문", "성북", "강북", "도봉", "노원", "은평", "서대문", "양천",
	"강서", "구로", "금천", "동작", "관악", "중랑", "중구",
	# 서울 업무지구·랜드마크
	"판교", "분당", "정자동", "서현", "야탑", "상암", "DMC", "여의도", "역삼",
	"삼성동", "선릉", "테헤란로", "가산디지털단지", "가산", "구로디지털단지",
	"문정", "잠실",
	"성수", "을지로", "광화문", "시청", "강남역", "양재", "도곡", "논현",
	"신사", "압구정", "마곡", "공덕", "홍대", "사당", "왕십리", "청담",
	# 경기·인천
	"성남", "수원", "용인", "화성", "안양", "부천", "고양", "일산", "광명",
	"하남", "시흥", "안산", "평택", "이천", "파주", "김포", "남양주", "의정부",
	"과천", "군포", "의왕", "송도", "청라", "인천", "동탄", "기흥", "죽전",
	# 광역시·지방
	"대전", "대구", "부산", "광주", "울산", "세종", "천안", "아산", "청주",
	"포항", "창원", "제주", "구미", "전주", "원주", "춘천",
	# 영문 표기
	"Gangnam", "Seocho", "Songpa", "Mapo", "Yeouido", "Pangyo", "Bundang",
	"Sangam", "Yeoksam", "Samseong", "Guro", "Gasan", "Seongsu", "Jamsil",
	"Magok", "Seongnam", "Suwon", "Yongin", "Hwaseong", "Anyang", "Bucheon",
	"Goyang", "Ilsan", "Songdo", "Incheon", "Daejeon", "Busan", "Daegu",
	"Gwangju", "Ulsan", "Sejong", "Cheonan", "Asan", "Dongtan", "Gwacheon",
]
# 라벨 뒤 이 거리 안에서 지명을 찾으면 '라벨 확인'으로 본다.
LABEL_RE = re.compile(
	r"(근무\s*(?:지역|지|위치|장소|형태|방식|조건|환경)|사무실|오피스|주소|"
	r"work\s*(?:location|arrangement|setup)|office\s*location|location|worksite)", re.I)
# "점"은 접미사에서 뺀다 — 넣으면 '가산점'이 가산(디지털단지)으로 잡힌다.
_SUFFIX = r"(?:특별시|광역시|자치시|시|구|군|동|읍|면|역|캠퍼스|사옥|타워|오피스|지사|본사|센터)"
_JOSA = r"(?:에서|으로|까지|부터|은|는|이|가|을|를|에|의|와|과|로|도|만|및)?"


def _place_pattern():
	ko_strong = [p for p in PLACES if re.search(r"[가-힣]", p) and p not in WEAK]
	ko_weak = [p for p in PLACES if p in WEAK]
	en = [p for p in PLACES if not re.search(r"[가-힣]", p)]
	alt = "|".join(re.escape(p) for p in sorted(ko_strong, key=len, reverse=True))
	alt_w = "|".join(re.escape(p) for p in sorted(ko_weak, key=len, reverse=True))
	parts = []
	if alt:
		parts.append(rf"(?<![가-힣])(?:{alt}){_SUFFIX}?{_JOSA}(?![가-힣])")
	if alt_w:
		parts.append(rf"(?<![가-힣])(?:{alt_w}){_SUFFIX}{_JOSA}(?![가-힣])")
	if en:
		parts.append(r"\b(?:" + "|".join(re.escape(p) for p in en) + r")\b")
	return re.compile("|".join(parts))


PLACE_RE = _place_pattern()


def _norm_place(s):
	"""매치에 딸려온 조사를 떼되 지명 자체는 깎지 않는다.

	단순히 조사 후보를 잘라내면 "여의도"→"여의", "송도"→"송", "테헤란로"→"테헤란"
	처럼 지명의 끝 글자가 조사로 오인돼 표기가 망가진다. 사전에서 가장 긴 지명을
	먼저 확정한 뒤, 그 뒤에 붙은 행정 접미사만 살린다.
	"""
	s = s.strip()
	best = ""
	for p in PLACES:
		if s.startswith(p) and len(p) > len(best):
			best = p
	if not best:
		return s
	m = re.match(_SUFFIX, s[len(best):])
	return best + (m.group(0) if m else "")
REMOTE_RE = re.compile(r"재택|원격|리모트|remote|work\s*from\s*home|fully\s*distributed", re.I)
# 「근무지 서울 영등포구 여의대방로69길 23 10층」처럼 주소가 통째로 실릴 때가 있다.
# 구까지만 아는 것보다 이게 훨씬 쓸모 있으므로 지명 사전보다 먼저 시도한다.
ADDR_RE = re.compile(
	r"(?:서울|부산|대구|인천|광주|대전|울산|세종|경기도?|강원|충청[북남]도?|충[북남]|"
	r"전라[북남]도?|전[북남]|경상[북남]도?|경[북남]|제주)"
	r"[^,\n|]{0,40}?(?:대로|로|길)\s?\d+[^,\n|]{0,18}")


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


# --- 근무지 -----------------------------------------------------------------

def extract_worksite(body):
	"""본문에서 세부 근무지를 건진다.

	returns (worksite, source) — source 는 `label`(라벨 옆에서 확인),
	`body`(본문 어딘가), `remote`, `label-empty`(라벨은 있는데 값이 없음),
	`none`(단서 없음). label-empty 는 파싱 실패가 아니라 **원문에 값이 없는 것**이다
	— 원티드/그리팅 ATS 본문이 LinkedIn 으로 넘어올 때 자주 잘린다.
	"""
	if not body:
		return "", "none"
	flat = re.sub(r"\s+", " ", body)
	# 라벨은 한 본문에 여러 번 나오고 앞쪽이 비어 있을 수 있다 — 전부 순회한다.
	hits, addrs, saw_label, near_remote = [], [], False, False
	for m in LABEL_RE.finditer(flat):
		saw_label = True
		near = flat[m.end():m.end() + 200]
		for ad in ADDR_RE.findall(near):
			if ad not in addrs:
				addrs.append(ad.strip())
		for p in PLACE_RE.findall(near):
			p = _norm_place(p)
			if p and p not in hits:
				hits.append(p)
		if REMOTE_RE.search(near):
			near_remote = True
	if addrs:
		return " / ".join(addrs[:2]), "label"
	if hits:
		return " / ".join(hits[:3]), "label"
	ad = ADDR_RE.search(flat)
	if ad:
		return ad.group(0).strip(), "body"
	body_hits = []
	for p in PLACE_RE.findall(flat):
		p = _norm_place(p)
		if p and p not in body_hits:
			body_hits.append(p)
	if body_hits:
		return " / ".join(body_hits[:3]), "body"
	# remote 는 근무지 라벨 옆에 있을 때만 근무지로 친다. 본문 아무 데나 걸면
	# 복지 문단의 "remote-friendly" 가 서울 온사이트 공고를 원격으로 둔갑시킨다.
	if near_remote:
		return "remote?", "remote"
	return "", "label-empty" if saw_label else "none"


def parse_criteria(page):
	out = {}
	for m in re.finditer(
			r'criteria-subheader"?>(.*?)</h3>\s*<span[^>]*criteria-text[^>]*>(.*?)</span>',
			page, re.S):
		k = re.sub(r"\s+", " ", txt(m.group(1))).strip()
		v = re.sub(r"\s+", " ", txt(m.group(2))).strip()
		if k:
			out[k] = v
	return out


def get_detail(jid):
	"""공고 하나의 본문·criteria·근무지·지원경로를 한 요청으로 얻는다."""
	if not jid:
		return {"description": "", "criteria": {}, "worksite": "", "worksite_src": "none",
		        "apply": ""}
	page = fetch(POSTING + jid)
	# offsite 아이콘이 붙어 있으면 회사 사이트/외부 ATS 로 나가는 공고다.
	# 없으면 LinkedIn Easy Apply — 브라우저 축이 가입 없이 바로 낼 수 있다.
	apply = "offsite" if "offsite-apply-icon" in page else "easy"
	m = re.search(
		r'class="(?:show-more-less-html__markup|description__text)[^"]*">(.*?)</div>',
		page, re.S)
	body = m.group(1) if m else page
	body = re.sub(r"<(br|/p|/li|/div)[^>]*>", "\n", body)
	body = re.sub(r"<li[^>]*>", "- ", body)
	body = html.unescape(re.sub(r"<[^>]+>", "", body))
	body = re.sub(r"\n{3,}", "\n\n", body).strip()
	ws, src = extract_worksite(body)
	return {"description": body, "criteria": parse_criteria(page),
	        "worksite": ws, "worksite_src": src, "apply": apply}


def card_hint(loc):
	"""카드 위치가 쓸모 있는 만큼만 돌려준다.

	`Seongnam, Gyeonggi, South Korea` 는 쓸모 있고 `Seoul, Seoul, South Korea` 는
	구를 모른다. 본문 근무지가 없을 때 이 둘을 같은 `?` 로 뭉치면 판교권 공고를
	통째로 놓친다.
	"""
	parts, seen = [], set()
	for p in loc.split(","):
		p = p.strip()
		if not p or p.lower() in ("south korea", "korea") or p in seen:
			continue
		seen.add(p)
		parts.append(p)
	if not parts:
		return ""
	if len(parts) == 1 and parts[0].lower() in ("seoul", "서울"):
		return "서울·구미상"
	return parts[0]


def loc_ok(row, a):
	"""지역 필터. 기본은 **소프트** — 모르는 것은 버리지 않는다.

	근무지 확인율은 30% 남짓이다. 미확인을 불일치와 같이 취급해 잘라내면
	실제로 조건에 맞는 공고를 통째로 놓친다. 그래서 `--loc` 는 **확실히 어긋난
	것만** 자르고, 단서가 없으면 남긴다. 전부 잘라내려면 `--loc-strict`.
	"""
	blob = " ".join([row.get("location", ""), row.get("worksite", "")])
	if a.loc_exclude and re.search("|".join(a.loc_exclude), blob, re.I):
		return False
	if not a.loc:
		return True
	if re.search("|".join(a.loc), blob, re.I):
		return True
	if a.loc_strict:
		return False
	# 근무지도 모르고 카드도 뭉뚱그려져 있으면 판단을 미룬다 — 살려서 올린다.
	hint = card_hint(row.get("location", ""))
	known = bool(row.get("worksite")) or (hint and hint != "서울·구미상")
	return not known


# --- 서브커맨드 --------------------------------------------------------------

def cmd_search(a):
	seen, rows = set(), []
	want = a.limit * (4 if (a.loc or a.loc_exclude) else 1)
	for start in range(0, want, 10):
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

	# 근무지는 본문에만 있다 — 지역으로 거를 거면 카드만으로 자르지 않고 전부 받는다.
	if a.detail or a.worksite or a.loc or a.loc_exclude:
		for i, r in enumerate(rows, 1):
			print(f"\r# body {i}/{len(rows)}", end="", file=sys.stderr)
			d = get_detail(r["id"])
			r["worksite"] = d["worksite"]
			r["worksite_src"] = d["worksite_src"]
			r["criteria"] = d["criteria"]
			if a.detail:
				r["description"] = d["description"][:a.max_chars]
			time.sleep(a.delay)
		print("\r" + " " * 24 + "\r", end="", file=sys.stderr)

	if a.loc or a.loc_exclude:
		rows = [r for r in rows if loc_ok(r, a)]
	emit(rows[:a.limit], a)


def cmd_enrich(a):
	"""카드만 모아 둔 json 에 본문 유래 정보를 채운다.

	여러 쿼리를 돌면 같은 공고가 겹친다. 쿼리마다 본문을 받으면 그 배수만큼
	낭비하므로, 카드는 `search --json`(빠름)으로 모아 병합한 뒤 여기서 한 번만
	받는다. 이미 채워진 항목은 건너뛴다 — 중단됐던 판을 이어서 돌릴 수 있다.
	"""
	rows = json.load(open(a.file)) if a.file != "-" else json.load(sys.stdin)
	todo = [r for r in rows if a.force or "worksite" not in r]
	print(f"# enrich {len(todo)}/{len(rows)}", file=sys.stderr)
	for i, r in enumerate(todo, 1):
		print(f"\r# {i}/{len(todo)}", end="", file=sys.stderr)
		d = get_detail(r["id"])
		r["worksite"], r["worksite_src"] = d["worksite"], d["worksite_src"]
		r["criteria"], r["apply"] = d["criteria"], d["apply"]
		if a.keep_body:
			r["description"] = d["description"][:a.max_chars]
		time.sleep(a.delay)
		if a.out and i % 20 == 0:
			json.dump(rows, open(a.out, "w"), ensure_ascii=False)
	print("\r" + " " * 24 + "\r", end="", file=sys.stderr)
	if a.out:
		json.dump(rows, open(a.out, "w"), ensure_ascii=False)
		known = sum(1 for r in rows if r.get("worksite"))
		print(f"# {a.out}: {len(rows)}건, 근무지 확인 {known}", file=sys.stderr)
	else:
		json.dump(rows, sys.stdout, ensure_ascii=False)


def cmd_detail(a):
	for jid in a.ids:
		jid = re.sub(r".*?(\d{6,}).*", r"\1", jid)
		d = get_detail(jid)
		print(f"===== {jid} https://www.linkedin.com/jobs/view/{jid}")
		ws = d["worksite"] or "?"
		print(f"# 근무지: {ws}  (근거: {d['worksite_src']})  지원: {d['apply']}")
		if d["criteria"]:
			print("# " + " | ".join(f"{k}: {v}" for k, v in d["criteria"].items()))
		print(d["description"][:a.max_chars])
		print()


def score(row, a):
	blob = " ".join([row.get("title", ""), row.get("company", ""),
	                 row.get("location", ""), row.get("worksite", ""),
	                 row.get("description", "")]).lower()
	if any(m.lower() not in blob for m in a.must):
		return None
	neg = sum(3 for m in a.minus if m.lower() in blob)
	s = sum(2 for p in a.plus if p.lower() in blob) - neg
	if any(p.lower() in row.get("title", "").lower() for p in a.plus):
		s += 3
	# 지역 축. 맞으면 올리고, **확인된 근무지가** 어긋나면 내린다.
	# 미확인은 기본적으로 건드리지 않는다 — 확인율이 30% 남짓이라 감점하면
	# 조건에 맞는 공고 다수가 조용히 아래로 가라앉는다. 굳이 내리려면
	# --penalize-unknown 을 명시한다.
	locblob = " ".join([row.get("location", ""), row.get("worksite", "")]).lower()
	if a.near:
		# 직무가 안 맞는 공고를 지역 가점으로 끌어올리지 않는다.
		if any(n.lower() in locblob for n in a.near):
			if not neg:
				s += 6
		elif row.get("worksite"):
			s -= 4
	if a.penalize_unknown and not row.get("worksite"):
		s -= 2
	return s


def cmd_rank(a):
	rows = json.load(open(a.file)) if a.file != "-" else json.load(sys.stdin)
	out = []
	for r in rows:
		if a.require_worksite and not r.get("worksite"):
			continue
		s = score(r, a)
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
	unknown = sum(1 for r in rows if "worksite" in r and not r["worksite"])
	note = f", 근무지 미확인 {unknown}건" if "worksite" in (rows[0] if rows else {}) else ""
	print(f"# {len(rows)} jobs{note}", file=sys.stderr)
	for r in rows:
		ws = r.get("worksite") or ""
		if not ws and "worksite" in r:
			hint = card_hint(r.get("location", ""))
			tail = "·원문빈칸" if r.get("worksite_src") == "label-empty" else ""
			ws = f"?({hint}{tail})" if hint else (f"?({tail.lstrip('·')})" if tail else "?")
		cols = [r.get("score", ""), r["id"], r["posted"][:10], r["company"],
		        r["title"], r["location"], ws, r.get("apply", ""), r["url"]]
		print("\t".join(str(c) for c in cols))
		if r.get("description"):
			print("\t" + r["description"].replace("\n", " ⏎ ")[:600])


def main():
	p = argparse.ArgumentParser(description=__doc__,
	                            formatter_class=argparse.RawDescriptionHelpFormatter)
	sub = p.add_subparsers(dest="cmd", required=True)

	s = sub.add_parser("search")
	s.add_argument("keywords")
	s.add_argument("-l", "--location", default="",
	               help="LinkedIn 서버 필터. 광역으로 번진다 — 좁히려면 --loc 를 쓴다")
	s.add_argument("--geo-id", default="")
	s.add_argument("-n", "--limit", type=int, default=25)
	s.add_argument("--posted", choices=TPR, default="week")
	s.add_argument("--workplace", nargs="*", choices=WT, default=[])
	s.add_argument("--experience", nargs="*", choices=EXP, default=[])
	s.add_argument("--job-type", nargs="*", choices=JT, default=[])
	s.add_argument("--easy-apply", action="store_true")
	s.add_argument("--sort", choices=["relevant", "recent"], default="relevant")
	s.add_argument("--loc", nargs="*", default=[],
	               help="지역 화이트리스트(정규식). 소프트 — 확실히 어긋난 것만 자르고 "
	                    "근무지 미확인은 남긴다")
	s.add_argument("--loc-strict", action="store_true",
	               help="--loc 를 하드 컷으로. 미확인도 자른다 (놓칠 각오로)")
	s.add_argument("--loc-exclude", nargs="*", default=[], help="같은 축의 블랙리스트")
	s.add_argument("-w", "--worksite", action="store_true",
	               help="본문에서 세부 근무지만 뽑는다 (본문 전문은 출력하지 않음)")
	s.add_argument("-d", "--detail", action="store_true", help="본문까지 (느림)")
	s.add_argument("--max-chars", type=int, default=6000)
	s.add_argument("--delay", type=float, default=0.7)
	s.add_argument("--json", action="store_true")
	s.set_defaults(func=cmd_search)

	e = sub.add_parser("enrich", help="카드 json 에 근무지·criteria·지원경로를 채운다")
	e.add_argument("file", help="search --json 을 병합한 파일 (- 는 stdin)")
	e.add_argument("-o", "--out", default="", help="저장 경로 (20건마다 중간 저장)")
	e.add_argument("--force", action="store_true", help="이미 채워진 것도 다시")
	e.add_argument("--keep-body", action="store_true", help="본문도 남긴다 (커진다)")
	e.add_argument("--max-chars", type=int, default=6000)
	e.add_argument("--delay", type=float, default=0.7)
	e.set_defaults(func=cmd_enrich)

	d = sub.add_parser("detail")
	d.add_argument("ids", nargs="+", help="job id 또는 공고 URL")
	d.add_argument("--max-chars", type=int, default=12000)
	d.set_defaults(func=cmd_detail)

	r = sub.add_parser("rank")
	r.add_argument("file", help="search --json 결과 파일 (- 는 stdin)")
	r.add_argument("--must", nargs="*", default=[], help="전부 있어야 통과")
	r.add_argument("--plus", nargs="*", default=[], help="가점")
	r.add_argument("--minus", nargs="*", default=[], help="감점")
	r.add_argument("--near", nargs="*", default=[],
	               help="선호 지역. 맞으면 +6, 확인된 근무지가 어긋나면 -4. "
	                    "미확인은 건드리지 않는다")
	r.add_argument("--require-worksite", action="store_true",
	               help="본문 근무지가 확인된 공고만. 카드에 지명이 찍힌 공고까지 "
	                    "잘라내니 주의 — 보통은 --near 로 충분하다")
	r.add_argument("--penalize-unknown", action="store_true",
	               help="근무지 미확인에 -2 (기본은 감점 없음)")
	r.add_argument("-n", "--limit", type=int, default=20)
	r.add_argument("--json", action="store_true")
	r.set_defaults(func=cmd_rank)

	a = p.parse_args()
	a.func(a)


if __name__ == "__main__":
	main()
