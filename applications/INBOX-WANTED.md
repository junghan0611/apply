# INBOX-WANTED — 원티드 채널 후보 대기열

`INBOX.md` 의 자매 파일이다. **원티드에서 나온 흔적만 여기 모은다.**
기준·읽는 법·ATS 지도는 `INBOX.md` 를 따르고, 여기서 되풀이하지 않는다.
고르면 `./new.sh` 로 건이 되고 SSOT 는 `LEDGER.md` 로 넘어간다.

## 이 채널은 어떻게 훑는가 — 재현 가능한 수집 (2026-08-04 실측)

**리멤버와 정반대다. 원티드는 사람 손이 필요 없다.** 로그인·쿠키·브라우저 없이 공개 JSON API
하나로 목록과 본문이 다 나온다. 그래서 이 채널의 「수집 방법」은 문서가 아니라 **스크립트**다.

```sh
./wanted.py tags                    # 직무 카테고리 id·이름·공고수
./wanted.py scan --out scan.json    # 기본 9개 카테고리 전체 → 1,680건 (2026-08-04)
./wanted.py pick scan.json          # 제목 1차 거름망 → 520건
./wanted.py pick scan.json --min-annual 5   # 경력 상한 5년 미만 제외 → 461건
./wanted.py detail 368678 375404    # 담당업무·자격요건 본문
```

`scan.json` 은 리포에 넣지 않는다 — **하루 지나면 틀린 파일**이고, 스크립트가 언제든 다시 뜬다.
남길 것은 아래 표, 즉 **본문을 읽고 판정한 결과**다.

### API 지도

| 무엇 | 어떻게 |
|---|---|
| 목록 | `GET /api/v4/jobs?country=kr&locations=all&years=-1&limit=100&offset=<n>&job_sort=job.latest_order&tag_type_ids=<직무id>` |
| 본문 | `GET /api/v4/jobs/<id>` → `job.detail.{main_tasks,requirements,preferred_points}` |
| 카테고리 이름 | **어느 API 에도 없다.** `wdlist/518` **HTML 안의 JSON 배열**에서 긁는다 (372개) |
| 페이지 끝 | `links.next` 가 null 이 될 때까지 `offset` 을 100씩 민다 |

기본 카테고리 9개: 머신러닝 엔지니어(1634) · 소프트웨어 엔지니어(10110) · 서버 개발자(872) ·
파이썬(899) · 데이터 엔지니어(655) · 데이터 사이언티스트(1024) · DevOps(674) · 임베디드(658) ·
C,C++(900).

### 함정 넷 — 여기서 시간을 잃었다

1. **`tag_type_ids` 는 한 요청에 5개까지다. 6개부터 422** 를 뱉는다. 9개를 한 번에 넣었다가
   0건을 받았다. `scan` 이 5개씩 잘라 돈다.
2. **검색어(`query`)는 필터가 아니다.** `query=AI Agent` 로 「네오사피엔스 Product Manager」가
   나온다 — 제목이 아니라 회사·태그·본문을 섞은 느슨한 매칭이다. **믿을 축은 직무 카테고리**이고,
   검색어는 카테고리가 못 잡는 것을 줍는 보조축이다. (리멤버의 「자유텍스트가 필터로 안 먹힌다」와
   원인은 다르지만 결론은 같다.)
3. **짧은 약어에 경계를 안 주면 오탐이 온다.** 경계 없는 `AX` 가 「AXI Bus 설계」(반도체 IC)를
   물어 왔다. `pick` 의 정규식은 `\bAX\b` 로 잠갔다.
4. **`due_time` 은 대개 null 이다.** 마감일이 없다는 뜻이지 **상시 채용이라는 보장이 아니다.**
   낼 때 회사 채용홈에서 다시 본다.

### 아직 안 본 것

- **원티드 지원 폼을 실측하지 않았다.** 「간편 지원」(원티드 프로필 + 합격보상금)과 회사 자체
  ATS 로 넘어가는 경로 중 어느 쪽인지 건마다 다를 것이다 — 리멤버의 「간편 지원하기 vs 홈페이지
  지원하기」와 같은 갈래로 보이나 **확인 전이다.**
- `years` 파라미터가 실제로 거르는지 확인하지 않았다. 지금은 `-1`(전체)로만 돈다.
- 회사 축(`/api/chaos/search/v1/results` 의 `companies`)은 안 썼다. 직무 축으로 충분했다.

