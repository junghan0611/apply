# INBOX — 후보 공고 대기열

여기 있는 것은 **아직 지원 건이 아니다.** GLG가 고르면 `./new.sh` 로 건이 되고 원장에 행이 생긴다.
제출된 것은 `LEDGER.md` 가 SSOT다.

기준(`AGENTS.md` §타깃 기준): **서울·판교면 통과** · **게임회사 제외** · **정규직** ·
영세 스타트업 제외 · 대기업은 자체 사이트 · **한 회사 한 직무**.

수집 규모(2026-07-28): 34 쿼리 → 카드 352 → 본문 전부 조회 → 누적 **418건**.

## 이 표를 읽는 법

- **회사 이름이 첫 축이다.** 후보는 사실상 전부 서울 아니면 판교라, 구 단위 미확인은
  탈락 사유가 아니다. 위치는 참고로만 적는다.
- **🌐 = 외국계** (본사가 해외). 거르라는 표시가 아니라 **낼 때 다른 것을 확인하라는 표시**다 —
  비자·영어 상시 회의·본사 시차·한국 법인 규모. `FAQ.md` §5·§6.
- **⚠계약직** 등 고용형태 표시가 붙은 것은 기본 제외다. 낼지는 GLG가 건별로 정한다.
- **본문✓ / 본문?** — 본문을 읽었는지. **제목은 직무를 말해 주지 않는다**(§Sonatus 사고 참조).
- `경로` 의 `offsite` = 회사 사이트/외부 ATS, `easy` = LinkedIn Easy Apply.

---

## 지원 경로 — ATS 지도 (실측 확정)

경로는 계속 늘어난다. **같은 ATS는 재사용하되, 회사 이름만 보고 플랫폼을 추정하지 않는다.**

| 플랫폼 | 확인된 회사 | 주소 형태 | 가입 | 폼 특징 |
|---|---|---|---|---|
| **그리팅** | DEEPX · Hyundai AutoEver · Rebellions | `<회사>.career.greetinghr.com/ko/o/<id>` · `career.<회사>.com/ko/o/<id>` | 불필요 | **회사마다 폼이 다르다.** AutoEver는 사전질문 1,000자, DEEPX는 자기소개서를 묻는다 |
| **Ashby** | OpenAI · Cohere · 42dot · **FuriosaAI** · **Reflection AI** | `jobs.ashbyhq.com/<회사>/<uuid>` · 지원은 뒤에 `/application` | 불필요 | 폼 직접 작성 + 이력서 업로드. **공고 목록·본문이 API 한 번에 다 뜬다** — 아래 §Ashby API |
| **ninehire** | Enhans · **Telechips**(자체 도메인 화이트라벨) · **IGNITE**(이그나이트) | `<회사>career.ninehire.site/job_posting/<id>` · `careers.telechips.com/job_posting/<id>` · `ignite.ninehire.site/job_posting/<id>` | 불필요 | ⚠ **정정(2026-07-31, IGNITE 실측)**: 「서술형 칸 없음」은 **Telechips·Enhans 기준이었다 — 회사마다 다르다.** IGNITE는 별도 이력서 칸 없이 "경력기술서" 파일 업로드 하나로 겸하고, **서술형 3문항을 각 200-300자 캡(실시간 카운터)으로 커스텀**했다. ⚠ **파일 업로드를 에이전트가 못 한다**(공통, DOM에 `<input type=file>` 없음) — 아래 §브라우저 축 |
| **Workable** | **Lunit(루닛)** 한국 채용 | `apply.workable.com/<회사>/j/<코드>/` · 지원은 뒤에 `apply/` | 불필요 | **목록·본문·게시일이 공개 API 로 뜬다** — `apply.workable.com/api/v1/widget/accounts/<회사>?details=true` (title·city·employment_type·published_on·telecommuting·description). ⚠ 폼 구조는 아직 눈으로 안 봤다 |
| **Workday** | **GE HealthCare** 🌐 | `gehc.wd5.myworkdayjobs.com/GEHC_ExternalSite/job/..._<req>-1` | 폼에서 확인 | `wday/cxs/gehc/GEHC_ExternalSite/job/<posting>` JSON에 본문·`posted`·`canApply`·지원 URL이 뜬다. ⚠ 예전 Phenom 페이지와 열림 상태가 충돌할 수 있어 **Workday를 현재 SSOT로 확인**한다 |
| **Greenhouse** | Toss (`toss.im` 경유) | `toss.im/career/job-detail?gh_jid=<id>` | 불필요 | ⚠ `toss.im`은 브라우저 안전 제한으로 에이전트가 못 연다 |
| ~~자체~~ | ~~FuriosaAI~~ | — | — | **정정: FuriosaAI 는 Ashby 다**(위 행). `furiosa.ai/careers` 는 목록 페이지일 뿐이고 「Apply」가 Ashby 로 넘긴다 |

### ninehire 화이트라벨 — 목록에 보인다고 열린 게 아니다 (2026-07-28 실측)

Telechips 채용홈은 `careers.telechips.com` 이라 자체 사이트로 보이지만 **ninehire 다**
(`telechipscareer.ninehire.site` 가 같은 것을 낸다). 상세 페이지의
`<script id="__NEXT_DATA__">` → `props.pageProps.recruitment` 에 **`closedAt` · `deadlineValue` ·
`status` · `employmentType` · `career.range` · `jobLocations`(좌표·주소까지)** 가 들어 있다.

- ⚠ **Telechips 는 페이지에 82건이 걸려 있는데 실제로 열린 것은 3건이었다.** 나머지는
  `closedAt` 이 찍혔거나 마감일이 지났다. **회사 채용홈이라도 목록 = 열린 공고가 아니다.**
- 본문(`content`)은 이 JSON 에 없다 — 클라이언트가 따로 부른다. **본문은 LinkedIn 미러에서 뜬다.**

