# 제출 기록 — Telechips (텔레칩스) / [판교 사옥] Embedded S/W Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **자체 채용홈** `careers.telechips.com` (ninehire 화이트라벨) — 가입 불필요 |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`, 2쪽) |
| 공고 URL | https://careers.telechips.com/job_posting/iSXmKnRT |
| **지원 URL** | https://careers.telechips.com/job_posting/iSXmKnRT/apply |
| 근무지 | **텔레칩스 판교사옥** — 경기 성남시 수정구 금토로80번길 27 |
| 조건 | 정규직 · 경력 **3~15년** · 마감 **상시** · 직군 `Automotive Embedded S/W` |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`)
- [ ] 커버레터 / 지원 동기 — 폼에 칸이 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다
- [ ] 추가 서류 — 폼을 열어 확인. **경력기술서를 따로 받으면** DEEPX BSP 건의 통합본 선례를 쓴다
      (`../deepx--linux-bsp-engineer/`)

**⚠ ninehire 는 파일 업로드를 에이전트가 못 한다.** Enhans 건에서 확인했다 — file input 이 DOM 에
없고 클립 버튼이 네이티브 대화상자를 연다. **GLG 가 직접 올린다.** 올린 파일은 `submit/` 에 복사.

> **⛔ dossier 깊이 문서(AX Competency · Portfolio)를 붙이지 않는다 (2026-07-30 판정).**
> 2026-07-30 에 AX·에이전트 축 11건에는 이 2종을 세트에 깔았지만 **이 건은 뺐다.**
> 이 건의 컷은 **Embedded** 이고, 두 문서는 AX 전환·에이전트 플랫폼 축으로 쓰인 글이다.
> 같은 판단이 이미 Bear Robotics 커버레터에 적혀 있다 — *「에이전트·하네스·MCP 서사를
> 붙이면 지원자가 무엇을 하는 사람인지 흐려진다」*. **첨부를 늘리는 것이 성의가 아니라,
> 그 자리에 맞는 것을 내는 것이 성의다.**
> → 임베디드 축의 깊이 문서가 필요하면 **별도 조준 빌드**가 답이다. `dossier/` 정본은 한 벌
> 뿐이라 조준부를 바꿔 재빌드해야 하고, 선례는 `../deepx--*/build.sh`(이력서 컷 +
> `experience-detail.md` → `pdfunite`) 다. **NEXT.md 에 남겼다.**

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| 연락처 | **GLG 직접 입력** (문서에 값 없음) | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `3~15년` 통과 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 — 요건 `학사 이상` 통과 | `FAQ.md` §3 |
| 병역·보훈·장애 등 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**
> ninehire 계열은 **서술형 칸이 거의 없다**(Enhans 실측). 이력서 한 장이 사실상 전부일 수 있다.

## 왜 이 직무였는가

**Telechips 채용홈에 82건이 걸려 있지만 실제로 열려 있는 것은 3건뿐이다** — 그중 GLG 축에
걸리는 것은 이 하나다(나머지 둘은 `SoC Design Engineer(경력)` · `BD & Marketing Manager`).
「한 회사 한 직무」 고민이 필요 없는 건이다.

- **자격 4줄 중 3줄이 정면이다** — bootloader/커널 드라이버, Linux 커널 디버깅, 보드 bring-up.
  공고는 그중 **2개 이상**만 요구한다.
- **DEEPX Linux BSP 건과 같은 증거 패키지**를 쓴다. 그 건에서 Embedded 컷과 경력기술서를 이미
  한 번 조준해 냈다 — 이 건은 그 축의 재사용이다.
- **판교사옥**이라 통근 기준을 통과한다(경기 성남시 수정구 금토로80번길 27).
- 팀 소개가 「지식을 keep 하지 않고 share 하는 팀」을 반복해서 말한다. **문서·전파 축을 그대로
  꺼낼 수 있는 자리**다 — `AGENTS.md` §직무 선택 3번.

**경계는 먼저 밝힌다.** Hypervisor·Virtual platform·SOC Emulator·ASPICE·ISDB-T 는 없다(전부 우대
항목이다). 팹리스의 **칩 검증·불량 분석**은 인접이지 보유가 아니다 — 대는 것은 BSP·드라이버·
보드 bring-up 이다.

## 이후 기록

- [2026-07-28] GLG 지목으로 건 생성. LinkedIn `4431589221` 에서 본문 원문 채집.
- [2026-07-28] **지원 경로 확정 — 자체 채용홈 `careers.telechips.com`(ninehire 화이트라벨)**.
  채용홈 82건을 전부 훑어 `closedAt`/마감일로 걸러 **열린 3건**을 확인했다.
  `status=in_progress` · 상시 마감 · 정규직 · 경력 3~15년 · 판교사옥. 지원 URL HTTP 200 확인.
- [2026-07-28] 컷 **Embedded** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