⚠ **원티드는 위계상 뒤쪽 채널이다**(`AGENTS.md` §탐색 채널). 아래는 후보 흔적이고,
낼 때는 회사 공식 보드/원본 ATS 에서 열림 여부와 JD 원문을 다시 확인한다.

---

## 담당업무를 읽고 통과시킨 것 — AI·에이전트 축 (본문✓)

| 회사 | 직무 | 경력 | 왜 통과인가 (담당업무 근거) | wanted id |
|---|---|---|---|---|
| 오픈에이아이(OpenAI) 🌐 | Forward Deployed Engineer - Seoul | 5년+ | LLM 기반 시스템 배포 end-to-end, 풀스택. ⚠ 원장에 **OpenAI DevEx (`ready`)** 가 이미 있다 — 한 회사 한 직무 | 370620 |
| 구글(Google) 🌐 | FDE, Generative AI, Google Cloud | 2년+ | *multi-agent systems, MCP servers* 를 프로토→프로덕션. 평가·관측 파이프라인 | 365263 |
| 아마존(Amazon) 🌐 | Sr. Forward Deployed Deep Learning Architect, GenAI IC | 7년+ | 고객 현장 GenAI 솔루션 설계·구현 | 360075 |
| 채널코퍼레이션 | [채널톡] Forward Deployed Engineer | 무관 | 사내외 **AX 과제** 발굴·구현, 에이전트·툴을 제품/운영 자동화로 전환 | 324639 |
| 링크알파(LinqAlpha) | Forward Deployed Engineer | 1-5년 | 에이전트 코어/엣지 경계 설계, 프롬프트·툴 정책·라우팅을 **설정으로 운영** | 375859 |
| 슈퍼브에이아이(Superb AI) | Forward Deployed Engineer (5년 이상) | 5-11년 | 현장 스코핑→배포→자산화. ⚠ 축이 **Vision/VLM 파인튜닝**이라 증거 대조 필요 | 377073 |
| 심플랫폼 | AI Agent & LLM Engineer - 시니어 | 9-17년 | 제조·반도체·로봇 도메인 **AI Agent 오케스트레이션 플랫폼**(RAG·MCP), Coding AI Agent 도입 전략. GLG 축과 정면 | 368678 |
| 다키클라우드코리아 | 시니어 엔지니어 (Agent Native Cloud / AI Agent) | 7-14년 | 에이전트 런타임(루프·툴 디스패치·세션/정책/감사), LLM 게이트웨이, 샌드박스. ⚠ **Go 기반** | 371314 |
| 코리아포트원 | AI Agent Engineer (5년이상) | 5년+ | 결제/정산 도메인 에이전트 설계→프로덕션, 재현 가능한 실험·검증 체계 | 375404 |
| 애자일소다 | AI Agent Platform Engineer / Project Leader (금융) | 3년+ / 7년+ | 에이전트 플랫폼 축. 본문 미확인(본문?) | 374789 / 374919 |
| 플리토 | 에이전트 엔지니어(LLM플랫폼) | 3-7년 | LangGraph 멀티에이전트, **Eval Harness 자동화**, generate→judge→refine 루프. **마감 2026-08-16** | 378676 |
| 위밋모빌리티 | FDE — 물류 AI 솔루션 | 7-14년 | 외부 시스템 연동을 프로덕션 수준으로(멱등성·정합성·관측성). *모두 Claude Code 로 일한다* 고 JD 에 박혀 있다 | 373420 |
| 뷰티셀렉션 | [AX Dept] FDE | 3년+ | **멀티에이전트 아키텍처(A2A)** 설계, 권한·감사 경계를 코드로 | 378781 |
| 에이티씨아이 | Software Engineer (AI Agent부문) | 1-5년 | **DevOps workflow 자동화 에이전트**, 코드/로그/문서 RAG. 축은 정면이나 경력 상한이 낮다 | 349626 |
| 클리카(CLIKA) | Forward Deployed AI Engineer – Robotics | 0-10년 | 모델 최적화를 **엣지 디바이스·차량·로봇**에 배포. 임베디드 계보가 AI 축으로 이어지는 자리 | 376851 |
| 투모로로보틱스 | Physical AI Forward Deployed Engineer | 0-6년 | 휴머노이드 현장 배포·운영 안정화. §로봇 축 1번(현장 배치·통합·필드 디버깅) | 357998 |
| 포트로직스 | Forward Deployed Engineer | 5-15년 | 비정형 원천(PDF·메일·메신저) 구조화, 운영 SLA 책임. **마감 2026-08-31** | 376783 |
| 티맵모빌리티 | AI Agent SDK Engineer | 5년+ | 음성 에이전트 SDK. ⚠ 축이 **KWS/STT/TTS 최적화**라 증거가 얇다 | 370246 |

