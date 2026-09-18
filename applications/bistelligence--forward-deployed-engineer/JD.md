# 비스텔리젼스(Bistelligence) — Forward Deployed Engineer (FDE)

- 공고 URL: https://www.wanted.co.kr/wd/384457
- 채집일: 2026-09-18 (원티드 `wanted.py detail 384457`)
- 경로: 원티드 — 원본 ATS·회사 채용홈 미확인
- 원티드 id: 384457
- ⚠ **애매에서 올린 건이다.** `INBOX-WANTED.md`가 시스템 쪽 문장과 서비스 쪽 문장을 둘 다
  인용해 애매로 뒀고, GLG가 시스템 문장이 구체적이라 판단해 22건에 편입했다(`NEXT.md` §F).

## 공고 원문

### 담당업무

1. Customer Problem Discovery & Data-Driven Solution Design
- 고객의 운영 프로세스, 의사결정 구조, 데이터 흐름을 깊이 이해하고 핵심 문제를 정의합니다.
- 현업 사용자, 데이터 팀, IT 팀, 임원진과 직접 소통하며 요구사항을 구조화합니다.
- 데이터 탐색과 분석을 통해 가설을 수립하고, AI/ML/Agent를 활용한 해결 가능성을 검증합니다.
- 모호한 업무 문제를 Agent가 실행 가능한 시스템 요구사항으로 전환합니다.
- 고객별 PoC, 파일럿, 프로덕션 배포 전략을 설계하고 실행합니다.

2. Ontology Modeling
- 고객 도메인의 핵심 객체, 관계, 속성, 상태, 이벤트, 액션을 Ontology로 모델링합니다.
- 데이터베이스, SaaS, 문서, API, 업무 시스템에 흩어진 정보를 의미 기반의 통합 모델로 연결합니다.
- Agent가 사용할 수 있는 semantic layer, business object model, permission model, workflow
  model을 설계합니다.
- Ontology가 단순 데이터 스키마가 아니라 실제 업무 실행과 의사결정의 기반이 되도록 설계합니다.

3. Agent Enablement
- Agent가 고객의 업무 맥락을 이해하고 적절한 액션을 수행할 수 있도록 도구, 지식, 액션
  인터페이스를 설계합니다.
- Agent의 reasoning path, tool usage, execution boundary, human-in-the-loop 조건을 정의합니다.
- Agent가 접근 가능한 객체, 권한, 정책, 승인 흐름을 Ontology와 연결합니다.
- Agent 응답의 정확성, 추적 가능성, 안정성을 높이기 위한 평가 및 개선 루프를 구축합니다.

4. Technical Implementation
- 고객 환경의 데이터 소스, API, 업무 시스템과 연동합니다.
- Python, SQL, TypeScript 또는 유사한 기술 스택을 활용해 프로토타입과 프로덕션 기능을 구현하고
  데이터를 탐색·분석하고 문제 해결 가설을 검증합니다.
- AI/ML/LLM/Agent 기반의 프로토타입을 빠르게 구현하고 고객 데이터로 효과를 검증합니다.
- 데이터 파이프라인, API integration, workflow automation, custom UI 또는 backend service를
  개발합니다.
- 빠르게 실험하고, 고객 피드백을 반영해 Product Engineer와 협업하여 제품 경험을 반복 개선합니다.
- 모델 정확도뿐 아니라 실제 업무 개선 효과와 사용자 경험을 함께 평가합니다.

5. Product Feedback & Pattern Generalization
- 고객 현장에서 발견한 요구사항을 제품 팀과 공유하고 roadmap에 반영합니다.
- 반복적으로 등장하는 Ontology 패턴, Agent workflow, integration pattern을 제품화합니다.
- 고객별 커스텀 구현을 확장 가능한 플랫폼 기능으로 전환합니다.
- 내부 팀을 위한 문서, playbook, reusable template을 작성합니다.

Example Projects
- 제조 고객의 생산, 품질, 재고 데이터를 Ontology로 모델링하고, Agent가 이상 징후를 분석해
  담당자에게 조치를 추천하는 시스템 구축
- 내부 운영팀의 반복 업무를 Ontology 기반 action model로 정의하고, Agent가 사용자 승인 하에
  업무를 실행하는 automation 구축

### 자격 요건

- 3년 이상의 Data Science, 소프트웨어 엔지니어링, 솔루션 엔지니어링, 데이터 엔지니어링 또는
  유사한 기술 역할 경험
- 고객과 직접 소통하며 복잡한 문제를 정의하고 해결한 경험
- Python, SQL, JavaScript/TypeScript 중 하나 이상에 대한 실무 역량
- 데이터 모델링, API integration, workflow automation, enterprise system integration에 대한 이해
- 모호한 문제를 구조화하고 빠르게 프로토타입을 만들어 검증하는 능력
- 비즈니스 요구사항을 기술 아키텍처와 제품 기능으로 번역할 수 있는 능력
- 한국어와 영어로 기술적, 비즈니스적 커뮤니케이션이 가능한 분

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구: Ontology 기반 semantic layer/business object model/permission model 설계 +
  Agent reasoning path/execution boundary 정의(시스템 쪽) **동시에** 고객별 PoC·커스텀 구현을
  플랫폼 기능으로 전환(서비스 쪽) — Palantir식 FDE 정의와 겹친다.
- 우대 사항 중 내가 대는 증거: (컷 확정 후 채운다)
- 내가 대지 못하는 것 (경계): Ontology 모델링 실무 경험은 검증 코퍼스에 없다.

## 시스템 축 재분류 판정 근거 — 애매에서 올림, 양쪽 문장 인용

**시스템 쪽**: 「Agent가 사용할 수 있는 semantic layer, business object model, permission
model, workflow model을 설계합니다... Agent의 reasoning path, tool usage, execution boundary,
human-in-the-loop 조건을 정의합니다.」

**서비스 쪽**: 「고객별 PoC, 파일럿, 프로덕션 배포 전략을 설계하고 실행합니다... 고객별 커스텀
구현을 확장 가능한 플랫폼 기능으로 전환합니다.」

`NEXT.md` §F(애매에서 올린 2건) — 시스템 문장이 구체적이라 22건에 편입됐다.
