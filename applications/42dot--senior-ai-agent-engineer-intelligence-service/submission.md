# 제출 기록 — 42dot / Senior AI Agent Engineer (Intelligence Service)

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **Ashby** — 가입 불필요 |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 공고 URL | https://jobs.ashbyhq.com/42dot/[uuid removed] |
| **지원 URL** | https://jobs.ashbyhq.com/42dot/[uuid removed]/application |
| 근무지 | **판교** (Software Dream Center) · 현대차그룹 |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] 커버레터 / 지원 동기 — Ashby 폼에 칸이 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다
- [ ] 추가 서류 — 없음

**⚠ FuriosaAI · Lunit 과 같은 AI Engineer 컷이다.** 업로드 직전 파일명을 눈으로 확인한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `7년 이상` 통과 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

> ⚠ **전형에 코딩·과제 테스트가 있다**(서류 → 코딩 테스트 → 1차 → 2차 → 처우).
> 42dot 은 전 직군이 코딩 테스트를 낀다. 서류가 통과하면 그 준비가 다음 일이다.

## 왜 이 직무였는가

**42dot 에 에이전트 축이 넷 열려 있고, 그중 연차와 증거가 함께 맞는 자리는 이것 하나다.**
GLG 가 먼저 짚은 것은 `On-device Agent Orchestration` 이었는데, 그 자리는 자격이
**`2~3년 이상`(석사 졸업예정 가능)** 이라 8년차에는 처우가 아래로 잡힌다. 반면 이 건은
**`7년 이상`** 을 요구하고, 요구 문장이 GLG 가 만든 것과 거의 1:1이다.

- `query understanding → planning → tool routing → retrieval → response generation` —
  매일 굴리는 에이전트 세트의 실제 구조다.
- **`eval 하니스, 회귀 테스트, A/B 실험 체계를 구축·운영`** — 이 줄이 결정적이다.
  도구마다 회귀 검사를 붙여 고쳐 온 습관이 그대로 직무 요건이다.
- `grounding, guardrail, fallback 으로 hallucination 방어` — 출처를 인용해 답하는 기억 축과
  실패 처리·재개가 그 자리에 붙는다.
- `초기 설계·구조화·표준화·운영 안정성 개선을 주도` — 저장소마다 규약을 세워 다음 사람이
  쓰게 만든 이력이 증거다.

**경계는 먼저 밝힌다.** `AWS·K8s·Helm·Kafka 대규모 서비스 운영`과 `production traffic 을 받는
백엔드 운영`은 약한 축이다. `LangGraph 등 프레임워크 경험`은 **쓴 쪽이 아니라 직접 만든 쪽**이라
그대로 말한다. 차량·음성 비서 도메인은 없다.

## 이후 기록

- [2026-07-28] **GLG 가 `On-device Agent Orchestration` 을 짚어 42dot 재검토가 시작됐다.**
  아침에 본 두 건(LLM Training·Embedded Build)이 하필 축 밖이었을 뿐, 보드에는 에이전트 축이
  넷 있었다. **회사를 판정하지 말고 자리를 판정한다** — `INBOX.md` §42dot 판정 정정.
- [2026-07-28] 컷 **AI Engineer** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
  ⚠ On-device 건으로 바꾸려면 이 건을 `closed` 로 하고 `464eb98e` 로 새 건을 연다(1분이면 된다).
