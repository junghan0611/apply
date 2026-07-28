# 제출 기록 — Sonatus (소나투스) 🌐 / Staff DevOps Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **LinkedIn Easy Apply** — 이 배치에서 **유일하게 원클릭으로 끝나는 건** |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) |
| 공고 URL | https://www.linkedin.com/jobs/view/4380679251/ |
| **지원 URL** | **같은 페이지의 「간편 지원」** — Easy Apply 는 별도 URL 이 없다. 모달 5단계 (`../AGENTS.md` §브라우저 워크플로) |
| 근무지 | **Seoul, South Korea** · 정규직 |
| 회사 | 본사 **Sunnyvale, CA** · 250명+ · **차량 800만 대 이상 양산 탑재** · SDV 플랫폼. **🌐 외국계** |
| 팀 | **한국 사이트 — 전사 매출의 30%** 를 만드는 OEM 납품 축. 온프레미스 빌드·랩·테스트 환경 |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`)

> **⚠ LinkedIn 저장 이력서 주의.** `linkedin.com/jobs/application-settings/` 에 올려 둔 파일이
> **모든 Easy Apply 의 기본 선택**이 된다. 이 건에 Embedded 컷을 올리면 다음 Easy Apply 에
> 그게 딸려 나간다 (`applications/AGENTS.md` §브라우저 워크플로).

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** Bear Robotics · Telechips 와 **같은 Embedded 컷**이다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `8+ years in infrastructure, DevOps, or SRE` 는 **직함 기준으로는 못 댄다**(§경계) | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 한국어 | 모국어 — 우대 항목이다(`business conducted in both Korean and English`) | `FAQ.md` §6 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

> Easy Apply 4/5 의 「Additional Questions」에 **연차·비자·학위**가 나온다. 위 표의 값으로 답한다.
> **5/5 제출 버튼은 GLG 가 누른다.**

## 왜 이 직무였는가

**필수 8개 중 4개를 못 댄다. 그런데도 여는 이유는 둘이다.**

1. **LinkedIn Easy Apply 다.** 이 배치에서 **지원 비용이 가장 낮다.** 준비물이 이미 있는 상태에서
   내는 비용이 사실상 없다.
2. **우대 첫 줄이 정면이다** — **`Embedded systems build toolchains (Bazel, Yocto, CMake
   cross-compilation)`** 과 **`Hardware-in-the-loop / automotive test infrastructure`**.
   이 회사가 실제로 어려워하는 지점 — **빌드가 물리 하드웨어(ECU · 평가보드)와 만나는 곳** —
   은 GLG 가 양산에서 직접 통과한 자리다.

**컷을 Embedded 로 고른 이유가 여기 있다.** DevOps 컷은 없고, 이 자리에서 이길 수 있는 면은
스토리지·랙·Jenkins 가 아니라 **「빌드와 하드웨어가 만나는 곳」**이다. 서류가 붙으면 그 프레임으로 간다.

**경계는 크다. 먼저 밝힌다.**

- **DevOps/SRE 직함 8년이 없다**(필수 1).
- **Jenkins 대규모 운영 경험이 없다**(필수 4).
- **Terraform · Ansible 마이그레이션 실적이 없다**(필수 5). 공고가 「유지가 아니라 **마이그레이션**을
  해 봤는가」를 콕 집어 묻는다. **Nix 로 한 것은 같은 명제이지 같은 툴이 아니다.**
- **엔터프라이즈 스토리지(Pure Storage/NetApp) · SAN · 멀티사이트 복제 · 데이터센터 물리 운영이 없다**(필수 3·8).
- **대형 Groovy 코드베이스 · Kubernetes 경험이 없다.**

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 떴다.
  **지원 방식이 `easy`(Easy Apply)** 인 것을 확인했다.
- [2026-07-28] 컷 **Embedded** 확정. 상태 `ready` — **제출 대기**.
