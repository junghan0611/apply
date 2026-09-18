# 제출 기록 — Openedges Technology / NPU Firmware Engineer

| 항목 | 값 |
|---|---|
| 상태 | draft — **폼 실측 완료 · 컷 확정.** GLG 가 컷 PDF 를 원티드 [이력서] 탭에 올리면 `ready` |
| 지원일 | — |
| 경로 | **원티드 자체 지원** (`wd/365239`) — `out_link: null` 실측 (2026-09-18) |
| 첨부 컷 | **Embedded Software Engineer** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) — 컷의 「Edge AI — on-device sLLM and NPU deployment across accelerator families」가 이 JD 의 NPU 축과 직접 대응한다 |
| 공고 URL | https://www.wanted.co.kr/wd/365239 |
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

「신경망 연산자별 NPU 연산 Kernel 개발... Firmware에 대한 검증, 성능 Profile 분석 및 최적화
작업... 기능 안전(FuSa) 대응」

⚠ NPU/딥러닝 연산자 커널 개발 실무 경험은 검증 코퍼스에 없다 — 임베디드 펌웨어 축은 있으나
NPU 특화 경험은 아니다. 정직하게 경계로 남긴다.


## 요건-증거 매트릭스 (terra 축, 2026-09-18)
필수요건 항목마다 [직접 공개 증거 / 명시적 재직 사실 / 없음]을 붙인다.

| 필수요건 | 증거 유형 | 근거 |
|---|---|---|
| C/C++ 활용 Embedded Firmware 개발 경험 | 직접 공개 증거 | SKS Hub — 레거시 C Zigbee SDK 통합을 Zig의 타입세이프 FFI 레이어 뒤로 재작성 · NEMO-UX 임베디드 제품 전주기 |
| Interrupt를 이용한 비동기 이벤트 처리에 대한 이해 | 없음 | 펌웨어 재작성 산출물이 인터럽트 레벨 처리를 명시적으로 증언하지 않는다 |
| Deep Learning 연산자 이해 및 Computer Architecture(메모리 계층·DMA·IOMMU 등) | 직접 공개 증거 | On-Device AI Hub — RPi5+Hailo-8 NPU · IITP 국책과제에서 가속기 계열 간 NPU 워크로드 이식 진행 중 |

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
| 공고 상태 | `active` — 살아 있다 | `GET /api/chaos/jobs/v1/365239/details` (2026-09-18 실측) |
| 마감일 | 없음(`due_time: null`) — 상시라는 보장이 아니라 **예고 없이 닫힌다**는 뜻 | 〃 |
| 경력 요건 | 2~14년 | 〃 `annual_from` / `annual_to` |
| **지원 경로** | **원티드 자체 지원** — 회사 자체 ATS 로 튕기지 않는다 | 〃 `out_link: null`. 대조군 확인은 `WANTED-APPLY-FORM.md` §지원 경로 |
| 추가 지원 유형 | 전문연구요원·장애인 지원 가능 (`['alternative_military', 'disabled_person']`) | 〃 `additional_apply_type` |
| 국적·비자 칸 | 해당 없음 — `visa_information: null` | 〃 `visa_information` |
| **필수 첨부** | **[이력서] 탭 파일 목록에서 체크박스로 최소 1개** (슬롯 업로드가 아니다) | `WANTED-APPLY-FORM.md` §첨부 |
| **서술형 문항** | **없다** — 원티드 자체 지원에는 기업 추가 문항 칸이 없다. 따라서 글자수 캡도 없다 | `WANTED-APPLY-FORM.md` §서술형 문항 |
| **개인·법적 값 칸** | 이름·이메일·연락처는 프로필에서 자동. 이 경로에서 손으로 채울 칸은 사실상 없다 | `WANTED-APPLY-FORM.md` §개인·법적 값 칸 |
| 🔴 **막고 있는 것** | **컷 PDF 가 아직 [이력서] 탭에 없다.** 올려야 지원 화면 체크박스에 뜬다 — GLG 몫 | `WANTED-APPLY-FORM.md` §컷 PDF 선행조건 |
