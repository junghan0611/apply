# 제출 기록 — Wished / MLOps / AI Agent Developer

| 항목 | 값 |
|---|---|
| 상태 | draft — **폼 실측 완료 · 컷 확정.** GLG 가 컷 PDF 를 원티드 [이력서] 탭에 올리면 `ready` |
| 지원일 | — |
| 경로 | **원티드 자체 지원** (`wd/382306`) — `out_link: null` 실측 (2026-09-18) |
| 첨부 컷 | **Platform Engineer** (`resume/build/KimJunghan_Resume_Platform_Engineer.pdf`) — 담당업무가 폐쇄망 개발·인프라 아키텍처와 Docker 컨테이너 운영이다. 컷의 「self-hosted hosts and services」 축과 정면. ⚠ 담당업무에 Kubernetes 가 한 줄 있는데 컷은 multi-tenant K8s 운영을 명시로 부인한다 — **자격요건에는 없으므로 모순은 아니지만 경계는 그대로 보인 채로 낸다** |
| 공고 URL | https://www.wanted.co.kr/wd/382306 |
| 원장 대조 | `LEDGER.md`에 없음 — 신규 후보 |

## 낸 것

- [ ] 이력서 PDF — 컷 확정. **원티드 [이력서] 탭 업로드가 선행**이고 아직 안 되어 있다
- [x] 커버레터 / 지원 동기 — **해당 없음.** 원티드 자체 지원 폼에 서술형 칸이 없다 (`WANTED-APPLY-FORM.md` §서술형 문항)
- [ ] 추가 서류 — 이력서 탭에 올려둔 파일을 체크박스로 복수 선택할 수 있다. 무엇을 함께 낼지는 GLG 판단

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| **없음** — 원티드 자체 지원 폼에는 기업 추가 서술형 문항이 없다 | — | `WANTED-APPLY-FORM.md` §서술형 문항 |

## 왜 이 회사인가 (이 건의 글)

`INBOX-WANTED.md` §시스템 축 재분류 인용:

「폐쇄망 환경에 적합한 전체 개발·인프라 아키텍처 설계... 온프레미스 LLM 기반 AI Agent 설계 및
개발... 폐쇄망 환경의 패키지·의존성·이미지·모델 관리 체계 구축」

⚠ MLflow/Kubeflow 실무 경험은 검증 코퍼스에 없다.


## 요건-증거 매트릭스 (terra 축, 2026-09-18)
필수요건 항목마다 [직접 공개 증거 / 명시적 재직 사실 / 없음]을 붙인다.

| 필수요건 | 증거 유형 | 근거 |
|---|---|---|
| 폐쇄망 환경에 적합한 개발·인프라 아키텍처 설계 | 직접 공개 증거 | Smart Home Hub — closed network용 local mTLS broker(연결형은 AWS IoT, 폐쇄망은 로컬 mTLS로 같은 프로토콜을 서빙) |
| 온프레미스 LLM 기반 AI Agent 설계 및 개발 | 직접 공개 증거 | HomeAgent(RPi5+Hailo-8 NPU 온디바이스 에이전트), IITP 국책과제(NPU 워크로드 가속기 이식) |
| Docker 기반 컨테이너 환경 구축·배포·운영 | 직접 공개 증거 | GPU 클러스터 인프라(NixOS, 17개 Docker 서비스) |

판정: **선행 큐 후보** (직접 증거 2건 이상)

## 이후 기록

- [2026-09-18] 건 생성. `JD.md`에 원티드 본문 보존. 제출본 컷·폼 실측은 4-B 단계.
- [2026-09-18] **4-B 폼 실측.** 지원 경로를 `out_link` 로 확정(원티드 자체 지원)하고, 폼 구조는
  15건 공유 정본 `applications/WANTED-APPLY-FORM.md` 로 분리했다. 남은 미실측은 지원 모달 내부
  한 화면뿐이고 🔴 「지원하기」 클릭 금지라 GLG 가 한 번 열어 주면 15건이 함께 닫힌다.

## 제출 요건 실측 (4-B, 2026-09-18)

**폼 구조는 원티드 15건이 한 벌로 공유한다 — 정본은 `applications/WANTED-APPLY-FORM.md`.**
지원 경로 판정법·첨부 방식·서술형 문항 유무·개인값 칸·남은 미실측이 영수증과 함께 거기 있다.
아래는 **이 건에서만 다른 값**이다.

| 항목 | 값 | 영수증 |
|---|---|---|
| 공고 상태 | `active` — 살아 있다 | `GET /api/chaos/jobs/v1/382306/details` (2026-09-18 실측) |
| 마감일 | 없음(`due_time: null`) — 상시라는 보장이 아니라 **예고 없이 닫힌다**는 뜻 | 〃 |
| 경력 요건 | 2년 이상 (상한 미표기) | 〃 `annual_from` / `annual_to` |
| **지원 경로** | **원티드 자체 지원** — 회사 자체 ATS 로 튕기지 않는다 | 〃 `out_link: null`. 대조군 확인은 `WANTED-APPLY-FORM.md` §지원 경로 |
| 추가 지원 유형 | 없음 (`additional_apply_type: null`) | 〃 `additional_apply_type` |
| 국적·비자 칸 | 해당 없음 — `visa_information: null` | 〃 `visa_information` |
| **필수 첨부** | **[이력서] 탭 파일 목록에서 체크박스로 최소 1개** (슬롯 업로드가 아니다) | `WANTED-APPLY-FORM.md` §첨부 |
| **서술형 문항** | **없다** — 원티드 자체 지원에는 기업 추가 문항 칸이 없다. 따라서 글자수 캡도 없다 | `WANTED-APPLY-FORM.md` §서술형 문항 |
| **개인·법적 값 칸** | 이름·이메일·연락처는 프로필에서 자동. 이 경로에서 손으로 채울 칸은 사실상 없다 | `WANTED-APPLY-FORM.md` §개인·법적 값 칸 |
| 🔴 **막고 있는 것** | **컷 PDF 가 아직 [이력서] 탭에 없다.** 올려야 지원 화면 체크박스에 뜬다 — GLG 몫 | `WANTED-APPLY-FORM.md` §컷 PDF 선행조건 |
