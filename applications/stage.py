#!/usr/bin/env python3
"""제출 세트를 각 건의 submit/ 에 실물로 깐다 — GLG 가 여는 것과 올라가는 것을 같게 만든다.

왜 있나 (2026-07-29 GLG):
  「제출할 버전 세트를 열어서 볼거야. 제출할 양식 그대로.」
  검수는 소스(org/md)가 아니라 **나갈 물건** 위에서 한다. 그래야 실제 제출본과 갭이 없고,
  고칠 때는 org·파이프라인을 고쳐 세트 전체를 다시 깔면 된다.

무엇을 하나:
  - 각 건 submission.md 의 `첨부 컷` 행에서 resume/build/*.pdf 경로를 읽어 submit/ 에 복사
  - `추가 첨부` 행이 있으면 dossier/build/*.pdf(경력기술서·포트폴리오)도 함께 깐다
    ⭐ 2026-07-30 추가. 그 전에는 이력서 컷만 깔 수 있어서, 폼에 선택 첨부 슬롯이 있는
    건도 세트를 열면 **이력서 한 장뿐**이었다. AIRS 에 나간 dossier 2종은 손으로 복사된
    것이고 파이프라인에 경로가 없었다 — 「성의가 없다」의 구조적 원인이 여기였다.
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
DEPTH_MARK = "KimJunghan_AX_"  # 회사 중립이어야 하는 깊이 문서
# stage.py 가 소유하는 파일 — 「추가 첨부」에서 빠지면 치운다. 글롭이 아니라 정확한 이름이다.
MANAGED = ("KimJunghan_AX_Competency.pdf", "KimJunghan_AX_Portfolio.pdf")

# 폼의 어느 칸으로 가는지 — 파일명 접미사로 판정한다
SLOT = {
	"00-cover.pdf": "⛔ 올리지 않는다 — 합본 입력용 중간 산물",
	"_Resume_": "이력서 (필수)",
	"_Competency": "경력기술서·역량기술서 (5쪽) — 선택 슬롯이 **있으면** 올린다",
	"_Portfolio": "포트폴리오 (12쪽) — 선택 슬롯이 **있으면** 올린다. 칸이 하나면 이것을",
	"cover-letter.txt": "커버레터 — 전체 복사해 붙여넣는다 (칸 유무·상한은 그 건 `submission.md` §폼)",
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
	"""첨부 행에서 빌드 산출물을 뽑는다 — 이력서 컷(resume/)과 깊이 문서(dossier/) 둘 다.

	`첨부 컷` 은 폼의 필수 이력서 슬롯, `추가 첨부` 는 선택 슬롯(경력기술서·포트폴리오)이다.
	슬롯이 없는 폼에는 `추가 첨부` 행을 두지 않는다 — 세트에 낼 수 없는 파일을 깔지 않는다.
	"""
	found: list[Path] = []
	for row in ("첨부 컷", "추가 첨부"):
		m = re.search(rf"^\|\s*{row}\s*\|\s*(.+?)\s*\|", text, re.M)
		if not m:
			continue
		found += [
			ROOT / p
			for p in re.findall(r"(?:resume|dossier)/build/[\w.]+\.pdf", m.group(1))
		]
	return list(dict.fromkeys(found))


def source_org(pdf: Path) -> list[Path]:
	"""이 PDF 를 만드는 org 정본만 고른다.

	⚠ 레인 전체(dossier 의 org 둘)를 보면 **과잉 판정**이 난다 — `competency.org` 만 고쳐도
	`Portfolio` 가 낡았다고 한다. 그러면 3.8MB 를 헛되게 다시 굽고, 「또 낡음」 피로가 쌓여
	**검사를 무시하게 된다.** 산출물 하나에 대응하는 정본만 본다.
	"""
	name = pdf.stem
	if name == "KimJunghan_AX_Competency":
		return [ROOT / "dossier/competency.org"]
	if name == "KimJunghan_AX_Portfolio":
		return [ROOT / "dossier/portfolio.org"]
	if name.startswith("KimJunghan_Resume_"):
		target = name[len("KimJunghan_Resume_") :].lower().replace("_", "-")
		return [ROOT / "resume/body.org", ROOT / f"resume/targets/{target}.org"]
	return []


def is_stale(pdf: Path) -> bool:
	"""빌드 산출물이 정본 org 보다 오래됐는가 — **gitignore 된 깊이 문서에만 적용한다.**

	막으려는 사고는 하나다: **`dossier/build/` 는 git 밖이라 노트북에 앞 회사 조준판이
	남아 있고**, `git pull` 로 새 org 를 받아도 재빌드하지 않으면 그것이 그대로 깔린다.

	⛔ **tracked 이력서 컷에는 쓰지 않는다** (2026-07-30 GPT 재검 P0-A).
	git 은 커밋 시각을 복원하지 않고 **checkout 순간의 mtime** 을 준다. 같은 커밋에서 PDF 와
	org 가 함께 갱신돼도 경로 정렬상 `resume/build/*.pdf` 가 `resume/targets/*.org` 보다 먼저
	써지면 **PDF 가 stale 로 오판**된다. 그러면 노트북 `git pull` 직후 `stage.py` 가 이력서
	재빌드를 요구하고, 「resume 빌드는 선택」이라는 §0 과 정면으로 충돌한다 —
	**카페에서 막힌다.** tracked 쌍의 일치는 같은 커밋의 원자성이 보증한다.
	(mtime 으로 tracked source/output 일치를 판정하지 않는다. 필요해지면 build provenance
	hash 를 넣는다.)
	"""
	if DEPTH_MARK not in pdf.name:
		return False
	orgs = [p for p in source_org(pdf) if p.exists()]
	if not orgs:
		return False
	return pdf.stat().st_mtime < max(p.stat().st_mtime for p in orgs)


def aim_leak(pdf: Path, case_name: str) -> str | None:
	"""깊이 문서에 다른 건의 회사 이름이 실렸는지 — check.py 의 판정을 재사용한다.

	사람이 `--deep` 을 따로 기억하는 구조를 만들지 않는다 (GPT 교차검수 P0-3).
	"""
	if DEPTH_MARK not in pdf.name:
		return None
	try:
		sys.path.insert(0, str(HERE))
		import check  # noqa: PLC0415 — 같은 폴더의 도구를 재사용한다
	except Exception as exc:
		# fail-closed. import 가 깨졌을 때 「깨끗하다」로 처리하면 안전 게이트가 아니다
		# (2026-07-30 GPT 재검 P0-C). gs 실패는 이미 fail-closed 였고 여기만 열려 있었다.
		return f"{pdf.name}: 조준 검사를 실행하지 못했다 ({exc}) — check.py 를 고친다"
	text = check.pdf_text(pdf)
	if text is None:
		return f"{pdf.name}: gs 로 본문을 못 읽었다 — 판정하지 않는다"
	own = next((k for k in check.BRANDS if case_name.startswith(k)), None)
	head = check.aim_scope(text)
	for slug, names in check.BRANDS.items():
		if slug == own:
			continue
		for name in names:
			if re.search(rf"(?<!\w){re.escape(name)}(?!\w)", head, re.I):
				return f"{pdf.name}: 「{name}」 조준이 남아 있다 — 중립판으로 재빌드한다"
	return None


def paste_body(path: Path) -> str | None:
	"""cover-letter.md 의 §붙여넣을 본문 — 폼에 그대로 들어갈 평문만."""
	text = path.read_text()
	m = re.search(r"^## 붙여넣을 본문\s*\n(.*?)(?=^---\s*$|^## )", text, re.M | re.S)
	return m.group(1).strip() + "\n" if m else None


def stage(case: Path) -> tuple[str, list[str], list[str]]:
	record = case / "submission.md"
	text = record.read_text()
	status = status_of(text)
	if status == "submitted":
		return status, [], []

	out = case / "submit"
	out.mkdir(exist_ok=True)
	staged: list[str] = []

	problems: list[str] = []
	for cut in cuts_of(text):
		if not cut.exists():
			lane = "dossier" if "dossier/" in str(cut) else "resume"
			# 경고만 하고 성공하면 「제출 준비 명령이 통과했는데 세트가 불완전」해진다.
			# 나열된 소스가 없는 것은 실패다 (2026-07-30 GPT 교차검수 P0-3).
			problems.append(
				f"없음: {cut.relative_to(ROOT)} — 먼저 (cd {lane} && ./run.sh) 를 돌린다"
			)
			continue
		if is_stale(cut):
			problems.append(
				f"낡음: {cut.relative_to(ROOT)} 가 정본 org 보다 오래됐다 — 다시 빌드한다"
			)
			continue
		shutil.copy2(cut, out / cut.name)
		staged.append(cut.name)
		# 깐 직후 바로 조준을 검사한다 — 사람이 `--deep` 을 따로 기억하는 구조를 만들지 않는다.
		leak = aim_leak(out / cut.name, case.name)
		if leak:
			problems.append(leak)

	letter = case / "cover-letter.md"
	if letter.exists():
		body = paste_body(letter)
		if body:
			(out / "cover-letter.txt").write_text(body)
			staged.append("cover-letter.txt")
		else:
			print(f"  ⚠ {letter.name} 에 §붙여넣을 본문 절이 없다")

	# 「추가 첨부」에서 빠진 관리 대상 파일은 치운다.
	# **남겨 두면 오업로드 위험**이다 — README 는 「이 폴더가 올라갈 파일 전부」라고 말하는데
	# 기록은 안 낸다고 말하는 모순이 생긴다. SOCAR 가 실제로 그 상태였다 (GPT 교차검수 P0-4).
	#
	# ⚠ **정확한 파일명 allowlist 로만 지운다** (2026-07-30 GPT 재검). `KimJunghan_AX_*` 글롭은
	# 미래의 Evidence ZIP·합본까지 지울 수 있다. 계약은 미리 좁혀 둔다.
	for name in MANAGED:
		target = out / name
		if target.exists() and name not in staged:
			target.unlink()
			print(f"  🧹 치웠다: {name} — 「추가 첨부」에 없다")

	# 합본 입력용 중간 산물은 세트에 두지 않는다 — 폴더 기준으로 움직이면 올라간다
	# (2026-07-30 GPT 재검). 발사대에서 다시 만들 수 있는 파일이다.
	for interim in ("00-cover.pdf",):
		if (out / interim).exists():
			(out / interim).unlink()
			print(f"  🧹 치웠다: {interim} — 합본 입력용 중간 산물이라 세트에 두지 않는다")

	# submit/ 에 이미 있던 다른 산출물(합본 PDF 등)도 세트의 일부다
	present = sorted(
		f.name for f in out.iterdir()
		if f.is_file() and f.name not in {"MANIFEST.sha256", "README.md", "SOURCES.md"}
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
	# 첨부가 하나도 없는 건(draft·held)에는 빈 지문·재현 안내를 두지 않는다.
	# 빈 MANIFEST 는 `sha256sum -c` 를 깨뜨린다 (2026-07-30 GPT 교차검수).
	if present:
		(out / "MANIFEST.sha256").write_text("\n".join(digests) + "\n")
		(out / "SOURCES.md").write_text(sources_doc(case, present))
	else:
		for leftover in ("MANIFEST.sha256", "SOURCES.md"):
			(out / leftover).unlink(missing_ok=True)

	return status, present, problems




def sources_doc(case: Path, present: list[str]) -> str:
	"""PDF 는 git 에 없다. 무엇으로 이 세트를 다시 만드는지 여기 적는다."""
	needs_resume = any("_Resume_" in n for n in present)
	needs_dossier = any(("_Competency" in n or "_Portfolio" in n) for n in present)

	lines = [
		f"# 이 세트를 어떻게 다시 만드나 — {case.name}",
		"",
		"**새 깊이 PDF(`KimJunghan_AX_*`)는 git 에 없다** (`.gitignore`). 산출물이고 정본은 org 다.",
		"이력서 컷과 제출 완료 건의 옛 스냅샷은 **이미 tracked 라 `git pull` 로 온다** —",
		"「PDF 가 아예 없다」는 절대명제가 아니다.",
		"",
		"`MANIFEST.sha256` 은 **그때 낸 파일의 identity commitment** 다. 파일이 있으면",
		"**바이트 동일 여부를 판정**하고, 없으면 증언만 보존한다. 원본을 버린 뒤 비결정적",
		"빌드가 지문과 어긋나면 *무엇이* 달라졌는지는 말해 주지 않는다 — 재현 경로는 아래다.",
		"",
		"- ⭐ **재현점은 이 파일이 담긴 커밋이다.** 그 커밋에 org 정본이 함께 들어 있다 —",
		"  `git log --oneline -- <이 파일>` 로 찾고 `git show <커밋>:dossier/competency.org` 로 꺼낸다.",
		"  (커밋 SHA 를 여기 박지 않는다. 박으면 커밋할 때마다 이 파일이 갱신되는 순환이 생긴다.)",
		"",
		"```bash",
	]
	if needs_resume:
		lines.append("(cd resume   && ./run.sh all)        # 이력서 여섯 컷")
	if needs_dossier:
		lines += [
			"(cd dossier && ./run.sh competency)   # 5쪽 — xelatex 경로",
			"(cd dossier && ./run.sh portfolio)    # 12쪽 — LibreOffice 불필요",
		]
	lines += [
		"applications/stage.py                 # 세트를 다시 깐다 (누출·낡음을 스스로 검사한다)",
		"applications/check.py --deep          # 전체 게이트 — 조준 누출 + 지문 대조",
		"```",
		"",
	]
	if needs_dossier:
		lines += [
			"⚠ **깊이 문서는 회사 중립판이어야 한다.** `competency.org` 프롤로그 첫 문장이",
			"조준 자리다. 다른 건을 조준한 채로 빌드하면 **그 회사 이름이 이 건에 실려 나간다.**",
			"`./check.py --deep` 이 그것을 잡는다.",
			"",
		]
	lines.append("생성: `applications/stage.py` · 손으로 고치지 않는다.\n")
	return "\n".join(lines)


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
	failed: list[str] = []
	for case in cases:
		status, staged, problems = stage(case)
		if status == "submitted":
			continue
		if not staged and not problems:
			continue
		touched += 1 if staged else 0
		print(f"{case.name}  [{status}]")
		for name in staged:
			print(f"  {name:<52} {slot_of(name)}")
		for problem in problems:
			print(f"  🔴 {problem}")
			failed.append(f"{case.name}: {problem}")

	print(f"\n{touched}건 세트 갱신")
	if failed:
		# 조용히 성공하지 않는다 — 세트가 불완전하거나 타사 조준판인데 exit 0 이면
		# 「준비 명령이 통과했으니 올려도 된다」로 읽힌다 (GPT 교차검수 P0-3).
		print(f"\n🔴 FAIL {len(failed)}건 — 이 세트는 올리지 않는다:")
		for item in failed:
			print(f"  {item}")
		return 1
	return 0


if __name__ == "__main__":
	raise SystemExit(main())
