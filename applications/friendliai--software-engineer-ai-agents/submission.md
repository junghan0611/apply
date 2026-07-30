# 제출 기록 — FriendliAI (프렌들리AI) / Software Engineer – AI Agents

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **Ashby** (가입 불필요) |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 추가 첨부 | ⚠ **슬롯 미실측 — 폼에 선택 첨부칸이 있으면 올린다** · `dossier/build/KimJunghan_AX_Competency.pdf` (경력·역량기술서 5쪽) · `dossier/build/KimJunghan_AX_Portfolio.pdf` (포트폴리오 12쪽) |
| 공고 URL | https://jobs.ashbyhq.com/friendliai/[uuid removed] |
| **지원 URL** | https://jobs.ashbyhq.com/friendliai/[uuid removed]/application (HTTP 200 확인) |
| 근무지 | **Seoul** · FullTime · 게시 2026-03-24 |
| 회사 | 추론 플랫폼. HuggingFace 와 직접 연동해 **50만+ 오픈소스 모델**을 서빙한다 |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4401175991/`)와 같은 공고다.** 본문이 동일하고
LinkedIn 쪽은 offsite 라 **Ashby 원본으로 낸다.**

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] 커버레터 — Ashby 는 건마다 칸이 다르다. **칸이 있으면** 아래 §왜 이 직무였는가 를 줄여 쓴다
- [ ] ⭐ **경력·역량기술서** `submit/KimJunghan_AX_Competency.pdf` (5쪽) ·
      **포트폴리오** `submit/KimJunghan_AX_Portfolio.pdf` (12쪽) — **세트에 깔려 있다.**
      `dossier/` 정본에서 2026-07-30 **회사 중립판으로 재빌드**했다(회사명 잔재 0건).
      ⚠ **Ashby 는 폼 정의를 페이지에서 못 읽는다.** 열어서 선택 첨부 칸이 있으면 **올린다.**
      칸이 하나면 **Portfolio 12쪽**. 없으면 그냥 두고 면접에서 낸다
      (2026-07-30 GLG: 「하나만 내기에는 성의가 없다」)

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** FuriosaAI · Lunit · 42dot · Upstage 와 **같은 AI Engineer 컷**이다.

> 🔴 **폼 마지막 단계에서 「선택 첨부 관련 동의」가 있는지 눈으로 확인한다** (2026-07-30 GPT 교차검수 R3).
> 리포 안의 증거로는 이 폼에 그 동의가 있는지 **확정할 수 없다** — `docsInfo` ·
> `additionalApplicantInfoConfig` 는 개인정보 동의 UI 를 증명하지 않는다. Lunit 은 실측으로
> 「(선택) 추가 지원 서류 수집 동의」가 있었고 한화비전에는 「선택항목 수집 동의」가 있다.
> **「없다」고 추론하지 않는다** — 미동의로 내면 올린 첨부가 처리되지 않는다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `3+ years` 를 여유 있게 통과 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 — 요건 `Bachelor's or Master's` 통과 | `FAQ.md` §3 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 영어 | 서울 자리이나 본사 축이 샌프란시스코다 — 문서·비동기는 문제없음 | `FAQ.md` §6 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

## 왜 이 직무였는가

**서울 8건 중 이 자리가 정면이다.** 우대 항목 세 줄이 동시에 걸린다 —
**`Built or contributed to agent frameworks, SDKs, or CLIs`** ·
**`Passion for developer experience and enabling AI adoption`** ·
**`Experience with document understanding pipelines (OCR, RAG, structured extraction)`**.
이 조합이 걸리는 자리는 이번 배치에서 여기와 마키나락스뿐이다.

- **`agent API 와 reference application 을 만든다`** — 만든 것을 공개 저장소와 문서로 같이
  내는 것이 기존 방식이다. 「레퍼런스 구현 + 문서」가 **부산물이 아니라 산출물**이었다.
- **`document understanding`** — `memex-kb` 가 **HWPX · 스캔 PDF · EPUB · Org · 오피스**를
  오간다. 하이브리드 검색(벡터 + FTS) 색인은 직접 만들어 매일 운영한다.
- **`startup / fast-paced with ownership and ambiguity`** — 창업 4년(실패 포함),
  개발자 12명 조직에서 에이전트 축을 혼자 세웠다.

**같은 보드의 `Software Engineer – Python Developer Tools` 는 열지 않았다** — SDK·CLI 오너십과
DevEx 로 서사가 겹치지만 **Python 순도**(프로덕션 라이브러리 3년 · monorepo · asyncio/typing/
packaging · gRPC)를 정면으로 묻는다. 그쪽은 경계가 더 크다. **한 회사에 하나** 원칙대로 골랐다.

**경계는 먼저 밝힌다.** **Python 이 제1 언어가 아니다** — 축은 Go · Elisp · Nix · C 다.
**HuggingFace · LangChain · LlamaIndex 를 「써 온 사람」이 아니라 같은 문제를 직접 만들어 푼
사람**이다. 프레임워크 사용 경력으로 포장하지 않는다. **Kubernetes 프로덕션 경험이 없다.**
**추론 엔진·GPU 커널은 이 회사의 본진이지만 GLG 의 축이 아니다.**

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜬 뒤,
  **Ashby 보드(18건)에서 같은 공고를 찾아 원본 경로로 바꿨다.**
- [2026-07-28] 컷 **AI Engineer** 확정. 지원 URL HTTP 200 확인. 상태 `ready` — **제출 대기**.