위 18건은 **1,680건 → 제목 거름망 520건 → 담당업무를 직접 읽어** 남긴 것이다. 나머지는 표에
올리지 않았다 — 목록을 길게 두는 것이 아니라 **읽은 것만 남기는 것**이 이 파일의 값이다.

### 이미 원장에 있는 회사 (원티드에도 떠 있다 — 새 건이 아니다)

마키나락스(FDE 계열 11건 노출) · 카카오헬스케어 `AI Agent Engineer`(`submitted`) ·
인핸스 FDE(`rejected`) · 업스테이지 · 포티투닷(42dot) · 홀리데이로보틱스.

### 다음 한 걸음

- 위 표에서 GLG 가 고르면 `./new.sh` 로 건을 만든다. **원티드 지원 폼은 아직 실측하지 않았다** —
  원티드 자체 지원(합격보상금 경로)과 회사 자체 ATS 중 어느 쪽으로 낼지는 건별로 정한다.
- 표의 `본문?` 두 건(애자일소다)은 낼 후보가 되면 본문부터 확인한다.

---

## 추가 수확 — 2026-09-09 (OFFENSE MODE)

`README.md` 상단 배너대로 산업·회사 규모 필터를 풀고 다시 스캔했다(`scan` 기본 9개 카테고리
전체, 1,638건). 임베디드·DevOps·펌웨어 축도 이번엔 통과시킨다. 아래는 담당업무를 직접 읽고
남긴 것만이다 — 제목 거름망만 거친 나머지는 올리지 않았다.

| 회사 | 직무 | 경력 | 왜 통과인가 (담당업무 근거) | wanted id |
|---|---|---|---|---|
| 에스투더블유(S2W) | FDE (AI Platform Engineering) | 3-8년 | 온톨로지 스토어·에이전틱 런타임·LAM 기반 「의사결정 OS」 코어를 직접 설계. GLG 축과 정면 | 365961 |
| 팀카이 | FDE (Forward Deployed Engineer) | 연차무관(LLM 빌드 경험) | 고객사별 에이전트 인스턴스 구축→현장 상주→로그 기반 튜닝. FDE 원형과 정확히 일치 | 369739 |
| 데이원컴퍼니 | [Day1 AI Deployment Company] FDE | 연차무관 | 고객사 상주, Prototype→Production 전 과정, 전사 자산화까지 FDE 정석 | 383391 |
| 지니파이 | 사내 AX 리드 / FDE (5년~) | 5년+ | 사내를 고객 삼는 FDE — 에이전트 워크플로·SSOT·MCP 구축. FDE 정의와 정확 일치 | 383849 |
| 멘타트 | Forward Deployed Engineer (FDE) | 연차무관 | 로펌·금융 온프레미스 vLLM/SGLang 서빙+ACL 연동, 망분리 환경 FDE | 381184 |
| 부스터스 | Forward Deployed Engineer (FDE) | 연차무관 | 커머스 도메인 FDE, Claude Code 전사 도입 환경에서 현장 재설계 | 382343 |
| 큐픽스 | 머신러닝 엔지니어(LLM, ML, RAG, AI Agent) | 3년+ | LangGraph 멀티에이전트·멀티모달 RAG, 공간지능 도메인 특화 에이전트 | 373064 |
| 마드라스체크(플로우) | [AI Work Agent 플로우] FDE | 4년+ | MCP 도구 서버+AI Agent 기능 개발, 고객 도입까지 겸장 | 379774 |
| 콘센트릭스서비스코리아 | LLM/Agent Engineer (과/차장급) | 4-8년 | LangGraph Multi-Agent Workflow 아키텍처 설계·리딩, 세션/메모리/폴백 전체 | 379871 |
| 위시드 | MLOps / AI 에이전트 개발자 | 2-5년 | 폐쇄망 환경 온프레미스 LLM Agent + MLOps 인프라를 처음부터 설계 | 382306 |
| 미리비트 | Data Engineer & Local LLM AI Agent Engineer | 3년+ | 로컬 LLM(GLM/Kimi) 서빙+멀티에이전트 오케스트레이션, 데이터파이프라인 겸장 | 382386 |
| 워트인텔리전스 | Senior AI Engineer (LLM / NLP / MLOps) | 5년+ | RAG/Agent/Search 설계+평가체계 구축+프로젝트 기술 리딩 | 383713 |
| 비상교육 | Lead DevOps/AI Platform Engineer | 10년+ | AI 플랫폼 전체 아키텍처 리드, MSA·GitOps·DevSecOps. 대기업급 리드 자리(offense mode) | 375022 |
| 오픈엣지테크놀로지 | NPU Firmware Engineer (전문연구요원 가능) | 2년+ | NPU 연산 커널·펌웨어 검증·FuSa. 순수 임베디드 축(offense mode로 신규 편입) | 365239 |
| 소울아트 | System Software Engineer (Embedded AI) | 연차무관 | Edge AI 통합, 네이티브 프로그램. 순수 임베디드 축(offense mode) | 350980 |
| ⚠ 모레(Moreh) | LLM Platform Engineer | 2-8년 | Inference Gateway·K8s Operator·Observability, Rust/Go LLM 서빙 플랫폼 | 375108 |
| ⚠ 모레(Moreh) | NPU System Software Engineer (Firmware/Driver) | 2-8년 | NPU 런타임/드라이버, Linux Kernel-Mode Driver, 화성 임베디드 시스템 | 382920 |
| ⚠ 원프레딕트(onepredict) | LLMOps Engineer | 3년+ | vLLM/Triton 추론 서빙, 폐쇄망 GPU 최적화 | 381443 |
| ⚠ 콕스웨이브(Coxwave) | [AX AgentX] 데이터 엔지니어(RAG/LLM Pipeline) | 3-7년 | ETL+벡터DB 인덱싱+LLMOps 환경. LinkedIn(`4438204315`)에서도 같은 자리로 이미 본 적 있다 | 383356 |

