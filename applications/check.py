#!/usr/bin/env python3
"""LEDGER와 건별 submission/submit 스냅샷의 닫힘 상태를 검사한다.

  ./check.py          # 빠른 검사 — 원장 ↔ 기록 ↔ 세트 정합
  ./check.py --deep   # + 깊이 문서의 조준 누출 검사 (gs 로 PDF 본문을 읽는다, 수십 초)

`--deep` 이 왜 있나 (2026-07-30):
  `dossier/` 정본은 **한 벌**이고 `competency.org` 프롤로그 한 줄이 조준 자리다. 한 건을
  조준해 빌드한 뒤 중립으로 되돌리지 않으면, 다음 건 세트에 **앞 회사 이름이 실려 나간다.**
  실제로 2026-07-30 아침 AIRS 조준판이 그대로 남아 있었다. 사람이 눈으로 볼 수 없는 사고라
  기계가 잡는다.
"""
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
LEDGER = ROOT / "LEDGER.md"
STATUSES = {"draft", "ready", "saved", "submitted", "replied", "interview",
            "offer", "rejected", "closed"}

# 조준 누출 검사 — 폴더 슬러그 → 깊이 문서 본문에서 찾을 표기.
# 자기 건의 표기는 허용하고, 다른 건의 표기가 나오면 조준을 되돌리지 않은 것이다.
BRANDS = {
	"airs-medical": ("AIRS", "에어스"),
	"hanwha-vision": ("Hanwha Vision", "한화비전"),
	"lunit": ("Lunit", "루닛"),
	"socar": ("SOCAR", "쏘카"),
	"toss": ("Toss", "비바리퍼블리카"),
	"upstage": ("Upstage", "업스테이지"),
	"friendliai": ("FriendliAI",),
	"furiosaai": ("FuriosaAI",),
	"42dot": ("42dot",),
	"reflection-ai": ("Reflection AI",),
	"makinarocks": ("MakinaRocks", "마키나락스"),
	"cohere": ("Cohere",),
	"openai": ("OpenAI",),
	"nhn": ("NHN",),
	# 깊이 문서를 붙이지 않는 건도 사전에 둔다 — 조준부를 그 회사로 바꿔 빌드한 판이
	# 다른 건에 남는 사고는 축과 무관하게 일어난다.
	"bear-robotics": ("Bear Robotics",),  # 단독 `Bear` 는 영어 낱말이라 쓰지 않는다
	"holiday-robotics": ("Holiday Robotics",),
	"telechips": ("Telechips", "텔레칩스"),
	"telit-cinterion": ("Telit",),
	"sonatus": ("Sonatus",),
	"enhans": ("Enhans",),
	"deepx": ("DEEPX",),
	"hyundai-autoever": ("AutoEver", "오토에버"),
	# 단독 `카카오` 는 쓰지 않는다 — 계열사가 많고 본문에 정당하게 등장할 수 있다
	"kakao-healthcare": ("Kakao Healthcare", "카카오헬스케어"),
	"ge-healthcare": ("GE HealthCare",),  # 단독 `GE` 는 오탐이 난다
	"penguin-solutions": ("Penguin Solutions",),
	"xcena": ("XCENA", "엑시나"),
	"insighter": ("Insighter",),
}
DEPTH_DOC = "KimJunghan_AX_"  # 회사 중립이어야 하는 파일

# 검사 범위는 **참고문헌 절 이전 본문 전체**다.
#
# 왜 이 경계인가 (2026-07-30, GPT 교차검수 J3):
#   첫 판은 본문 전체를 봤고 참고문헌의 `OpenAI, "Codex cli." 2025`(문서 93% 위치)를
#   조준으로 읽어 12건을 오판했다. 그래서 「앞 6,000자」로 좁혔는데 그것은 **휴리스틱이라
#   구조적으로 뚫려 있었다** — `portfolio.org` 는 프로젝트마다 「JD 관련성」 절을 두는
#   문법이고(`dossier/AGENTS.md` §편집 우선순위) 거기 조준문이 들어가면 6,000자 밖이다.
#   페이지 비율·문자 수보다 **문서 구조 경계가 안정적이다.**
#
#   현재 정본 정책은 「깊이 문서 본문에 회사명 0건」이다. 본문에 정당한 회사명이
#   필요해지면 그때 BRANDS 옆에 명시 allowlist 를 둔다 — 범위를 다시 좁히지 않는다.
BIB_HEADS = ("참고자료", "참고문헌", "References", "REFERENCES")


def aim_scope(text: str) -> str:
	"""조준 검사 범위 — 참고문헌 절 앞까지."""
	cut = len(text)
	for head in BIB_HEADS:
		i = text.find(head)
		if i != -1:
			cut = min(cut, i)
	return text[:cut]


def pdf_text(path: Path) -> str | None:
	"""gs 로 본문을 뽑는다. pdftotext 는 이 서버에 없고, 없는 채로 부르면
	빈 결과가 「깨끗함」으로 읽힌다 — 그 오독을 만들지 않는다."""
	try:
		out = subprocess.run(
			["gs", "-q", "-sDEVICE=txtwrite", "-o", "-", str(path)],
			capture_output=True, text=True, timeout=120,
		)
	except FileNotFoundError:
		return None
	except subprocess.SubprocessError:
		return None
	return out.stdout if out.returncode == 0 else None


