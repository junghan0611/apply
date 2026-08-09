# 제출 기록 — Telit Cinterion (텔릿 신테리온) 🌐 / Edge AI Software Engineer

| 항목 | 값 |
|---|---|
| 상태 | ✅ **submitted** — 2026-08-09 GLG 가 브라우저에서 최종 제출 완료 |
| 지원일 | **2026-08-09** |
| 경로 | **Paylocity** (`recruiting.paylocity.com`) — **이 저장소에서 처음 만나는 ATS** |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) |
| 추가 첨부 | ✅ **`submit/KimJunghan_Embedded_Experience_Detail.pdf` (3쪽)** → 폼의 **`Upload Additional Files`(10MB, 선택)** 칸. 칸은 2026-08-09 실측으로 확인했다(아래 §폼 스키마). AX 축 깊이 문서는 여전히 이 자리의 답이 아니다 — **임베디드 축 중립판**이 2026-08-09 에 새로 나왔다. 정본·재현: `../telechips--embedded-sw-engineer/{experience-detail.md,build.sh}` |
| 공고 URL | https://recruiting.paylocity.com/recruiting/jobs/Details/4158364/TELIT-IOT-PLATFORMS-LLC/Edge-AI-Software-Engineer (HTTP 200 확인) |
| **지원 URL** | **https://recruiting.paylocity.com/Recruiting/jobs/Apply/4158364** (브라우저 실측 2026-07-29) |
| 근무지 | **Seoul, KOR** · 정규직 |
| 회사 | IoT 모듈·엔드투엔드 IoT 솔루션. **서방 최대 규모 셀룰러 모듈 공급사.** 🌐 외국계 |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4411555374/`)와 같은 자리다.** offsite 라 Paylocity 원본으로 낸다.

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Embedded_Software_Engineer.pdf` (28.5 kB)
      → 상단 `Select Resume to Upload` 슬롯
- [x] ⭐ **임베디드 축 깊이 문서** — `submit/KimJunghan_Embedded_Experience_Detail.pdf`
      (3쪽 · 30.4 kB · 영문 · 회사 중립판) → `Upload Additional Files` (10MB 선택 칸)
- [x] **Submit 완료** (2026-08-09). 파일 2개는 에이전트가 올렸고,
      **Step 1 개인·주소값 · SMS 동의 · `Next Step` · Step 2·3 · 최종 제출은 GLG** 가 했다.
      개인값은 저장하지 않는다.
- ⛔ 커버레터 — Step 1 에 칸이 없었다. Step 2·3 은 §미실측으로 남는다(아래).

**⚠ 업로드 직전 파일명을 눈으로 확인했다.** Bear Robotics · Sonatus · Telechips 와 **같은 Embedded 컷**이다.

> ⚠ **Step 2·3 은 끝내 실측되지 않았다.** GLG 가 그대로 통과해 제출했고, 에이전트는 Step 1 만
> 봤다. **그 두 단계에 무엇이 있었는지 이 저장소는 모른다** — 다음 Paylocity 건에서 다시 만나면
> 그때 뜬다. **「없었다」로 적지 않는다**(07-30 계약: 미실측은 「없음」이 아니다).

> **⛔ dossier 깊이 문서(AX Competency · Portfolio)를 붙이지 않는다 (2026-07-30 판정).**
> 2026-07-30 에 AX·에이전트 축 11건에는 이 2종을 세트에 깔았지만 **이 건은 뺐다.**
> 이 건의 컷은 **Embedded** 이고, 두 문서는 AX 전환·에이전트 플랫폼 축으로 쓰인 글이다.
> 같은 판단이 이미 Bear Robotics 커버레터에 적혀 있다 — *「에이전트·하네스·MCP 서사를
> 붙이면 지원자가 무엇을 하는 사람인지 흐려진다」*. **첨부를 늘리는 것이 성의가 아니라,
> 그 자리에 맞는 것을 내는 것이 성의다.**
> → 임베디드 축의 깊이 문서가 필요하면 **별도 조준 빌드**가 답이다. `dossier/` 정본은 한 벌
> 뿐이라 조준부를 바꿔 재빌드해야 하고, 선례는 `../deepx--*/build.sh`(이력서 컷 +
> `experience-detail.md` → `pdfunite`) 다. **NEXT.md 에 남겼다.**
>
> ✅ **2026-08-09 — 그 별도 빌드가 나왔고, 이 건의 빈자리가 채워졌다.**
> `KimJunghan_Embedded_Experience_Detail.pdf`(3쪽, 영문, **회사 중립판**)를
> `Upload Additional Files` 칸에 낸다. 검증: `gs` 로 앞 6,000자를 읽어 **Telechips · Telit ·
> Bear Robotics · Sonatus 잔재 0건** 확인(2026-08-09). 정본은 임베디드 레인의
> `../telechips--embedded-sw-engineer/experience-detail.md` 한 벌이고, 이 폴더의 것은 **사본**이다.
> ⚠ **AX 축 2종을 붙이지 않는다는 07-30 판정은 그대로 살아 있다** — 바뀐 것은 *「임베디드 축에
> 낼 물건이 생겼다」* 이지 *「AX 문서를 붙여도 된다」* 가 아니다.

