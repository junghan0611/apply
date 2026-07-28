#!/usr/bin/env python3
"""ljobs 회귀 검사 — 네트워크 없이 돈다.

지명 경계, 근무지 추출, 키워드 점수, 지역 가감점, 빈 응답의 지원경로 판정을 고정한다.

	./test_ljobs.py        # 실패하면 exit 1
"""
import importlib.util
import json
import os
import sys
import tempfile
from types import SimpleNamespace

_here = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location("lj", os.path.join(_here, "ljobs.py"))
lj = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(lj)

# 지명으로 잡히면 안 되는 것 — 전부 실물 공고에서 물렸거나 물릴 뻔한 문장이다.
MUST_NOT = [
	"MUSINSA 무신사 북미 인플루언서 사업",   # 무'신사'
	"무신사 테라스",
	"신사업 기획 담당",
	"분당 처리량 5000건",                     # 분당 = per minute
	"고양이 사료 커머스",
	"시청자 로그 분석",
	"일산화탄소 센서 펌웨어",
	"성수기 트래픽 대응",
	"전주기 테스트 자동화",
	"이천만원 상당의 지원",
	"구미가 당기는 문제",
	"광명한 미래를 위해",
	"안산업 클러스터",
	"agent system 의 구조와 동작 방식을 설계",  # FuriosaAI 공고
	"디바이스 드라이버 내부 동작에 대한 경험",   # Boeing 공고
	"가산점이 있습니다",
	"부산물 처리 공정",
	"원주민 데이터셋",
	"화성암 성분 분석",
	"세종대왕 프로젝트",
	"성동일 배우 캐스팅",
	"각 지구로 배분한다",
	"대전제를 세우다",
]

# 반드시 잡아야 하는 것 — 값은 결과에 들어 있어야 할 표기
MUST_HAVE = {
	"서울 신사동 가로수길": "신사동",
	"성남시 분당구 판교역로 235": "분당구",
	"판교에서 근무합니다": "판교",
	"서울 강남구 테헤란로 152": "테헤란로",
	"마포 상암 DMC 근무": "상암",
	"근무지: 여의도 IFC": "여의도",
	"Pangyo, Seongnam": "Seongnam",
	"성수동 오피스": "성수동",
	"용산구 한강대로": "용산구",
	"인천 송도 캠퍼스": "송도",
	"경기도 고양시 일산동구": "고양시",
	"서초구 서초대로": "서초구",
	"동작구 상도동": "동작구",
	"가산디지털단지 A동": "가산디지털단지",
	"화성 공장 근무": "화성",
	"부산 해운대": "부산",
	"제주 오피스": "제주",
}

# 라벨/원격/빈칸 판정까지 포함한 end-to-end 케이스
EXTRACT = [
	("근무지 서울 영등포구 여의대방로69길 23 10층", "label", "영등포"),
	("근무지\n\n추천 공고\n\n다른 공고들", "label-empty", ""),
	("Cohere is remote-friendly. We have offices in Toronto.", "none", ""),
	("근무 형태: 재택 근무 100%", "remote", "remote?"),
	("본사는 강남역 인근입니다", "body", "강남"),
]


def score_args(**overrides):
	values = dict(must=[], plus=[], minus=[], near=[], penalize_unknown=False)
	values.update(overrides)
	return SimpleNamespace(**values)


def main():
	fails = []

	for s in MUST_NOT:
		hits = [lj._norm_place(x) for x in lj.PLACE_RE.findall(s)]
		if hits:
			fails.append(f"오탐: {s!r} -> {hits}")

	for s, want in MUST_HAVE.items():
		hits = [lj._norm_place(x) for x in lj.PLACE_RE.findall(s)]
		if want not in hits:
			fails.append(f"누락: {s!r} -> {hits} (기대 {want!r})")

	for body, want_src, want_sub in EXTRACT:
		ws, src = lj.extract_worksite(body)
		if src != want_src:
			fails.append(f"근거: {body[:32]!r} -> {src} (기대 {want_src})")
		elif want_sub and want_sub not in ws:
			fails.append(f"값:  {body[:32]!r} -> {ws!r} (기대 {want_sub!r} 포함)")

	# 영문 단어 경계. `intern`은 `internal`을 감점하면 안 된다.
	if not lj.term_match("AI", "Applied AI Engineer"):
		fails.append("term: AI 낱말을 찾지 못함")
	if lj.term_match("intern", "internal platform engineer"):
		fails.append("term: intern 이 internal 에 오탐")

	score_cases = [
		("internal-not-intern",
		 {"title": "Internal Platform Engineer"},
		 score_args(plus=["platform"], minus=["intern"]), 5),
		("negative-blocks-near-bonus",
		 {"title": "AI Intern", "worksite": "강남"},
		 score_args(minus=["intern"], near=["강남"]), -3),
		("known-location-mismatch",
		 {"title": "Engineer", "worksite": "부산"},
		 score_args(near=["강남"]), -4),
		("card-location-mismatch",
		 {"title": "Engineer", "location": "Seongnam, Gyeonggi"},
		 score_args(near=["강남"]), -4),
		("unknown-location-neutral",
		 {"title": "Engineer", "location": "Seoul, Seoul, South Korea"},
		 score_args(near=["강남"]), 0),
		("near-bonus",
		 {"title": "Engineer", "worksite": "강남"},
		 score_args(near=["강남"]), 6),
		("unknown-penalty",
		 {"title": "Engineer"},
		 score_args(penalize_unknown=True), -2),
		("must-missing",
		 {"title": "Backend Engineer"},
		 score_args(must=["agent"]), None),
	]
	for name, row, args, want in score_cases:
		row = {"company": "", "location": "", "worksite": "", "description": "", **row}
		got = lj.score(row, args)
		if got != want:
			fails.append(f"score {name}: {got!r} (기대 {want!r})")

	# 네트워크/마크업 실패를 Easy Apply로 둔갑시키지 않는다.
	original_fetch = lj.fetch
	try:
		lj.fetch = lambda _url: ""
		if lj.get_detail("123456")["apply"] != "unknown":
			fails.append("detail: 빈 응답을 unknown으로 분류하지 않음")
	finally:
		lj.fetch = original_fetch

	# 중간 저장은 원자적으로 교체되고 다시 읽혀야 한다.
	with tempfile.TemporaryDirectory() as td:
		path = os.path.join(td, "rows.json")
		lj.write_json_atomic(path, [{"id": "1"}])
		with open(path, encoding="utf-8") as f:
			if json.load(f) != [{"id": "1"}]:
				fails.append("atomic json: 저장 후 값 불일치")

	total = len(MUST_NOT) + len(MUST_HAVE) + len(EXTRACT) + 2 + len(score_cases) + 2
	if fails:
		print(f"FAIL {len(fails)}/{total}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {total}/{total} — 지명 오탐 {len(MUST_NOT)} · 참값 {len(MUST_HAVE)} · "
	      f"추출 {len(EXTRACT)} · 점수 {len(score_cases)} · 안전성 4")
	return 0


if __name__ == "__main__":
	sys.exit(main())
