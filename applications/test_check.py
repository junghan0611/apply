#!/usr/bin/env python3
"""check.py --public 회귀 검사 — 임시 git 저장소에서 돈다. 이 저장소의 파일은 건드리지 않는다.

공개 후보(추적 + 미추적·비ignore)의 private artifact 는 실패로, gitignore 된 로컬 보관면은
정보로만 가른다. git 목록을 못 얻으면 파일시스템 전체로 fail-closed 한다.
2026-10-15 실물 사고: 로컬 `submit/` 사본 58건이 전부 실패로 세어져 게이트가 늘 빨간불이었다.

	./test_check.py        # 실패하면 exit 1
"""
import importlib.util
import os
import subprocess
import sys
import tempfile
from pathlib import Path

_here = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location("check", os.path.join(_here, "check.py"))
check = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(check)

# (경로, 상태) — tracked: git add · untracked: 그냥 둠 · ignored: .gitignore 로 가림
TREE = [
	("docs/a.pdf", "tracked"),
	("docs/my file.pdf", "tracked"),                    # 공백 — `-z` 로 경로가 온전해야 한다
	("out/b.ZIP", "untracked"),                         # 대문자 확장자
	("applications/x/assignment/sub/task.md", "untracked"),  # 과제 디렉터리 아래 깊은 파일
	("applications/x/referral.md", "untracked"),
	("applications/x/Foo_Detail_Form.md", "tracked"),
	("applications/x/submit/KimJunghan_Resume.pdf", "ignored"),
	("applications/x/submit/bundle.zip", "ignored"),
	("README.md", "tracked"),
	("applications/x/submission.md", "untracked"),
]
MUST_FAIL = {p for p, s in TREE if s != "ignored" and check.private_kind(p)}
MUST_PASS = {p for p, s in TREE if s == "ignored" or not check.private_kind(p)}


def build(root: Path, use_git: bool):
	for rel, _ in TREE:
		f = root / rel
		f.parent.mkdir(parents=True, exist_ok=True)
		f.write_text("x")
	if not use_git:
		return
	(root / ".gitignore").write_text("applications/*/submit/*.pdf\napplications/*/submit/*.zip\n")
	git = ["git", "-C", str(root)]
	subprocess.run(git + ["init", "-q"], check=True)
	tracked = [rel for rel, s in TREE if s == "tracked"] + [".gitignore"]
	subprocess.run(git + ["add", "--", *tracked], check=True)


def flagged(faults):
	return {f.split(": ", 1)[0] for f in faults}


def main():
	fails = []
	n = 0

	# 1. 범주 판정 — 경로만 보고 정한다.
	kinds = [
		("x/y.PDF", True), ("x/y.odt", True), ("x/assignment/z", True),
		("x/assignment/deep/z.txt", True), ("referral.md", True),
		("a/Foo_Applicant_Form.md", True), ("README.md", False), ("x/pdf.md", False),
		("x/assignments/z", False),
	]
	for rel, want in kinds:
		n += 1
		if bool(check.private_kind(rel)) != want:
			fails.append(f"private_kind({rel!r}) → {check.private_kind(rel)!r}, 기대 {want}")

	# 2. git 저장소: 공개 후보만 실패, ignore 된 것은 정보.
	with tempfile.TemporaryDirectory() as td:
		root = Path(td)
		build(root, use_git=True)
		faults, notes = check.public_faults(root)
		got = flagged(faults)
		n += 4
		if got != MUST_FAIL:
			fails.append(f"git: 실패 집합 {sorted(got)} ≠ 기대 {sorted(MUST_FAIL)}")
		if got & MUST_PASS:
			fails.append(f"git: ignore 된 로컬 보관면을 실패로 셌다 {sorted(got & MUST_PASS)}")
		if not any("gitignored) 2건" in x for x in notes):
			fails.append(f"git: ignore 된 2건이 정보로 나오지 않음 {notes}")
		if any("fail-closed" in x for x in notes):
			fails.append("git: 정상 저장소에서 fail-closed 폴백을 탔다")

	# 3. git 밖(목록 실패): 파일시스템 전체로 fail-closed — ignore 될 뻔한 것도 실패다.
	with tempfile.TemporaryDirectory() as td:
		root = Path(td)
		build(root, use_git=False)
		faults, notes = check.public_faults(root)
		got = flagged(faults)
		every = {p for p, _ in TREE if check.private_kind(p)}
		n += 2
		if got != every:
			fails.append(f"no-git: fail-closed 실패 집합 {sorted(got)} ≠ 기대 {sorted(every)}")
		if not any("fail-closed" in x for x in notes):
			fails.append(f"no-git: 폴백 사실을 알리지 않음 {notes}")

	if fails:
		print(f"FAIL {len(fails)}/{n}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {n}/{n} — 범주 {len(kinds)} · git 공개후보/ignore 분리 4 · git 밖 fail-closed 2")
	return 0


if __name__ == "__main__":
	sys.exit(main())