⚠ 표시 셋은 **동일 회사 재지원**이다 — 모레는 09-09에 다른 직무(AI System SW Engineer, Remember
경로)로 이미 `rejected` 처리됐고, 원프레딕트는 09-01에 다른 직무(Embedded Software Developer,
그리팅 경로)로 이미 `submitted` 상태다. `AGENTS.md` §한 회사 한 직무는 기본 전략이지 법이
아니다 — offense mode에서 낼지는 GLG 판단.

이번 라운드는 카테고리 필터(직무 카테고리 9개 + AI/임베디드/플랫폼 축 정규식)로 1,638건 →
709건(제목 통과) → 위 18건(본문까지 읽고 정면으로 남긴 것)으로 좁혔다. 나머지 691건은
제목만 통과했을 뿐 본문 미확인 — 스캔 원본은 `/tmp/ljobs/wanted-scan.json`(리포에 넣지 않음,
하루 지나면 틀린 파일이라는 원칙은 `INBOX-WANTED.md` 상단과 같다).

### 2차 (같은 스캔, 다음 점수대 8건 추가 확인)

| 회사 | 직무 | 경력 | 왜 통과인가 (담당업무 근거) | wanted id |
|---|---|---|---|---|
| 비스텔리젼스 | Forward Deployed Engineer (FDE) | 3년+ | Ontology Modeling + Agent Enablement — Palantir식 FDE 정의와 정확히 겹친다(semantic layer·permission model·reasoning path 설계) | 384457 |
| 오토메타 | AI Agent Engineer (AI 에이전트 엔지니어) | 3-10년 | Agent turn loop·tool 계약·guardrail·LLM provider abstraction. GLG 축 정면 | 384691 |
| 퓨쳐스콜레 | Platform Engineer Lead (DevOps) | 8년+ | AWS+K8s+Terraform 플랫폼 전체 리드, 데이터 파이프라인까지 겸장 | 371498 |
| 트위닛 | [뷰티컨시어지] LLM/Agent Engineer | 2년+ | Knowledge System+RAG+Context/Memory 기반 Agent 개발 | 383456 |
| 더씨에스알 | AI 엔지니어 (LLM·RAG) | 1-5년 | RAG 파이프라인+LLM 서빙, ⚠ 자기소개서 사전질문(RAG 환각 지표) 필수 | 385276 |
| 현대그린푸드 | AI 데이터 엔지니어 (AX 과제 기획 및 MLOps) | 5-7년 | AWS MLOps+MCP Server 파이프라인, 대기업(offense mode) | 384142 |
| 카이트다이나믹스 | 임베디드 펌웨어 및 제어 엔지니어 | 4-10년 | 로보틱스 MCU 펌웨어+모션제어. 순수 임베디드 축(offense mode) | 384224 |
| 리주비놀 | 로봇 제어 및 펌웨어 개발 엔지니어 | 3-10년 | 로봇팔 경로계획+MCU 펌웨어. 순수 임베디드 축(offense mode) | 382219 |

