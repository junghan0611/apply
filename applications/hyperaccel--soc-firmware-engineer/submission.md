# 제출 기록 — HyperAccel / SoC Firmware Engineer

| 항목 | 값 |
|---|---|
| 상태 | draft |
| 지원일 | — |
| 경로 | 그리팅 (hyperaccel.career.greetinghr.com) |
| 첨부 컷 | — |
| 공고 URL | https://hyperaccel.career.greetinghr.com/ko/o/229084 |

## 낸 것

- [ ] 이력서 PDF —
- [ ] 커버레터 / 지원 동기 —
- [ ] 추가 서류 —

## 판정 (2026-10-08, 에이전트 초안 — GLG 확정 전) — **선행 큐 후보**

**시스템 축 ✅.** 담당업무가 칩 bring-up 펌웨어·부트로더·RTOS/Embedded Linux·드라이버 연동이고, 고객 요청 구현·서비스 문장은 없다. 회사가 AI 가속기(LPU)여도 보직은 펌웨어다(`AGENTS.md` §불변식 — 판정은 담당업무에서 한다).

**요건 매트릭스** — 자격요건 셋이 전부다. ⚠ 증거 입구는 이 저장소의 다른 케이스·스킬에서 **물려받은 것이고 이 세션에서 다시 열어 보지 않았다.** 제출 전에 열어 확인한다.

| 자격요건(인용) | 붙이는 값 | 물려받은 입구 (출처) |
|---|---|---|
| 「(Embedded) C/C++ 언어 역량」 | **직접 공개 증거** 후보 | `homeagent-config` `bsp/` · Zig/C 펌웨어 (`SKILL.md` §6) |
| 「Linux 환경에서 … Firmware 개발 경험」 | **직접 공개 증거** 후보 | `bsp/` fsbl→opensbi→u-boot→커널→rootfs→freertos 재현 빌드 (`xcena--embedded-system-bsp-engineer/submission.md`) |
| 「컴퓨터 구조 및 운영체제 기초 지식」 | **명시적 재직·학력 사실** 후보 | 대학원 NVM 블록 디바이스 드라이버·NUMA 연구 실적 (`~/sync/org/notes/20250317T150522`) |

우대 중 대는 것(후보): ARM/RISC-V SoC 펌웨어 · FreeRTOS · Yocto/BSP(NEMO-UX 2016). **없음**: ZeBu/Trace32 · UCIe/AXI 고속 버스 · Cortex-A 어셈블리 수준의 깊이.
→ 직접 증거 후보 2개 이상 + 허들이 낮아 **선행 큐**. 단 「신입/경력」 공고라 **연차 대비 처우가 낮게 잡힐 수 있다** — 낼지는 GLG 결정.

**같은 회사의 다른 열린 직무(GLG 선택)** — 한 회사 한 직무가 기본이다. 보드에서 같은 날 확인:
- `216666` **Device Driver Engineer** — 「AI 가속기(PCIe 디바이스)용 Linux 커널 드라이버」 · 「임베디드 리눅스(ARM SoC) 커널 드라이버 개발 platform device / device tree」. 자격은 「Linux 커널 모듈 또는 디바이스 드라이버 개발에 대한 이해」 수준, 우대 「PCIe 드라이버 3년+」는 **없음**.
- `210116` System Software Engineer — 통신 알고리즘·분산 런타임(NCCL/MPI 우대)이라 **증거 입구 없음**.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
|  |  | `FAQ.md` §? |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**

## 왜 이 회사인가 (이 건의 글)

## 이후 기록

- [2026-10-08] 건 생성.
