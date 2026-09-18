# 미리비트(Miribit) — Data Engineer & Local LLM AI Agent Engineer

- 공고 URL: https://www.wanted.co.kr/wd/382386
- 채집일: 2026-09-18 (원티드 `wanted.py detail 382386`)
- 경로: 원티드 — 원본 ATS·회사 채용홈 미확인
- 원티드 id: 382386

## 공고 원문

### 담당업무

Data Engineering
- 데이터 수집·정제·변환·적재(ETL/ELT) 파이프라인 설계 및 구축
- 데이터 모델링, Iceberg 기반 데이터 레이크 아키텍처 설계 및 운영
- 대용량 데이터 처리 (Scala, Spark, Kafka, Airflow 등 활용)
- 데이터 품질 관리, 모니터링, 거버넌스 체계 구축
- AI/Agent 시스템을 위한 데이터 준비 (청킹, 임베딩, 벡터 DB 연동 등)

Local AI Agent 개발
- GLM, Kimi 등 로컬 LLM을 활용한 AI Agent 시스템 설계·개발·배포
- 로컬 모델 서빙 환경 구축 및 최적화 (vLLM, SGLang, llama.cpp, Ollama, Unsloth 등)
- Tool-calling / Function-calling 기반 Agent 구현
- Multi-agent 오케스트레이션, Planning, Memory, State 관리
- RAG 파이프라인 설계 및 성능 최적화 (로컬 임베딩 모델 포함)
- Agent와 데이터 파이프라인 연동 (실시간/배치 데이터 활용)
- 로컬 환경에서의 추론 성능·메모리·지연시간 최적화 (양자화, 텐서 병렬, 오프로딩 등)

시스템 안정화 및 운영
- 프로덕션 레벨 Agent 시스템의 모니터링, 로깅, 장애 대응
- Kubernetes 기반 배포 및 CI/CD 파이프라인 구축
- 모델 성능 평가 및 지속적인 개선

### 자격 요건 (필수)

- Data Engineering 실무 경험 3년 이상 또는 동등한 역량
- Scala & Python 숙련 (데이터 처리 및 AI/Agent 개발 모두 가능 수준) — 데이터 파이프라인은 모두 Scala
- SQL 및 데이터 파이프라인 구축 경험
- LLM 기반 AI Agent 개발 경험 (LangChain, LangGraph, LlamaIndex, AutoGen 등 중 하나 이상)
- 로컬 LLM 배포·서빙 경험 (vLLM, SGLang, llama.cpp 등 중 하나 이상)
- GLM, Kimi, Qwen, DeepSeek 계열 모델을 직접 활용해본 경험 (API 또는 로컬 배포)
- Tool-calling / Function-calling 구현 경험

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구: 로컬 LLM 서빙 환경 구축·최적화(vLLM/SGLang/llama.cpp) + 멀티에이전트 오케스트레이션을
  둘 다 직접 담당. Scala 데이터 엔지니어링과 겸장이라 요구 폭이 넓다.
- 우대 사항 중 내가 대는 증거: (컷 확정 후 채운다)
- 내가 대지 못하는 것 (경계): Scala 실무 경험은 검증 코퍼스에 없다. GLM/Kimi 등 중국계 오픈모델
  로컬 배포 경험도 미검증.

## 시스템 축 재분류 판정 근거

「GLM, Kimi 등 로컬 LLM을 활용한 AI Agent 시스템 설계·개발·배포... 로컬 모델 서빙 환경 구축 및
최적화 (vLLM, SGLang, llama.cpp 등)... Multi-agent 오케스트레이션, Planning, Memory, State 관리」
— ✅ 시스템 축.
