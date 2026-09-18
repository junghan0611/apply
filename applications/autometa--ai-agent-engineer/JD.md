# 오토메타(Autometa) — AI Agent Engineer

- 공고 URL: https://www.wanted.co.kr/wd/384691
- 채집일: 2026-09-18 (원티드 `wanted.py detail 384691`)
- 경로: 원티드 — 원본 ATS·회사 채용홈은 미확인, 원티드가 현재 유일 확인 출처
- 원티드 id: 384691
- 회사명 영문 표기 미확인 — "Autometa"는 한글 "오토메타"의 음차 추정이다. 공식 영문명 확인 전.

> 아래에 **공고 본문을 원문 그대로** 붙인다. 요약하지 않는다.
> 공고는 마감되면 사라지고, 면접 준비 때 필요한 것은 원문이다.

## 공고 원문

### 담당업무

- AI agent의 turn loop, tool-use flow, streaming 응답, error recovery 설계 및 개선
- agent가 사용할 수 있는 tool 계약 관리 (schema, versioning, 권한, scope)
- ticket·incident·proposal·인프라·코드·모니터링 컨텍스트에 대한 context retrieval(RAG / 그래프 기반) 전략 설계
- 과도한 tool 호출, 대용량 결과, 잘못된 상태 전이, 민감정보 노출을 막는 guardrail 구현
- 코드 변경 워크플로우 연동 (ticket handoff, repo context, test generation, PR status, CI/CD loopback)
- 자동 테스트·coverage·E2E·CI status를 agent workflow에 연결
- agent 실행 로그, tool-call telemetry, 실패 패턴, 비용·token budget, 품질 지표 수집 및 개선
- 다양한 LLM provider abstraction 운영, 모델별 동작 차이를 제품 품질로 흡수
- draft / approval / execution 상태 분리 및 human-in-the-loop UX 설계
- 검증 가능한 agent system을 위한 unit / integration / golden trace / e2e 테스트 작성

### 자격 요건

- Python 또는 TypeScript 기반 backend system을 프로덕션 수준으로 설계·운영한 경험
- LLM tool-use / function calling / agent loop / structured output을 실제 제품에 적용한 경험
- REST API, JSON Schema, 인증(OAuth/API key), webhook, 비동기 워크플로우(SSE/queue) 이해
- RAG, semantic search, 그래프·컨텍스트 retrieval 중 하나 이상의 실무 경험
- 복잡한 상태 기계를 안전하게 설계한 경험 (approval/execution state, retry, idempotency, 동시성 제어 등)
- 테스트 자동화 경험 (pytest, Playwright, CI/CD checks, coverage 등)
- 보안 기본기 (secret redaction, 최소 권한, audit logging, replay protection, tenant 격리)
- GitHub Actions 또는 Azure DevOps 기반 PR/CI/CD 워크플로우 이해

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구: agent turn loop·tool 계약·guardrail·상태기계(draft/approval/execution)를 직접
  설계·구현하는 것. LLM provider abstraction 운영도 명시적으로 요구한다.
- 우대 사항 중 내가 대는 증거: (컷 확정 후 채운다 — `submission.md` §왜 이 회사인가)
- 내가 대지 못하는 것 (경계): ticket/incident 도메인(예: ServiceNow류) 연동 실무 경험은
  검증된 코퍼스에 없다. CI/CD loopback(PR status·test generation)은 공개 커밋으로 일부 대조 가능.

## 시스템 축 재분류 판정 근거 (INBOX-WANTED.md §시스템 축 재분류 인용)

「AI agent의 turn loop, tool-use flow, streaming 응답, error recovery 설계 및 개선... tool 계약
관리 (schema, versioning, 권한, scope)... 다양한 LLM provider abstraction 운영」 — ✅ 시스템 축,
26건 중 가장 정면으로 판정됨.
