# 제출 기록 — Concentrix Services Korea / LLM/Agent Engineer

| 항목 | 값 |
|---|---|
| 상태 | draft — 시스템 축 판정 완료, 제출본 컷·폼 실측 전 |
| 지원일 | — |
| 경로 | 원티드 (`wd/379871`) — 회사 자체 ATS 여부 미확인 |
| 첨부 컷 | **AI Engineer** — LangGraph Multi-Agent 아키텍처·세션 상태·Fallback/Retry — Agent Platform Engineer 컷과 일치 |
| 공고 URL | https://www.wanted.co.kr/wd/379871 |
| 원장 대조 | `LEDGER.md`에 없음 — 신규 후보 |

## 낸 것

- [ ] 이력서 PDF — 컷 미정
- [ ] 커버레터 / 지원 동기 — 폼 미실측(4-B)
- [ ] 추가 서류 — 미실측

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| (원티드 폼 문항 미실측 — 4-B 단계) | | |

## 왜 이 회사인가 (이 건의 글)

`INBOX-WANTED.md` §시스템 축 재분류 인용:

「LangGraph 기반 Multi-Agent Workflow 핵심 아키텍처 설계 및 고도화... 복잡한 세션 상태 관리,
단기/장기 메모리 통합 설계, 정교한 Fallback/Retry 및 에러 복구 파이프라인 구축」


## 요건-증거 매트릭스 (terra 축, 2026-09-18)
필수요건 항목마다 [직접 공개 증거 / 명시적 재직 사실 / 없음]을 붙인다.

| 필수요건 | 증거 유형 | 근거 |
|---|---|---|
| LangGraph, LangChain 또는 이에 준하는 Agent Orchestration Framework 활용 경험 | 직접 공개 증거 | n8n 기반 계층형 AI 에이전트 시스템(40+ 노드 워크플로우, Supabase pgvector 연동) — LangGraph 자체는 아니나 「이에 준하는」 프레임워크 |
| Tool Calling/Function Calling 기반 API Orchestration을 실제 서비스에 적용한 경험 | 직접 공개 증거 | Forge connector(대화를 Forgejo work item으로 전환하는 에이전트 디스패치) · HomeAgent |
| Python 기반 Backend API 및 서비스 Architecture에 대한 높은 이해도 | 명시적 재직 사실 | PostgreSQL JSONB 파이프라인·GPU 클러스터 인프라 설계(구체 API 저장소 링크는 없음) |

판정: **선행 큐 후보** (직접 증거 2건 이상)

## 이후 기록

- [2026-09-18] 건 생성. `JD.md`에 원티드 본문 보존. 제출본 컷·폼 실측은 4-B 단계.

## 제출 요건 실측 (4-B, 원티드 API 2026-09-18)

| 항목 | 값 |
|---|---|
| 공고 상태(API) | `active` — 살아있음 |
| 마감일 | 없음(`due_time: null`) — 상시 채용 가능성, 상시라는 보장은 아니다 |
| 경력 요건(API) | 4~8년 |
| 지원 경로 | **미실측** — 원티드 자체 지원(합격보상금)인지 회사 자체 ATS로 넘어가는지는 공개 API로 확인 불가. 로그인/지원 화면을 열어야 한다(브라우저 미사용 라운드라 보류) |
| 폼 문항·필수 첨부·글자수 캡 | **미실측** — 로그인 필요 |

- [2026-09-18] 4-B: 원티드 공개 API로 상태·경력요건만 실측(`status=active`, id `379871`). 지원 경로·폼 문항은 로그인이 필요해 이번 라운드(브라우저 미사용)에서는 미실측으로 남긴다.