총 26건(1차 18 + 2차 8)이 이번 offense-mode 스캔에서 본문까지 확인된 신규 후보다.

---

## 생존 실측 — 2026-09-18 (09-09 후보 전수 + 08-04 배치)

09-09 스캔의 26건과 08-04 배치 19건, 총 45건의 `GET /api/v4/jobs/<id>` `job.status` 를
그대로 읽었다(로그인 없음, 판정 아님 — 원티드가 말한 값). **9일 기다린 값이 여기 있다.**

### ⛔ 닫힌 것 — 9건 (기다려서 잃었다)

| 회사 | 직무 | status | wanted id | 잃은 값 |
|---|---|---|---|---|
| **에스투더블유(S2W)** | FDE (AI Platform Engineering) | `close` | 365961 | 09-09 배치에서 **「GLG 축과 정면」으로 1번**이었다. 온톨로지 스토어·에이전틱 런타임·LAM 의사결정 OS |
| **콕스웨이브** | [AX AgentX] 데이터 엔지니어(RAG/LLM) | `close` | 383356 | LinkedIn(`4438204315`)에도 떠 있던 건 — 그쪽도 함께 확인 필요 |
| 현대그린푸드 | AI 데이터 엔지니어(AX·MLOps) | `close` | 384142 | 마감일 `2026-09-13` 이 실제로 닫혔다 |
| 원프레딕트 | LLMOps Engineer | `close` | 381443 | 재지원 후보였음 |
| 애자일소다 | AI Agent Platform Project Leader(금융) | `close` | 374919 | 본문 미확인인 채로 닫혔다 |
| 플리토 | 에이전트 엔지니어(LLM플랫폼) | `close` | 378676 | 마감 `2026-08-16` — 08-04 배치에서 이미 예고돼 있었다 |
| 위밋모빌리티 | FDE — 물류 AI 솔루션 | `close` | 373420 | *「모두 Claude Code 로 일한다」* 고 JD 에 박혀 있던 건 |
| 포트로직스 | FDE | `close` | 376783 | 마감 `2026-08-31` — 08-04 배치에서 예고돼 있었다 |
| 티맵모빌리티 | AI Agent SDK Engineer | `close` | 370246 | Vision/음성 축이라 애초에 플래그돼 있던 건 |

`draft` 2건 — **구글** FDE GenAI(365263) · **아마존** Sr FDE DL Architect(360075). 원티드 면에서는
목록에 안 나온다는 뜻이고, 회사 자체 보드가 정본이므로 **원티드 status 로 죽었다고 판정하지 않는다.**

### ✅ 아직 열린 것 — 34건. 마감일이 붙은 셋이 먼저다

| 마감 | 회사 | 직무 | wanted id |
|---|---|---|---|
| 🔴 **2026-09-18 (오늘)** | 트위닛 | [뷰티컨시어지] LLM/Agent Engineer | 383456 |
| 🟠 2026-09-25 | 모레(Moreh) | NPU System SW Engineer (FW/Driver) | 382920 |
| 🟠 2026-09-30 | 워트인텔리전스 | Senior AI Engineer (LLM/NLP/MLOps) | 383713 |
| 🟡 2026-10-31 | 마드라스체크(플로우) | [AI Work Agent 플로우] FDE | 379774 |

나머지 30건은 `due_time` 이 null 이다 — **마감일이 없다는 뜻이지 상시 채용이라는 보장이 아니다**
(이 파일 §API 지도). 위 9건이 전부 null 이거나 이미 지난 마감이었다는 것이 그 증거다.

### 이 실측이 말하는 것

09-09 에 본문까지 읽어 정면으로 판정한 후보가 **9일 동안 케이스가 되지 못했고, 그 사이 정면 1번이
닫혔다.** `INBOX.md` 에 남는 것은 후보이지 지원이 아니다. 읽은 다음의 한 걸음이 `./new.sh` 로
가지 않으면 읽기의 값은 시간과 함께 감가한다 — `NEXT.md` RAIL 5 번(「낼 때 남긴다」)의 반대 방향
실패다. 이쪽은 **낼 것을 안 내서** 잃었다.

---

## 시스템 축 재분류 — 2026-09-18