def digest_faults(dirpath: Path, manifest: Path) -> list[str]:
	"""지문을 실제로 검사한다.

	**있는 파일만 해시를 비교하고, 없는 파일은 「증언만 보존」으로 통과시킨다** —
	PDF 는 git 밖이라 clone 한 기계에서는 당연히 없다. 그 부재를 실패로 읽으면
	검사가 늘 빨간불이라 아무도 보지 않게 된다 (2026-07-30 GPT 교차검수).
	"""
	import hashlib

	out = []
	for line in manifest.read_text().splitlines():
		line = line.strip()
		if not line:
			continue
		parts = line.split(None, 1)
		if len(parts) != 2 or len(parts[0]) != 64 or not re.fullmatch(r"[0-9a-f]{64}", parts[0]):
			out.append(
				f"{dirpath.name}: MANIFEST 형식이 깨졌다 — `{line[:40]}` "
				f"(sha256sum -c 가 실패한다)"
			)
			continue
		digest, name = parts
		target = dirpath / "submit" / name
		if not target.exists():
			continue  # 증언만 보존 — 파일은 git 밖이다
		actual = hashlib.sha256(target.read_bytes()).hexdigest()
		if actual != digest:
			out.append(
				f"{dirpath.name}/submit/{name}: 지문 불일치 — 그때 낸 파일과 **바이트가 다르다**"
			)
	return out


def aim_leaks(dirpath: Path) -> list[str]:
	"""이 건의 깊이 문서에 다른 건의 회사 이름이 실렸는지."""
	out = []
	own = next((k for k in BRANDS if dirpath.name.startswith(k)), None)
	for pdf in sorted((dirpath / "submit").glob(f"{DEPTH_DOC}*.pdf")):
		text = pdf_text(pdf)
		if text is None:
			out.append(f"{dirpath.name}/submit/{pdf.name}: gs 로 본문을 못 읽었다 — 판정하지 않는다")
			continue
		head = aim_scope(text)
		for slug, names in BRANDS.items():
			if slug == own:
				continue
			for name in names:
				if re.search(rf"(?<!\w){re.escape(name)}(?!\w)", head, re.I):
					out.append(
						f"{dirpath.name}/submit/{pdf.name}: 「{name}」 조준이 남아 있다 — "
						f"dossier 를 중립판으로 재빌드하고 stage.py 를 다시 돌린다"
					)
					break
	return out


def table_rows(text):
	for line in text.splitlines():
		if not line.startswith("|") or line.startswith("|---") or "| 회사 |" in line:
			continue
		cols = [c.strip().strip("`") for c in line.strip().strip("|").split("|")]
		if len(cols) == 7 and cols[2] in STATUSES:
			yield cols


def field(text, name):
	m = re.search(rf"^\|\s*{re.escape(name)}\s*\|\s*(.*?)\s*\|$", text, re.M)
	return m.group(1) if m else ""


def main():
	deep = "--deep" in sys.argv[1:]
	fails = []
	checked = 0
	deep_seen = 0
	for company, role, status, date, channel, cut, folder in table_rows(LEDGER.read_text()):
		if folder.startswith("../"):
			continue  # 닫힌 외부 레인은 자기 검증 계약을 쓴다.
		dirpath = ROOT / folder
		record = dirpath / "submission.md"
		if not record.exists():
			fails.append(f"{folder}: submission.md 없음")
			continue
		checked += 1
		text = record.read_text()
		record_status = field(text, "상태").lower()
		if not re.search(rf"\b{re.escape(status)}\b", record_status):
			fails.append(f"{folder}: LEDGER={status}, submission={record_status or '?'}")
		# 지문 대조는 **manifest 가 있는 모든 건**에서 돈다 (2026-07-30 GPT 재검 P0-B).
		# `submitted` 안에만 두면 ready 세트의 PDF 가 손상·교체돼도 마지막 게이트가 통과한다 —
		# 「전체 게이트」라는 이름이 거짓이 된다. stage 직후라 비용도 작다.
		manifest = dirpath / "submit" / "MANIFEST.sha256"
		if manifest.exists() and manifest.read_text().strip():
			fails += digest_faults(dirpath, manifest)

		if status == "submitted":
			record_date = field(text, "지원일")
			if date == "—" or date not in record_date:
				fails.append(f"{folder}: submitted 날짜 불일치 LEDGER={date}, submission={record_date or '?'}")
			# PDF 는 git 밖이다(2026-07-30). 다른 기계에서 clone 하면 파일이 없으므로
			# **지문과 재현 경로**가 스냅샷의 증언을 대신한다. 여기서는 존재만 요구한다.
			if not manifest.exists() or not manifest.read_text().strip():
				fails.append(f"{folder}: submitted인데 submit/MANIFEST.sha256 지문 없음")
			if "제출 완료" not in text and "최종 제출" not in text:
				fails.append(f"{folder}: 제출 완료 기록 문장 없음")

		if deep and (dirpath / "submit").exists():
			leaks = aim_leaks(dirpath)
			deep_seen += len(list((dirpath / "submit").glob(f"{DEPTH_DOC}*.pdf")))
			fails += leaks

	if fails:
		print(f"FAIL {len(fails)} — {checked}건 검사", file=sys.stderr)
		for item in fails:
			print("  " + item, file=sys.stderr)
		return 1
	tail = f" · 깊이 문서 {deep_seen}개 조준 검사 통과" if deep else ""
	print(f"ok — LEDGER/submission/submit {checked}건 일치{tail}")
	return 0


if __name__ == "__main__":
	raise SystemExit(main())
