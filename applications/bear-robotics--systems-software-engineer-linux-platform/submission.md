# 제출 기록 — Bear Robotics (베어로보틱스) / Systems Software Engineer (Linux Platform)

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **Breezy HR** (`bear-robotics.breezy.hr`) — **이 저장소에서 처음 만나는 ATS** |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) |
| 공고 URL | https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform |
| **지원 URL** | **https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform/apply** (HTTP 200 확인) |
| 근무지 | **Seoul, Korea** · 보고 라인 **Principal Software Engineer (USA)** |
| 회사 | 서빙로봇 20여개국 **2만대** · AMR · 한 공간 **1,000대 군집제어** · 200명+ ·
  **2025-05 LG전자 계열회사 편입** |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4411324046/`)와 같은 공고다.** offsite 라 Breezy 원본으로 낸다.

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`)
- [ ] 커버레터 — Breezy 는 보통 「Cover Letter」 칸이 있다. 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다

> **⚠ 공고 첫 줄이 `English CV must be submitted.` 다.** `resume/build/` 의 여섯 컷이 **전부 영문**이라
> 그대로 통과한다. **한글 서류를 만들지 않는다.**

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** Telechips · DEEPX BSP 건과 **같은 Embedded 컷**이다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `1년 이상` 을 크게 넘는다 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 — 요건은 학사다 | `FAQ.md` §3 |
| 영어 | 필수 항목이다(`비즈니스 영어 커뮤니케이션`). 보고 라인이 **미국**이다 | `FAQ.md` §6 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

## 왜 이 직무였는가

**이번 배치에서 필수 요건을 가장 여유 있게 통과하는 건이다.** 필수가 **Python/Go 시스템 데몬 ·
Bash 자동화 · 리눅스 시스템 · 경력 1년+** 다 — 전부 대는 축이고, **우대 여덟 줄 중 다섯이 직접
걸린다.**

- **`모바일·데스크탑 리눅스 시스템 구축 또는 커스터마이징`** — NEMO-UX 에서 **대형 터치
  디스플레이용 리눅스 기반 OS 를 직접 만들었다**(창업 4년). 지금은 NixOS 로 4대 머신을 선언형 구축.
- **`Debian/Ubuntu, Arch 등 패키지 배포·관리`** — Nix 로 매일 한다. 설치 시 **`vcs_revision` ·
  소스트리 다이제스트 · 바이너리 SHA-256** 을 기록해 **무엇이 깔렸는지 되짚을 수 있게** 만들었다.
- **`오픈소스 프로젝트 기여 또는 관리`** — 외부 저장소에 머지된 PR(ghostel #343 · #510).
- **`로봇 인증체계 개발·운영 및 접근정책 관리`** — **mTLS 브로커 + AWS IoT 이중 백엔드**를 설계했다.
- **`로봇 소프트웨어 배포·관리 인프라`** — ARM Linux · Yocto · static musl · board HAL.
  **실리콘부터 양산까지 한 번 끝까지 간** 이력이 그대로 붙는다.

**회사 규모 기준도 통과한다** — LG전자 계열, 200명+, 20개국 2만대. **위로 찌르는 기본값**에 맞다.

**경계는 먼저 밝힌다.** **Terraform 등 IaC 툴체인 실적이 없다**(우대) — 선언적 인프라는 Nix 로 댄다.
**로봇/ROS 경험이 없다** — 다만 이 자리는 자율주행 알고리즘이 아니라 **로봇을 떠받치는 리눅스
플랫폼·배포·인증 인프라**다. **리눅스 보안 인프라를 직무로 해 본 적은 없다.**
**영어 상시 회의 축은 확인이 필요하다**(`FAQ.md` §6).

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **exa-search 로 Breezy 원본 공고를 찾아** 지원 URL(HTTP 200)까지 확인했다.
- [2026-07-28] 컷 **Embedded** 확정. 상태 `ready` — **제출 대기**.
