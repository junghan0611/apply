# 위즈코어(주)(Wizcore) — 온프레미스 K8s 플랫폼 엔지니어 (시니어)

- 공고 URL: (리멤버 로그인 필요 — 저장소에 URL·엔드포인트 패턴을 적지 않는다,
  `docs/HISTORY-REDACTION.md` §login-gated-automation)
- 채집일: 2026-09-18 (GLG 로그인 브라우저, `get_page_text`)
- 경로: 리멤버 — 원본 ATS·회사 채용홈 미확인
- 리멤버 id: 333230
- ⚠ 원래 `INBOX-REMEMBER.md`가 지목한 "[제조 AX 플랫폼] 임베디드 개발자" 타이틀과는
  다른 req다 — 회사명 검색 카드 목록에서 대표로 이 K8s 플랫폼 엔지니어를 읽었다.

## 공고 원문

「설계-제조 통합 AX 전문기업 위즈코어입니다. 제조 AX 플랫폼 개발을 함께하실 클라우드
엔지니어를 모십니다.」

### 담당업무

- GPU 자원 배분 체계 수립 — 노드 풀 분리, MIG 프로파일, Kueue 큐 · 쿼터 정책
- NVIDIA GPU Operator · DCGM 운영, 드라이버 · CUDA 버전 관리, 노드 장애 대응
- Vault HA 구성 및 운영, cert-manager 연동 인증서 자동화
- 온프레미스 로드밸런싱 — MetalLB(L2 / BGP), Ingress · Gateway 구성 · 운영
- Rook-Ceph RBD 운영 — 풀 설계, OSD 교체, 리밸런싱 영향 관리, 용량 증설
- 스토리지 클래스 이원화 — 자체 복제 워크로드는 local NVMe, 단일 인스턴스는 Ceph RBD
- Istio 안정화 및 순환 의존 차단 — etcd · Vault 백업 외부 보관, 복구 훈련
- 인터넷 · 폐쇄망 이원 운영 — Harbor 복제, 패키지 미러, 단방향 반입, 이미지 서명

### 자격 요건

- 클라우드/인프라 운영 경력 7~15년
- 온프레미스 Kubernetes 프로덕션 운영 (관리형 K8s 경험만으로는 불충분)
- 베어메탈 네트워크 / 로드밸런서 구축
- Vault 또는 동급 시크릿 관리 HA 운영
- Terraform / Ansible IaC, Linux 시스템 · 스토리지 트러블슈팅

### 우대사항

- Istio 또는 Cilium 운영, Rook-Ceph 경험
- NVIDIA GPU Operator · MIG · DCGM
- Kueue / Volcano 등 배치 스케줄러
- 폐쇄망 환경 구축, BGP 환경 경험

근무지: 서울특별시 성동구 · 경력 7~15년 · 학사 이상 · 마감일: 채용 시 마감(2026-09-18 확인 시 열려 있음)

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구: 온프레미스 K8s 프로덕션 운영(관리형 아님) + GPU Operator/MIG + Vault HA +
  폐쇄망 이원 운영. AI/에이전트 이름은 없지만 시스템 축 키워드(게이트웨이·오케스트레이션·
  관측성)와 정확히 겹친다.
- 우대 사항 중 내가 대는 증거: (컷 확정 후 채운다)
- 내가 대지 못하는 것 (경계): Rook-Ceph·Vault HA·베어메탈 로드밸런서 실무 경험은 검증
  코퍼스에서 대조 필요. 7-15년 경력 문턱도 재확인.

## 시스템 축 재분류 판정 근거

「GPU 자원 배분 체계 수립 — 노드 풀 분리, MIG 프로파일, Kueue 큐·쿼터 정책... Vault HA 구성
및 운영... 인터넷·폐쇄망 이원 운영 — Harbor 복제, 패키지 미러, 단방향 반입, 이미지 서명」 —
✅ 시스템 축(`INBOX-REMEMBER.md` §시스템 축 재분류).
