#!/usr/bin/env python3
"""LEDGER와 건별 submission/submit 스냅샷의 닫힘 상태를 검사한다."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent
LEDGER = ROOT / "LEDGER.md"
STATUSES = {"draft", "ready", "saved", "submitted", "replied", "interview",
            "offer", "rejected", "closed"}


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
	fails = []
	checked = 0
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
		if status == "submitted":
			record_date = field(text, "지원일")
			if date == "—" or date not in record_date:
				fails.append(f"{folder}: submitted 날짜 불일치 LEDGER={date}, submission={record_date or '?'}")
			pdfs = list((dirpath / "submit").glob("*.pdf")) if (dirpath / "submit").exists() else []
			if not pdfs:
				fails.append(f"{folder}: submitted인데 submit/*.pdf 스냅샷 없음")
			if "제출 완료" not in text and "최종 제출" not in text:
				fails.append(f"{folder}: 제출 완료 기록 문장 없음")

	if fails:
		print(f"FAIL {len(fails)} — {checked}건 검사", file=sys.stderr)
		for item in fails:
			print("  " + item, file=sys.stderr)
		return 1
	print(f"ok — LEDGER/submission/submit {checked}건 일치")
	return 0


if __name__ == "__main__":
	raise SystemExit(main())