### Ashby API — 본문까지 인증 없이 한 번에 (2026-07-28 실측)

```bash
curl -s "https://api.ashbyhq.com/posting-api/job-board/<슬러그>?includeCompensation=true"
```

- 슬러그: `furiosa-ai` · `openai` · `cohere` · `42dot`. 실측 공고 수 **56 · 749 · 138 · 120**.
- 한 건에 `title` · `location` · `employmentType`(FullTime/Contract) · `publishedAt` ·
  `isListed`(살아 있는지) · `jobUrl` · **`descriptionHtml`(본문 전체)** 가 들어 있다.
  **브라우저를 열지 않고 「본문✓」를 만들 수 있는 유일한 경로다.** JD.md 에 뜰 원문도 여기서 나온다.
- `location` 문자열로 한국 건만 거른다(`Seoul` · `Korea` · `Pangyo`). 회사 보드는 전 세계가 섞여 있다.
- LinkedIn 검색 결과보다 **이쪽이 진짜 목록**이다(FuriosaAI: LinkedIn 23 → Ashby 56).

### 브라우저 축 실무 메모

- **링크 따는 법**: LinkedIn 「회사 사이트에서 지원」 클릭이 새 탭을 못 열 때가 있다. 그때는
  `read_page` 의 `ref_id` 로 `href` 를 직접 읽으면 `linkedin.com/safety/go/?url=<인코딩>` 이
  나온다. 클릭보다 빠르고 확실하다.
- **파일 업로드**: `file_upload` 도구가 이 저장소 경로를 그대로 받는다(LinkedIn·그리팅 확인).
  단 **ninehire 는 file input이 DOM에 없고 클립 버튼이 네이티브 대화상자를 연다** — 그 경우
  에이전트가 못 하고 GLG가 직접 올린다.
- **LinkedIn 저장 이력서**(`jobs/application-settings/`)에는 **베이스판만** 둔다. 한 공고용
  문서를 올려 두면 다음 열 곳에 그게 딸려 나간다(NHN AX 문서가 그럴 뻔했다).

### ⭐ 브라우저 없이 「폼」까지 읽을 수 있는가 — ATS 별 판정 (2026-07-29 오라클 실측)

공고 **본문**을 인증 없이 읽는 축은 위에 있다. 이건 한 겹 더 안쪽 — **지원 폼의 문항·서류
슬롯·부가정보 수집**까지 브라우저 없이 읽히느냐다. 읽히면 `FAQ.md` §4(희망연봉·입사가능일·
이직사유)가 그 건에 **실제로 필요한지**가 브라우저 전에 판정된다.

| ATS | 폼 판독 | 방법 · 한계 |
|---|---|---|
| **그리팅** | ⚠ **워크스페이스마다 다르다** | 상세 페이지 `__NEXT_DATA__` → `dehydratedState.queries[getOpeningById].state.data.data` 의 `docsInfo` · `questionnairesInfo` · `additionalApplicantInfoConfig`. **SOCAR·Upstage 는 실림, AIRS·MakinaRocks 는 `docsInfo: null`** — `/apply` 경로에도 안 실린다(폼을 런타임에 XHR 로 가져온다). 넷 다 `useApplicationForm=true` 라 **이 플래그로는 구분 안 된다** |
| **ninehire** | ✅ 메타는 됨 | 상세 `__NEXT_DATA__` 의 `recruitment` — `status` · `closedAt` · `career.range` · `jobLocations` · `employmentType`. 폼 문항 자체는 브라우저에서 봤다 |
| **Ashby** | ⛔ **안 됨** | 지원 페이지의 `window.__appData` 에 `organization` · `posting` 은 있으나 **폼 정의가 없다** — 로드 후 API 로 가져온다. 본문·`isListed` 는 보드 API 로 그대로 읽힌다 |
| **Workable · Breezy · Paylocity · Toss 자체 · LinkedIn Easy Apply** | ⛔ 미확인/불가 | 브라우저로 실측한 것만 기록에 있다 |

- **비용 대비**: 그리팅이 실리는 워크스페이스면 폼 전체가 한 번의 GET 으로 나온다(SOCAR 가
  그래서 ⚠ 세 개를 브라우저 없이 지웠다). **안 실리면 거기서 멈추고 브라우저로 넘긴다** —
  JS 번들을 뒤져 API 를 복원하는 것은 하지 않는다(2026-07-29 시도했고 값이 안 나왔다).
- **판정하지 않는 것을 기록한다.** 못 읽은 폼을 「가벼울 것」으로 적지 않는다.
  `alive.py` 가 어댑터 없는 곳을 「미판정」으로 두는 것과 같은 규칙이다.

---

## 다음 타깃 — 우선순위

### 티어 1 · 본문까지 본 묶음

| 회사 | 🌐 | 권고 직무 (원제목) | 컷 | 경로 | 본문 | 공고 |
|---|---|---|---|---|---|---|
| **Lunit (루닛)** | | **(Seoul) Senior AX Engineer** | AI | **Workable** | **✓** | `4426954164` → **건 열림 · `ready`** |
| **FuriosaAI** | | **Software Engineer, Agent System Developer** | AI | Ashby | **✓** | `4387941500` → **건 열림 · `ready`** |
| **GE HealthCare** | **🌐** | **Senior Software Engineer** | Embedded/Systems | **Workday** | **✓** | `R4042393` · `4430473327` → **건 열림 · `draft`** |
| **HITS** (히츠) | | AI Agent Engineer | AI | **easy** | **✓** | `4420262371` |
| **카카오뱅크** | | DevOps 엔지니어 | DevEx | offsite | ? | `4437387455` |
| **NeuroFusion** | ? | Back End Developer | SWE | — | ? | `4444060387` |
| **LVIS** | ? | Backend Software Engineer | SWE | offsite | ? | `4434953668` |
| **Gauss Labs** | **🌐** | Senior FDE Operations (KR) | **FDE** | offsite | ? | `4445211164` — SK hynix 자회사, 본사 Palo Alto |