판정 기준은 `AGENTS.md` §시스템 축 (2026-09-18 GLG). §생존 실측이 잡은 34건 활성 중 35개
wanted id(애자일소다 항목 하나가 두 id 를 안고 있어 34행 34건이 35 id 로 펼쳐진다)를
`wanted.py detail` 로 전부 다시 읽고, 담당업무 원문을 인용해 판정했다. 등급이 아니라 인용이
근거다 — 회사 소개의 「AI 기반」류는 근거로 쓰지 않았다.

### ✅ 시스템 축 — 낸다

| 회사 | 직무 | id | 담당업무 인용 (판정 근거) |
|---|---|---|---|
| 링크알파(LinqAlpha) | FDE | 375859 | 「인프라부터 백엔드까지 직접 구현합니다... 에이전트가 도는 실행 환경(노드·Pod·스토리지, warm pool, 오토스케일링)까지 — 데모가 아니라 프로덕션 파이프라인을 직접 짭니다.」 |
| 심플랫폼 | AI Agent & LLM Engineer | 368678 | 「AI Agent Orchestration 플랫폼의 아키텍처를 설계하고 구축을 주도합니다. (멀티 에이전트 오케스트레이션, RAG, MCP 연동 등)」 |
| 다키클라우드코리아 | 시니어 엔지니어(Agent Native Cloud) | 371314 | 「자율 AI 에이전트 런타임(에이전트 루프, 툴 디스패치, 세션·정책·감사 파이프라인) 설계 및 구현... LLM 게이트웨이(멀티 프로바이더 추상화)... 샌드박스 실행 환경」 |
| 애자일소다 | AI Agent Platform Engineer | 374789 | 「Kubernetes 기반의 AI Agent 실행·운영 환경을 구축하고... Agent 개발용 공통 라이브러리·도구를 설계하고 개발합니다.」 |
| 뷰티셀렉션 | [AX Dept] FDE | 378781 | 「여러 Agent가 업무를 나눠 맡고 조율하는 멀티에이전트 아키텍처 설계 — 역할 정의부터 통신 프로토콜(A2A 등), 실행 결과 검증까지... 권한과 감사 경계를 코드로 정의」 |
| 에이티씨아이 | Software Engineer(AI Agent부문) | 349626 | 「Agent 간 통신 및 orchestration 로직 설계 (state, memory, context 관리)... DevOps workflow 자동화 Agent 개발」 |
| 큐픽스 | 머신러닝 엔지니어(공간지능) | 373064 | 「BIM 도면과 현장 360° 캡처를 LLM/VLM이 비교·판단하는 도메인 특화 에이전트를 설계하고 개발합니다... LangGraph 기반 멀티 에이전트 워크플로우를 설계」 — 자사 제품 축, 고객 요청 구현이 아니다 |
| 콘센트릭스서비스코리아 | LLM/Agent Engineer | 379871 | 「LangGraph 기반 Multi-Agent Workflow 핵심 아키텍처 설계 및 고도화... 복잡한 세션 상태 관리, 단기/장기 메모리 통합 설계, 정교한 Fallback/Retry 및 에러 복구 파이프라인 구축」 |
| 위시드 | MLOps/AI 에이전트 개발자 | 382306 | 「폐쇄망 환경에 적합한 전체 개발·인프라 아키텍처 설계... 온프레미스 LLM 기반 AI Agent 설계 및 개발... 폐쇄망 환경의 패키지·의존성·이미지·모델 관리 체계 구축」 |
| 미리비트 | Data Engineer & Local LLM AI Agent Engineer | 382386 | 「GLM, Kimi 등 로컬 LLM을 활용한 AI Agent 시스템 설계·개발·배포... 로컬 모델 서빙 환경 구축 및 최적화 (vLLM, SGLang, llama.cpp 등)... Multi-agent 오케스트레이션, Planning, Memory, State 관리」 |
| 비상교육 | Lead DevOps/AI Platform Engineer | 375022 | 「AI 플랫폼의 전체 아키텍처를 설계... API 설계를 표준화하고, API Gateway 전략을 수립합니다... GitOps 기반 배포 체계를 설계합니다.」 |
| 모레(Moreh) | LLM Platform Engineer | 375108 | 「Performance Gateway 개발... Inference Autopilot 개발 — 서비스 구성(Preset)을 선언적으로 관리하는 Kubernetes Operator를 설계·개발... High-Fidelity Observability 구축」 |
| 모레(Moreh) | NPU System SW Engineer(FW/Driver) | 382920 | 「저수준 Runtime과 User-Mode Driver 공동 개발... Linux Kernel-Mode Driver와 PCIe, MMIO, DMA, Interrupt, IOMMU 기반 Host–Device 인터페이스 공동 개발」 — 🟠 마감 2026-09-25 |
| 오픈엣지테크놀로지 | NPU Firmware Engineer | 365239 | 「신경망 연산자별 NPU 연산 Kernel 개발... Firmware에 대한 검증, 성능 Profile 분석 및 최적화... 기능 안전(FuSa) 대응」 — 임베디드 축, AI 이름은 없으나 커널/펌웨어라 시스템 축 |
| 소울아트 | System Software Engineer(Embedded AI) | 350980 | 「Station을 위해 개발되는 다양한 프로그램을 통합합니다... 임베디드 환경에 맡는 보안 환경을 설계합니다... Edge AI 통합 경험」 |
| 오토메타 | AI Agent Engineer | 384691 | 「AI agent의 turn loop, tool-use flow, streaming 응답, error recovery 설계 및 개선... tool 계약 관리 (schema, versioning, 권한, scope)... 다양한 LLM provider abstraction 운영」 — 가장 정면 |
| 퓨쳐스콜레 | Platform Engineer Lead(DevOps) | 371498 | 「Kubernetes 기반 컨테이너 오케스트레이션 환경을 설계하고 운영합니다... CI/CD 파이프라인을 고도화... 관측성(Observability) 체계를 설계」 — AI 이름은 없으나 플랫폼 리드가 게이트웨이·오케스트레이션·관측성 정의와 겹친다 |
| 카이트다이나믹스 | 임베디드 펌웨어 및 제어 엔지니어 | 384224 | 「MCU 및 Embedded Processor 기반 실시간 소프트웨어 개발... Fault Detection, Safety Logic 및 Recovery 기능 개발」 — 순수 임베디드(offense mode), AI 축 없음 |
| 리주비놀 | 로봇 제어 및 펌웨어 개발 엔지니어 | 382219 | 「MCU 기반 모터 및 센서 제어 펌웨어 개발... 모터 드라이버, 센서 및 상위 제어 시스템 간 인터페이스 개발」 — 순수 임베디드(offense mode), AI 축 없음 |

