# NOW — NHN 제출 레인: timeline 증거 보강

- **Stem**: NHN 제출본 3종을 “이 사람이 이걸 냈다”가 성립하는 완성도까지 올린다.
- **Current**: competency 5p, portfolio v2 10p. GPT 구조·교열 → Opus 사실/프로토콜/memex 반영 → GPT 검수 루프 완료. 포트폴리오 생성형 인포그래픽 5장 모두 2K PNG로 교체했고, andenken 흐름도도 `세션·가든 → LanceDB → 벡터/BM25 → 점수 정규화 → 통합 검색`으로 교정했다. `./run.sh verify` GREEN.
- **Next**: timeline 스킬로 프로젝트별 날짜·사건·판단·증거 경로를 회수해 (1) portfolio의 `[운영 기록]` 근거 강화 → (2) detail.org의 Tech Interview anchors와 정합 → (3) `./run.sh all && ./run.sh verify && ./run.sh package` 최종 게이트.
- **Blocker**: none.
- **Read**: 루트 `AGENTS.md` → `nhn/AGENTS.md` → `nhn/PORTFOLIO-PLAN.md` → `junghan0611/apply/MATERIAL.md`.
- **Do not touch**: 공개 `junghan0611/apply/ax/`; 파생 ODT/PDF/MD 수기 수정; 추천인·지원 경로·근무지; 원시 고객 식별자·자격증명.
- **Timeline contract**: 허영 수치를 되살리지 않는다. 날짜·장애·판단·정책 변화·공개 PR을 `as_of`·`content_sha256`·`code_sha256`·소스 상태와 함께 대조한다.
- **Image debt (non-blocking)**: 현재 5장 모두 채택. 이후 GLG가 원하면 색·여백·세부 연결만 다듬되, 본문 사실과 한글 라벨을 바꾸지 않는다.

# RECENT

- [2026-07-18] competency 프롤로그·PKM·운영·도메인·문서·엔지니어링 교열, AX 전체 그림 v3 확정. 5p GREEN.
- [2026-07-18] portfolio v2를 프로젝트 5개 문법(명제→경계→판단→상태 변화→인계→확인 지점)으로 재작성. OpenClaw 수치 제거, ACP·A2A·A2UI 프로토콜 축과 forge-config durable state, memex-kb 문서 파이프라인 반영.
- [2026-07-18] 포트폴리오 인포그래픽 5장 생성·교차검수. P3 검색 순서 왜곡을 재생성으로 교정. 최종 PDF 10p, 캡션·페이지 배치·Org 강조·인용·noexport 검증 GREEN.

# LEDGER

- 소재 SSOT: `~/repos/gh/junghan0611/apply/MATERIAL.md`.
- 포트폴리오 결정·이미지 계약: `nhn/PORTFOLIO-PLAN.md`.
- 제출물 SSOT: Org·이미지·파이프라인. 파생물은 재빌드한다.
- 최종 강조 순서·회사명 노출·커밋·푸시는 GLG가 결정한다.