**탈락시킨 것 (행은 남긴다):**

| 회사 | 사유 |
|---|---|
| ~~KRAFTON~~ | **게임회사 — GLG 관심 축 아님** (2026-07-28). 열려 있던 3건 전부 제외 |
| ~~Sonatus~~ 🌐 | `Staff Cloud Backend Engineer` — **제목은 정확했으나** 본문이 time-series · OLAP/OLTP · Cassandra/Druid/Pinot **DB 전문직**이다. 증거 축 아님 |

**FuriosaAI Agent System Developer가 1순위다** — 건이 열려 있다
(`furiosaai--agent-system-developer`, 상태 `ready`). JD 가 agent orchestration ·
context management · tool execution · memory abstraction 을 그대로 요구한다.
경로는 **Ashby, 가입 불필요**. Ashby 보드 실제 공고 수는 23건이 아니라 **55건**이고 에이전트
축이 셋이다(Agent System Developer · ML Engineer Agentic AI · Technical Writer).
⚠ **2026-03-20 게시로 4개월째 열려 있다** — 회신이 느릴 수 있다.

**HITS 는 2순위.** 석사 요건 통과(GLG M.S. 2008–2010)이고 Easy Apply 라 비용이 싸다. 다만
요구 스택이 LangChain·LangGraph·LlamaIndex 이고 도메인이 bioinformatics/cheminformatics 라
**적합도는 중간**이다.

> ### 제출 대기 여섯 건 — 2026-07-28 저녁 (오라클서버에서 준비, 노트북에서 제출)
>
> | # | 건 | 컷 | 경로 | 비고 |
> |---|---|---|---|---|
> | 1 | **Lunit · (Seoul) Senior AX Engineer** | AI | **Workable** | **적합도 최고.** 강남역 1분. GLG 지목 |
> | 2 | **FuriosaAI · Agent System Developer** | AI | Ashby | 폼 값 셋만 정하면 낸다 |
> | 3 | **Telechips · [판교] Embedded S/W Engineer** | **Embedded** | 자체 채용홈 | 자격 4줄 중 3줄 정면. GLG 지목 |
> | 4 | **Reflection AI 🌐 · FDE, Lead** | FDE | Ashby | GLG 지목. 리더십 연차만 경계 |
> | 5 | **Cohere 🌐 · FDE, Agentic Platform (Korea)** | FDE | Ashby | 요구가 에이전트 평가·실패 처리 |
> | 6 | **OpenAI 🌐 · Developer Experience Engineer (Seoul)** | **DevEx** | Ashby | 한국어가 자격이라 가점 |
>
> **여섯 건 전부 `ready` 다** — `LEDGER.md` 참조. 네 건이 Ashby 한 경로라 폼 구조가 같다.
> 컷은 이미 만들어 둔 여섯 종을 그대로 쓴다(새로 빌드하지 않는다).
> **HITS 는 그 다음이다** — Easy Apply 라 비용은 싸지만 도메인 적합도가 위보다 낮다.

> ### 이 표가 틀렸던 두 자리 — 2026-07-28 정리
>
> **원인은 스킬이 아니라 뒷정리였다.** 데이터는 멀쩡했고 옮겨 적으면서 잃었다.
>
> 1. **KRAFTON — 제목을 줄이다 「계약직」을 날렸다.**
>    원제목은 `[AI Transformation Dept.] AX Governance Specialist (3년 이상 / 계약직)` 인데
>    표에는 `AX Governance Specialist (3년+)` 로 올라 있었다. **계약직 공고가 「권고 확정」
>    묶음에 정규직처럼 앉아 있었다.** → §계약 「제목을 줄이지 않는다」
> 2. **Sonatus — 제목만 보고 「확정」으로 올렸다.**
>    제목 `Staff Cloud Backend Engineer` 는 정확했다. 본문이 DB 전문직이라는 건 제목 어디에도
>    없었다. → §계약 「확정이라고 적으려면 본문을 읽었어야 한다」
>
> **스킬에도 구멍이 하나 있었다.** `enrich` 가 받아 두는 `criteria`(고용형태·연차)를 `emit()`
> 이 한 번도 출력하지 않았다. 이제 `rank`/`search` TSV 에 `⚠Contract` 처럼 뜬다
> (`test_ljobs.py` 고용형태 7 케이스).

### 티어 2 · 반도체·모빌리티 (본문 미확인 — 내려면 본문부터)

| 회사 | 🌐 | 권고 직무 | 컷 | 본문 | 공고 | 비고 |
|---|---|---|---|---|---|---|
| ~~42dot~~ | | ~~LLM Engineer (LLM Training)~~ | AI | **✓** | `4443770588` | **본문 확인 후 탈락 권고 — 연구직이다**(아래 §42dot 판정) |
| ~~42dot~~ | | ~~Senior Embedded Linux Build Engineer~~ | Embedded | **✓** | `4442731341` | **QNX 5년 하드 게이트**(아래 §42dot 판정) |
| **Rebellions** | | System Software Architect | Embedded | ? | `4415303828` | 8건 중 2건은 강서구 — 이 건은 판교 표기 |
| **XCENA** | | System SW Engineer, Performance & **Developer Tools** | DevEx | ? | `4444920306` | 나머지 10건은 SoC/HW 설계라 증거 밖 |
| **Telechips** | | **[판교] Embedded S/W Engineer** | Embedded | **✓** | `4431589221` | **건 열림 · `ready`.** 원본은 자체 채용홈 `careers.telechips.com/job_posting/iSXmKnRT` |
| Penguin Solutions | **🌐** | DevOps Engineer | DevEx | ? | `4440528153` | 미국(구 SMART Global Holdings) |