## ✅ 폼 스키마 — 브라우저 실측 (2026-08-09, 읽기 전용 · Step 1 만)

지원 URL `https://recruiting.paylocity.com/Recruiting/jobs/Apply/4158364` · **로그인 불필요** ·
**3단계 위저드** (`Step 1 of 3`). 폼 상단에 `Edge AI Software Engineer` · `Seoul, KOR` 이
그대로 떠 있어 **공고가 살아 있는 것을 지원 폼 자체로 확인**했다(`alive.py` 는 Paylocity 어댑터가
없어 「미판정」으로 낸다 — 이 실측이 그 자리를 메운다).

⚠ 법인 표기가 두 개다 — 공고 상세는 `TELIT IOT PLATFORMS LLC`, 지원 폼은 **`TELIT IOT SOLUTIONS, INC`**.

| 구역 | 칸 | 필수 | 값 |
|---|---|---|---|
| 🔴 상단 | `Apply with resume` / `Fill out application with my resume` | — | **피할 수 없다 — 아래 §자동 파싱** |
| Information | First Name / Last Name | ✅ | Junghan / Kim |
| Information | Middle Name · Preferred First Name | 선택 | 비움 |
| Information | Email Address | ✅ | [email removed] |
| Information | Mobile Number (국제번호는 `+82…` 형식) | 선택 | GLG 직접 (Git 미보존) |
| Information | Home Phone Number | 선택 | 비움 |
| Information | **`We may use SMS during the hiring process. Do you give us permission to text you?`** | ✅ | ✅ **Yes** (GLG 확정 2026-08-09 — 채용 관련 문자 수신 가능) |
| 주소 | **Country** — 기본값이 **`United States`** | — | 🔴 **반드시 `Korea` 로 바꾼다.** 그대로 두면 State/Zip 이 미국식으로 강제된다 |
| 주소 | Address Line 1/2 · City · County · State · Zip | 상황따라 | GLG 직접 (Git 미보존) |
| 기타 | `How did you hear about us?` | 선택 | **`Online Job Board`** (LinkedIn 경유가 사실이다) |
| 기타 | `Referred by` | 선택 | 비움 |
| 기타 | `Skills` | 선택 | GLG 판단 |
| ✅ 첨부 | **`Upload Additional Files` — `Select File(s)` · 10MB 제한** | 선택 | **`submit/KimJunghan_Embedded_Experience_Detail.pdf`** (3쪽 · 30KB) |
| — | `Next Step` → **Step 2 · 3 은 미실측** | — | 1단계를 넘겨야 보인다 |

- ⭐ **이 칸의 계보** — 아침엔 **「슬롯 있음 · 낼 물건 없음」**이었다(07-30 판정은 *「칸이 없다」*가
  아니라 *「Embedded 컷에 AX 축 깊이 문서를 붙이지 않는다」*였다). 같은 날 임베디드 축 중립
  깊이 문서가 나오면서 **「슬롯 있음 · 낼 물건 있음」**이 됐다. **판정이 뒤집힌 게 아니라
  재고가 생긴 것이다.**
### 🔴 자동 파싱 — 「Autofill 을 쓰지 않는다」는 선택지가 아니었다 (2026-08-09 실측)

