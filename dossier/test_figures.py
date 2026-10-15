#!/usr/bin/env python3
"""dossier 도해 게이트 회귀 검사 — 임시 사본 트리에서 돈다. 실파일·build/ 는 건드리지 않는다.

`run.sh figures` 의 소스 대조(export 범위 자리표시 · 참조 파일 존재)와 `figure_gate` 의 산출물
판정(자리표시 · 캡션 수 = 소스 기대량)을 실패 주입으로 고정한다.
2026-10-15 실물 사고: `[diagram removed at publication …]` 이 PDF·MD 에 찍혔는데 verify 는
이미지·캡션을 warn 만 해서 통과했다.

	./test_figures.py        # 실패하면 exit 1
"""
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCES = ("competency.org", "portfolio.org", "detail.org")
DIAGRAM_HOLE = "[diagram " + "removed at publication]"


def tree(td: Path) -> Path:
	d = td / "dossier"
	d.mkdir()
	shutil.copy2(HERE / "run.sh", d / "run.sh")
	for f in SOURCES:
		shutil.copy2(HERE / f, d / f)
	shutil.copytree(HERE / "images", d / "images")
	return d


def run(d: Path, *args: str) -> tuple[int, str]:
	r = subprocess.run(["bash", str(d / "run.sh"), *args], capture_output=True, text=True, timeout=120)
	return r.returncode, r.stdout + r.stderr


def sourced(d: Path, script: str, *args: str) -> tuple[int, str]:
	r = subprocess.run(["bash", "-c", f'source "$1"; shift; {script}', "_", str(d / "run.sh"), *args],
	                   capture_output=True, text=True, timeout=120)
	return r.returncode, r.stdout + r.stderr


def main():
	fails = []
	cases = []

	def expect(name, code, out, ok, needle=None):
		cases.append(name)
		if (code == 0) != ok:
			fails.append(f"{name}: exit {code} (기대 {'0' if ok else '≠0'})\n    {out.strip()[-300:]}")
		elif needle and needle not in out:
			fails.append(f"{name}: 출력에 「{needle}」 없음\n    {out.strip()[-300:]}")

	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		expect("현재 소스", *run(d, "figures"), ok=True, needle="참조 11건")

	# 소스 실패 주입
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		p = d / "portfolio.org"
		p.write_text(p.read_text().replace("[[file:images/openclaw-ops.png]]", DIAGRAM_HOLE, 1))
		expect("export 범위 자리표시", *run(d, "figures"), ok=False, needle="정제 자리표시")
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		(d / "images" / "andenken-rag.png").unlink()
		expect("참조 파일 없음", *run(d, "figures"), ok=False, needle="andenken-rag.png")

	# export 범위 판정 — :noexport:·COMMENT 서브트리, 주석·예제 블록 안은 세지 않는다.
	scope = (
		"* 본문\n[[file:images/a.png]]\n"
		"* 메모 :noexport:\n[[file:images/b.png]]\n" + DIAGRAM_HOLE + "\n** 아래 단계도 제외\n[[file:images/c.png]]\n"
		"* COMMENT 초안\n[[file:images/d.png]]\n"
		"* 다시 본문\n#+begin_example\n[[file:images/e.png]]\n#+end_example\n# [[file:images/f.png]]\n"
		"[[file:./images/g.png]]\n"
	)
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		(d / "scope.org").write_text(scope)
		code, out = sourced(d, 'export_scan "$1"', str(d / "scope.org"))
		got = sorted(x.split()[1] for x in out.splitlines() if x.startswith("ref "))
		cases.append("export 범위")
		if code != 0 or got != ["images/a.png", "images/g.png"] or "placeholder" in out:
			fails.append(f"export 범위: {got} / {out.strip()[:200]!r} (기대 a·g 만, 자리표시 0)")
		code, out = sourced(d, 'expected_figures "$1"', str(d / "portfolio.org"))
		cases.append("portfolio 기대량")
		if out.strip() != "6":
			fails.append(f"portfolio 기대량: {out.strip()!r} (기대 6)")

	# 산출물 판정 — PDF 텍스트를 흉내 낸 문자열.
	with tempfile.TemporaryDirectory() as td:
		d = tree(Path(td))
		three = "그림 1. 가\n본문\n그림 2. 나\n그림 3. 다\n"
		expect("캡션 3/3", *sourced(d, 'figure_gate "$1" "$2"', three, "3"), ok=True)
		expect("캡션 부족", *sourced(d, 'figure_gate "$1" "$2"', three, "4"), ok=False, needle="기대 4")
		expect("자리표시 찍힘", *sourced(d, 'figure_gate "$1" "$2"', three + DIAGRAM_HOLE, "3"),
		       ok=False, needle="자리표시")
		expect("기대 0 · 그림 0", *sourced(d, 'figure_gate "$1" "$2"', "본문만\n", "0"), ok=True)
		expect("기대 0 · 그림 있음", *sourced(d, 'figure_gate "$1" "$2"', three, "0"), ok=False)

	n = len(cases)
	if fails:
		print(f"FAIL {len(fails)}/{n}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {n}/{n} — 소스 대조 · 실패 주입 2 · export 범위 2 · 산출물 판정 5")
	return 0


if __name__ == "__main__":
	sys.exit(main())