42dot 나머지: RL `4443782022` · Evaluation `4443770586` · Data Generation `4436476007` ·
ML Platform `4442734241` · DevOps Platform `4442733252`.
Rebellions 나머지: Server/NPU Infra `4441428492` · Collective Comm `4437141292` · BMC FW `4432085933`.
XCENA 나머지: Firmware InfiniteMemory `4444918359` · Embedded BSP `4444930080`.

> ### ⚠ 42dot 판정 정정 — 2026-07-28 밤 (GLG 지적)
>
> **아래 「두 건 다 내려놓기」는 42dot 전체 판정이 아니다.** 내가 본 두 건이 하필 축 밖이었을
> 뿐이고, **42dot 에는 에이전트 축이 넷 더 있다.** GLG 가 `On-device Agent Orchestration` 을
> 짚어서 드러났다 — **후보를 좁게 잡은 것이 원인이지 회사가 문제가 아니었다.**
>
> | 자리 | 연차 요건 | 성격 |
> |---|---|---|
> | **Senior AI Agent Engineer (Intelligence Service)** `e1bcc942` | **7년+** | RAG agent orchestration · planning→tool routing→retrieval · **eval 하니스·회귀 테스트·guardrail·fallback** → **건 열림** |
> | AI Engineer (On-device Agent Orchestration) `464eb98e` | **2~3년+** | SDV 차량 온디바이스 · Kotlin/Android 우대. **GLG 가 짚은 자리** — 연차가 아래라 처우가 낮게 잡힌다 |
> | [집중채용] SDV Agent Engineer (Connected Service) `93be2878` | — | 차량 커넥티드 |
> | AI Engineer (Navigation Agent) `4a19a543` | — | 내비 에이전트 |
>
> **교훈: 회사를 판정하지 말고 자리를 판정한다.** 보드에 120건이 있는 회사를 두 건으로 닫았다.
>
> ### 42dot LLM/Build 두 건 판정 — 2026-07-28 저녁
>
> **이 두 건은 내려놓는다.**
>
> - **LLM Engineer (LLM Training)** — 요구가 `Pre-training / Post-training 효율`,
>   `분산 학습 프레임워크(Slurm·DDP·Horovod)`, `PyTorch 모델 설계·학습·최적화`,
>   우대가 `ACL·EMNLP·NeurIPS 논문`이다. **모델을 만드는 연구직**이지 에이전트 시스템을
>   짓는 자리가 아니다. GLG 축(에이전트 오케스트레이션 · 시스템 SW · 문서·전파)과 겹치지 않는다.
>   → 「제목만 보고 티어 1로 올렸던」 Sonatus 사고와 같은 형태를 본문이 먼저 잡아냈다.
> - **Senior Embedded Linux Build Engineer** — 빌드·CI·재현성 축은 GLG 서사와 정면인데
>   자격이 **`Yocto 5년 이상` + `QNX 5년 이상`을 둘 다** 요구한다. QNX 5년은 없다.
>   내겠다면 그 칸을 어떻게 답할지 GLG 가 먼저 정해야 한다.
>
> 42dot 자체를 닫는 건 아니다. 나중에 다른 축(DevOps Platform · ML Platform)이 열리면 다시 본다.

### 티어 3 · FDE 축 (경쟁이 얕고 서사가 정면으로 맞는다)

**여기는 거의 전부 외국계다.** 서사는 정면인데 영어 상시 회의·본사 시차·한국 법인 규모가
같이 걸린다. **Ashby 두 곳(Cohere · OpenAI)은 2026-07-28 저녁에 본문을 떴다**(아래 판정).
나머지는 아직 본문 미확인이라 내려면 본문부터 뜬다.

| 회사 | 🌐 | 직무 | 경로 | 본문 | 공고 |
|---|---|---|---|---|---|
| **Cohere** | **🌐** 캐나다 | **FDE, Agentic Platform (Korea)** | **Ashby** | **✓** | `4366574942` · `cohere/[uuid removed]` |
| **OpenAI** | **🌐** 미국 | FDE - Seoul | **Ashby** | **✓** | `4431428608` · `openai/[uuid removed]` |
| **Reflection AI** | **🌐** 미국 | **FDE, Lead - AI Engineer** | **Ashby** | **✓** | `4425516036` → **건 열림 · `ready`** (비-Lead 쌍둥이 `4425505149` 는 대안으로 보류) |
| **Databricks** | **🌐** 미국 | Forward Deployed Engineer | offsite | ? | `4410609158` |
| Cloudflare | **🌐** 미국 | FDE, Professional Services | — | ? | `4432741765` |
| BCG | **🌐** 미국 | (Senior) Forward Deployed AI Engineer | offsite | ? | `4433468111` |
| CJ OLIVE YOUNG | | Forward Deployed AI Engineer | offsite | ? | `4424964255` — **국내 유일** |
| ~~KRAFTON~~ | | ~~[Infra] Technical Solution Engineer (10년+)~~ | — | — | `4435529194` **게임회사 제외** |

> ### Cohere · OpenAI FDE 판정 — 2026-07-28 저녁, Ashby 본문 확인 후
>
> - **Cohere FDE, Agentic Platform (Korea)** — 게시 2026-01-28, `FullTime`, 근무지 `Korea`.
>   요구가 **「LLM 에이전트를 설계·구축·평가·파인튜닝한 실경험」 + 「툴 사용 · 다단계 워크플로
>   (ReAct) · 실패 처리」 + Python/TS + 고객 대면**이다. Enhans FDE 에 낸 서사와 **같은 축**이라
>   글을 새로 쓰지 않아도 된다. 걸리는 것 셋: **영어·한국어 fluency 명시**, 출장 20–40%,
>   「senior + 팀 단위 기술 리더십」 요구. 제품(North)은 엔터프라이즈 AI 워크스페이스.
> - **OpenAI FDE - Seoul** — 게시 2026-06-23, `FullTime`. 5년+ 고객 대면 엔지니어링,
>   프론트·백 프로덕션 코드, LLM 시스템 구축 경험. 조건이 무겁다 — **주 3일 서울 오피스 출근 +
>   출장 50%**. 서사는 맞지만 경쟁이 가장 두꺼운 자리다.
>
> **FDE 축을 한 건만 낸다면 Cohere 다.** 요구 문장이 GLG 가 실제로 판 것(에이전트 오케스트레이션 ·
> 평가 · 실패 처리)을 그대로 부르고, 경로가 Ashby(가입 불필요)라 비용도 싸다.

