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

## 지원 경로 — 플랫폼 5종 (실측 확정)

한국 채용 플랫폼은 다섯으로 수렴한다. **하나를 익히면 여러 회사가 덮인다.**

| 플랫폼 | 확인된 회사 | 주소 형태 | 가입 | 폼 특징 |
|---|---|---|---|---|
| **그리팅** | DEEPX · Hyundai AutoEver · Rebellions | `<회사>.career.greetinghr.com/ko/o/<id>` · `career.<회사>.com/ko/o/<id>` | 불필요 | **회사마다 폼이 다르다.** AutoEver는 사전질문 1,000자, DEEPX는 자기소개서를 묻는다 |
| **Ashby** | OpenAI · Cohere · 42dot · **FuriosaAI** | `jobs.ashbyhq.com/<회사>/<uuid>` | 불필요 | 폼 직접 작성 + 이력서 업로드. **공고 목록은 API 로 한 번에 뜬다** — `api.ashbyhq.com/posting-api/job-board/<회사>` (title·team·location·employmentType·publishedAt·applyUrl·본문 HTML) |
| **ninehire** | Enhans | `<회사>career.ninehire.site/job_posting/<id>` | 불필요 | **서술형 칸 없음.** 이력서 + URL 한 줄이 전부 |
| **Greenhouse** | Toss (`toss.im` 경유) | `toss.im/career/job-detail?gh_jid=<id>` | 불필요 | ⚠ `toss.im`은 브라우저 안전 제한으로 에이전트가 못 연다 |
| ~~자체~~ | ~~FuriosaAI~~ | — | — | **정정: FuriosaAI 는 Ashby 다**(위 행). `furiosa.ai/careers` 는 목록 페이지일 뿐이고 「Apply」가 Ashby 로 넘긴다 |

### 브라우저 축 실무 메모

- **링크 따는 법**: LinkedIn 「회사 사이트에서 지원」 클릭이 새 탭을 못 열 때가 있다. 그때는
  `read_page` 의 `ref_id` 로 `href` 를 직접 읽으면 `linkedin.com/safety/go/?url=<인코딩>` 이
  나온다. 클릭보다 빠르고 확실하다.
- **파일 업로드**: `file_upload` 도구가 이 저장소 경로를 그대로 받는다(LinkedIn·그리팅 확인).
  단 **ninehire 는 file input이 DOM에 없고 클립 버튼이 네이티브 대화상자를 연다** — 그 경우
  에이전트가 못 하고 GLG가 직접 올린다.
- **LinkedIn 저장 이력서**(`jobs/application-settings/`)에는 **베이스판만** 둔다. 한 공고용
  문서를 올려 두면 다음 열 곳에 그게 딸려 나간다(NHN AX 문서가 그럴 뻔했다).

---

## 다음 타깃 — 우선순위

### 티어 1 · 본문까지 본 묶음

| 회사 | 🌐 | 권고 직무 (원제목) | 컷 | 경로 | 본문 | 공고 |
|---|---|---|---|---|---|---|
| **FuriosaAI** | | **Software Engineer, Agent System Developer** | AI | Ashby | **✓** | `4387941500` → **건 열림** |
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
| **42dot** | | LLM Engineer (LLM Training) | AI | ? | `4443770588` | **집중채용 중**(2026-07-23 회사 포스트). 현대차그룹. LLM 4종은 한 팀이라 하나만 |
| 42dot | | *또는* Senior Embedded Linux Build Engineer | DevEx | ? | `4442731341` | DevEx 컷을 쓸 거면 이쪽 |
| **Rebellions** | | System Software Architect | Embedded | ? | `4415303828` | 8건 중 2건은 강서구 — 이 건은 판교 표기 |
| **XCENA** | | System SW Engineer, Performance & **Developer Tools** | DevEx | ? | `4444920306` | 나머지 10건은 SoC/HW 설계라 증거 밖 |
| Telechips | | Embedded Software Engineer | Embedded | ? | `4431589221` | BSP·Device Driver |
| Penguin Solutions | **🌐** | DevOps Engineer | DevEx | ? | `4440528153` | 미국(구 SMART Global Holdings) |

42dot 나머지: RL `4443782022` · Evaluation `4443770586` · Data Generation `4436476007` ·
ML Platform `4442734241` · DevOps Platform `4442733252`.
Rebellions 나머지: Server/NPU Infra `4441428492` · Collective Comm `4437141292` · BMC FW `4432085933`.
XCENA 나머지: Firmware InfiniteMemory `4444918359` · Embedded BSP `4444930080`.

### 티어 3 · FDE 축 (경쟁이 얕고 서사가 정면으로 맞는다)

**여기는 거의 전부 외국계다.** 서사는 정면인데 영어 상시 회의·본사 시차·한국 법인 규모가
같이 걸린다. 전부 **본문 미확인**이라 내려면 본문부터 뜬다.

