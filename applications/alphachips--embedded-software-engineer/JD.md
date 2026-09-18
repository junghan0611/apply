# AlphaChips (㈜알파칩스) — Embedded Software Engineer

- 공고 URL: **없다.** 공개 채용 페이지가 아니라 **이메일로 받은 JD 문서**다
- 채집일: 2026-09-18
- 경로: 리멤버에서 받은 포지션 제안을 GLG 가 수락 → JD 첨부 메일 수신
- 근무지: 경기 성남시 분당구 판교
- 채용절차: 서류전형 → 1차면접 → 2차면접 → 처우협의 → 최종합격
- 마감: **따로 없음.** 다만 추석 연휴 전 제출하면 **9/28 주에 바로 서류 검토**가 시작된다고 안내받음

⚠ **원본 `.docx` 는 이 저장소에 두지 않는다.** 제3자가 보낸 비공개 문서이고
`AGENTS.md` §산출물 안전 · §공개는 현재 계약이다에 따라 private 면이 소유한다.
아래는 **판정에 필요한 요건 정리**이고 원문 복제가 아니다.
제안을 보낸 쪽의 이름·연락처·소속은 **GLG 지시로 기록하지 않는다.**

## 포지션이 무엇인가 — 한 줄

**Custom Silicon(ARM / RISC-V SoC)의 Bootloader · BSP · Device Driver · SDK 를 요구사항
분석부터 Silicon Bring-up 과 고객사 SDK 배포까지 전 과정으로 맡는 자리.**
Hardware IP 와 Software Stack 이 통합된 플랫폼을 고객에게 넘기는 것이 산출물이다.

## 담당업무 — 넷으로 갈린다

**시스템 소프트웨어**

- SoC Requirement · Register Specification 분석과 HW/SW Interface 정의
- Embedded Linux · RTOS · Bare-metal 환경의 System Software 설계·구현
- ARM Cortex(A/R/M) 및 RISC-V 기반 Platform Board Bring-up 과 System 통합
- Hardware IP 검증용 Platform Level Test 시나리오 작성, HW-SW Co-debug
- 고객 요구사항 분석 · Customization · Technical Support
- Design Specification · Programming Guide · Release Note 작성

**Bootloader & BSP**

- Boot Chain(Boot ROM → SPL → U-Boot → Kernel) 구현과 SoC/Board 별 Customization
- Linux Kernel Porting · Device Tree 작성 · Kernel Configuration 관리
- Clock · Reset · Power · Pinmux · DDR Initialization 등 플랫폼 초기화 코드
- Secure Boot(ATF, OP-TEE) 구현, Yocto / Buildroot 기반 BSP Release 관리

**Device Driver**

- Linux Kernel Device Driver 및 Bare-metal / RTOS Driver 아키텍처 설계·구현
- Peripheral(UART, I2C, SPI, GPIO) 및 주요 IP(PCIe, Ethernet, USB, DMA) Driver
- Register Access Layer · HAL 구조 설계 · Device Tree Binding 정의
- Interrupt · DMA Descriptor · Cache Coherency 처리, Kernel 수준 디버그

**SDK**

- SDK Architecture 설계와 Public API 정의
- Middleware · User-space Library · Reference Application · Sample Code
- BSP · Kernel · Driver · Firmware 를 통합한 SDK Package 구성과 Release 관리
- CI · Regression Test 환경 운영, System-level Validation, Performance Benchmark

## 자격요건

1. **Embedded System Software 실무 경력 8 ~ 15년**
2. C 및 Assembly 기반 Low-level System Programming
3. Embedded Linux 환경 System Software 개발 경험
4. ARM Cortex(A/R/M) 또는 MIPS / RISC-V CPU 기반 개발 경험
5. System Software · Hardware IP · OS 개념 이해와 Register 기반 하드웨어 제어
6. SoC 주변장치(UART, I2C, SPI, USB, SDIO, Ethernet, PCIe 등) Driver 이해
7. Board Bring-up 및 JTAG Debugger(Trace32 / J-Link / OpenOCD) 활용 경험

## 우대사항

- 관련 공학 분야 석사 또는 박사 학위
- HBM, LPDDR5/5X, PCIe Gen4/5/6, UCIe, MIPI CSI-2 등 High-speed Interface SW 경험
- BSP · Bootloader 개발, Yocto Project / Buildroot 기반 Distribution 구축
- Linux Kernel 프로그래밍, OS 내부 구조 이해, **Kernel Upstream 기여 경험**
- DSP · NPU · Accelerator 의 Driver / Runtime / SDK 개발 경험
- 고객 대상 SDK Release 및 Technical Support 경험
- **Open Source Community 활동** 또는 Verilog / RTL 설계 기본 이해
- 영어 기술문서 작성 및 해외 고객 · IP Vendor 커뮤니케이션

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- **핵심 요구**: SoC 레벨 시스템 소프트웨어 전주기 — Bootloader/BSP/Driver/SDK. 제품 애플리케이션이
  아니라 **하드웨어 바로 위 한 층**이다.
- **우대사항 중 내가 대는 증거**: BSP·Yocto·RISC-V 포팅 · NPU 가속기 워크로드 이식 ·
  오픈소스 공개 활동 · 고객사향 SDK 성격의 배포(스마트홈 허브 서버·앱까지 포함).
- **내가 대지 못하는 것 (경계)**: Custom Silicon Bring-up · JTAG Trace32 디버깅 ·
  Secure Boot(ATF/OP-TEE) · PCIe/DMA 드라이버 · Kernel Upstream 기여 · 석박사 학위.

## 요청받은 제출물 (2026-09-18 메일)

1. **이력서** — 지정 양식(`.docx`) 또는 워드 파일
2. **경력기술서** — 같은 양식. JD 의 자격요건·우대사항을 기준으로 정리해 달라는 요청
3. **포트폴리오** — 이 포지션에 관련된 것만 추려 **PDF 또는 링크**로
4. 🔴 **연봉 기재 요청** — 현재 연봉(직전 원천징수 또는 올해 계약연봉)을 기본급/성과급/기타
   현금성 복지로 나누어 적고, 희망 연봉은 금액으로. **값은 이 저장소에 적지 않는다**
   (`AGENTS.md` §산출물 안전 — 보상값은 private 면). 알파칩스는 성과급이 없다는 안내를 받음

제출본은 검토를 거쳐 회사로 전달되고, 서류 결과·면접 일정이 회신된다.