**Ashby 두 곳(Cohere · OpenAI)은 API 로 본문·게시일을 한 번에 볼 수 있다** — 위 플랫폼 표 참조.

**exa 축(피드 포스트)에서만 잡힌 것** — guest API에 안 걸린다:
Google Cloud AI FDE(한국) 🌐 · TreeSoop FDE · OpenAI Partner AI Deployment Engineer(AWS) 🌐.
~~KRAFTON AX FDE 집중채용~~ 은 게임회사라 제외.

### 티어 4 · DevEx 축

| 회사 | 🌐 | 직무 | 본문 | 공고 |
|---|---|---|---|---|
| **OpenAI** | **🌐** 미국 | **Developer Experience Engineer** (Seoul) | **✓** | `4418860629` · `openai/[uuid removed]` |
| **FuriosaAI** | | SW Engineer, **Technical Writer & Document Specialist** | **✓** | `4426791367` · `furiosa-ai/[uuid removed]` |
| FriendliAI | | Developer Advocate | `4405336361` |
| CJ OLIVE YOUNG | | DevRel | `4424177483` |
| NVIDIA | **🌐** 미국 | Senior Developer Relations Manager - GenAI | `4416335601` |
| ~~KRAFTON~~ | | ~~[HR] Developer Relations Program Manager~~ | `4424176050` **게임회사 + ⚠계약직** |

**FuriosaAI Technical Writer를 눈여겨본다.** JD가 docs-as-code다 — 소스를 읽고 실제 하드웨어에서
스택을 돌려 문서를 쓰고, **자동 파이프라인으로 문서를 라이브 코드베이스에 대해 계속 검증**한다.
NPU·컴파일러 도메인 + 문서·전파 축이 한 자리에서 겹친다. `AGENTS.md` §직무 선택 3번에 정확히
걸린다.

> ### 티어 4 판정 — 2026-07-28 저녁, Ashby 본문 확인 후
>
> - **FuriosaAI Technical Writer — 엔지니어 트랙 맞다. 브라우저 확인 필요 없다.**
>   LinkedIn 분류가 `Marketing, PR, Writing/Editing` 이었지만 Ashby 원문 제목이
>   `Software Engineer, Technical Writer & Document Specialist` 이고, 요구가
>   **MDX docs-as-code 파이프라인 · CI 링크/샘플 자동 검증 · 실제 RNGD 하드웨어 대상
>   hardware-in-the-loop 문서 검증 · Python/Rust 소스 읽기**다. 문서를 **테스트되는
>   버전 산출물**로 다룬다 — GLG 가 가든에서 하는 일의 회사판이다.
>   게이트는 하나: **`developer-facing 소프트웨어 기술문서 3년 이상`** 과 강한 영문 작성력.
>   ⚠ 다만 **FuriosaAI 는 이미 Agent System Developer 건이 열려 있다**(§한 회사 한 직무).
>   둘 다 내려면 GLG 가 명시적으로 예외를 정해야 한다 — DEEPX 2건이 그 선례다.
> - **OpenAI Developer Experience Engineer (Seoul)** — 게시 2026-05-13, `FullTime`, 서울.
>   데모·샘플앱·튜토리얼·블로그·영상으로 **개발자 생태계를 키우는 자리**이고
>   **`Korean language skills`** 가 자격에 박혀 있다(한국 커뮤니티 담당). 풀스택 + LLM 앱 구축
>   경험을 함께 본다. **APAC 출장 30%.** GLG 의 「짓고 + 쓰고 + 전파한다」가 한 칸에 다 들어가는
>   드문 자리다. 경쟁은 세지만 서사가 흔하지 않다.

---

## 「한 회사 한 직무」 권고표

| 회사 | 🌐 | 열린 공고 | 권고 | 근거 |
|---|---|---|---|---|
| FuriosaAI | | **Ashby 55건** (LinkedIn엔 23건만) | **Agent System Developer** | **건 열림.** 2순위는 Technical Writer |
| 42dot | | 19건 (LLM 4 동시) | **LLM Engineer (LLM Training)** | LLM 4종은 한 팀 집중채용 |
| Rebellions | | 8건 | **System Software Architect** | 시스템 SW 축이 증거가 가장 두껍다 |
| XCENA | | 11건 | **Performance & Developer Tools** | 나머지는 SoC/HW 설계 |
| OpenAI | **🌐** | 5건 | **Developer Experience Engineer** | DevEx가 가장 정확히 맞고 경쟁이 얕다 |
| GE HealthCare | **🌐** | 성남 Software·AI/ML 연차별 묶음 | **Senior Software Engineer** | 7~12년 application/system SW가 정면. AI/ML 계열은 모델 개발 하드 갭 |
| NHN | | 5건 | 내려면 **LLM 기술 개발** `4439978335` | ⚠ **세 번째 접촉** — GLG 판단 자리 |
| CJ OLIVE YOUNG | | 2건 | **Forward Deployed AI Engineer** | FDE 축이 더 얕다 |
| ~~KRAFTON~~ | | ~~14건~~ | — | **게임회사 제외** |

**LinkedIn 공고 수를 믿지 않는다.** FuriosaAI 는 LinkedIn guest 검색에 23건이었는데 실제
Ashby 보드는 55건이었다. **회사를 정했으면 그 회사 채용 보드를 직접 본다.**

