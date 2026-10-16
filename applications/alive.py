#!/usr/bin/env python3
"""alive.py — `ready` 건의 공고가 아직 열려 있는지 훑는다.

공고는 죽는다. `check.py` 는 원장·문서·스냅샷의 **내부 일치**를 보고, 이것은 **바깥 세계**를
본다. 제출 직전에 한 번 돌린다 — 어제 연 건이 오늘 닫혀 있을 수 있다.

    ./alive.py              전체 훑기
    ./alive.py lunit toss   이름 일부로 거른다

## 왜 문자열 검색을 쓰지 않는가 — 2026-07-29 실패에서 나온 규칙

첫 판은 본문에서 `"마감된 공고"` 를 찾는 방식이었고 **그리팅 3건을 전부 닫힘으로 오판했다.**
그리팅은 페이지마다 **i18n 사전 전체**를 실어 보낸다 — `"지원이 마감된 공고입니다."` 는 그
사전의 한 항목이고 공고 상태와 무관하게 항상 있다. 실제 상태는
`__NEXT_DATA__ → openingsInfo.status == "OPEN"` 였다.

**그래서 이 도구는 구조화된 상태 필드만 믿는다.** 어댑터가 없는 ATS 는 `http` 로만 보고하고
**닫혔다고 말하지 않는다.** 모르는 것을 안다고 하는 쪽이 놓치는 쪽보다 나쁘다.

판정:
  open    ATS 가 「열림」이라고 답했다 (구조화 필드 근거)
  closed  ATS 가 「닫힘」이라고 답했다 (구조화 필드 근거)
  http    HTTP 200 은 떴다. **열림 여부는 판정하지 않았다** — 어댑터 없음
  gone    4xx/5xx (429 는 제외 — 아래)
  limited 429. 상대가 긁는 것을 막은 것이지 공고가 죽은 것이 아니다
  ?       네트워크 실패. 다시 돌린다
  invalid 대상 항목 자체가 깨졌다 — 요청을 보내지 않았다. TARGETS 를 고친다
  error   이 도구가 그 한 건에서 예외로 멈췄다. 공고 상태는 모른다

## 한 건이 전체를 죽이지 않는다 — 2026-10-15 실패에서 나온 규칙

history 정제(`docs/HISTORY-REDACTION.md`)가 Ashby posting id 를 `[uuid removed]` 로 바꿔
두었고, 그 URL 이 `urllib` 안에서 `InvalidURL` 을 던져 **스물두 건 전체가 한 줄도 못 찍고
죽었다.** 그래서 대상은 요청 전에 검증하고(`invalid`), 그래도 새는 예외는 그 행에만
가둔다(`error`). 둘 다 **성공으로 치지 않는다** — 열림을 확인하지 못한 것은 열림이 아니다.
"""

from __future__ import annotations

import concurrent.futures
import json
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

UA = (
	"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
	"(KHTML, like Gecko) Chrome/131.0 Safari/537.36"
)
TIMEOUT = 25

# (표시명, 확인 URL, ATS 키) — ATS 키가 어댑터를 고른다.
TARGETS = [
	("Lunit", "https://apply.workable.com/lunit/j/E3C22F589F/apply/", "workable"),
	("FuriosaAI", "https://jobs.ashbyhq.com/furiosa-ai/[uuid removed]/application", "ashby"),
	("42dot", "https://jobs.ashbyhq.com/42dot/[uuid removed]/application", "ashby"),
	("FriendliAI", "https://jobs.ashbyhq.com/friendliai/[uuid removed]/application", "ashby"),
	("Reflection AI", "https://jobs.ashbyhq.com/reflectionai/[uuid removed]/application", "ashby"),
	("Toss", "https://toss.im/career/apply/basic/7646941003", "plain"),
	("MakinaRocks", "https://makinarocks.career.greetinghr.com/ko/o/214041", "greeting"),
	("AIRS Medical", "https://airsmed.career.greetinghr.com/ko/o/216673", "greeting"),
	("SOCAR", "https://socar.career.greetinghr.com/ko/o/220124", "greeting"),
	("Telechips", "https://careers.telechips.com/job_posting/Re4LUYvK", "ninehire"),
	("Bear Robotics", "https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform/apply", "plain"),
	("Telit Cinterion", "https://recruiting.paylocity.com/recruiting/jobs/Details/4158364/TELIT-IOT-PLATFORMS-LLC/Edge-AI-Software-Engineer", "plain"),
	("Sonatus", "https://www.linkedin.com/jobs/view/4380679251/", "plain"),
	("Holiday Robotics", "https://holiday-robotics.com/careers/forward-deployed-robotics-engineer/apply", "plain"),
	("Hanwha Vision", "https://hanwhavision.ninehire.site/job_posting/6NDP9uTE", "ninehire"),
	("Kakao Healthcare", "https://recruit.kakaohealthcare.com/job_posting/e9Q82rF9", "ninehire"),
	("NHN (2번째)", "https://careers.nhn.com/recruits/4370711607830110861", "plain"),
	("Upstage", "https://careers.upstage.ai/ko/o/194880", "greeting"),
	("IGNITE", "https://ignite.ninehire.site/job_posting/xGwZ5VTB", "ninehire"),
	# 마감이 박혀 있는 유일한 건 — 2026-08-06 23:59 · 영입 완료 시 조기 마감
	("Kakao Bank DW", "https://recruit.kakaobank.com/jobs/260510", "plain"),
	# 보류 2건 — 되살릴 때를 위해 같이 본다
	("Cohere (보류)", "https://jobs.ashbyhq.com/cohere/[uuid removed]/application", "ashby"),
	("OpenAI (보류)", "https://jobs.ashbyhq.com/openai/[uuid removed]/application", "ashby"),
]


