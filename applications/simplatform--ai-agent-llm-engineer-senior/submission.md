# 제출 기록 — Simplatform / AI Agent & LLM Engineer Senior

| 항목 | 값 |
|---|---|
| 상태 | draft — **폼 실측 완료 · 컷 확정.** GLG 가 컷 PDF 를 원티드 [이력서] 탭에 올리면 `ready` |
| 지원일 | — |
| 경로 | **원티드 자체 지원** (`wd/368678`) — `out_link: null` 실측 (2026-09-18) |
| 첨부 컷 | **AI Engineer** — AI Agent Orchestration 플랫폼 아키텍처 + Coding AI Agent 도입 전략 — Agent Platform Engineer 컷과 일치 |
| 공고 URL | https://www.wanted.co.kr/wd/368678 |
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

「AI Agent Orchestration 플랫폼의 아키텍처를 설계하고 구축을 주도합니다. (멀티 에이전트
오케스트레이션, RAG, MCP 연동 등)... Coding AI Agent 도입 전략을 수립하고 사내에 전파」

Claude Code 등 코딩 에이전트 사용 능숙자를 명시로 우대 — GLG의 실전 이력과 겹친다.


## 요건-증거 매트릭스 (terra 축, 2026-09-18)
필수요건 항목마다 [직접 공개 증거 / 명시적 재직 사실 / 없음]을 붙인다.

| 필수요건 | 증거 유형 | 근거 |
|---|---|---|
| Python과 TypeScript 두 언어 모두 능숙 | 직접 공개 증거 | entwurf(TypeScript) · 코퍼스 전반 Python 파이프라인(Airbyte→PostgreSQL JSONB) |
| RAG 등 LLM 기반 서비스를 프로덕션 환경에 적용한 경험 | 직접 공개 증거 | andenken — LanceDB hybrid retrieval을 실제 서비스로 배포·공개 |
| Kubernetes 환경에서 서비스 배포·운영 경험 | 없음 | K8s 운영 증거 없음 — Docker/NixOS까지만 공개 코퍼스에 있다 |

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
| 공고 상태 | `active` — 살아 있다 | `GET /api/chaos/jobs/v1/368678/details` (2026-09-18 실측) |
| 마감일 | 없음(`due_time: null`) — 상시라는 보장이 아니라 **예고 없이 닫힌다**는 뜻 | 〃 |
| 경력 요건 | **9~17년** | 〃 `annual_from` / `annual_to` |
| **지원 경로** | **원티드 자체 지원** — 회사 자체 ATS 로 튕기지 않는다 | 〃 `out_link: null`. 대조군 확인은 `WANTED-APPLY-FORM.md` §지원 경로 |
| 추가 지원 유형 | 외국인 지원 가능 (`['foreigner']`) | 〃 `additional_apply_type` |
| 국적·비자 칸 | **국적 칸이 뜰 수 있다** — `visa_information.supported_visas: ['E-7']` 로 글로벌 포지션 표시가 붙어 있다 | 〃 `visa_information` |
| **필수 첨부** | **[이력서] 탭 파일 목록에서 체크박스로 최소 1개** (슬롯 업로드가 아니다) | `WANTED-APPLY-FORM.md` §첨부 |
| **서술형 문항** | **없다** — 원티드 자체 지원에는 기업 추가 문항 칸이 없다. 따라서 글자수 캡도 없다 | `WANTED-APPLY-FORM.md` §서술형 문항 |
| **개인·법적 값 칸** | 이름·이메일·연락처는 프로필에서 자동. 이 경로에서 손으로 채울 칸은 사실상 없다 | `WANTED-APPLY-FORM.md` §개인·법적 값 칸 |
| 🔴 **막고 있는 것** | **컷 PDF 가 아직 [이력서] 탭에 없다.** 올려야 지원 화면 체크박스에 뜬다 — GLG 몫 | `WANTED-APPLY-FORM.md` §컷 PDF 선행조건 |

- 🔴 **연차 하한 미달 — hard gate.** 공고 하한이 **9년**인데 `FAQ.md` §3 의 폼에 쓸 값은 **8+ years** 다.
  `AGENTS.md` §둘째 축이 든 예(「8년/10년 같은 연차 하한은 스크리닝에서 먼저 잘린다」)와 같은 자리다.
  요건-증거 매트릭스와 무관하게 **먼저 잘릴 수 있다.** 그래도 낼지는 GLG 판정이다.
