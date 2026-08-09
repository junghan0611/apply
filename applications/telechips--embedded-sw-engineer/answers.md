# 폼 서술형 답 — Telechips [판교] Embedded S/W Engineer (BSP Driver)

`stage.py` 가 아래 ```text 블록을 `submit/answers.txt` 로 뽑는다. **폼에 붙여넣을 본문은
블록 안이 전부다.** 블록 밖은 왜 그렇게 썼는지의 기록이고 제출되지 않는다.

⚠ **글자 수는 아래 셈이 폼 카운터와 일치한다는 보장이 없다.** 붙여넣은 뒤 **폼 카운터를
눈으로 확인한다** (2026-08-01 IGNITE 에서 셈법이 실측으로 검증된 계약).

---

## 문항 1 — 경력요약 (폼 8번 · 필수 · 10,000자)

**폼의 예시가 서술문이 아니라 용어 나열이다** — `ex) BSP Kernel Driver 개발 / Verilog HDL
능숙 / PCB Artwork`. 그래서 나열형을 기본 골격으로 잡되, 맨 위에 **두 줄 요약**을 둔다.
읽는 사람이 나열만 훑고 지나가면 *「실리콘에서 양산까지 끝까지 가 봤다」* 는 축이 안 보이고,
그 축이 이 지원의 핵심이기 때문이다.

**2026-08-09 GLG**: *「경력요약은 임베디드 관련 내 이력들로 적으면 되거든.」*
→ 에이전트·AX·하네스 축을 넣지 않았다. 이 칸은 임베디드 이력만 쓴다.

```text
[요약]
Linux 임베디드 제품을 하드웨어 bring-up 부터 양산까지 두 번 끝까지 수행했습니다. 최근에는 ARMv7/glibc(vendor sysroot) 기반 제품 코어를 RISC-V(SG2000)/static musl 로 포팅하고, 보드 차이가 제품 로직에 새지 않도록 board HAL 을 분리했습니다. 대학원에서는 비휘발성 메모리 파일시스템과 가상화 환경 NUMA lock 성능을 연구해 커널 계층이 낯선 어휘가 아닙니다.
지원 자격 4개 중 Linux Kernel debugging / Embedded board bring-up / 관련 전공 학사 이상 3개를 충족하며, bootloader(LK·U-Boot) 포팅과 production kernel driver 개발 경험은 없습니다. 이 경계는 첨부한 경력기술서 마지막 절에 그대로 적어 두었습니다.

[임베디드 시스템 · 보드]
Embedded board bring-up (하드웨어팀 협업, 미완성 보드 단계부터) / 크로스 아키텍처 포팅 ARMv7 → RISC-V(SG2000) / static musl 유저랜드 전환 / board HAL 추출 및 보드 의존성 격리 / ARM · RISC-V 크로스 툴체인 / Yocto Project 이미지 빌드 / AOSP(Android 15) 기반 제품 통합 / RK3576 · RPi5 · Hailo-8 NPU · EFR32MG24 · ESP32-H2 실장 경험

[펌웨어 · 드라이버 경계]
Zigbee 게이트웨이 펌웨어 개발 및 양산 / legacy C Zigbee SDK 를 Zig type-safe FFI 경계로 격리 / 드라이버-프로토콜-클라우드 계층을 관통하는 단일 상태기계(HubState) 설계 / 24시간 aging 테스트 자동화 / 실기기 다중 허브 fan-out 검증 / OTA 및 monotonic versioning 기반 shadow 동기화 / mTLS 브로커와 AWS IoT 이중 백엔드를 동일 펌웨어 바이너리로 지원

[커널 · 시스템 소프트웨어]
Linux Kernel debugging 및 계측 기반 성능 진단 (CPU 상태 · 부팅 · resident memory) / 비휘발성 메모리(NVM) 파일시스템 연구 / 가상화 환경 NUMA lock 성능 연구 (성균관대 분산컴퓨팅연구실, Virginia Tech COSMOSS Lab 교환연구) / 릴리스 승격 정책 성문화 (2버전 점프 금지 · 비운영 타깃 24시간 스테이징 · 이상 신호 시 중단)

[제품 전체 수명주기]
NEMO-UX 공동창업 — 대형 터치 디스플레이용 Linux 기반 OS 개발, 하드웨어 통합 · OS 커스터마이징 · 애플리케이션 개발 · 양산 / 스마트홈 게이트웨이 제품 양산 / 고객사 SDK 딜리버리 (버전 관리되는 AAR 패키징, 고객 네임스페이스)

[언어 · 도구]
C / Zig / Go / Python / Bash / Nix / Git / Yocto / CMake · 크로스컴파일 / Docker / 선언형 인프라(NixOS 4대 머신)

[수상]
2010 한국 소프트웨어 공모대전 국무총리상 — 모바일 가상화 소프트웨어

[경계 — 먼저 밝힙니다]
bootloader(LK · U-Boot) 포팅 경험 없음 / device tree 신규 플랫폼 작성·최적화 경험 없음 / production kernel driver 개발 경험 없음 (커널 계층 이력은 연구입니다) / Assembly 실무 경험 없음 / JTAG · ETM · SWD 미사용 / Hypervisor · Virtual platform · SOC Emulator · ASPICE 경험 없음 / 팹리스의 칩 검증 및 불량 분석은 인접 영역이며 보유 경험이 아닙니다
```

### 왜 이렇게 썼는가

- **자가 측정 수치를 넣지 않았다** (`AGENTS.md` §불변식 §숫자). 부팅 45.4→5.8초 · 메모리
  816→246MiB · 코드 공유 96% 는 전부 뺐다. 성능 개선의 실체는 **업스트림 릴리스**였고
  내 몫은 진단·롤백 기준·정책이라, 그 자리를 **「릴리스 승격 정책 성문화」**로 적었다.
- **경계를 나열의 마지막 항목으로 넣었다.** 자격 4줄 중 3줄이 정면이라 굳이 감출 이유가
  없고, 감추면 면접 첫 질문에서 무너진다. 첨부한 경력기술서 §5 와 **같은 문장**을 쓴다 —
  두 문서가 갈라지면 그게 더 큰 감점이다.
- **AI·에이전트·하네스 축을 한 줄도 넣지 않았다.** GLG 지시대로 이 칸은 임베디드 이력만
  쓴다. 그 축은 이 폼의 어느 칸도 묻지 않는다.
- **양산을 두 번 말했다.** NEMO-UX 와 현직 게이트웨이 — 이 팀이 하는 일이 *「고객사 개발
  및 양산 지원」* 이라 양산까지 가 본 경험이 이 자리에서 가장 값이 나가는 사실이다.
