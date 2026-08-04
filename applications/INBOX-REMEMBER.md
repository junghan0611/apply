# INBOX-REMEMBER — 리멤버 채널 후보 대기열

`INBOX.md` 의 자매 파일이다. **리멤버(Remember)에서 나온 흔적만 여기 모은다.**
기준·읽는 법·ATS 지도는 `INBOX.md` 를 따르고, 여기서 되풀이하지 않는다.
고르면 `./new.sh` 로 건이 되고 SSOT 는 `LEDGER.md` 로 넘어간다.

## 리멤버 스캔 (2026-08-04) — 새 채널

**출처**: `career-api.rememberapp.co.kr/job_postings/search`. 로그인 뒤에 있는 **비공개
채널**이라 Wanted 처럼 인증 없는 공개 API가 없다 — 대신 `applications/remember.js` 로 앱
자신의 `Authorization` 헤더를 브라우저 안에서 가로채 같은 엔드포인트를 직접 두들긴다.
**토큰은 페이지 밖으로 절대 안 나간다**(리포·로그·대화 어디에도 안 남김). 자세한 쓰는 법과
API 지도는 그 파일 머리말을 본다 — 여기서는 이번 스캔 결과와 판정만 적는다.

⚠ **리멤버는 위계상 뒤쪽 채널이다**(`AGENTS.md` §탐색 채널). 아래는 후보 흔적이고, 낼 때는
회사 공식 보드/원본 ATS 에서 열림 여부와 JD 원문을 다시 확인한다.

### 1차 시도(수동 브라우저 스캔)는 폐기하고 API 수집으로 바꿨다

이 파일의 첫 버전은 `career.rememberapp.co.kr/job/postings` 화면을 직무 필터로 좁혀(AI·데이터
`AI·ML·DL` + SW개발 `백엔드`, 768→340건) 상위 몇 건을 클릭해 눈으로 읽은 것이었다. 그 과정에서
**"주요업무" 탭을 누르려다 "간편 지원하기" 버튼을 오클릭해 지원 확인 페이지까지 들어간 사고**가
있었다(제출은 안 됐다). `remember.js` 로 API 를 직접 부르면 **목록 응답 자체에 담당업무·자격
요건 전문이 다 들어 있어** 공고를 하나씩 열 필요가 없고, 이 오클릭 위험 자체가 사라진다.
**앞으로 리멤버 탐색은 API 축을 쓴다 — 상세 페이지를 손으로 클릭하지 않는다.**

또 하나 정정: 검색창 자유텍스트가 "필터로 안 먹힌다"고 처음에 적었는데, 실제로는 **먹는다 —
다만 OR + 토큰 분리**다. `"AI Agent"` 를 넣으면 공백 기준으로 쪼개져 `"AI"` 하나만 남고, 그게
전체 13,281건 중 768건이라 안 좁혀지는 것처럼 보였을 뿐이다. `remember.js` 의 `collect()` 는
키워드를 하나씩 따로 돌려 합집합을 쌓고, 진짜 필터는 담당업무 본문 정규식(`pick()`)에서 건다.

### 수집 결과

```
collect(["AI","LLM","에이전트","Forward Deployed","FDE","RAG","MLOps"])
  → 누적 809건 (전체 13,281건 중 이 7개 키워드 OR 합집합)
pick()  — 담당업무 본문에 Agent/LLM/RAG/MCP/GenAI/FDE 축이 있고, PM·영업·마케팅 등 제외
  → 207 / 809
제목까지 정면(Agent·FDE·Forward Deployed·Agentic)으로 다시 거르고
LEDGER.md 에 이미 있는 회사(42dot·Enhans·MakinaRocks·NHN 등)를 뺀 것
  → 44건 — 아래 표는 이 중 본문을 끝까지 읽은 것부터 적는다
```

### 본문 다 읽고 판정한 것 (담당업무 근거)

