# INBOX — 후보 공고 대기열

여기 있는 것은 **아직 지원 건이 아니다.** GLG가 고르면 `./new.sh` 로 건이 되고 원장에 행이 생긴다.
제출된 것은 `LEDGER.md` 가 SSOT다.

기준(`AGENTS.md` §타깃 기준): **성남(판교)·강남권** · 영세 스타트업 제외 · 대기업은 자체 사이트 ·
**한 회사 한 직무**.

수집 규모(2026-07-28): 34 쿼리 → 카드 352 → 본문 전부 조회 → 누적 **418건**, 근무지 확정 74건(18%).
읽는 법: `?(Seongnam)` 은 **본문에 없고 카드에 찍힌 값**이다. 지우지 않는다 — 브라우저 축에서 확인한다.
`경로` 의 `offsite` = 회사 사이트/외부 ATS, `easy` = LinkedIn Easy Apply.

---

## 지원 경로 — 플랫폼 5종 (실측 확정)

한국 채용 플랫폼은 다섯으로 수렴한다. **하나를 익히면 여러 회사가 덮인다.**

| 플랫폼 | 확인된 회사 | 주소 형태 | 가입 | 폼 특징 |
|---|---|---|---|---|
| **그리팅** | DEEPX · Hyundai AutoEver · Rebellions | `<회사>.career.greetinghr.com/ko/o/<id>` · `career.<회사>.com/ko/o/<id>` | 불필요 | **회사마다 폼이 다르다.** AutoEver는 사전질문 1,000자, DEEPX는 자기소개서를 묻는다 |
| **Ashby** | OpenAI · Cohere · 42dot | `jobs.ashbyhq.com/<회사>/<uuid>` | 불필요 | 폼 직접 작성 + 이력서 업로드 |
| **ninehire** | Enhans | `<회사>career.ninehire.site/job_posting/<id>` | 불필요 | **서술형 칸 없음.** 이력서 + URL 한 줄이 전부 |
| **Greenhouse** | Toss (`toss.im` 경유) | `toss.im/career/job-detail?gh_jid=<id>` | 불필요 | ⚠ `toss.im`은 브라우저 안전 제한으로 에이전트가 못 연다 |
| **자체** | FuriosaAI | `furiosa.ai/careers` | 확인 필요 | — |

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

### 티어 1 · 근무지 확정 + 「한 회사 한 직무」 권고 확정

| 회사 | 권고 직무 | 근무지 | 컷 | 경로 | 공고 |
|---|---|---|---|---|---|
| **FuriosaAI** | **Agent System Developer** | **강남 도산대로 145** | AI | offsite | `4387941500` |
| **KRAFTON** | AX Governance Specialist (3년+) | **역삼** | AI | offsite | `4444946832` |
| **HITS** | AI Agent Engineer | **강남역** | AI | **easy** | `4420262371` |
| **카카오뱅크** | DevOps 엔지니어 | **성남 분당구 분당내곡로 131** | DevEx | offsite | `4437387455` |
| **NeuroFusion** | Back End Developer | 판교/강남 | SWE | — | `4444060387` |
| **Sonatus** | Staff Cloud Backend Engineer | **판교** | SWE | **easy** | `4419070095` |
| **LVIS** | Backend Software Engineer | 강남 | SWE | offsite | `4434953668` |
| **Gauss Labs** | Senior FDE Operations (KR) | ?(역삼동) | **FDE** | offsite | `4445211164` |

**FuriosaAI Agent System Developer가 1순위다.** JD가 agent orchestration · context management ·
tool execution · memory abstraction 을 그대로 요구하고 팀 이름이 **AI Transformation** 이다.
23건 전부 강남권이라 회사 자체가 기준을 통과한다.

### 티어 2 · 판교권 (카드 확정 · 본문 미확인 — 지역은 통과로 봐도 되는 묶음)

| 회사 | 권고 직무 | 컷 | 공고 | 비고 |
|---|---|---|---|---|
| **42dot** | LLM Engineer (LLM Training) | AI | `4443770588` | **집중채용 중**(2026-07-23 회사 포스트). LLM 4종은 한 팀이라 하나만 |
| 42dot | *또는* Senior Embedded Linux Build Engineer | DevEx | `4442731341` | DevEx 컷을 쓸 거면 이쪽 |
| **Rebellions** | System Software Architect | Embedded | `4415303828` | ⚠ 8건 중 2건은 **강서구**. Seongnam 표기만 골랐다 |
| **XCENA** | System SW Engineer, Performance & **Developer Tools** | DevEx | `4444920306` | 나머지 10건은 SoC/HW 설계라 증거 밖 |
| Telechips | Embedded Software Engineer | Embedded | `4431589221` | BSP·Device Driver |
| Penguin Solutions | DevOps Engineer | DevEx | `4440528153` | — |

42dot 나머지: RL `4443782022` · Evaluation `4443770586` · Data Generation `4436476007` ·
ML Platform `4442734241` · DevOps Platform `4442733252`.
Rebellions 나머지: Server/NPU Infra `4441428492` · Collective Comm `4437141292` · BMC FW `4432085933`.
XCENA 나머지: Firmware InfiniteMemory `4444918359` · Embedded BSP `4444930080`.

### 티어 3 · FDE 축 (경쟁이 얕고 서사가 정면으로 맞는다 — 지역 확인 필요)