---

## 보드 훑기 수확 — 2026-07-28 밤 (다음 배치)

**LinkedIn guest 검색은 광고가 상단을 먹고 키워드당 10건에서 끊긴다.** 그래서 회사 채용 보드를
직접 긁는 축을 만들었다 — `.claude/skills/linkedin-jobs/boards.py` + `companies.txt`.
25개 보드 1,400여 건에서 **331건이 GLG 축 키워드에 걸렸다.** 그중 국내·정면인 것만 남긴다.

| 회사 | 자리 | 컷 | 경로 | 근무지 |
|---|---|---|---|---|
| ~~**마키나락스**~~ **→ 케이스 열림** | **[FDE] AI Agent Application Engineer** | FDE | greeting | 서초 강남대로 |
| **센드버드** | **Software Engineer, AI Agent** | AI | greenhouse | 서울 |
| ~~**업스테이지**~~ **→ 케이스 열림(막힘)** | **AI Engineer - Agents** — 제품 체험 평가 필수 | AI | greeting | 강남 테헤란로 |
| **카카오페이** | **FDE — 전사 프로젝트 지원 및 AI 기반 업무 생산성 향상** | FDE/AI | greeting | 판교역로 166 |
| **카카오모빌리티** | 물류 & **에이전트 개발실** 백엔드 개발자 | AI | greeting | 판교역로 152 |
| **뤼튼** | **AX Agent Developer** · `Platform Engineer` | AI | greeting | 서초 |
| **리벨리온** | **Linux Device Driver Engineer** · `NPU Kernel Driver` · `NPU SW - SDK` | Embedded | greeting | 판교 정자 |
| ~~**프렌들리AI**~~ **→ 케이스 열림** | Software Engineer – AI Agents | AI | ashby | 서울 |

- **리벨리온이 증거다.** LinkedIn 에는 8건이었는데 **보드에는 41건**이고, GLG 축 정면인
  `Linux Device Driver` · `NPU Kernel Driver` · `SDK` 는 **LinkedIn 목록에 아예 없었다.**
- **마키나락스는 FDE 만 12건**이다. FDE 축을 파려면 여기가 가장 두껍다.
- 카카오페이 FDE 는 자격 첫 줄이 **`Java/Kotlin 기반 깊이 있는 백엔드`** 다 — Enhans AgentOS 를
  같은 이유로 뺐던 자리다. **내려면 그 칸을 어떻게 답할지 먼저 정한다.**
- 🔴 **카카오헬스케어 — 2026-07-30 정정. 「두 건이고 둘 다 못 낸다」가 아니었다. 세 번째가 있었고,
  그것이 이 배치에서 가장 정면인 공고다 → 케이스 열림 `kakao-healthcare--ai-agent-engineer`.**

  | 공고 | addressKey | 상태 | 판정 |
  |---|---|---|---|
  | **`[경력] AI Agent Engineer`** | **`e9Q82rF9`** | `in_progress` · `closedAt=null` · `until_filled` · **경력 5년 이상** | ✅ **케이스 열림.** 하드 게이트 **없음** — 요건이 「CS·ML 석사 + 3년 이상 실무」이고 담당 업무가 **밑바닥부터 만드는 agent harness · subagent/skill/workflow 인터페이스 · 평가·관측 · LLM 서빙 라우팅 · STT/OCR 도입 판단** 다섯이다 |

  - **왜 못 찾았나 — 발견 경로가 이 회사에서 구조적으로 막혀 있다.**
    ① `recruit.kakaohealthcare.com` 은 **목록이 클라이언트 렌더**라 `boards.py` 로 못 훑는다.
    ② `careers.kakao.com` 공동체 목록(`boards.py list kakao:all`)에 **이 건이 잡히지 않았다.**
    ③ 그래서 2026-07-29 재조사는 **공동체 목록에 뜬 두 건만** 보고 회사를 통째로 닫았다.
    **GLG 가 URL 을 직접 건네서 발견됐다.**
  - **교훈**: 카카오 계열은 **공동체 목록 = 그 회사의 전체 공고가 아니다.** 한 회사를 「없음」으로
    닫기 전에 **자체 채용홈을 사람 눈으로 한 번 연다.** 한화비전에서 이미 같은 성질을 배웠다 —
    *"ninehire 는 목록에 없는 공고가 URL 로 살아 있다."* **그 교훈을 이 회사에 적용하지 않았다.**
  - **아래 두 건에 대한 2026-07-29 판정 자체는 여전히 사실이다.** 지우지 않고 그대로 둔다.

- **카카오헬스케어 — 재조사 (2026-07-29, GLG 지시). 아래 두 건은 둘 다 못 낸다.**
  앞 판에는 `AI Native EHR` 하나만 적혀 있었다. 빠져 있던 것은 `Data Engineer(Healthcare)` 다.

  | 공고 | careers.kakao | 원본 ATS(ninehire) 실측 | 하드 게이트 | 판정 |
  |---|---|---|---|---|
  | `AI Native EHR 개발` (`S-4699`) | 상시 | `9W2MmlSr` · **`in_progress`** · `closedAt=null` · `until_filled` | **의료정보시스템(EMR/HIS/OCS/EHR) 개발·운영 10년 이상** | ⛔ **제외** — 열려 있지만 축 밖 |
  | `Data Engineer(Healthcare)` (`S-4689`) | 상시 | `byfZYpGH` · **`archived`** · **`closedAt=2026-05-15`** | **의료정보시스템(EMR/HIS/CDW/CDM) 5년 이상** | ⛔ **제외** — 이미 닫혔고, 살아 있었어도 축 밖 |

  - 근무지는 둘 다 **카카오판교아지트**(판교역로 166) · 정규직. 지역은 통과였다.
  - `Data Engineer` 는 우대가 Spark/Hadoop·비식별화·데이터 마이그레이션으로 **데이터 엔지니어
    정직군**이다. 임베디드·에이전트 축과 겹치는 면이 없다.
  - ⚠ **`careers.kakao.com` 공동체 목록은 stale 하다.** 소스 ATS 에서 **두 달 넘게 archived**
    인 공고를 「상시」로 그대로 노출한다. **카카오 공동체 건은 `boards.py list kakao:all` 로
    찾은 뒤 원본 ATS 에서 `status` 를 다시 확인한다** — 목록을 믿고 케이스를 열면 안 된다.
  - 카카오헬스케어 자체 보드(`recruit.kakaohealthcare.com`)는 **목록이 클라이언트 렌더**라
    `boards.py` 로 못 훑는다. 상세 페이지 `__NEXT_DATA__` 의 `recruitment` 는 정상이므로
    **`careers.kakao.com` 으로 발견 → ninehire 상세로 검증**이 이 회사의 경로다.
    (list API 세 경로 시도 전부 404 — `api.ninehire.com` 은 공개 목록 엔드포인트가 없다.)