| 회사 | 직무 | 경력 | Agent 축 적합도 | 마감/비고 | 리멤버 ID |
|---|---|---|---|---|---|
| **렛서** | Forward Deployed Engineer | 3년 | ⭐⭐ **최정면.** JD 원문에 *"Claude Code·Cursor 같은 AI 코딩 도구와 LLM·에이전트로 며칠 만에 작동하는 프로토타입을 만들어 검증"* 이 그대로 박혀 있다. 고객 현장 진단→설계→구현→배포→운영을 혼자 책임지는 FDE. **8월 중 합류 가능자 우대** — 시급 확인 필요 | `328646` |
| **플리토** | 에이전트 엔지니어(LLM플랫폼) | 3-7년 | ⭐⭐ RAG·ReAct 파이프라인, LangGraph/LangChain 멀티에이전트, MCP 툴 통합, generate→judge→refine 평가 루프. **GitHub/실력 증빙 필수 제출.** `INBOX-WANTED.md` 에도 같은 회사 같은 포지션이 떠 있다(wanted `378676`, 마감 2026-08-16) — **두 채널 동시 확인 = 신뢰도 높음** | `331387` |
| **코리아포트원** | AI Agent Engineer (5년 이상) | 5년+ | ⭐⭐ 결제/정산 도메인, LLM·RAG·Agent·Workflow로 0→1 설계부터 프로덕션까지 핸즈온. Agentic vs Deterministic Code 경계를 직접 정의. `INBOX-WANTED.md` 에도 동일 회사 동일 포지션(wanted `375404`) — 두 채널 교차 확인 | `327365` |
| **유모스원** | Agentic AI System Engineer | 5년+ | ⭐⭐ MCP 기반 Action Framework, LLM-비즈니스로직(API/DB) 연결, 지식그래프 기반 Context 파이프라인, 에이전트 의사결정 품질 시뮬레이션. 백엔드 5년(Java/Kotlin/Go/Python) 요구 | `325284` |
| **인포시즈** | Sr. Forward Deployed Engineer | 5-15년 | ⭐ 정면. LLM 기반 Agent·AI 솔루션을 프로덕션 수준으로 배포·정착, ontology 모델링, RAG·벡터DB·임베딩 요구(본문 뒷부분 TRUNCATED — 재확인 필요) | `322136` |
| CJ올리브영 | Forward Deployed AI Engineer | 4-12년 | 중간. 전사 AX 조직, AI API Gateway·백엔드 인프라 구축이 핵심 업무. Agent·Prompt Engineering 은 **우대사항**이지 담당업무 1순위가 아니다. 대신 **대기업 계열사라 안정성·브랜드 강함** | `324801` |
| 슈퍼브에이아이 | Forward Deployed Engineer (5+) | 5년+ | 약함. 축이 **Vision Foundation Model(ZERO)·VLM 파인튜닝**이다 — Agent/LLM 아님. `INBOX-WANTED.md` 판정("Vision/VLM 파인튜닝이라 증거 대조 필요")과 일치 | `328049` |

### 제목만 확인, 본문 미확인 — 다음에 이어서 읽는다 (37건 중 눈에 띄는 것)

