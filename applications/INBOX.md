# INBOX — 후보 공고 대기열

「낼 곳」을 찾는 축(`linkedin-jobs` 스킬)과 브라우저 축에서 주운 것이 여기 모인다.
여기 있는 것은 **아직 지원 건이 아니다.** GLG가 고르면 `./new.sh` 로 건이 되고 원장에 행이 생긴다.

기준(`AGENTS.md` §타깃 기준): 성남·판교·강남권 · 영세 스타트업 제외 · 대기업은 자체 사이트 ·
**한 회사 한 직무**.

---

## 넘겨받는 규격

```
<Company EN> | <Role EN> | <근무지> | <경로: LinkedIn Easy Apply | 자체사이트> | <공고 URL>
```

---

## 근무지 확인 문제 (2026-07-28 확인)

**`ljobs.py detail` 로는 근무지가 안 나오는 공고가 많다.** 9건을 본문까지 읽어 확인한 결과,
근무지가 본문에 명시된 것은 2건뿐이었다. LinkedIn 카드의 위치 표기는 「Seoul, Seoul, South
Korea」로 뭉뚱그려져 **강남인지 마포인지 구분되지 않는다.** `-l "Seongnam"` 으로 검색해도
광역으로 번져 서울 공고가 섞여 나온다.

지역이 기준의 첫 축인 이상, **근무지 미확인 건은 「낼 곳」으로 확정하지 않는다.** 확인 경로는
셋이다: ① 회사 채용 사이트 원문 ② 브라우저로 공고 페이지 열기 ③ 웹 검색으로 본사 소재지.
인사이터 건이 실례다 — LinkedIn 표기는 「서울」이었지만 본문에 마포 DMC가 있었다.

---

## 지원 경로 — 실제로 두드려서 확인 (2026-07-28)

LinkedIn 「회사 사이트에서 지원」이 실제로 어디로 보내는지 확인했다. **플랫폼은 네 종류뿐이다.**
하나를 익히면 여러 회사가 덮인다.

| 플랫폼 | 확인된 회사 | 주소 형태 | 가입 |
|---|---|---|---|
| **그리팅 (greetinghr)** | DEEPX · Hyundai AutoEver | `<회사>.career.greetinghr.com/ko/o/<id>` 또는 `career.<회사>.com/ko/o/<id>` | **필요** (GLG 진행 중) |
| **Ashby** | OpenAI · Cohere | `jobs.ashbyhq.com/<회사>/<uuid>` | 대개 불필요 — 폼 직접 작성 + 이력서 업로드 |
| **Greenhouse** | Toss Bank (`toss.im` 경유) | `toss.im/career/job-detail?gh_jid=<id>` | 대개 불필요 |
| **자체** | Coxwave | `careers.coxwave.com/c/<id>` | 확인 필요 |

### 열어 둔 탭 (GLG 가입·확인용)

| 회사 · 직무 | URL |
|---|---|
| Hyundai AutoEver — AI Agent 엔지니어 | `career.hyundai-autoever.com/ko/o/210269` |
| DEEPX — [SW] Generative AI Engineer | `deepx.career.greetinghr.com/ko/o/114811` |
| OpenAI — Developer Experience Engineer | `jobs.ashbyhq.com/openai/[uuid removed]/application` |
| Cohere — FDE, Agentic Platform (Korea) | `jobs.ashbyhq.com/cohere/[uuid removed]` |
| Coxwave — [AX AgentX] 데이터 엔지니어 | `careers.coxwave.com/c/u2CKaMyTaP` |
| Toss Bank — AIOps Platform Engineer | `toss.im/career/job-detail?gh_jid=7702581003` — ⚠ **브라우저 안전 제한으로 에이전트가 못 연다. GLG가 직접 연다** |

### 링크 따는 법 (탭이 안 열릴 때)

「회사 사이트에서 지원」 클릭이 새 탭을 못 여는 경우가 있다. 그때는 클릭하지 말고
`read_page`의 `ref_id`로 그 링크의 `href`를 직접 읽는다. LinkedIn이
`linkedin.com/safety/go/?url=<인코딩된 실제 주소>` 로 감싸 두므로 디코드하면 실주소가 나온다.

---

## A. 근무지 확인됨 · 기준 적합

