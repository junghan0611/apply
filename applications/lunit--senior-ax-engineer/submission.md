# 제출 기록 — Lunit (루닛) / (Seoul) Senior AX Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **Workable (자체 채용홈)** — 가입 불필요 (지원 URL HTTP 200 확인, 2026-07-28) |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 공고 URL | https://apply.workable.com/lunit/j/E3C22F589F/ |
| **지원 URL** | https://apply.workable.com/lunit/j/E3C22F589F/apply/ |
| 근무지 | 서울 강남구 강남대로 374 케이스퀘어 강남2 5층 — **강남역 3번 출구 도보 1분** |
| 팀 | Lunit OS Engineering (전사 500명이 쓰는 운영 인프라) |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] **경력기술서** — ⚠ **공고가 「이력서 및 경력 기술서」를 요구한다.**
      Workable 폼은 이력서 외 첨부칸이 있으면 따로 올리고, **한 파일만 받으면 통합본을 만든다**.
      DEEPX 건에 통합 PDF 를 만드는 `build.sh` 선례가 있다
      (`../deepx--ai-agent-workflow-automation-engineer/build.sh` — 이력서 컷 + 경력기술서 → `pdfunite`).
      **폼을 연 뒤 어느 쪽인지 정한다.** 통합본이 필요하면 이 폴더에 `build.sh` 를 복제해 만든다.
- [ ] 커버레터 — 칸이 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** FuriosaAI 건과 **같은 AI Engineer 컷**이다.
올린 파일은 **그대로 `submit/` 에 복사**한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 공고 요건 `풀스택 6년 이상` 통과 | `FAQ.md` §3 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 한국어 | 모국어 — 공고가 `Korean proficiency` 를 명시적으로 요구한다 | `FAQ.md` §6 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** — 공고는 `면접 후 결정` | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**
> **Workable 은 이 저장소에서 처음 쓰는 ATS 다.** 폼 구조를 열어 본 뒤
> `INBOX.md` §지원 경로 표와 `applications/AGENTS.md` §외부 ATS 에 추가한다.

## 왜 이 직무였는가

**오늘 본 공고 중 적합도가 가장 높다.** 이 자리는 「AI 를 쓰는 개발자」도, 「의료 AI 연구자」도
아니고 — **조직이 매일 쓰는 에이전트 플랫폼을 짓는 사람**을 찾는다. 요구 항목이 GLG 가 이미
만들어 굴리고 있는 것과 한 줄씩 대응한다.

- `플랫폼 SDK & CLI — 누구든 10분 안에 워크플로우 앱을 Scaffolding` ↔ 하나의 ID 축으로 말이
  통하는 CLI 한 벌과, **스킬 규격으로 새 작업면을 찍어내는 구조**. 이게 정확히 「내가 만든 것을
  남이 쉽게 쓰게 설계하는 플랫폼 사고」다.
- `정책을 실시간 인용하며 24/7 답변하는 도메인 에이전트` ↔ 하이브리드 검색(벡터+FTS) 위에
  **출처를 인용해 답하는 기억 축**을 올려 매일 운영 중이다.
- `Central Data Layer — OLAP + Vector DB + Graph DB` ↔ LanceDB 임베딩 색인과 재현 가능한 파이프라인.
- `Slack·Confluence·Jira·M365 통합 커넥터` ↔ 그 도구들을 **에이전트 도구면으로 붙여 쓰는 세트**.
- `Claude Code, Codex 를 일상 업무에 쓰며 가능성과 한계를 체득` ↔ **매일 쓰는 축**이고,
  한계를 문서로 남겨 온 것이 그대로 증거다.
- `AX 프로젝트 리딩 — 스펙을 받아 구현한 게 아니라 문제를 직접 정의` ↔ 도구 대부분이
  「내 불편 → 직접 정의 → 도구화 → 공개」 순서로 나왔다.
- `전사 자동화 문화 확산(가이드·교육)` ↔ 공개 디지털 가든에 수년치 가이드가 쌓여 있다.

그리고 **지역이 강남역 3번 출구 도보 1분**이다 — 통근 기준을 가장 편하게 통과하는 자리다.

**경계는 먼저 밝힌다.** 의료·헬스케어 도메인 경험이 없다(우대 항목). **Web UI 축이 백엔드보다
얇다** — `백엔드 API 설계부터 Web UI 구현까지 풀스택 6년 이상` 요건에서 부풀리지 않고
「시스템·백엔드가 두껍고 UI 는 필요한 만큼」으로 답한다. K8s/GCP 대규모 마이크로서비스 운영과
멀티 테넌트 아키텍처도 강한 축이 아니다.

## 이후 기록

- [2026-07-28] GLG 지목으로 건 생성. LinkedIn `4426954164` 에서 본문 원문 채집.
- [2026-07-28] **지원 경로 정정 — LinkedIn Easy Apply 가 아니라 Workable 이 원본이다.**
  루닛 한국 채용은 `apply.workable.com/lunit`(21건). Workable API 로 `published_on 2026-06-12` ·
  `Full-time` · `telecommuting=false` 확인. 지원 URL HTTP 200 확인.
- [2026-07-28] 컷 **AI Engineer** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
  ⚠ 남은 결정 하나: **경력기술서를 따로 올릴지 통합본으로 만들지** — 폼을 열어 보고 정한다.
