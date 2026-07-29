#!/usr/bin/env python3
"""제출 세트를 각 건의 submit/ 에 실물로 깐다 — GLG 가 여는 것과 올라가는 것을 같게 만든다.

왜 있나 (2026-07-29 GLG):
  「제출할 버전 세트를 열어서 볼거야. 제출할 양식 그대로.」
  검수는 소스(org/md)가 아니라 **나갈 물건** 위에서 한다. 그래야 실제 제출본과 갭이 없고,
  고칠 때는 org·파이프라인을 고쳐 세트 전체를 다시 깔면 된다.

무엇을 하나:
  - 각 건 submission.md 의 `첨부 컷` 행에서 resume/build/*.pdf 경로를 읽어 submit/ 에 복사
  - cover-letter.md 가 있으면 §붙여넣을 본문만 뽑아 submit/cover-letter.txt 로 (폼은 textarea 다)
  - MANIFEST.sha256 갱신
  - 어느 파일이 폼의 어느 칸으로 가는지 submit/README.md 에 적는다

무엇을 하지 않나:
  - **이미 제출한 건(status=submitted)은 건드리지 않는다.** 그때 나간 파일이 사실이다.
  - submit/ 에 이미 있는데 소스를 모르는 파일(합본 PDF 등)은 지우지 않는다.

  ./stage.py            # ready 인 건 전부
  ./stage.py holiday    # 폴더명에 holiday 가 들어가는 건만
"""
import hashlib
import re
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent

# 폼의 어느 칸으로 가는지 — 파일명 접미사로 판정한다
SLOT = {
	"00-cover.pdf": "⛔ 올리지 않는다 — 합본 입력용 중간 산물",
	"_Resume_": "이력서 (필수)",
	"_Portfolio": "포트폴리오",
	"cover-letter.txt": "커버레터 textarea — 전체 복사해 붙여넣는다",
}


def slot_of(name: str) -> str:
	for key, label in SLOT.items():
		if key in name:
			return label
	return "—"


def status_of(text: str) -> str:
	m = re.search(r"^\|\s*상태\s*\|\s*(.+?)\s*\|", text, re.M)
	if not m:
		return "?"
	raw = m.group(1)
	for s in ("submitted", "ready", "draft", "saved", "closed", "held"):
		if s in raw:
			return s
	return "?"


def cuts_of(text: str) -> list[Path]:
	"""첨부 컷 행에서 resume/build/*.pdf 를 뽑는다."""
	m = re.search(r"^\|\s*첨부 컷\s*\|\s*(.+?)\s*\|", text, re.M)
	if not m:
		return []
	return [ROOT / p for p in re.findall(r"resume/build/[\w.]+\.pdf", m.group(1))]


def paste_body(path: Path) -> str | None:
	"""cover-letter.md 의 §붙여넣을 본문 — 폼에 그대로 들어갈 평문만."""
	text = path.read_text()
	m = re.search(r"^## 붙여넣을 본문\s*\n(.*?)(?=^---\s*$|^## )", text, re.M | re.S)
	return m.group(1).strip() + "\n" if m else None


def stage(case: Path) -> tuple[str, list[str]]:
	record = case / "submission.md"
	text = record.read_text()
	status = status_of(text)
	if status == "submitted":
		return status, []

	out = case / "submit"
	out.mkdir(exist_ok=True)
	staged: list[str] = []

	for cut in cuts_of(text):
		if not cut.exists():
			print(f"  ⚠ 컷 없음: {cut.relative_to(ROOT)} — 먼저 resume 를 빌드한다")
			continue
		shutil.copy2(cut, out / cut.name)
		staged.append(cut.name)

	letter = case / "cover-letter.md"
	if letter.exists():
		body = paste_body(letter)
		if body:
			(out / "cover-letter.txt").write_text(body)
			staged.append("cover-letter.txt")
		else:
			print(f"  ⚠ {letter.name} 에 §붙여넣을 본문 절이 없다")

	# submit/ 에 이미 있던 다른 산출물(합본 PDF 등)도 세트의 일부다
	present = sorted(
		f.name for f in out.iterdir()
		if f.is_file() and f.name not in {"MANIFEST.sha256", "README.md"}
	)

	lines = [
		f"# 제출 세트 — {case.name}",
		"",
		"**이 폴더가 실제로 올라갈 파일 전부다.** 검수는 여기서 한다 — 소스(org/md)가 아니라",
		"나갈 물건 위에서. 고칠 것이 있으면 org·파이프라인을 고치고 `./stage.py` 를 다시 돌린다.",
		"",
		"| 파일 | 폼의 어느 칸 |",
		"|---|---|",
	]
	lines += [f"| `{n}` | {slot_of(n)} |" for n in present]
	lines += [
		"",
		"생성: `applications/stage.py` · 손으로 고치지 않는다.",
		"",
	]
	(out / "README.md").write_text("\n".join(lines))

	digests = [
		f"{hashlib.sha256((out / n).read_bytes()).hexdigest()}  {n}"
		for n in present
	]
	(out / "MANIFEST.sha256").write_text("\n".join(digests) + "\n")

	return status, present


def main() -> int:
	needle = sys.argv[1] if len(sys.argv) > 1 else ""
	cases = sorted(
		d for d in HERE.iterdir()
		if d.is_dir() and (d / "submission.md").exists() and needle in d.name
	)
	if not cases:
		print(f"해당 건 없음: {needle!r}")
		return 1

	touched = 0
	for case in cases:
		status, staged = stage(case)
		if status == "submitted":
			continue
		if not staged:
			continue
		touched += 1
		print(f"{case.name}  [{status}]")
		for name in staged:
			print(f"  {name:<52} {slot_of(name)}")
	print(f"\n{touched}건 세트 갱신")
	return 0


if __name__ == "__main__":
	raise SystemExit(main())
