# 제출 기록 — Autometa / AI Agent Engineer

| 항목 | 값 |
|---|---|
| 상태 | draft — 시스템 축 판정 완료, 제출본 컷·폼 실측 전 |
| 지원일 | — |
| 경로 | 원티드 (`wd/384691`) — 회사 자체 ATS 여부 미확인 |
| 첨부 컷 | **AI Engineer** — agent turn loop·tool 계약·guardrail·provider abstraction — Applied AI/Agent Platform Engineer 컷과 정면 일치 |
| 공고 URL | https://www.wanted.co.kr/wd/384691 |
| 원장 대조 | `LEDGER.md`에 없음 — 신규 후보 (`AGENTS.md` §후보를 판정하기 전에 원장을 먼저 본다) |

## 낸 것

- [ ] 이력서 PDF — 컷 미정
- [ ] 커버레터 / 지원 동기 — 원티드 지원 폼 미실측(4-B)
- [ ] 추가 서류 — 미실측

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| (원티드 폼 문항 미실측 — 4-B 단계에서 채운다) | | |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**

## 왜 이 회사인가 (이 건의 글)

`AGENTS.md` §시스템 축(2026-09-18 GLG) 판정 근거 — 담당업무 원문 인용(`INBOX-WANTED.md` §시스템
축 재분류, 2026-09-18 소넷 형제 판정):

「AI agent의 turn loop, tool-use flow, streaming 응답, error recovery 설계 및 개선... tool 계약
관리 (schema, versioning, 권한, scope)... 다양한 LLM provider abstraction 운영, 모델별 동작
차이를 제품 품질로 흡수」

26건 중 가장 정면으로 판정된 건이다 — 에이전트 런타임의 핵심 구성요소(turn loop·tool 계약·
guardrail·provider abstraction)를 전부 담당업무로 명시한다.

## 제출 요건 실측 (4-B, 원티드 API 2026-09-18)

| 항목 | 값 |
|---|---|
| 공고 상태(API) | `active` — 살아있음 |
| 마감일 | 없음(`due_time: null`) — 상시 채용 가능성, 상시라는 보장은 아니다 |
| 경력 요건(API) | 3~10년 |
| 지원 경로 | **미실측** — 원티드 자체 지원(합격보상금)인지 회사 자체 ATS로 넘어가는지는
  공개 API로 확인 불가. 로그인/지원 화면을 열어야 한다(브라우저 미사용 라운드라 보류) |
| 폼 문항·필수 첨부·글자수 캡 | **미실측** — 로그인 필요 |


## 요건-증거 매트릭스 (terra 축, 2026-09-18)
필수요건 항목마다 [직접 공개 증거 / 명시적 재직 사실 / 없음]을 붙인다.

| 필수요건 | 증거 유형 | 근거 |
|---|---|---|
| Python/TypeScript backend를 프로덕션 수준으로 설계·운영한 경험 | 직접 공개 증거 | entwurf(TypeScript, npm 배포, 30일 1,395 설치) — 하네스가 서로를 id로 호출하는 디스패치 기판 |
| LLM tool-use/function calling/agent loop를 실제 제품에 적용한 경험 | 직접 공개 증거 | HomeAgent(on-device AI agent, RPi5+Hailo-8 NPU) · n8n 40+ 노드 계층형 에이전트 시스템 |
| RAG/semantic search/그래프 컨텍스트 retrieval 실무 경험 | 직접 공개 증거 | andenken(LanceDB hybrid retrieval, vector+FTS score-normalized, 한영 교차언어 확장) |

판정: **선행 큐 후보** (직접 증거 2건 이상)

## 이후 기록

- [2026-09-18] 건 생성. 시스템 축 재분류(`INBOX-WANTED.md`)에서 넘어온 후보, `JD.md`에
  원티드 본문 보존. 제출본 컷·폼 실측은 4-B 단계.
- [2026-09-18] 4-B: 원티드 공개 API로 상태·경력요건만 실측(`status=active`). 지원 경로·폼
  문항은 로그인이 필요해 이번 라운드(브라우저 미사용)에서는 미실측으로 남긴다.
