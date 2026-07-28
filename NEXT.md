# NOW — FuriosaAI Agent System Developer 를 낸다

- **Hot group**: 지원 실행. 공개 준비는 이 축이 아니다.
- **Current**: 2026-07-28 4건 제출 완료(AutoEver · DEEPX ×2 · Enhans). 원장 · 기록 · 스킬 ·
  이력서 검수 통과. 다음 stem 은 **FuriosaAI Agent System Developer**(강남 도산대로 145, `4387941500`).
- **Next**: `applications/INBOX.md` 티어1 을 읽고 `./new.sh "FuriosaAI" "Agent System Developer" <URL>`
  로 건을 연다. 컷은 AI. 지원 경로는 자체 사이트(`furiosa.ai/careers`) — **가입 필요 여부 미확인**이
  첫 확인 사항이다.
- **Blocker**: 없음. 다음 폼 전에 GLG 가 정할 값 셋 — **희망 연봉 · 입사 가능일 · 이직 사유**.
  민감 법적 값(병역 등)은 계속 브라우저에서만 입력한다.
- **Read**: `applications/INBOX.md` 티어1 → `applications/FAQ.md` → `AGENTS.md`.
- **Do not touch**: 제출된 4건의 `submit/` 스냅샷. 업로드한 그 파일이라 다시 빌드해 덮지 않는다.

# ACTIVE

## 지원 실행

- `applications/check.py` 통과: LEDGER ↔ 5건 submission ↔ submit 스냅샷 일치.
- 티어1 후보 8곳이 INBOX 에 근무지 · 컷 · 경로까지 정해진 채 대기 중이다. FuriosaAI 다음은
  KRAFTON(역삼) · HITS(강남, Easy Apply) 순.
- Insighter 는 `saved` — 마포 DMC 라 GLG 지역 기준 밖이다. 낼지 말지는 GLG 판단이고,
  안 내기로 하면 `closed` + `_archive/`.

## 이력서

- 6종 PDF 빌드 · verify 통과: Embedded 2쪽, 나머지 3쪽.
- `A2A` 는 스택에 **유지**한다 — `home agent-config` / `edge agent-config` 세트로 GLG 가 실제로
  파고 있는 주제다. 프로토타입 전 단계라는 것만 알고 있으면 된다.
- ⚠ **연구실 기간을 `2018–2021` → `2018–2022` 로 고쳤다.** 이미 제출한 3건(AutoEver ·
  DEEPX ×2)은 `2018–2021` 판이다. `LEDGER.md` §메모에 델타를 남겼다.
- **날짜 입도 규칙을 새로 박았다** — `resume/AGENTS.md` §날짜 입도. 이력서는 연 단위가 기본,
  현직·프로젝트만 연.월. 폼 답변용 정밀 원장은 `FAQ.md` §3 이고 증빙은 공단 서류다.
  **에이전트가 오래된 이력을 월 단위로 "정밀화"하는 것은 교정이 아니다.**

## linkedin-jobs

- 57개 network-free 회귀 검사 통과. 표준 흐름: 카드 수집 → dedupe → `enrich --keep-body` 한 번 →
  `rank --explain`.
- 고친 것: `intern`→`internal` 오탐, 알려진 근무지 mismatch 감점, 빈 fetch 를 Easy Apply 로 오판,
  search 의 `apply` 누락, enrich 원자 저장 · 재개, 점수 근거.
- guest endpoint 는 비공식 · best-effort. 403/999 또는 markup 변경 시 exa/브라우저로 전환.

# RECENT

- [2026-07-28] 4개 역할(탐색 · 문서 · 브라우저 · 메타)이 분리된 채로 4건을 제출하고, 그 과정의
  실패를 테스트와 계약으로 회수했다. 기록은 `docs/case-study-2026-07-28.md`.
- [2026-07-20] NHN dossier 제출 완료. `nhn/` 은 닫힌 건이다.

# LEDGER

- 제출 SSOT: `applications/LEDGER.md` · 닫힘 검사: `applications/check.py`
- 후보 큐: `applications/INBOX.md` · 폼 재사용 답: `applications/FAQ.md`
- 이력서 사실: `resume/body.org` · 빌드: `(cd resume && ./run.sh all && ./run.sh verify)`
- 탐색: `.claude/skills/linkedin-jobs/SKILL.md`
- 전체 계약: `AGENTS.md`
- **나중에** 공개할 때만: `PUBLICATION.md`, `scripts/check-public.sh`, `README.md`