class Fetched:
	def __init__(self, code: int, body: str):
		self.code = code
		self.body = body


def fetch(url: str, cap: int | None = 2_000_000) -> Fetched | str:
	"""cap=None 이면 끝까지 읽는다. Ashby 보드 API 는 12MB 도 나온다 — 자르면 JSON 이 깨진다."""
	req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept": "text/html,*/*"})
	try:
		with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
			raw = r.read() if cap is None else r.read(cap)
			return Fetched(r.status, raw.decode("utf-8", "replace"))
	except urllib.error.HTTPError as e:
		return f"HTTP {e.code}"
	except (urllib.error.URLError, TimeoutError, OSError) as e:
		return str(e)[:60]


def next_data(body: str) -> dict | None:
	m = re.search(r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>', body, re.S)
	if not m:
		return None
	try:
		return json.loads(m.group(1))
	except json.JSONDecodeError:
		return None


def check_greeting(url: str, f: Fetched) -> tuple[str, str]:
	"""그리팅 — __NEXT_DATA__ 의 openingsInfo.status 가 사실이다."""
	d = next_data(f.body)
	if not d:
		return ("http", f"HTTP {f.code} · __NEXT_DATA__ 없음")
	for q in d.get("props", {}).get("pageProps", {}).get("dehydratedState", {}).get("queries", []):
		inner = (q.get("state") or {}).get("data")
		if not isinstance(inner, dict):
			continue
		info = (inner.get("data") or {}).get("openingsInfo") if isinstance(inner.get("data"), dict) else None
		if isinstance(info, dict) and "status" in info:
			status = info["status"]
			due = info.get("dueDate") or "마감일 없음"
			# `deploy` 는 **공고 상태가 아니다.** 그리팅이 호스팅하는 채용 홈페이지를 띄웠는지의
			# 값이다. 쏘카는 채용홈을 socarcorp.kr 로 따로 운영해서 `deploy=False` 인데
			# 공고는 멀쩡히 열려 있다(2026-07-29 브라우저 확인). 판정은 `status` 만 쓴다.
			verdict = "open" if status == "OPEN" else "closed"
			note = f"status={status} · {due}"
			if not info.get("deploy"):
				note += " · deploy=False(채용홈 미배포 — 공고 상태 아님)"
			return (verdict, note)
	return ("http", f"HTTP {f.code} · openingsInfo 못 찾음")


def check_ninehire(url: str, f: Fetched) -> tuple[str, str]:
	"""ninehire — recruitment.status / closedAt 이 사실이다."""
	d = next_data(f.body)
	if not d:
		return ("http", f"HTTP {f.code} · __NEXT_DATA__ 없음")
	r = d.get("props", {}).get("pageProps", {}).get("recruitment")
	if not isinstance(r, dict) or "status" not in r:
		return ("http", f"HTTP {f.code} · recruitment 못 찾음")
	status, closed = r["status"], r.get("closedAt")
	verdict = "open" if status == "in_progress" and not closed else "closed"
	return (verdict, f"status={status} · closedAt={closed} · {r.get('deadlineType')}")


def check_ashby(url: str, f: Fetched) -> tuple[str, str]:
	"""Ashby — 공개 job-board API 에 그 posting id 가 살아 있는지 본다."""
	m = re.match(r"https://jobs\.ashbyhq\.com/([^/]+)/([0-9a-f-]{36})", url)
	if not m:
		return ("http", f"HTTP {f.code} · URL 에서 슬러그/ID 를 못 뽑았다")
	slug, pid = m.group(1), m.group(2)
	api = fetch(f"https://api.ashbyhq.com/posting-api/job-board/{slug}?includeCompensation=false", cap=None)
	if not isinstance(api, Fetched):
		return ("http", f"HTTP {f.code} · 보드 API 실패 ({api})")
	try:
		jobs = json.loads(api.body).get("jobs", [])
	except json.JSONDecodeError:
		return ("http", f"HTTP {f.code} · 보드 API 파싱 실패")
	for j in jobs:
		if j.get("id") == pid:
			listed = j.get("isListed", True)
			return ("open" if listed else "closed", f"보드 {len(jobs)}건 중 존재 · isListed={listed}")
	return ("closed", f"보드 {len(jobs)}건에 이 posting 없음")


def check_plain(url: str, f: Fetched) -> tuple[str, str]:
	"""어댑터 없음 — HTTP 만 보고하고 열림 여부는 **판정하지 않는다**."""
	return ("http", f"HTTP {f.code} · {len(f.body) // 1024}KB · 열림 여부 미판정")


ADAPTERS = {
	"greeting": check_greeting,
	"ninehire": check_ninehire,
	"ashby": check_ashby,
	"workable": check_plain,
	"plain": check_plain,
}

# history 정제가 남긴 자리표시 — `[uuid removed]` · `[email removed]` 류.
REDACTED = re.compile(r"\[[^\]]*removed[^\]]*\]", re.I)
ASHBY_URL = re.compile(r"https://jobs\.ashbyhq\.com/[^/]+/[0-9a-f-]{36}(/|$)")


def target_fault(url: str, ats: str) -> str | None:
	"""요청을 보내기 전에 대상 항목이 성립하는지 본다. 깨졌으면 이유를, 아니면 None."""
	if ats not in ADAPTERS:
		return f"ATS 키 「{ats}」 에 어댑터가 없다"
	m = REDACTED.search(url)
	if m:
		return f"URL 에 정제 자리표시 「{m.group(0)}」 — 원본 URL 을 다시 받아 TARGETS 를 고친다"
	try:
		parts = urllib.parse.urlsplit(url)
	except ValueError as e:
		return f"URL 파싱 실패 ({e})"
	if parts.scheme not in ("http", "https") or not parts.netloc:
		return f"URL 에 http(s) 스킴/호스트가 없다 ({url[:60]})"
	if re.search(r"[\s<>\"\[\]]", url):
		return "URL 에 공백이나 허용되지 않는 문자가 있다"
	if ats == "ashby" and not ASHBY_URL.match(url):
		return "Ashby URL 에서 슬러그/posting id(36자) 를 못 뽑는다"
	return None


def probe(item: tuple[str, str, str]) -> tuple[str, str, str, str]:
	name, url, ats = item
	fault = target_fault(url, ats)
	if fault:
		return (name, ats, "invalid", fault)
	try:
		return _probe(name, url, ats)
	except Exception as e:  # noqa: BLE001 — 한 건의 예외를 그 행에 가둔다
		return (name, ats, "error", f"{type(e).__name__}: {str(e)[:80]}")


def _probe(name: str, url: str, ats: str) -> tuple[str, str, str, str]:
	f = fetch(url)
	if isinstance(f, str):
		if f == "HTTP 429":
			return (name, ats, "limited", "429 — 긁기 차단. 공고 상태와 무관하다")
		if f.startswith("HTTP "):
			return (name, ats, "gone", f)
		return (name, ats, "?", f)
	verdict, note = ADAPTERS[ats](url, f)
	return (name, ats, verdict, note)


def main() -> int:
	needles = [a.lower() for a in sys.argv[1:]]
	targets = [t for t in TARGETS if not needles or any(n in t[0].lower() for n in needles)]
	if not targets:
		print("일치하는 건이 없다", file=sys.stderr)
		return 2

	with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
		rows = list(pool.map(probe, targets))

	mark = {"open": "✅", "closed": "⛔", "gone": "⛔", "http": "·", "limited": "🔒", "?": "⚠",
	        "invalid": "✖", "error": "✖"}
	width = max(len(r[0]) for r in rows)
	for name, ats, verdict, note in rows:
		print(f"{mark[verdict]} {name.ljust(width)}  {verdict.ljust(8)} {ats:<10} {note}")

	dead = [r for r in rows if r[2] in ("closed", "gone")]
	broken = [r for r in rows if r[2] in ("invalid", "error")]
	print()
	print(f"{len(rows)}건 · 열림확인 {sum(1 for r in rows if r[2] == 'open')} · "
	      f"미판정 {sum(1 for r in rows if r[2] == 'http')} · "
	      f"닫힘 {len(dead)} · 차단 {sum(1 for r in rows if r[2] == 'limited')} · "
	      f"미상 {sum(1 for r in rows if r[2] == '?')} · "
	      f"무효 {len(broken)}")
	if dead:
		# 닫힌 것은 **채용 요청**이지 **전형 결과**가 아니다. 이미 낸 건은 공고가 내려가도
		# 전형이 계속된다 — 이 출력으로 결과 원장을 자동으로 고치지 않는다(2026-10-15).
		print("\n⛔ 닫힌 공고 — 아직 내지 않은 건이면 제출 후보에서 다시 판정한다.")
		print("   이미 낸 건(submitted 이후)의 원장 상태는 이것으로 바꾸지 않는다 — 전형 결과가 아니다:")
		for name, _, _, note in dead:
			print(f"   {name} — {note}")
	if broken:
		print("\n✖ 확인하지 못한 건 — 열림이 아니다. 대상 항목(TARGETS)이나 이 도구를 고친다:")
		for name, _, verdict, note in broken:
			print(f"   {name} [{verdict}] — {note}")
	return 1 if dead or broken else 0


if __name__ == "__main__":
	raise SystemExit(main())
