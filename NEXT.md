# NOW — NHN 제출 레인: 포트폴리오 v2

- **Stem**: NHN 제출본 3종을 “이 사람이 이걸 냈다”가 성립하는 완성도까지 올린다.
- **Current**: competency 커밋 완료(프롤로그 요약화·개인정보/LinkedIn 상단·부제 교정·AX-layer 이미지 v3). portfolio v2 본문·이미지 프롬프트 커밋(468e179). **Opus 교차검토 완료 → GLG가 7건 확정**(`nhn/PORTFOLIO-PLAN.md` §v2 교차검토 결정). Opus가 bib에 프로토콜 3키 추가. 포트폴리오 이미지 5장은 아직 placeholder.
- **Next (GPT, 새 세션)**: PLAN §v2 교차검토 결정을 portfolio.org에 반영 — **프로젝트 2 수치 제거(역량 서사만)·프로젝트 4 프로토콜(ACP·A2A·A2UI) 확장·프로젝트 5/문서절에 memex-kb 삽입**, 중복 제거. 그 뒤 (3) 생성형 인포그래픽 5장 제작·검수 → (4) 페이지 배치 → (5) timeline 보강.
- **Blocker**: none.
- **Read**: 루트 `AGENTS.md` → `nhn/AGENTS.md` → `nhn/PORTFOLIO-PLAN.md` → `junghan0611/apply/MATERIAL.md`.
- **Do not touch**: 공개 `junghan0611/apply/ax/`; 파생 ODT/PDF/MD 수기 수정; 추천인·지원 경로·근무지; 원시 고객 식별자·자격증명.
- **Image contract**: 프로젝트마다 Gemini 생성형 인포그래픽 1장 필수. Mermaid·Graphviz 폴백 없음. 한글 오탈자·라벨 중복·사실 왜곡은 재생성 사유.
- **Timeline contract**: 서사가 안정된 뒤 날짜·사건·판단·증거 경로를 붙인다. 허영 수치가 아니라 재현 가능한 기록만 사용한다.

# RECENT

- [2026-07-18] Opus 포트폴리오 v2 교차검토(사실 경계·목소리·누락) → MATERIAL.md·bib 대조. GLG 7건 확정: ghostel 병합 확인, 프로젝트2 수치 제거, "실사용 트래픽" 완화, #4 React→프로토콜 축(ACP·A2A·A2UI), #5 memex-kb 삽입, 회사명 일반화 유지, forge-config 명칭 확정. bib 프로토콜 3키 추가. 결정 SSOT는 `nhn/PORTFOLIO-PLAN.md` §v2 교차검토 결정.
- [2026-07-18] competency 프롤로그·PKM·운영·도메인·문서·엔지니어링 문장 교열. Org 강조 조사 공백 제거. `./run.sh competency && ./run.sh verify` GREEN, 5p. 미커밋.
- [2026-07-18] portfolio v2 방향 확정. 프로젝트 5개 구조 유지, 도메인 에이전트→OpenClaw→andenken→entwurf/forge→제품 기반 순서. 상세 계약은 `nhn/PORTFOLIO-PLAN.md`.
- [2026-07-18] portfolio 본문 1차 재작성. 허영 수치·반복 JD 대응·경쟁자 비교를 제거하고 명제→경계→판단→상태 변화→인계→확인 지점 문법으로 통일. 생성형 이미지 5장 프롬프트를 16:9·2K·한글 라벨 계약으로 교체. 현 PDF 9p, 이미지는 아직 placeholder.

# LEDGER

- 소재 SSOT: `~/repos/gh/junghan0611/apply/MATERIAL.md`.
- 제출물 SSOT: Org·이미지·파이프라인. 파생물은 재빌드한다.
- 최종 강조 순서·회사명 노출·커밋·푸시는 GLG가 결정한다.
