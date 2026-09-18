# 마카롱팩토리(마이클)(Macaron Factory) — Platform Engineering (5년 이상)

- 공고 URL: (리멤버 로그인 필요 — URL·엔드포인트 패턴 미보존,
  `docs/HISTORY-REDACTION.md` §login-gated-automation)
- 채집일: 2026-09-18 (GLG 로그인 브라우저, `get_page_text`)
- 경로: 리멤버 — 원본 ATS·회사 채용홈 미확인
- 리멤버 id: 333599
- 회사명 영문 표기 미확인 — "Macaron Factory"는 원장 `마이클(마카롱팩토리)` 표기의 음차 추정.

## 공고 원문

「2,500만 운전자의 국민 서비스로의 여정, 지금 바로 합류하세요」

### 주요업무

- 서비스를 만들고 운영하는 데 필요한 것을 직접 처리할 수 있는 환경을 구축하고, 그 범위를
  넓혀갑니다. 플랫폼을 제품으로 보고 쓰는 사람의 불편에서 출발합니다.
- 표준 템플릿: 새 서비스를 시작할 때 쓰는 기본 골격을 제공합니다. CI, 배포, 관측성, 시크릿
  관리가 처음부터 붙어 있게 합니다.
- 개발환경과 배포: 개발부터 상용까지 일관된 환경과 배포 흐름을 제공합니다. 인프라를 코드로
  관리하고, 개발자가 직접 변경을 제안·리뷰할 수 있는 흐름을 만듭니다.
- 신뢰성과 관측성: SLI/SLO와 측정 체계를 세우고, 알람 심각도 분류와 서비스 간 요청 추적을
  설계합니다. 인시던트는 격상·라우팅·포스트모템까지 하나의 절차로 연결합니다.
- 보안 운영: 의존성·이미지 취약점 대응을 파이프라인에 넣고, 시크릿 저장 표준과 프로덕션 접근
  권한 체계를 만듭니다.
- 개발자 경험 측정: 플랫폼이 개발자의 인지 부하를 실제로 줄이는지 지표와 설문으로 확인합니다.
- AI로 운영 자동화: 사람이 매번 처리하는 운영 판단과 반복 요청을 워크플로우와 AI로 옮기고,
  프로덕션에 영향을 주는 작업은 어디까지 맡길지 기준을 세웁니다.

### 기술 스택

- 클라우드: AWS
- 컨테이너·오케스트레이션: ECS, EKS, k3s, Helm
- IaC·CI/CD: Terraform, AWS CDK, Atlantis, GitHub Actions, ArgoCD, Ansible
- 관측·운영: Datadog, Sentry, Grafana, Prometheus, CloudWatch
- 보안: AWS Secrets Manager, external-secrets, IAM Roles Anywhere, Wazuh
- 데이터베이스: Aurora MySQL·PostgreSQL, DynamoDB, Redis, OpenSearch, Druid, Kafka
- 언어: Python, Shell, TypeScript, Kotlin/Java
- 협업 관련: Git, Asana, Slack, Confluence

근무지: 경기도 성남시 분당구 · 경력 5~10년 · 학력 무관 · 마감일: 채용 시 마감
(2026-09-18 확인 시 열려 있음)

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구: 표준 CI/배포 템플릿 + SLI/SLO 관측성 체계 + 시크릿/보안 파이프라인 +
  AI를 활용한 운영 자동화. 전형적인 플랫폼 엔지니어링 직무지만 AI 운영 자동화가 담당업무에
  명시된다.
- 우대 사항 중 내가 대는 증거: (컷 확정 후 채운다)
- 내가 대지 못하는 것 (경계): Datadog·ArgoCD·Atlantis 실무 경험은 검증 코퍼스에서 대조 필요.

## 시스템 축 재분류 판정 근거

「표준 템플릿: 새 서비스를 시작할 때 쓰는 기본 골격을 제공... CI, 배포, 관측성, 시크릿 관리가
처음부터 붙어 있게 합니다... AI로 운영 자동화: 사람이 매번 처리하는 운영 판단과 반복 요청을
워크플로우와 AI로 옮기고」 — ✅ 시스템 축(`INBOX-REMEMBER.md` §시스템 축 재분류).