| 회사 | 직무 | 근무지 | 붙일 컷 | 경로 | 공고 |
|---|---|---|---|---|---|
| Hyundai AutoEver | [Tech] AI Engineer — AI Agent 엔지니어 | **서울 강남** (본문 명시) | AI Engineer | 자체(1분컷·자율양식) | `jobs/view/4394471434` |
| DEEPX | [SW] Generative AI Engineer | **성남** (Series D, 영세 아님) | AI Engineer | — | `jobs/view/4437997421` |

### ⚠ Hyundai AutoEver — 한 회사 4개 공고

`AI Agent 엔지니어` · `LLM 엔지니어` · `Physical AI Engineer` · `[AVP] Mobility Platform Infra`
가 동시에 열려 있다. **하나만 낸다.** 권고는 **AI Agent 엔지니어** — 다섯 축 중 AI 컷이
가장 두껍게 붙고, 에이전트 하네스 운영 증거가 그대로 맞는다. Physical AI는 임베디드 서사와
겹치지만 자동차 도메인 증거가 없다.

### ⚠ DEEPX — 한 회사 3개 공고

`[SW] Generative AI Engineer`(성남) · `Generative AI Engnieer`(분당) · `[SW] Firmware
Engineer`(성남). 앞의 둘은 사실상 같은 자리로 보인다. **NPU·온디바이스 AI는 GLG의 IITP
국책(NPU 워크로드 가속기 간 포팅)·Hailo-8·sLLM 증거와 정면으로 맞는다.** 지역도 판교권이라
이번 판의 1순위 후보다. 셋 중 하나를 고르려면 본문 비교가 더 필요하다.

## B. 내용 적합 · 근무지 미확인 (확인 후 판단)

| 회사 | 직무 | 표기 | 붙일 컷 | 확인할 것 |
|---|---|---|---|---|
| OpenAI | Developer Experience Engineer | Seoul | **DevEx** | 근무지·고용형태. 본문에 「한국어 필요」 명시. Codex·개발자 생태계 — **DevEx 컷과 가장 정확히 맞는 자리** |
| Cohere | Forward Deployed Engineer, Agentic Platform (Korea) | Seoul | FDE | remote-friendly 명시, Seoul 오피스 있음. 원격이면 지역 기준 무관 |
| Coxwave | [AX AgentX] 데이터 엔지니어 (RAG/LLM Pipeline) | Seoul | AI Engineer | 근무지 필드가 비어 있음. 경력 **3~7년**, Python/Java/Scala. Pre-A 누적 125억 — 영세는 아니나 규모 확인 |
| Toss Bank | AIOps Platform Engineer | Seoul | DevEx | 경력 **3년 이상**, 데이터 파이프라인·SRE 축. 강남 테헤란로로 알려져 있으나 **미검증** |
| Fluiz | AI Agent Engineer / LLM Systems | Seoul | AI Engineer | 근무지·규모 둘 다 본문에 없음. **영세 여부 확인 필요** |
| Telechips | Embedded Software Engineer | Gyeonggi | Embedded | BSP·Device Driver. 근무지 본문 미표시 |
| XCENA | Firmware Engineer, InfiniteMemory | Gyeonggi | Embedded | CXL 메모리 펌웨어. 근무지 본문 미표시 |

## C. 브라우저 축에서 주운 것 (미검증)

OpenAI FDE Seoul · Google FDE Generative AI (Cloud) · KT AI Agent Engineer / AI Platform
Engineer(**같은 회사 2건**) · NVIDIA Developer Technology Engineer · FuriosaAI Productization
Engineer(화성) · AIRS Medical AX Engineer · Lunit Senior AX Engineer.

**FDE 슬롯이 두껍다** — OpenAI · Google · Cohere. 다섯 축 중 FDE는 지원자가 얕은 편이고
「기업·현장 접합」서사가 그대로 맞는다. 셋 다 자체 사이트 지원이라 손이 더 간다.

## D. 보류 (기준 미달)

| 회사 | 직무 | 사유 |
|---|---|---|
| Insighter | AX Engineer | 서울 마포 DMC — 지역 기준 밖. 건은 이미 있고(`insighter--ax-engineer`) Easy Apply 임시저장 상태. GLG 판단 대기 |
| Harper | Founding Engineer / Applied AI | Founding 단계 — 영세 기준에 걸린다 |
| ALCOFIND | Embedded Firmware Engineer | 서울·인천권. 지역 밖 |