**이력서를 슬롯에 올리는 것만으로 Paylocity 가 PDF 를 파싱해 칸을 채운다.**
`Fill out application with my resume` 버튼을 누르지 않았는데도 채워졌다 —
**업로드가 곧 파싱이다.** 이 건에서 채워진 것:

| 칸 | 자동으로 들어간 값 | 판정 |
|---|---|---|
| `info.firstName` / `info.lastName` | `Junghan` / `Kim` | ✅ 정확 |
| `info.email` | [email removed] | ✅ 정확 |
| `public-site-address-city` | `Suwon` | ✅ 정확 (`FAQ.md` §1 거주지) |
| `Skills` | 이력서 Core Competencies 3줄(Embedded Linux and Firmware / IoT Protocols / Portability and Productization) | ✅ 이력서 원문 그대로 |
| `public-site-address-country` | **비어 있다** | 🔴 **`Korea` 를 직접 넣는다** |

이 건은 **이력서에 이미 적힌 공개 값만** 채워져 결과가 맞았다. **그래도 눈으로 확인한다** —
아래가 그 이유다.

> 🚨 **다른 레인 사고 (2026-08-09, Bear Robotics 제출에서 잡힘).** 자동 파싱이
> **구조화 경력을 잘못 채웠다** — 현직을 퇴사 처리·분할, IITP 국가 R&D 와 교환연구를
> **고용으로 오인**, NEMO-UX **준비기간을 재직으로 신고**, 실제 재직 하나 누락.
>
> ⭐ **그래서 계약은 이것이다 — 자동 입력된 구조화 경력·학력은 「값」이 아니라 「초안」이다.**
> GLG 승인 전에 **`hyundai-autoever--ai-agent-engineer/submit/KimJunghan_AutoEver_Detail_Form.md`
> 스냅샷 + `FAQ.md` §3** 과 **한 줄씩** 대조한다. **재직 중인 회사의 종료일은 비운다.**
> 이 건 Step 1 에는 경력·학력 칸이 없었지만 **Step 2·3 은 미실측**이라 거기서 나오면 이 규칙을 편다.
> ⚠ **DOM 의 `required` 와 화면의 필수 표기를 같은 것으로 읽지 않는다.**

- ⚠ **쿠키 배너(`Accept All Cookies`)가 떠 있다.** 동의 항목이라 에이전트가 누르지 않았다 —
  GLG 가 판단한다(불필요 쿠키 거부가 기본 권장).
- ⚠ **Step 2·3 이 미실측이다.** 커버레터 칸·EEO 설문·서술형 질문이 거기 있을 수 있다.
  1단계를 실제로 넘기는 것은 GLG 세션에서 한다.

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
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

## 왜 이 직무였는가

**GLG 의 두 축 — 임베디드와 에이전트 — 이 한 자리에 같이 있는 드문 공고다.**

주요 업무 다섯 줄 중 마지막이 **「LLM 기반 Agent 프레임워크를 R&D 조직의 일상 개발
워크플로에 프로덕션 도입한다」**이다. **대부분의 임베디드 회사는 공고에 이 문장을 쓰지 않는다.**
그리고 이건 GLG 가 지금 회사에서 실제로 하고 있는 일이다 — 스킬 SSOT 하나를 다섯 개 하네스로
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
- [2026-08-09] 공고 상세 HTTP 200(마감·철회 문구 0건) + **지원 폼이 실제로 열리는 것**을 확인해
  생존을 닫았다. §폼 스키마에 Step 1 전체를 기록 — **Country 기본값이 United States** 이고
  **SMS 수신 동의가 필수**이며 **선택 첨부 칸이 존재**한다는 것이 새로 드러났다.
  Step 2·3 은 미실측.
- [2026-08-09] ✅ **제출 완료.** 완료 화면: `…/Recruiting/Jobs/Success/4158364` ·
  *"Your application has been received! Thank you for applying."*
  ⭐ **오늘 아침에 「슬롯 있음 · 낼 물건 없음」이던 칸이 같은 날 채워져 나갔다** —
  임베디드 레인이 중립 깊이 문서를 빌드했고, 이 건이 그 첫 사용처다.
  07-30 에 *「임베디드 축 깊이 문서가 필요하면 별도 조준 빌드가 답이다」* 라고 남긴 메모가
  **10일 만에 실행돼 같은 날 제출까지 갔다.**