| 회사 | 🌐 | 직무 | 경로 | 공고 |
|---|---|---|---|---|
| **Reflection AI** | **🌐** 미국 | Forward Deployed Engineer - AI Engineer | offsite | `4425505149` |
| **Databricks** | **🌐** 미국 | Forward Deployed Engineer | offsite | `4410609158` |
| Cloudflare | **🌐** 미국 | FDE, Professional Services | — | `4432741765` |
| Cohere | **🌐** 캐나다 | FDE, Agentic Platform (Korea) | **Ashby** | `4366574942` |
| OpenAI | **🌐** 미국 | FDE - Seoul | **Ashby** | `4431428608` |
| BCG | **🌐** 미국 | (Senior) Forward Deployed AI Engineer | offsite | `4433468111` |
| CJ OLIVE YOUNG | | Forward Deployed AI Engineer | offsite | `4424964255` — **국내 유일** |
| ~~KRAFTON~~ | | ~~[Infra] Technical Solution Engineer (10년+)~~ | — | `4435529194` **게임회사 제외** |

**Ashby 두 곳(Cohere · OpenAI)은 API 로 본문·게시일을 한 번에 볼 수 있다** — 위 플랫폼 표 참조.

**exa 축(피드 포스트)에서만 잡힌 것** — guest API에 안 걸린다:
Google Cloud AI FDE(한국) 🌐 · TreeSoop FDE · OpenAI Partner AI Deployment Engineer(AWS) 🌐.
~~KRAFTON AX FDE 집중채용~~ 은 게임회사라 제외.

### 티어 4 · DevEx 축

| 회사 | 🌐 | 직무 | 공고 |
|---|---|---|---|
| **OpenAI** | **🌐** 미국 | Developer Experience Engineer | `4418860629` — 본문에 「한국어 필요」 명시 |
| **FuriosaAI** | | SW Engineer, **Technical Writer & Document Specialist** | `4426791367` — Ashby, 2026-06-10 게시 |
| FriendliAI | | Developer Advocate | `4405336361` |
| CJ OLIVE YOUNG | | DevRel | `4424177483` |
| NVIDIA | **🌐** 미국 | Senior Developer Relations Manager - GenAI | `4416335601` |
| ~~KRAFTON~~ | | ~~[HR] Developer Relations Program Manager~~ | `4424176050` **게임회사 + ⚠계약직** |

**FuriosaAI Technical Writer를 눈여겨본다.** JD가 docs-as-code다 — 소스를 읽고 실제 하드웨어에서
스택을 돌려 문서를 쓰고, **자동 파이프라인으로 문서를 라이브 코드베이스에 대해 계속 검증**한다.
NPU·컴파일러 도메인 + 문서·전파 축이 한 자리에서 겹친다. `AGENTS.md` §직무 선택 3번에 정확히
걸린다. 단 LinkedIn 분류가 `Marketing, PR, Writing/Editing` 이라 **엔지니어 트랙인지 브라우저
확인이 필요**하다.

---

## 「한 회사 한 직무」 권고표

| 회사 | 🌐 | 열린 공고 | 권고 | 근거 |
|---|---|---|---|---|
| FuriosaAI | | **Ashby 55건** (LinkedIn엔 23건만) | **Agent System Developer** | **건 열림.** 2순위는 Technical Writer |
| 42dot | | 19건 (LLM 4 동시) | **LLM Engineer (LLM Training)** | LLM 4종은 한 팀 집중채용 |
| Rebellions | | 8건 | **System Software Architect** | 시스템 SW 축이 증거가 가장 두껍다 |
| XCENA | | 11건 | **Performance & Developer Tools** | 나머지는 SoC/HW 설계 |
| OpenAI | **🌐** | 5건 | **Developer Experience Engineer** | DevEx가 가장 정확히 맞고 경쟁이 얕다 |
| NHN | | 5건 | 내려면 **LLM 기술 개발** `4439978335` | ⚠ **세 번째 접촉** — GLG 판단 자리 |
| CJ OLIVE YOUNG | | 2건 | **Forward Deployed AI Engineer** | FDE 축이 더 얕다 |
| ~~KRAFTON~~ | | ~~14건~~ | — | **게임회사 제외** |

**LinkedIn 공고 수를 믿지 않는다.** FuriosaAI 는 LinkedIn guest 검색에 23건이었는데 실제
Ashby 보드는 55건이었다. **회사를 정했으면 그 회사 채용 보드를 직접 본다.**

---

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

- **티어 2·3·4 가 통째로 본문 미확인이다.** Sonatus 사고가 그 묶음에서 나왔다. 내기로 정하면
  **먼저 본문부터 뜬다.** Ashby 쓰는 곳(OpenAI · Cohere · FuriosaAI)은 API 한 번이면 된다.
- **외국계 표시 중 `?` 두 곳** — NeuroFusion · LVIS 는 본사 국적을 확인하지 않았다.
  낼 때 확인한다. 모르면 `?` 로 둔다.
- **LinkedIn 공고 수는 하한이다.** 회사 채용 보드가 진짜 목록이다(FuriosaAI 23 → 55).
- **Kakao Enterprise 1건 · Telechips 2건** — 영문 사명으로 안 걸린다. 국문 사명
  (`카카오엔터프라이즈`)으로 재검색 필요. ~~NCSOFT~~ 는 게임회사라 이제 볼 필요 없다.
- 안랩 · SK플래닛 · 한컴 · LINE Plus는 각 10건씩 잡혔으나 GLG 축에 걸리는 자리가 없었다.
