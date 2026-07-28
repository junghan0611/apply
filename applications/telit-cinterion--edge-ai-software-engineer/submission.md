# 제출 기록 — Telit Cinterion (텔릿 신테리온) 🌐 / Edge AI Software Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **Paylocity** (`recruiting.paylocity.com`) — **이 저장소에서 처음 만나는 ATS** |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) |
| 공고 URL | https://recruiting.paylocity.com/recruiting/jobs/Details/4158364/TELIT-IOT-PLATFORMS-LLC/Edge-AI-Software-Engineer (HTTP 200 확인) |
| 근무지 | **Seoul, KOR** · 정규직 |
| 회사 | IoT 모듈·엔드투엔드 IoT 솔루션. **서방 최대 규모 셀룰러 모듈 공급사.** 🌐 외국계 |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4411555374/`)와 같은 자리다.** offsite 라 Paylocity 원본으로 낸다.

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`)
- [ ] 커버레터 — Paylocity 폼은 건마다 다르다. **칸이 있으면** 아래 §왜 이 직무였는가 를 줄여 쓴다

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** Bear Robotics · Sonatus · Telechips 와 **같은 Embedded 컷**이다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 — 요건은 학사 이상 | `FAQ.md` §3 |
| 영어 | 필수는 **읽기·쓰기**다(`read technical documentation and collaborate with global teams`) | `FAQ.md` §6 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

## 왜 이 직무였는가

**GLG 의 두 축 — 임베디드와 에이전트 — 이 한 자리에 같이 있는 드문 공고다.**

주요 업무 다섯 줄 중 마지막이 **「LLM 기반 Agent 프레임워크를 R&D 조직의 일상 개발
워크플로에 프로덕션 도입한다」**이다. **대부분의 임베디드 회사는 공고에 이 문장을 쓰지 않는다.**
그리고 이건 GLG 가 지금 회사에서 실제로 하고 있는 일이다 — 스킬 SSOT 하나를 6개 하네스로
팬아웃하고, 40+ 스킬을 실제 코퍼스 위에서 굴린다.

- **`TinyML · edge intelligence · on-device inference`**(우대) — **HomeAgent**: RPi5 +
  **Hailo-8 NPU**(Yocto)와 RK3576(Android)에서 도는 온디바이스 AI 에이전트. **Go 단일
  코드베이스로 두 배포를 96% 공유**했다.
- **`multi-platform inference optimization (DSP/NPU/GPU)`**(우대) — **국가 R&D(IITP 2025–2028)**
  에서 **NPU 워크로드를 가속기 간 포팅**하는 것이 담당 범위다. sLLM 음성 제어 포함.
- **`cellular modules, IoT devices, wireless terminals, embedded products`**(우대) —
  Matter 월패드를 **RK3576 + Android 15 · ESP32-H2 Thread RCP** 로 고객사 네임스페이스에
  버전드 AAR 로 납품했다.
- **`Proficiency in C / C++`**(필수) — **AOSP 네이티브 CHIP C++ SDK** 와 `ot-daemon`.
- **`Contribution experience in open-source community`**(우대) — 외부 저장소에 머지된 PR.

**경계는 먼저 밝힌다. 필수의 절반이 ML 모델 최적화다.**

- **pruning · quantization · distillation 을 직접 수행한 실적이 아니다**(필수 4).
  NPU 배포는 **워크로드 포팅·통합** 축이다.
- **TFLite · TFLite Micro · PyTorch Mobile · ONNX Runtime 통합 실적을 명시적으로 못 댄다**(필수 6).
- **FFT / STFT 신호처리 파이프라인 경험이 없다**(필수 5).
- **MCU/RTOS 급 초경량 플랫폼이 아니라 임베디드 리눅스·안드로이드 축**이다(필수 7).
- **모델 학습(training) 실적이 얇다.** 추론·배포·통합이 두껍다.
- **셀룰러 모듈·모뎀 호스트 인터랙션 경험이 없다.**

**대는 것은 「모델을 깎는 손」이 아니라 「모델을 기기에 얹고 파이프라인으로 만드는 손」이다.**
서류가 붙으면 그 프레임으로 간다.

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **exa-search 로 Paylocity 원본(HTTP 200)** 을 찾았다.
- [2026-07-28] 컷 **Embedded** 확정. 상태 `ready` — **제출 대기**.
