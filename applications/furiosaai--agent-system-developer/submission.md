# 제출 기록 — FuriosaAI / Agent System Developer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 저녁 제출**) |
| 지원일 | — |
| 경로 | **Ashby** — 가입 불필요 |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 공고 URL | https://jobs.ashbyhq.com/furiosa-ai/[uuid removed] |
| **지원 URL** | https://jobs.ashbyhq.com/furiosa-ai/[uuid removed]/application |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] 커버레터 / 지원 동기 — Ashby 폼에 있으면 아래 §왜 이 회사인가 를 쓴다. 필수 아니면 생략 가능
- [ ] 추가 서류 — 없음

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** ATS 에 저장된 기본 파일이 다른 타깃 문서를 가리킬 수
있다 (`AGENTS.md` §산출물 안전). 올린 파일은 **그대로 `submit/` 에 복사**한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 어디에나 같은 값 | `FAQ.md` §3 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 최종 학력 · 「석사 이상?」 | 석사 보유 → **Yes**. 「박사 보유?」는 **No**(수료는 학위가 아니다) | `FAQ.md` §3 |
| 연락처 · 병역 등 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**
> Ashby 는 서술형 칸이 회사마다 다르다. 실제 폼을 열어 확인하고 이 표를 채운다.

## 왜 이 회사인가 (이 건의 글)

**Responsibilities 네 줄이 내가 이미 만든 것과 1:1로 겹친다.** 이 자리는 「AI 를 쓰는 개발자」가
아니라 **에이전트 런타임을 만드는 사람**을 찾는다 — orchestration, context management, tool
execution, memory abstraction, 그리고 CLI·SDK.

- **orchestration**: `entwurf` — 하네스마다 다른 경계를 지키며 세션을 띄우고, 수명과 재개를 관리한다.
- **context management · memory abstraction**: `andenken` — LanceDB 하이브리드 검색 위에
  세션·가든을 임베딩하고, `semantic-memory`·`session-recap` 으로 **기억을 API 로 추상화**했다.
- **developer-facing interface**: `denotecli`·`dictcli`·`gitcli`·`bibcli`·`lifetract`·`voscli` —
  전부 Denote ID 한 축으로 말이 통하는 CLI 한 벌이다. 데모가 아니라 매일 쓰는 도구다.

그리고 팀의 목적이 「**엔지니어링 조직의 업무 효율화**」다. 그건 내가 회사에서 실제로 해 온
축이다 — 운영 데이터를 다루는 `voscli`·`incidentcli` 를 실무에 넣었고, 에이전트가 조직 안에서
돌아가게 만드는 쪽에 시간을 썼다.

**경계는 먼저 밝힌다.** 모델 설계·학습은 내 축이 아니다. NPU·컴파일러 도메인도 인접이지 보유가
아니다. 내가 대는 것은 **에이전트 시스템을 만들고 운영해 온 증거**이고, 그건 공개 저장소에서
바로 열어 볼 수 있다.

## 이후 기록

- [2026-07-28] 건 생성. 지원 경로 확인 — **Ashby**(`jobs.ashbyhq.com/furiosa-ai/...`), 가입 불필요.
  회사 채용페이지 `furiosa.ai/careers/software-agentsystem` 이 Ashby 로 넘긴다.
- [2026-07-28] 컷 **AI Engineer** 확정. JD 대조·경계를 `JD.md` §판단에 기록. 상태 `ready`.
  **GLG 저녁 제출 대기** — 개인·법적 값과 최종 Submit 은 GLG 몫이다.