## 보류 · 제외

| 회사 | 🌐 | 사유 |
|---|---|---|
| **KRAFTON** | | **게임회사 — GLG 관심 축 아님** (2026-07-28 확정). 열려 있던 3건 전부 |
| **Sonatus** | **🌐** | 본문이 time-series·OLAP·Cassandra/Druid/Pinot **DB 전문직**. 증거 축 아님 |
| **Insighter** | | Easy Apply **임시저장 상태**(제출 아님). 마포 DMC. 버리려면 `closed` + `_archive/` |
| **Mistral** (Applied AI Engineer) | **🌐** 프랑스 | 부서는 Solutions인데 요구는 **PhD/석사 AI · 파인튜닝 · PyTorch · fluent English**. 적합도 중하 |
| **Coxwave** | | GLG 회사 판단으로 제외 |
| Harper | **🌐** | Founding 단계 — 영세 기준 |
| ALCOFIND · Toss Insurance · FuriosaAI Productization(화성) | | 통근 범위 밖 |

## 남은 구멍

- **Ashby 쓰는 네 곳은 본문을 다 떴다**(2026-07-28 저녁, 6건: 42dot ×2 · OpenAI ×2 · Cohere ·
  FuriosaAI TW). 전부 `FullTime` · `isListed=true` 로 살아 있다. **아직 본문 미확인인 묶음은
  티어 2 의 Rebellions · XCENA · Telechips · Penguin, 티어 3 의 offsite 다섯 곳**이다.
  Sonatus 사고가 그 묶음에서 나왔다 — 내기로 정하면 **먼저 본문부터 뜬다.**
- **외국계 표시 중 `?` 두 곳** — NeuroFusion · LVIS 는 본사 국적을 확인하지 않았다.
  낼 때 확인한다. 모르면 `?` 로 둔다.
- **LinkedIn 공고 수는 하한이다.** 회사 채용 보드가 진짜 목록이다(FuriosaAI 23 → 55).
- **Kakao Enterprise 1건 · Telechips 2건** — 영문 사명으로 안 걸린다. 국문 사명
  (`카카오엔터프라이즈`)으로 재검색 필요. ~~NCSOFT~~ 는 게임회사라 이제 볼 필요 없다.
- 안랩 · SK플래닛 · 한컴 · LINE Plus는 각 10건씩 잡혔으나 GLG 축에 걸리는 자리가 없었다.

---

## GLG 가 링크로 건넨 건 — 2026-07-28 밤 (전부 케이스로 열림)

보드 훑기와 **다른 축**이다. GLG 가 LinkedIn 에서 눈으로 고른 자리를 링크로 던지면,
`ljobs.py detail` 로 본문을 뜨고 **원본 ATS 를 찾아** 경로를 바꾼 뒤 케이스를 열었다.
**LinkedIn 은 대부분 offsite 였고, 원본 경로가 따로 있었다.**

| 회사 | 자리 | 컷 | 원본 경로(LinkedIn 아님) | 상태 |
|---|---|---|---|---|
| **쏘카(SOCAR)** | Platform Engineer | DevEx | greeting `socar` | `ready` |
| **Toss** | AI Engineer (Platform) | AI | **토스 자체** `toss.im/career` | `ready` |
| **FriendliAI** | Software Engineer – AI Agents | AI | ashby `friendliai` | `ready` |
| **AIRS Medical** | AX Engineer | DevEx | greeting `airsmed` | `ready` |
| **Bear Robotics** | Systems SW Engineer (Linux Platform) | Embedded | **Breezy HR** | `ready` |
| **Telit Cinterion** 🌐 | Edge AI Software Engineer | Embedded | **Paylocity** | `ready` |
| **Sonatus** 🌐 | Staff DevOps Engineer | Embedded | **LinkedIn Easy Apply** (원본) | `ready` |
| **Penguin Solutions** 🌐 | Sr. System Engineer | 미정 | **SuccessFactors** | **보류 — 적합도 최하위** |

- **`AIRS Medical` 가 이번 수확의 최고점이다.** 우대 첫 줄이
  `Claude Code · Codex · Gemini · OpenCode 를 자체 skill/hook/agent/MCP server 로 customize` +
  `openclaw 같은 personal AI agent 사용·구축` 이다. **DevEx 컷 이력서에 그 목록이 이미 있다.**
- **`Bear Robotics` 가 문턱이 가장 낮다** — 필수 경력 **1년 이상**, Python/Go + Bash + 리눅스.
  우대 여덟 줄 중 다섯이 직접 걸린다. LG전자 계열이라 규모 기준도 통과.
- **`Telit Cinterion` 은 임베디드와 에이전트가 한 자리에 있다** — 주요 업무 다섯 번째가
  「LLM 기반 Agent 프레임워크를 R&D 일상 워크플로에 프로덕션 도입」이다. 대신 **필수 절반이
  모델 최적화**(pruning/quantization/TFLite/ONNX/FFT)라 간극이 분명하다.