| 회사 | 직무 | 표기 | 경로 | 공고 |
|---|---|---|---|---|
| **Reflection AI** | Forward Deployed Engineer - AI Engineer | ?(서울) | offsite | `4425505149` |
| **Databricks** | Forward Deployed Engineer | ?(서울) | offsite | `4410609158` |
| Cloudflare | FDE, Professional Services | ?(서울) | — | `4432741765` |
| Cohere | FDE, Agentic Platform (Korea) | ?(서울) | Ashby | `4366574942` |
| OpenAI | FDE - Seoul | ?(서울) | Ashby | `4431428608` |
| BCG | (Senior) Forward Deployed AI Engineer | ?(서울) | offsite | `4433468111` |
| CJ OLIVE YOUNG | Forward Deployed AI Engineer | ?(서울) | offsite | `4424964255` |
| KRAFTON | [Infra] Technical Solution Engineer (10년+) | 역삼 | — | `4435529194` |

**exa 축(피드 포스트)에서만 잡힌 것** — guest API에 안 걸린다:
KRAFTON AX FDE 집중채용(2026-03 포스트 4건, 「HQ 각 조직에 파견되어 수행할 AI Native
Engineer」 — GLG의 AX 서사와 정면이나 4개월 전이라 현재 열림 여부 확인 필요) ·
Google Cloud AI FDE(한국) · TreeSoop FDE · OpenAI Partner AI Deployment Engineer(AWS).

### 티어 4 · DevEx 축

| 회사 | 직무 | 표기 | 공고 |
|---|---|---|---|
| **OpenAI** | Developer Experience Engineer | ?(서울) | `4418860629` — 본문에 「한국어 필요」 명시 |
| **FuriosaAI** | SW Engineer, **Technical Writer & Document Specialist** | 강남 | `4426791367` |
| FriendliAI | Developer Advocate | ?(서울) | `4405336361` |
| CJ OLIVE YOUNG | DevRel | ?(서울) | `4424177483` |
| NVIDIA | Senior Developer Relations Manager - GenAI | ?(서울·인천) | `4416335601` |
| KRAFTON | [HR] Developer Relations Program Manager | 역삼 | `4424176050` — **계약직** |

**FuriosaAI Technical Writer를 눈여겨본다.** JD가 docs-as-code다 — 소스를 읽고 실제 하드웨어에서
스택을 돌려 문서를 쓰고, **자동 파이프라인으로 문서를 라이브 코드베이스에 대해 계속 검증**한다.
NPU·컴파일러 도메인 + 문서·전파 축이 한 자리에서 겹친다. `AGENTS.md` §직무 선택 3번에 정확히
걸린다. 단 LinkedIn 분류가 `Marketing, PR, Writing/Editing` 이라 **엔지니어 트랙인지 브라우저
확인이 필요**하다.

---

## 「한 회사 한 직무」 권고표

| 회사 | 열린 공고 | 권고 | 근거 |
|---|---|---|---|
| FuriosaAI | 23건 (엔지니어 9) | **Agent System Developer** | 2순위는 Technical Writer |
| 42dot | 19건 (LLM 4 동시) | **LLM Engineer (LLM Training)** | LLM 4종은 한 팀 집중채용 |
| Rebellions | 8건 (Seongnam 5) | **System Software Architect** | 시스템 SW 축이 증거가 가장 두껍다 |
| KRAFTON | 14건 | **AX Governance Specialist** | FDE 표제는 현재 안 열려 있다 |
| XCENA | 11건 | **Performance & Developer Tools** | 나머지는 SoC/HW 설계 |
| OpenAI | 5건 | **Developer Experience Engineer** | DevEx가 가장 정확히 맞고 경쟁이 얕다 |
| NHN | 5건 | 내려면 **LLM 기술 개발** `4439978335` | ⚠ **세 번째 접촉** — GLG 판단 자리 |
| CJ OLIVE YOUNG | 2건 | **Forward Deployed AI Engineer** | FDE 축이 더 얕다 |

---

## 보류 · 제외

| 회사 | 사유 |
|---|---|
| **Insighter** | 서울 마포 DMC — 지역 밖. Easy Apply **임시저장 상태로 남아 있다**(제출 아님). 버리려면 `closed` 로 바꾸고 `_archive/` 로 옮긴다 |
| **Mistral** (Applied AI Engineer, 서울) | 부서는 Solutions인데 요구는 **PhD/석사 AI · 파인튜닝 · PyTorch · Python 주력 · fluent English**. 적합도 중하 — 시간 남으면 마지막에 |
| **Coxwave** | GLG 회사 판단으로 제외 |
| Harper | Founding 단계 — 영세 기준 |
| ALCOFIND · Toss Insurance(구로) · Rebellions 2건(강서) · FuriosaAI Productization(화성) | 지역 밖 |

## 남은 구멍

- **근무지 확인율 18%.** 한국 공고는 본문에 근무지를 안 적는 경우가 많다. 카드 표기는 회사
  단위로는 믿을 만하지만 같은 회사가 두 곳을 쓰는 경우(Rebellions)가 있다 — 최종 확인은
  브라우저 축.
- **NCSOFT 0건 · Kakao Enterprise 1건 · Telechips 2건** — 영문 사명으로 안 걸린다.
  국문 사명(`엔씨소프트`, `카카오엔터프라이즈`)으로 재검색 필요.
- 안랩 · SK플래닛 · 한컴 · LINE Plus는 각 10건씩 잡혔으나 GLG 축에 걸리는 자리가 없었다.
