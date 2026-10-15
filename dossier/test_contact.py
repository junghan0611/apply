#!/usr/bin/env python3
"""dossier 연락처 게이트 회귀 검사 — 임시 사본 트리에서 돈다. 실파일·build/ 는 건드리지 않는다.

`run.sh contact` 의 소스 대조와 `email_gate` 의 산출물 판정을 실패 주입으로 고정한다.
2026-10-15 실물 사고: 소스와 verify 패턴이 같은 `[email removed]` 로 정제돼, 다음 재빌드가
자리표시 이메일을 박은 PDF 를 「이메일 노출 ok」로 통과시킬 상태였다.

	./test_contact.py        # 실패하면 exit 1
"""
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
SSOT = HERE.parent / "resume" / "pipeline" / "preamble.org"
SOURCES = ("competency.org", "portfolio.org", "detail.org")
PLACEHOLDER = "[email removed]"


def ssot_email() -> str:
	m = re.search(r"mailto:([^}]+)", SSOT.read_text())
	return m.group(1)


def tree(td: Path, with_resume: bool = True) -> Path:
	"""dossier/ 와 resume/pipeline/preamble.org 의 사본 트리."""
	d = td / "dossier"
	d.mkdir()
	shutil.copy2(HERE / "run.sh", d / "run.sh")
	for f in SOURCES:
		shutil.copy2(HERE / f, d / f)
	if with_resume:
		(td / "resume" / "pipeline").mkdir(parents=True)
		shutil.copy2(SSOT, td / "resume" / "pipeline" / "preamble.org")
	return d


def contact(d: Path) -> tuple[int, str]:
	r = subprocess.run(["bash", str(d / "run.sh"), "contact"], capture_output=True, text=True, timeout=60)
	return r.returncode, r.stdout + r.stderr


def gate(d: Path, txt: str, email: str) -> tuple[int, str]:
	r = subprocess.run(
		["bash", "-c", 'source "$1"; email_gate "$2" "$3"', "_", str(d / "run.sh"), txt, email],
		capture_output=True, text=True, timeout=60,
	)
	return r.returncode, r.stdout + r.stderr


def edit(path: Path, old: str, new: str, count: int = 1):
	text = path.read_text()
	assert old in text, f"주입 자리 없음: {path.name} {old!r}"
	path.write_text(text.replace(old, new, count))


def main():
	fails = []
	email = ssot_email()
	# 예약된 example 도메인의 합성 주소. 공개 스캐너 self-test와 같이 리터럴을 분리한다.
	other = "someone.else" + "@" + "example.org"
	cases = []

	def expect(name, code, out, ok, needle=None, absent=None):
		cases.append(name)
		if (code == 0) != ok:
			fails.append(f"{name}: exit {code} (기대 {'0' if ok else '≠0'})\n    {out.strip()[-300:]}")
		elif needle and needle not in out:
			fails.append(f"{name}: 출력에 「{needle}」 없음\n    {out.strip()[-300:]}")
		elif absent and absent in out:
			fails.append(f"{name}: 출력에 「{absent}」 가 있으면 안 된다")

	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		expect("현재 소스", *contact(d), ok=True, needle=email)

	# 소스 실패 주입
	injections = [
		("competency mailto 자리표시", "competency.org", f"mailto:{email}", f"mailto:{PLACEHOLDER}", "정제 자리표시"),
		("portfolio odt 자리표시", "portfolio.org", f">{email}</text:a>", f">{PLACEHOLDER}</text:a>", "정제 자리표시"),
		("detail #+email 자리표시", "detail.org", f"#+email: {email}", f"#+email: {PLACEHOLDER}", "정제 자리표시"),
		("portfolio 다른 주소", "portfolio.org", f"mailto:{email}", f"mailto:{other}", "정본과 다른"),
	]
	for name, f, old, new, needle in injections:
		with tempfile.TemporaryDirectory() as td:
			d = tree(Path(td))
			edit(d / f, old, new)
			expect(name, *contact(d), ok=False, needle=needle)

	# 정본이 있는데 못 읽으면 실패 — 패키지 폴백으로 숨기지 않는다.
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		pre = Path(td) / "resume" / "pipeline" / "preamble.org"
		pre.write_text(pre.read_text().replace("mailto:", "nomail:"))
		expect("정본 파싱 불가", *contact(d), ok=False, needle="읽지 못했다", absent="패키지 실행")
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		pre = Path(td) / "resume" / "pipeline" / "preamble.org"
		edit(pre, f"mailto:{email}", f"mailto:{PLACEHOLDER}")
		expect("정본 자리표시", *contact(d), ok=False, needle="정제 자리표시")
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		(Path(td) / "resume" / "pipeline" / "preamble.org").unlink()
		expect("정본 파일 없음(resume/ 있음)", *contact(d), ok=False, needle="정본 없음")

	# 패키지(resume/ 없음) — competency.org #+email 로 폴백하고 그 사실을 말한다.
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td), with_resume=False)
		expect("패키지 폴백", *contact(d), ok=True, needle="패키지 실행")
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td), with_resume=False)
		edit(d / "competency.org", f"#+email: {email}", f"#+email: {PLACEHOLDER}")
		expect("패키지 폴백 자리표시", *contact(d), ok=False, needle="정제 자리표시")

	# 산출물 판정 — PDF 텍스트를 흉내 낸 문자열.
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		expect("PDF 정본 주소", *gate(d, f"김정한 {email} github.com/junghan0611", email), ok=True)
		expect("PDF 자리표시", *gate(d, f"김정한 {PLACEHOLDER} github.com", email), ok=False, needle="자리표시")
		expect("PDF 자리표시+정본", *gate(d, f"{email}\n{PLACEHOLDER}", email), ok=False, needle="자리표시")
		expect("PDF 다른 주소만", *gate(d, f"김정한 {other}", email), ok=False, needle="정본과 다른")
		expect("PDF 주소 없음", *gate(d, "김정한 github.com/junghan0611", email), ok=False, needle="안 보임")

	n = len(cases)
	if fails:
		print(f"FAIL {len(fails)}/{n}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {n}/{n} — 소스 대조 · 실패 주입 {len(injections)} · 정본 3 · 패키지 폴백 2 · 산출물 판정 5")
	return 0


if __name__ == "__main__":
	sys.exit(main())
