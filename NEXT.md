# NOW — 제출 대기 6건. 컷 세 종으로 갈린다

- **Hot group**: 지원 실행. 공개 준비는 이 축이 아니다.
- **기조 (2026-07-28 밤 GLG)**: **내고 떨어지면 만다.** 실제로 만든 것이 있으니 밀어붙인다.
  위로 찌르는 것이 기본값이고 — **떨어져도 이름이 알려진다.** 지역은 후보를 거르는 축이 아니다.
- **Current**: **6건이 전부 `ready` 다.** 오라클서버에서 폴더·JD 원문·컷·**지원 URL(HTTP 200
  확인)** 까지 끝냈다. `applications/check.py` → **13건 일치**.

  **AI Engineer 컷 — 3건** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`)

  | 건 | 지원 URL |
  |---|---|
  | **Lunit** (Seoul) Senior AX Engineer | `apply.workable.com/lunit/j/E3C22F589F/apply/` |
  | **FuriosaAI** Agent System Developer | `jobs.ashbyhq.com/furiosa-ai/[uuid removed]/application` |
  | **42dot** Senior AI Agent Engineer (Intelligence Service) | `jobs.ashbyhq.com/42dot/[uuid removed]/application` |

  **FDE 컷 — 2건** (`..._Forward_Deployed_Engineer.pdf`)

  | 건 | 지원 URL |
  |---|---|
  | **마키나락스** [FDE] AI Agent Application Engineer | `makinarocks.career.greetinghr.com/ko/o/214041` 의 「지원하기」 |
  | **Reflection AI** 🌐 FDE, Lead - AI Engineer | `jobs.ashbyhq.com/reflectionai/[uuid removed]/application` |

  **Embedded 컷 — 1건**

  | 건 | 지원 URL |
  |---|---|
  | **Telechips** [판교] Embedded S/W Engineer | `careers.telechips.com/job_posting/iSXmKnRT/apply` |

  **⏸ 보류 2건 — 이번 배치 아님** (2026-07-28 GLG: 「지금 안 한다」)

  | 건 | 컷 | 상태 |
  |---|---|---|
  | **Cohere** 🌐 FDE, Agentic Platform (Korea) | FDE | 준비 끝. 되살릴 때 `submission.md` 부터 |
  | **OpenAI** 🌐 Developer Experience Engineer (Seoul) | DevEx | 준비 끝. 되살릴 때 `submission.md` 부터 |

  외국계 두 건을 빼고 **더 현실적인 곳부터 후다닥 낸다.** 그 자리를 마키나락스가 채웠다.
  **경로는 넷** — Ashby 3 · 그리팅 1 · Workable 1 · ninehire 1.

- **Next**: **GLG 가 노트북 브라우저에서 제출한다**(오라클서버는 탐색·준비 축이다).
  개인·법적 값 입력 → **파일명 눈으로 확인** → Submit. 낸 뒤 올린 파일을 그 건의 `submit/` 에
  복사하고 `LEDGER` + `submission.md` 를 `submitted` 로 같이 닫는다(`applications/check.py`).
- **Blocker**: 폼이 물으면 GLG 가 그 자리에서 정할 값 — **희망 연봉 · 입사 가능일 · 이직 사유**
  (`FAQ.md` §4 가 아직 ⚠ 다). 보류한 두 건을 되살릴 때는 **출장 수용 여부**도 정해야 한다
  (Cohere 20–40%, OpenAI APAC 30%).
  민감 법적 값(병역 등)은 계속 브라우저에서만 입력한다.
- **건별로 하나씩 남은 결정**
  - **Lunit** — 공고가 「이력서 **및 경력 기술서**」를 요구한다. 폼이 파일 하나만 받으면
    DEEPX 선례(`deepx--ai-agent-workflow-automation-engineer/build.sh`)로 통합본을 만든다.
  - **Telechips** — ninehire 는 **에이전트가 파일 업로드를 못 한다.** GLG 가 직접 올린다.
  - **Reflection AI** — `기술 리더십 2년+` 은 직함으로 없다. **지어내지 않는다.**
  - **42dot** — 전형에 **코딩 테스트**가 있다. 서류가 붙으면 그 준비가 다음 일이다.
    GLG 가 짚은 `On-device Agent Orchestration`(2~3년 자리)로 바꾸려면 이 건을 닫고 새로 연다.
  - **마키나락스** — 폼이 요구하는 서류는 **`Resume/CV` 하나**다(그리팅 `docsInfo` 확인).
    코딩테스트 없음 — 서류 → 사전인터뷰 → 기술 → Fit.
- **다음 배치 — 말만 하면 이 순서로 연다** (`applications/INBOX.md` §보드 훑기 수확)
  - **센드버드** `Software Engineer, AI Agent` — 서울, greenhouse
  - **카카오모빌리티** `물류 & 에이전트 개발실 백엔드` — 판교, 대기업
  - **리벨리온** `Linux Device Driver Engineer` — 판교 정자. **LinkedIn 에 없던 자리**
  - **업스테이지** `AI Engineer - Agents` · **뤼튼** `AX Agent Developer` · **프렌들리AI** `AI Agents`
  - ⚠ **카카오페이 FDE** 는 자격 첫 줄이 `Java/Kotlin 깊이 있는 백엔드` 다 — 낼지 먼저 정한다
- **Read**: 각 건의 `submission.md` (§폼에 답한 질문 · §왜 이 직무였는가) → `FAQ.md` §3·§4·§5.
- **Do not touch**: 제출된 4건의 `submit/` 스냅샷. 업로드한 그 파일이라 다시 빌드해 덮지 않는다.

# ACTIVE

## 지원 실행

- `applications/check.py` 통과: LEDGER ↔ 13건 submission ↔ submit 스냅샷 일치.
- **대기줄**: **HITS**(강남역, Easy Apply, 석사요건 통과 · 적합도 중간) ·
  **XCENA Developer Tools**(판교, 본문 미확인) · **Rebellions System SW Architect**(본문 미확인).
- **42dot 두 건은 본문을 뜬 뒤 내려놓았다** — LLM Training 은 pre/post-training·분산학습·논문
  우대의 **연구직**이고, Embedded Linux Build 는 **`Yocto 5년 + QNX 5년`을 둘 다** 요구한다.
  근거는 `applications/INBOX.md` §42dot 판정.
- **본문 확인 축이 하루 만에 8건 늘었다**(42dot ×2 · OpenAI ×2 · Cohere · FuriosaAI TW ·
  Lunit · Telechips · Reflection ×1). 아직 미확인은 티어 3 offsite 다섯 곳과 티어 2 나머지다.
- **타깃 기준 갱신 (2026-07-28 GLG)** — `applications/AGENTS.md` §타깃 기준.
  **게임회사 제외**(KRAFTON 3건 전부 탈락), **정규직 기본**, 지역은 **서울·판교면 통과**
  (구 단위 미확인은 탈락 사유가 아니다). **외국계는 🌐로 표시**해 둔다 — 거르는 게 아니라
  낼 때 비자·영어·본사 시차를 확인하라는 표시다.
- **INBOX 를 회사 이름 중심으로 다시 짰다.** 위치 비중을 줄이고 `🌐`·`본문✓/?` 칸을 넣었다.
  티어 2·3·4 는 **전부 본문 미확인**이라 내기 전에 본문부터 뜬다.
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

## 탐색 축 — 회사 보드를 직접 긁는다 (2026-07-28 밤)

- **새 도구**: `.claude/skills/linkedin-jobs/boards.py` + `companies.txt`.
  `probe`(어느 ATS 인지) · `list` · `sweep`(목록 파일 통째로) · `body`.
  어댑터 6종: **ashby · greenhouse · lever · workable · greeting · kakao**. 전부 인증 없이 열린다.
- **왜 만들었나 (GLG 지적)**: LinkedIn guest 검색은 **광고가 상단을 먹고 키워드당 10건에서
  끊긴다.** 리벨리온은 LinkedIn 8건 / 보드 41건이었고, **정면인 자리 셋이 LinkedIn 목록에
  아예 없었다.** 25개 보드 1,400여 건 → **331건이 축 키워드에 걸렸다.**
- **원칙 두 개가 바뀌었다** (`applications/AGENTS.md` §타깃 기준):
  **지역을 1차 필터로 쓰지 않는다** · **지금 회사보다 큰 곳으로 위로 찌른다.**
- **교훈**: 회사를 판정하지 말고 **자리를 판정한다.** 42dot 을 두 건 보고 닫을 뻔했는데
  보드에 에이전트 축이 넷이었다.

## 지원 경로 — ATS 지도가 넓어졌다 (2026-07-28 저녁)

- **회사 채용 보드 API 세 개를 인증 없이 뚫었다.** 브라우저 없이 「본문✓」를 만드는 축이다.
  - **Ashby**: `api.ashbyhq.com/posting-api/job-board/<슬러그>` — 본문·게시일·고용형태·`isListed`.
    실측: `furiosa-ai` 56 · `openai` 749 · `cohere` 138 · `42dot` 120 · `reflectionai` 62.
  - **Workable**: `apply.workable.com/api/v1/widget/accounts/<회사>?details=true` — **Lunit 한국 채용**.
  - **ninehire 화이트라벨**: 상세 페이지 `__NEXT_DATA__` → `recruitment` 에 `closedAt`·`status`·
    `career.range`·`jobLocations`. **Telechips 는 82건 중 3건만 열려 있었다.**
- 전부 `applications/INBOX.md` §지원 경로 에 적었다. **회사를 정했으면 그 회사 보드를 직접 본다.**

## linkedin-jobs

- 65개 network-free 회귀 검사 통과. 표준 흐름: 카드 수집 → dedupe → `enrich --keep-body` 한 번 →
  `rank --explain`.
- **고용형태를 목록에 내보낸다.** `enrich` 가 받아 두던 `criteria` 를 `emit()` 이 한 번도
  출력하지 않아 계약직이 표에 정규직처럼 섞였다. 이제 `⚠Contract` 로 뜬다.
- **뒷정리 계약 2개를 SKILL.md 에 박았다** — 「제목을 줄이지 않는다」(괄호 안에 연차·고용형태가
  있다), 「확정이라고 적으려면 본문을 읽었어야 한다」. 두 실물 사고에서 나왔다.
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
