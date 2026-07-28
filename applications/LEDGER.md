# LEDGER — 지원 원장

**어디에 · 언제 · 무엇을 냈는가.** 이 표가 지원 이력의 SSOT다. 건마다 행 하나.
행을 지우지 않는다 — 불합격도 이력이다. 폴더는 `_archive/`로 옮겨도 행은 남긴다.

상태: `draft`(자리만 만듦) · `ready`(글·첨부 준비됨, 제출 대기) · `saved`(플랫폼에 임시저장)
· `submitted`(제출 완료) · `replied`(회신 옴) · `interview` · `offer` · `rejected` · `closed`(공고 마감/철회)

| 회사 | 직무 | 상태 | 지원일 | 경로 | 첨부 컷 | 폴더 |
|---|---|---|---|---|---|---|
| NHN | AX Transformation / AI Infra (BE) | submitted | 2026-07-20 | 직접 제출 | `nhn/` 3종 세트 | `../nhn/` |
| Insighter | AX Engineer | saved | — | LinkedIn Easy Apply | — | `insighter--ax-engineer` |
| Hyundai AutoEver | AI Agent Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | AI Engineer + 국문 자기소개서 | `hyundai-autoever--ai-agent-engineer` |
| DEEPX | AI Agent Workflow Automation Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | AI Engineer + 경력기술서 통합 (7쪽) | `deepx--ai-agent-workflow-automation-engineer` |
| DEEPX | Linux BSP Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | Embedded + 경력기술서 통합 (5쪽) | `deepx--linux-bsp-engineer` |
| Enhans | Forward Deployed Engineer (7년 이상) | submitted | 2026-07-28 | ninehire (자체 채용홈) | FDE | `enhans--forward-deployed-engineer` |
| FuriosaAI | Agent System Developer | ready | — | Ashby (자체 채용페이지 경유) | AI Engineer | `furiosaai--agent-system-developer` |
| Lunit | (Seoul) Senior AX Engineer | ready | — | **Workable** (자체 채용홈) | AI Engineer | `lunit--senior-ax-engineer` |
| Cohere | Forward Deployed Engineer, Agentic Platform (Korea) | ready | — | Ashby (가입 불필요) | FDE | `cohere--forward-deployed-engineer-agentic-platform-korea` |
| OpenAI | Developer Experience Engineer (Seoul) | ready | — | Ashby (가입 불필요) | DevEx | `openai--developer-experience-engineer-seoul` |
| Telechips | [판교] Embedded S/W Engineer (BSP Driver) | ready | — | 자체 채용홈 (ninehire 화이트라벨) | Embedded | `telechips--embedded-sw-engineer` |
| Reflection AI 🌐 | FDE, Lead - AI Engineer (Seoul) | ready | — | Ashby (가입 불필요) | FDE | `reflection-ai--forward-deployed-engineer-lead-ai-engineer` |
| 42dot | Senior AI Agent Engineer (Intelligence Service) | ready | — | Ashby (가입 불필요) | AI Engineer | `42dot--senior-ai-agent-engineer-intelligence-service` |
| MakinaRocks | [FDE] AI Agent Application Engineer | ready | — | 그리팅 (자체 도메인) | FDE | `makinarocks--ai-agent-application-engineer-fde` |

---

## 기록 규율

- **낼 때 남긴다.** 내고 나서 기록하려 하면 남지 않는다. `./new.sh` 가 먼저다.
- **공고 URL은 죽는다.** `JD.md` 에 본문을 떠 두는 것이 링크보다 중요하다.
- 같은 회사 다른 직무는 **별도 건**이다. 같은 직무 재지원도 별도 건이고, 폴더명 뒤에
  `--2`를 붙인다.
- 회신·면접 일정은 그 건의 `submission.md` 하단 「이후 기록」에 시간순으로 덧붙인다.

## 메모

- ⚠ **제출본과 현재 이력서의 차이 (2026-07-28 이후)** — 면접에서 되물릴 수 있으니 알고 있는다.
  - 2026-07-28 제출한 3건(AutoEver · DEEPX ×2)의 PDF 에는 연구실 기간이 **`2018 – 2021`** 로
    적혀 있다. 이후 이력서를 **`2018 – 2022`** 로 고쳤다(연 단위 — `resume/AGENTS.md` §날짜 입도).
  - **각 건의 `submit/` 스냅샷이 실제로 낸 문서다.** 다시 빌드해서 덮지 않는다. 물어보면
    "2022년까지가 맞고 당시 서류에 2021로 나갔다"가 사실이다. 정확한 월은 `FAQ.md` §3
    (`2022.06`), 증빙은 **공단 가입이력 증명서**로 낸다.
  - 스택의 `A2A` 는 제출본에도 있고 현재 이력서에도 **유지**한다. `home agent-config` /
    `edge agent-config` 세트로 실제로 파고 있는 주제다(프로토타입 전 단계).

- **DEEPX 2건 (2026-07-28)** — 그리팅이지만 다른 회사 폼과 구조가 달랐다. 자기소개서
  슬롯 대신 **이력서+경력기술서 통합 PDF 하나**와 300자 답변을 요구했다.
  - 개인·법적 필드는 GLG가 브라우저에서 직접 사실값으로 입력해 두 건 모두 제출했다.
    민감값은 Git에 저장하지 않는다.
  - 에이전트들은 처음에 AI Agent 건만 먼저 내고 BSP는 3~5일 뒤 재판단하자고 권고했다.
    GLG가 두 증거 패키지를 읽고 **같은 날 둘 다 제출**하기로 명시적으로 override했다.
  - 같은 회사에 복수 지원한 예외와 각 직무의 경계는 두 `submission.md`에 보존한다.
  - 세 번째 System SW 공고는 증거 밖이라 자리를 만들지 않았다.

- **그리팅 공고 원문 뜨는 법** — WebFetch 는 **403**. 브라우저 UA 를 붙인 `curl` 은 200 이고,
  본문·폼 스키마가 전부 `<script id="__NEXT_DATA__">` 안에 있다
  (`props.pageProps.dehydratedState.queries[1].state.data.data` → `openingsInfo.detail`,
  `docsInfo`, `questionnairesInfo`, `additionalApplicantInfoConfig`).
  **필수/선택 여부와 글자수 상한까지 정확히 나온다** — 브라우저로 폼을 열기 전에 여기서 읽는다.

- **Insighter / AX Engineer** — 2026-07-28 브라우저 워크플로를 검증하면서 Easy Apply 4/5까지
  열고 임시저장했다(**제출 아님**). 이어서 내려면 공고 페이지의 「계속」에서 재개한다.
  4/5 질문 「경력 2년 이상 또는 석사 이상」은 **Yes**.
  - ⚠ **지역 기준 미달** — 근무지가 서울 마포구 DMC다. GLG 기준(성남·판교·강남권)에서
    벗어난다. 내용 적합도는 중상(`JD.md` §판단)이나 **낼지 말지는 GLG 판단이다.**
    내지 않기로 하면 이 건은 `closed`로 바꾸고 `_archive/`로 옮긴다.