- **`Penguin Solutions` 는 방향이 반대다** — 동사가 install·administer·patch·troubleshoot 이고
  **주간 온콜**이 상수다. 대는 카드는 **NVM 파일시스템·병렬 스토리지 연구 4년** 하나뿐이다.
- **처음 만난 ATS 넷**(토스 자체 · Breezy · Paylocity · SuccessFactors)의 경로는
  `.claude/skills/linkedin-jobs/companies.txt` 하단에 적어 두었다.

---

## 🤖 로봇·피지컬 축 — 2026-07-28 심야 개시

**GLG 방향 전환**: "너무 시스템 가니까 재미없어 보인다. 로봇쪽도 넓게 보려고 해."
**에이전트 공존 = 피지컬 실체를 염두한 포석**이라는 축을 여기서부터 실제 후보로 옮긴다.
GLG 는 로봇 전공자가 아니지만 **전체 시스템을 다 다뤄 왔고** ROS·RTOS 도 만졌다.
기준은 적합도가 아니라 **지향과 흥미**다.

### 케이스로 연 것

| 회사 | 자리 | 근무지 | 비고 |
|---|---|---|---|
| **Holiday Robotics** | Forward Deployed Robotics Engineer (3–8년) | 서울 강남 | **케이스 열림.** 2024설립·28명·Series A **$105M**·산업용 휴머노이드 `FRIDAY`. ⚠ ROS2 필수 |

**Holiday Robotics 채용 페이지에 `Wild Card` 입구가 따로 있다** —
*"맞는 자리가 없으면, 무슨 문제를 풀고 싶고 무엇을 만들지 말해 달라. 같이 방법을 찾자."*
FDE 폼이 ROS2 로 막히면 **이쪽이 오히려 GLG 의 문**이다. 같은 회사에 두 입구를 동시에 쓰지 않는다.

### 훑어서 나온 것 — 아직 본문 미확인

| 회사 | 자리 | 근무지 | 게시 | ID |
|---|---|---|---|---|
| **Holiday Robotics** | Humanoid Robot Field Service Manager (3–10년) | 서울 강남 | 07-21 | 4443053720 |
| Hyundai AutoEver | [SDx] Platform Developer - Robot | 서울 | 07-24 | 4426051229 |
| Raion Robotics | 로봇 SW 엔지니어 (서울/대전) | 서울 | 07-22 | 4443121237 |
| Beyond Honeycomb | Robotics Engineer | 서울 | 07-15 | 4439996330 |
| Hyundai Motor | [Manufacturing Robotics] Robotics Data Engineer | 성남 | 07-15 | 4438043344 |
| Hyundai Motor | Lunar Mobility Software Engineer (Space) | 화성 | 07-15 | 4438029658 |
| Woowa Bros. | 로보틱스 S/W 엔지니어링 (SLAM 개발) | 서울 | 07-17 | 4414163925 |
| Sequor Robotics | SLAM Engineer | 서울 | 07-28 | 4445448460 |
| NVIDIA 🌐 | Solutions Architect - AI Technology Center for **Physical AI** | 서울/인천 | 07-24 | 4416338532 |
| NVIDIA 🌐 | Simulation Engineer, Industrial Physics and Robotics | 서울/인천 | 07-22 | 4434379426 |
| Superb AI | Simulation Engineer | 서울 | 07-05 | 4437115788 |
| Ludo Robotics | AI/ML Research Engineer (Robotics) (2년 이상) | 서울 | 07-23 | 4386388310 |
| Doosan Robotics | Robotics Mechanical Engineer | 성남 | 07-21 | 4414823437 |

### ⛔ Harper 는 안 쓴다 (2026-07-28 GLG 확정)

> "harper는 안 쓸 거야. **여기 실체가 별로 없어.**"

Harper 명의로 올라온 자리(`Head of Robotics Systems` 4443100893 · `Robotics Systems Engineer`
4443102776 · 앞서 나온 `Founding Engineer, AI Agent`)는 **전부 중개 구조**다. 공고 본문이
*"Harper is an AI career agent that works for you — the candidate. Skip the application form:
just talk to Harper"* 로 시작하고, **실제 고용주 이름이 공고 어디에도 없다**("삼성·현대·LG 가
투자한 로봇 파운데이션 모델 스타트업"이라고만 쓴다).

**앞으로 Harper 명의 공고는 목록에 올리지 않는다.** 훑다가 나오면 이 줄을 근거로 건너뛴다.

**이미 낸 것과 겹치는 자리**: Bear Robotics(`ready`, Systems SW Engineer) · Hyundai AutoEver
(`submitted`, AI Agent Engineer) — 로봇 축에서도 같은 회사가 다시 나온다.

### SLAM·제어·시뮬레이션은 축이 아니다

SLAM(우아한형제들·Sequor) · 기구 설계(두산) · 시뮬레이션(NVIDIA·Superb AI)은 **GLG 축이
아니다.** 로봇 축에서 GLG 가 서는 자리는 셋이다.

1. **현장 배치·통합·필드 디버깅** (Holiday FDE)
2. **로봇 플랫폼 위의 시스템/플랫폼 소프트웨어** (Bear Robotics · AutoEver SDx)
3. **로봇과 에이전트가 만나는 지점** — 아직 공고로 잘 안 나온다. **여기가 진짜 축이고,
   그래서 `Wild Card` 같은 입구가 중요하다.**


---

## 채널별 자매 파일

- **원티드**: `INBOX-WANTED.md` (2026-08-04 스캔 · 264건 필터 · 통과 18건)
- **리멤버**: `INBOX-REMEMBER.md` (2026-08-04 스캔 · `remember.js` API 축 · 809건 수집 → 담당업무 통과 207건 → 제목까지 정면 44건 · 본문 다 읽은 최정면 4건)
