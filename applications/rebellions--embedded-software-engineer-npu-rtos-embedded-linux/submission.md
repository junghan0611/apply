# 제출 기록 — Rebellions / Embedded Software Engineer - NPU/RTOS & Embedded Linux

| 항목 | 값 |
|---|---|
| 상태 | draft |
| 지원일 | — |
| 경로 | 그리팅 (rebellions.career.greetinghr.com) — 헤드헌터 제안 경로도 열려 있음 |
| 첨부 컷 | — |
| 공고 URL | https://rebellions.career.greetinghr.com/ko/o/234542 |

## 낸 것

- [ ] 이력서 PDF —
- [ ] 커버레터 / 지원 동기 —
- [ ] 추가 서류 —

## 판정 (2026-10-08, 에이전트 초안 — GLG 확정 전)

**시스템 축 ✅.** 담당업무 인용: 「커널 포팅 레이어(context switch, tick, interrupt nesting), 태스크 및 서비스 구조, 인터럽트 우선순위 체계, 디바이스 드라이버 개발」 · 「Linux 커널 bring-up, Device Tree 구성, 커널 디바이스 드라이버(PCIe, DMA, 인터럽트, mailbox) 개발, Yocto·Buildroot 기반 이미지 구성」. 고객 요청 구현·서비스 문장은 없다.

**요건 매트릭스** — 자격요건에서 뽑았다. ⚠ 아래 증거 입구는 이 저장소의 다른 케이스·스킬에서 **물려받은 것이고 이 세션에서 다시 열어 보지 않았다**(출처를 적는다). 제출 전에 열어 확인한다.

| 자격요건(인용) | 붙이는 값 | 물려받은 입구 (출처) |
|---|---|---|
| 「6년 이상의 임베디드 소프트웨어 개발 경력, ARM Cortex-M 계열 및 ARMv8-A(Cortex-A) 환경」 | **명시적 재직 사실** 후보 | `resume/body.org` 재직 모듈 — Cortex-M/A 구체성은 **미확인** |
| 「상용 RTOS(FreeRTOS, Zephyr, ThreadX 등) 기반 개발 경험」 | **직접 공개 증거** 후보 | `homeagent-config` `bsp/` 의 freertos 레인 (`xcena--embedded-system-bsp-engineer/submission.md`, `SKILL.md` §6) |
| 「Linux 커널 프로그래밍 역량 — 커널 모듈 및 디바이스 드라이버 개발, Device Tree」 | **직접 공개 증거** 후보 | `bsp/` 의 u-boot→커널→rootfs 재현 빌드 + 대학원 NVM 블록 디바이스 드라이버 연구 실적(`~/sync/org/notes/20250317T150522`) |

없음으로 둘 것(우대): PCIe Endpoint/SR-IOV 펌웨어 · Trace32 · Neoverse/SBSA · upstream 커널 기여 · 에뮬레이션 플랫폼(ZeBu). → 직접 증거 2개 이상이면 **선행 큐**, 위 입구가 열어 보고 무너지면 `reach`.

**같은 회사의 다른 열린 직무(GLG 선택)** — 한 회사 한 직무가 기본이다. 보드에서 같은 날 확인한 것:
- `187244` SoC System Software Engineer (ARM/RISC-V) — 「Architect, maintain, and deliver the Board Support Package (BSP)」 · 「bootloaders, secure services, and device drivers … ARM Cortex-A/M and RISC-V」, 6년+. `bsp/` 두 ISA 레인과 가장 가깝다.
- `154319` Silicon Solution Engineer – BSP — 「Build and maintain a reusable BSP platform … (Cortex-A/M, RV32/64)」, 5년+.
- `225672` Linux Device Driver Engineer — SR-IOV·IOMMU/SMMU·KASAN 이 필수라 **증거 입구가 약하다**.

**열린 두 번째 경로** — 2026-09-11 헤드헌터(HEDING)가 **같은 직무**를 제안했다(Gmail `1a08fee09457e85e`, 미회신). 직접 지원과 중복되지 않게 GLG 가 한 경로를 고른다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
|  |  | `FAQ.md` §? |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**

## 왜 이 회사인가 (이 건의 글)

## 이후 기록

- [2026-10-08] 건 생성.