| 회사 | 직무 | 경력 | 리멤버 ID |
|---|---|---|---|
| 뷰티셀렉션 | [AX Dept] FDE (Forward Deployed Engineer) | 3년+ | `331534` — ⚠ **원티드에도 동일 건**(wanted `378781`, "멀티에이전트 A2A 아키텍처") |
| 채널코퍼레이션 | [채널톡] Forward Deployed Engineer | 무관 | `324173` — ⚠ 원티드에도 동일 회사(wanted `324639`, "사내외 AX 과제 에이전트·툴 자동화") |
| 팀스파르타 | Forward Deployed Engineer (7-15년) | 7년+ | `327744` — 스파르타코딩클럽 운영사, 브랜드 알려짐 |
| 팀스파르타 | Forward Deployed Engineer (3-7년) | 3년+ | `327739` |
| 위시켓 | AIDP FDE (3-12년) | 3년+ | `294708` |
| 케이존 | CTO / Agentic AI Engineer | 3년+ | `322280` — 직책이 CTO 겸직이라 스타트업 초기 멤버급 |
| 밀버스 | AI Agent 엔지니어(경력) | 5년+ | `330350` |
| 한국네트웍스 | AI Agent Engineer | 5년+ | `328757` |
| 디딤 | AI Agent / LLM 기반 개발자 경력 채용 | 3년+ | `298677` |
| 셀키에이아이 | AI Agent 백엔드 개발자 | 5년+ | `328621` |
| 패스트뷰 | AI FDE (Forward Deployed Engineer) | 무관 | `326951` |
| 알엑스 | AI Agent 서비스 개발자 | 3년+ | `330697` |
| 에이치에너지 | [AX 엔지니어] AI Agent / Automation Engineer | 1년+ | `322487` |

### 판정 보류/제외

- **한국퀄컴(유)** `AI Researcher: On-Device Agentic AI`(`271360`) — 이름은 정면인데 🔴
  자격요건에 **`박사 이상`** 이 명시돼 있다. 박사 학위 없으면 후보에서 뺀다.
- **한화시스템·한화오션·큐빅** — 타이틀이 `AI Agent Project Manager`·`Product Manager (AI
  Agent)` 류로 **PM/기획직**이다. 엔지니어 축이 아니라 낮은 우선순위.
- **인핸스(Enhans) FDE**(`325034`) — 리멤버에도 같은 공고가 떠 있지만 `LEDGER.md` 에 이미
  `rejected`(2026-08-04 불합격 통보)로 닫혀 있다. 다시 내지 않는다.
- **비큐AI 인재풀**·**헤드헌팅 대행 공고**(`organization.headhunter=true`) — `pick()` 기본
  옵션이 이미 제외한다. 실제 고용주가 안 드러나는 구조라 우선순위 밖(`INBOX.md` §Harper 판정).

### 두 채널 교차 확인된 회사 (원티드 + 리멤버 동시 노출)

플리토(에이전트 엔지니어 LLM플랫폼) · 코리아포트원(AI Agent Engineer) · 뷰티셀렉션([AX Dept]
FDE) · 채널코퍼레이션/채널톡(FDE) · 슈퍼브에이아이(FDE, 둘 다 Vision 축이라 플래그) — **같은
공고가 두 채널에 다 뜬다는 것은 실제로 열려 있고 적극 채용 중이라는 신호**로 읽는다.

## 다음 한 걸음

1. **렛서·플리토·코리아포트원·유모스원** 넷이 지금까지 가장 정면이다 — 이 중 열 것을 GLG 가
   고른다. 열면 `./new.sh` 전에 회사 자체 채용페이지가 따로 있는지부터 확인한다(리멤버는
   위계상 뒤쪽 채널이고, 넷 다 `application_type: apply` = 리멤버 간편지원이라 원본 ATS 가
   따로 있을 수 있다).
2. **인포시즈**는 본문 뒷부분이 잘렸다 — `RJ.detail(322136)` 을 다시 불러 자격요건·우대사항
   전문을 마저 읽는다.
3. 위 "제목만 확인" 13건 중 우선순위를 골라 `RJ.detail(id)` 로 이어 읽는다. `remember.js` 의
   `rows` 객체에 809건이 이미 다 들어 있어 **추가 네트워크 요청 없이** 바로 읽을 수 있다(단,
   브라우저 세션이 살아있는 동안만 — 탭을 닫으면 다시 `arm()` 부터 해야 한다).
4. `AI·데이터` 나머지 태그(`MLOps`·`데이터 엔지니어`)와 `SW개발` 하위 `DevOps`·`클라우드
   엔지니어`로 키워드를 넓히면 44건보다 더 나올 수 있다 — 아직 안 해봤다.