### ⛔ 서비스 축 — 거른다

| 회사 | 직무 | id | 담당업무 인용 (판정 근거) |
|---|---|---|---|
| 채널코퍼레이션 | [채널톡] FDE | 324639 | 「고객사 현장(데이터, 프로세스, 조직 구조 등)을 깊이 이해하고, 실제 문제를 정확히 진단한 뒤, 빠르게 해결 방안을 설계·구현·검증하여 즉각적인 비즈니스 임팩트를 만드는 역할」 |
| 슈퍼브에이아이(Superb AI) | FDE(5년 이상) | 377073 | 「현장마다 다른 하드웨어·카메라 환경을 고려하여, 정확도와 비용을 함께 최적화한 솔루션을 배포합니다.」 — 고객 현장별 모델 적용, 런타임/게이트웨이 아님 |
| 클리카(CLIKA) | Forward Deployed AI Engineer – Robotics | 376851 | 「국내 기업 및 공공기관의 AI SI, PoC, Pilot 프로젝트를 기술적으로 수행합니다... 고객의 요청과 피드백을 내부 개발팀이 실행할 수 있는 기술 요구사항으로 정리합니다.」 |
| 팀카이 | FDE | 369739 | 「고객사 에이전트를 빌드합니다... 담당 고객사의 도메인·시스템·정책에 맞는 에이전트 1 instance를 구축합니다.」 — 고객사별 인스턴스 반복 빌드가 핵심 |
| 데이원컴퍼니 | [Day1] FDE | 383391 | 「고객사 상주: 현장의 실제 업무 흐름·데이터·시스템을 파악하고 기술적 해결책을 정의... Prototype부터 Production까지 AI 애플리케이션의 신속한 설계·구현·배포」 |
| 부스터스 | FDE | 382343 | 「수기·엑셀로 흩어져 있던 업무를 시스템과 데이터 파이프라인으로 전환해요... 현장에서 검증된 것을 플랫폼 표준으로 승격시켜요.」 — LLM/Agent 언급 없음, Claude Code 는 도구로만 쓰고 사내 업무 앱 구현이 핵심 |
| 더씨에스알 | AI 엔지니어(LLM·RAG) | 385276 | 「LLM 응답 품질 개선: LLM API 기반 프롬프트·컨텍스트 설계, 환각 제어, 응답 품질 개선... API 백엔드 연동: FastAPI로 AI 생성 모듈을 안정적으로 서빙」 — 매출 기능(RAG 제품) 구현, 런타임/게이트웨이 설계 아님 |

