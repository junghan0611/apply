# 제출 기록 — Penguin Solutions (펭귄솔루션스) 🌐 / Sr. System Engineer

| 항목 | 값 |
|---|---|
| 상태 | **draft** — 자리는 열었다. **보류: 낼지는 GLG 판단** (아래 §판단) |
| 지원일 | — |
| 경로 | **자체 채용홈** (`careers.penguinsolutions.com`, SuccessFactors 계열) — **계정 생성 필요할 수 있음** |
| 첨부 컷 | **Embedded** 또는 **SWE** — **낸다고 정해지면 그때 확정한다** |
| 공고 URL | **https://careers.penguinsolutions.com/job/Seongnam-si-Sr_-System-Engineer-Gyeo-13529/1408533400/** — Requisition ID **2027** · 게시 2026-07-14 (2026-08-09 확인) |
| ⚠ 죽은 URL | ~~`…/Seongnam-si-System-Engineer-Gyeo-13529/1408533300/`~~ — 2026-08-09 **"Sorry, this position has been filled."** 로 바뀌었다. 아래 §이후 기록 |
| 근무지 | **성남시 · Hybrid (주 3일 출근)** |
| 회사 | **Nasdaq: PENG** · 실리콘밸리 본사 · 메모리와 AI/HPC 인프라 30년. **🌐 외국계** |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4440517726/`)와 같은 자리다.**
⚠ **연차 표기가 다르다** — LinkedIn `9+ years`, 자체 채용홈 `7+ years`(2026-07-14 게시).
**자체 채용홈이 최신일 가능성이 높다.** 폼을 열 때 다시 확인한다.

## 낸 것

- [ ] 이력서 PDF — **컷 미확정.** 낸다고 정해지면 Embedded/SWE 중 고른다

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 다만 **UNIX/Linux 서버 관리자 경력이 아니다**(§판단) | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 영어 | **고객 대면 직무**다. 상시 영어 소통이 상수 | `FAQ.md` §6 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

## 판단 — **이번 배치에서 적합도 최하위다**

**「만드는 자리」가 아니라 「운영하는 자리」다.** 공고의 동사가 전부 install · administer ·
patch · troubleshoot · respond · support 이고, **주간 온콜 로테이션**과 **ITIL/SLA** 가 직무의
상수다. GLG 가 반복해 온 축(만들어서 사람이 반복하지 않게 하기)과 **방향이 반대에 가깝다.**

**못 대는 것:** HPC 클러스터 운영 · **SLURM/PBS/LSF 스케줄러**(필수) · UNIX/Linux **sysadmin
직함 7~9년**(필수) · ITIL/SLA 운영 · RunAI/W&B/Grafana/Nagios · Supermicro/InfiniBand ·
데이터센터 운영.

**대는 카드는 하나가 확실히 강하다** — **`High-Performance Storage and Parallel file systems
used in HPC/AI`**(우대). 성균관대 분산컴퓨팅연구실 4년의 **NVM 파일시스템·NUMA 락** 연구가
정확히 거기 걸리고, **이 회사의 본진(메모리와 AI/HPC 인프라의 교차점)과 같은 주제**다.
GPU 클러스터 자체 구축(3× RTX 5080 · NixOS · 10G · 17 Docker 서비스)도 인접 증거다.

**그래서 자리는 열어 두되 `hold` 다.** 낼지는 GLG 가 정한다. 내기로 하면
**연구 축을 전면에 세우는 컷**이 필요하고, 그건 기존 여섯 컷 중에 없다 —
`resume/AGENTS.md` §「새 타깃 컷 만드는 법」으로 하나 뽑아야 한다.

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **exa-search 로 자체 채용홈 원본(HTTP 200)** 을 찾았다. **연차 표기 불일치를 확인.**
- [2026-07-28] 상태 **`hold`** — 적합도 최하위. **낼지 GLG 판단 대기.**
- [2026-08-09] ⭐ **GLG override — 임베디드/시스템 축을 이번에 실제로 낸다.** 07-28 의
  「적합도 최하위·방향이 반대에 가깝다」 판정은 **지우지 않는다** — 지금도 사실이다.
  바뀐 것은 판정이 아니라 GLG 의 결정이다(`AGENTS.md` §사람의 권한).
- [2026-08-09] 🔴 **기록된 공고 URL 이 죽었다 — 그러나 자리는 살아 있다.**
  `…/1408533300/` 이 *"Sorry, this position has been filled."* 를 띄운다. 회사 채용 검색
  (`careers.penguinsolutions.com/search/?locationsearch=Korea`)을 훑어 **같은 직무의 새 req**
  를 찾았다 — `Sr. System Engineer` · **Requisition ID 2027** · `…/1408533400/` ·
  게시 2026-07-14 · Seongnam-si, Gyeonggi-do 13529. 본문은 같은 계열이다(HPC 클러스터
  install/deploy/administer · **SLURM·RunAI·W&B 중 2개 이상** · Grafana 대시보드 ·
  **주간 온콜 로테이션** · SLA). **`Apply now »` 버튼이 살아 있다.**
  ⚠ **연차 표기 재확인은 폼을 열 때 한다** — 07-28 에 LinkedIn `9+` vs 채용홈 `7+` 불일치를
  적어 두었는데, 새 req 본문에서 아직 대조하지 않았다.
- [2026-08-09] **부수 발견 — 같은 성남 사이트에 `Sr. DevOps Engineer`(`…/1408532500/`) 가
  열려 있다.** 이 레인의 스코프 밖이라 손대지 않았고 GLG 에게 보고만 했다. 이 회사에서
  낼 자리를 다시 고른다면 후보다(`AGENTS.md` §한 회사에 공고가 여러 개일 때).
