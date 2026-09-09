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
