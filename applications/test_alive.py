#!/usr/bin/env python3
"""alive.py 회귀 검사 — 네트워크 없이 돈다.

깨진 대상 한 건이 전체를 죽이지 않고, 확인하지 못한 건을 성공으로 치지 않는 것을 고정한다.
2026-10-15 실물 사고: Ashby URL 의 `[uuid removed]` 가 `InvalidURL` 을 던져 전체가 죽었다.

	./test_alive.py        # 실패하면 exit 1
"""
import contextlib
import importlib.util
import io
import os
import sys
import uuid

_here = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location("alive", os.path.join(_here, "alive.py"))
alive = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(alive)

# 합성 nil UUID를 런타임에 생성한다. 실제 posting/candidate 토큰을 소스에 남기지 않는다.
UUID = str(uuid.UUID(int=0))

# 요청 전에 걸려야 하는 대상 — (항목, 이유에 들어 있어야 할 말)
INVALID = [
	(("Redacted", "https://jobs.ashbyhq.com/furiosa-ai/[uuid removed]/application", "ashby"), "자리표시"),
	(("Redacted plain", "https://example.com/jobs/[id removed]", "plain"), "자리표시"),
	(("No scheme", "jobs.example.com/123", "plain"), "스킴"),
	(("Ftp", "ftp://example.com/job", "plain"), "스킴"),
	(("Space", "https://example.com/a b", "plain"), "허용되지 않는"),
	(("Ashby short id", "https://jobs.ashbyhq.com/acme/1234/application", "ashby"), "posting id"),
	(("Unknown ATS", "https://example.com/job", "lever"), "어댑터"),
]

VALID = [
	("https://jobs.ashbyhq.com/acme/" + UUID + "/application", "ashby"),
	("https://careers.example.com/job_posting/iSXmKnRT", "ninehire"),
	("https://example.com/careers/42", "plain"),
]

NINEHIRE_OPEN = (
	'<script id="__NEXT_DATA__" type="application/json">'
	'{"props":{"pageProps":{"recruitment":{"status":"in_progress","closedAt":null,'
	'"deadlineType":"open_ended"}}}}</script>'
)


def run_main(targets, argv=("alive.py",)):
	"""TARGETS 를 바꿔 끼워 main 을 돌리고 (exit, stdout) 을 돌려준다."""
	saved = (alive.TARGETS, sys.argv)
	alive.TARGETS, sys.argv = targets, list(argv)
	out = io.StringIO()
	try:
		with contextlib.redirect_stdout(out):
			code = alive.main()
	finally:
		alive.TARGETS, sys.argv = saved
	return code, out.getvalue()


def main():
	fails = []
	original_fetch = alive.fetch
	calls = []

	def no_network(url, cap=None):
		calls.append(url)
		raise AssertionError(f"요청을 보내면 안 되는 대상: {url}")

	try:
		# 1. 깨진 대상은 요청 없이 invalid 로 이름 붙는다.
		alive.fetch = no_network
		for item, why in INVALID:
			name, ats, verdict, note = alive.probe(item)
			if verdict != "invalid":
				fails.append(f"invalid: {name} → {verdict} ({note})")
			elif why not in note:
				fails.append(f"invalid 이유: {name} → {note!r} (기대 {why!r} 포함)")
		if calls:
			fails.append(f"invalid: 깨진 대상에 요청을 보냈다 {calls}")

		# 2. 성립하는 대상은 대상 검사를 통과한다.
		for url, ats in VALID:
			fault = alive.target_fault(url, ats)
			if fault:
				fails.append(f"valid 오탐: {url} → {fault}")

		# 3. 어댑터 안에서 새는 예외는 그 행에만 갇힌다 — error, 크래시 아님.
		alive.fetch = lambda url, cap=None: (_ for _ in ()).throw(ValueError("boom"))
		row = alive.probe(("Boom", "https://example.com/careers/42", "plain"))
		if row[2] != "error" or "ValueError" not in row[3]:
			fails.append(f"error: 예외를 행에 가두지 못함 → {row}")

		# 4. 깨진 건이 섞여도 나머지가 찍히고, exit 는 성공이 아니다.
		alive.fetch = lambda url, cap=None: alive.Fetched(200, NINEHIRE_OPEN)
		mixed = [
			("Open", "https://careers.example.com/job_posting/iSXmKnRT", "ninehire"),
			("Broken", "https://jobs.ashbyhq.com/x/[uuid removed]/application", "ashby"),
		]
		code, out = run_main(mixed)
		if "✅ Open" not in out:
			fails.append("mixed: 정상 건이 찍히지 않음")
		if "무효 1" not in out or "Broken [invalid]" not in out:
			fails.append("mixed: 무효 건이 요약·구획에 이름으로 나오지 않음")
		if code == 0:
			fails.append("mixed: 무효 건이 있는데 exit 0 — 확인 못 한 것을 성공으로 쳤다")

		# 5. 전부 열림이면 exit 0 — 수리가 정상 경로를 막지 않는다.
		code, out = run_main(mixed[:1])
		if code != 0 or "무효 0" not in out:
			fails.append(f"open-only: exit {code}, 요약 {out.strip().splitlines()[-1]!r}")

		# 6. 닫힌 공고 안내는 제출 전 후보 재판정이지, 낸 건의 원장 상태 변경이 아니다.
		alive.fetch = lambda url, cap=None: alive.Fetched(200, NINEHIRE_OPEN.replace("in_progress", "disabled"))
		code, out = run_main(mixed[:1])
		if code != 1 or "원장 상태는 이것으로 바꾸지 않는다" not in out or "`closed` 로 고친다" in out:
			fails.append(f"closed 안내: exit {code}, 낸 건의 원장을 고치라고 읽힌다")
	finally:
		alive.fetch = original_fetch

	total = len(INVALID) + 1 + len(VALID) + 1 + 3 + 1 + 1
	if fails:
		print(f"FAIL {len(fails)}/{total}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {total}/{total} — 무효 대상 {len(INVALID)} · 정상 대상 {len(VALID)} · "
	      f"예외 격리 1 · 혼합 exit 3 · 무요청 1 · 정상 exit 1 · 닫힘 안내 1")
	return 0


if __name__ == "__main__":
	sys.exit(main())