### ⚠ 애매 — GLG가 고른다

| 회사 | 직무 | id | 시스템 쪽 문장 | 서비스 쪽 문장 |
|---|---|---|---|---|
| 오픈에이아이(OpenAI) | FDE - Seoul | 370620 | 「Build full-stack systems that deliver customer value... Codify working patterns into tools, playbooks, or building blocks that others can use.」 | 「Embed closely with customer teams, understand their needs, and guide adoption of what you build.」 — ⚠ 원장에 OpenAI DevEx(`ready`)가 이미 있다 |
| 코리아포트원 | AI Agent Engineer | 375404 | 「LLM, RAG, Agent, Workflow를 조합해 에이전트를 직접 설계하고 프로덕션까지 구현해... 핸즈온으로 만드는 역할입니다」 | 「결제/정산 도메인의 고객·현업 문제를 듣고, "이걸 AI 에이전트로 어떻게 풀 것인가"를 설계 단계부터 판단합니다」 |
| 투모로로보틱스 | Physical AI FDE | 357998 | 「실제 운영 환경에서 발생하는 이슈를 분석하고 로봇 동작, 소프트웨어, 통신, 시스템, 운영 구조를 개선」 | 「고객별 요구사항과 환경 차이를 반영한 개발 및 기술 적용」 |
| 지니파이 | 사내 AX 리드/FDE | 383849 | 「업무 지식을 매일 수집해 에이전트가 함께 쓰는 SSOT로 관리... 외부 SaaS와 내부 데이터에 접근하는 API와 MCP 제공」 | 「사내에서 검증한 에이전트, SSOT, 평가 방식을 기업 AI 교육과 도입 서비스로 확장합니다.」 |
| 멘타트 | FDE | 381184 | 「vLLM, SGLang 기반 LLM·임베딩·리랭커 서빙 스택과 GPU 클러스터 구성 및 운영」 | 「고객과 협력하여 비즈니스 과제를 정의하고, AI 기반 해결 방안 설계... 프로젝트 전 과정을 주도적으로 관리하며 고객 요구사항을 기술적 결과물로 구체화」 |
| 마드라스체크(플로우) | [AI Work Agent] FDE | 379774 | 「repattern AI 제품 개발(40%): MCP 도구 서버 및 검색 연동, AI Agent 기능 개발」 | 「기존 flow 고객사 도입(40%): 기존 flow 고객 환경에 repattern AI 구축 및 적용, 고객 데이터·권한 구조에 맞춘 Agent 품질 튜닝」 — 🟡 마감 2026-10-31 |
| 워트인텔리전스 | Senior AI Engineer | 383713 | 「RAG, Agent, 검색 등 AI 시스템 설계 및 구현... 문제 정의부터 모델 적용 및 서비스화까지 End-to-End 개발」 | 「단순 모델 개발을 넘어... 실제 서비스 임팩트를 만들어낼 수 있는 엔지니어를 찾습니다.」 — 런타임/게이트웨이도 고객요청 구현도 아닌 ML 리서치+서비스화 성격 |
| 비스텔리젼스 | FDE | 384457 | 「Agent가 사용할 수 있는 semantic layer, business object model, permission model, workflow model을 설계합니다... Agent의 reasoning path, tool usage, execution boundary, human-in-the-loop 조건을 정의합니다.」 | 「고객별 PoC, 파일럿, 프로덕션 배포 전략을 설계하고 실행합니다... 고객별 커스텀 구현을 확장 가능한 플랫폼 기능으로 전환합니다.」 |
| 트위닛 | [뷰티컨시어지] LLM/Agent Engineer | 383456 | 「구조화 데이터, 문서, 검색 인덱스 등을 연결하고 RAG, Knowledge Graph, Ontology 등의 기술을 활용하여... Knowledge Retrieval 기술 개발」 | 「제품·AI·Backend 팀과 협업하여 분석, 검색, 추천, 시뮬레이션 등 다양한 기능을 하나의 AI 기반 사용자 경험으로 연결」 — 🔴 마감 오늘(2026-09-18) |

### 확인 못 한 것

- 없음 — §생존 실측이 `close`/`draft`로 표시한 11건(닫힘 9 + draft 2)은 이번 재분류에서 제외했다. `job.status` 자체가 활성 여부이지 시스템/서비스 판정이 아니므로 다시 부르지 않았다.
- LinkedIn·Remember 채널은 이번 세션에서 손대지 못했다 — 아래 보고 참고.
