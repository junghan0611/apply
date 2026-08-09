# Additional Information — OpenAI / Developer Experience Engineer (Seoul)

**어느 칸에 들어가는가**: Ashby 폼 하단 `Additional Information` (서술형, 선택).
칸이 묻는 것은 원문 그대로 **`Please share anything else you want us to know, such as your
motivation to apply or additional context for your application.`**

- 언어: **영문.** 폼·공고·붙일 이력서(DevEx 컷)가 전부 영문이다.
- 길이: 약 300단어. Holiday(385단어) 판과 같은 규격 — **동기 칸은 길게 쓰지 않는다.**
- ⛔ 성능·작업량 수치를 넣지 않는다 (`../FAQ.md` §원칙 4).
- 🔴 **경계 문단을 넣지 않았다** — 42dot 전례. 아래 §왜 이렇게 썼는가.

**⚠ GLG 승인 전 초안이다. 아직 어디에도 붙여넣지 않았다.**

---

## 붙여넣을 본문

The hardest part of developer experience is not the first API call. It is the second week, when
someone is building something real and the example no longer covers their case. That gap is where
I have spent my working life, and it is why I am applying.

I build agent tooling and then live inside it. One skill definition fans out to five different
agent harnesses; the memory layer that sits under them combines vector and full-text retrieval and
was split out as its own axis so no single harness owns it. These are not demos I assembled for a
portfolio. They are the tools I use to do my daily work, which means I hit the sharp edges the same
way a developer building on your API does, and I fix them because I have to.

Alongside that, I have written in Korean for the Korean developer community for years. My garden at
notes.junghanacs.com holds tutorials, concept notes, and failure write-ups published on a steady
rhythm, dated as they were written. Building demos, writing the tutorial, and standing in front of
the local community are three jobs in this posting; for me they have been one habit.

That is also why the Korean requirement reads differently to me than a language checkbox. Ecosystem
work in Korea is not translated documentation. It is knowing which questions Korean developers
actually ask first, and I have been answering those questions in public in Korean the whole time.

One signal from outside my own repositories: two patches I wrote to fix Korean and CJK input
composition were reviewed and merged into an Emacs terminal project I do not own
(github.com/dakra/ghostel, PR #343 and #510).

My work is public and dated: github.com/junghan0611, notes.junghanacs.com, ax.junghanacs.com.

---

## 왜 이렇게 썼는가

### 🔴 경계 문단을 넣지 않았다 — 42dot 전례를 따른다

에이전트 첫 초안(약 340단어)에는 경계 문단이 있었다 — *「Codex·OpenAI 플랫폼 위 공개 실적이
얇다」 · 「글에 비해 영상·발표가 적다」*. **뺐다.**

근거는 이 저장소에 이미 있다. 2026-07-30 **42dot `Motivation` 칸에서 GLG 가 제출 직전에 경계
문단을 직접 지웠고**, 거기서 규칙이 도출돼 `../FAQ.md` §9 에 올라갔다 —
**「경계 문단은 자유 서술 칸의 물건이고 동기 칸의 물건이 아니다.」**
못 하는 것을 적으면 **묻지 않은 답이 마지막 인상 자리를 차지한다.**

- 이 칸은 `motivation to apply or additional context` 를 묻는다. **묻는 것에만 답한다**
  (07-30 카페 계약 ③).
- **경계가 사라진 것이 아니다.** `submission.md` §왜 이 직무였는가 에 그대로 살아 있고
  (Codex 공개 실적 · 영상/발표 · 주 3일 상주), **면접에서 물으면 그때 답한다.**
- ⚠ 이 판단은 되물릴 수 있다. GLG 가 「경계를 쓰는 게 우리 방식」이라고 보면 마지막 문단 앞에
  두 문장으로 되살린다.

### 나머지 선택

- **첫 줄이 자기소개가 아니다.** Holiday 판의 방식 그대로 — 첫 문장이 **직무의 정의**여야 한다.
  「두 번째 주, 예제가 더 이상 안 맞을 때」는 DevEx 가 실제로 존재하는 이유이고, 공고의
  `from onboarding with Codex to first API call to production deployment` 를 되돌려준 문장이다.
- **「짓는다·쓴다·전파한다」를 세 직무가 아니라 한 습관으로 묶었다.** 공고가 셋을 따로 나열하는데,
  **그 셋이 한 사람 안에서 하나로 굴러간 것**이 이 지원의 유일한 차별점이다.
- **한국어 요건을 문단 하나로 승격했다.** 외국계 공고에서 한국어가 **가점으로 걸리는 드문 자리**다
  (`submission.md`). 「모국어입니다」로 끝내면 체크박스가 되므로,
  **「어떤 질문을 먼저 하는지 안다」**는 실질로 바꿨다.
- **제3자가 남긴 증거 한 줄** — 머지된 외부 PR 두 건. FuriosaAI 판과 같은 계약이다:
  스스로 주장한 강점이 아니라 **밖에서 확인된 것** 하나만 둔다.
- **좌표는 한 줄로 닫는다** (`../FAQ.md` §9 골격 5). **「봐 주세요」라고 쓰지 않는다.**
  이 폼은 파일 슬롯이 `Resume` 하나뿐이라 Competency·Portfolio 를 낼 칸이 없다 —
  **`ax.junghanacs.com` 이 그 자리를 대신한다.**

## 쓰지 않은 것 (의도)

- ⛔ **Codex·GPT-5.5 를 써 봤다고 말하지 않는다.** 공개 실적이 얇은 자리라 아는 척이 된다.
  대신 **모델 제공자에 묶이지 않은 에이전트 설계**로 선다.
- ⛔ 이력 전체를 요약하지 않는다. 이력서가 하는 일이다.
- ⛔ 묻지 않은 조건(연봉·입사일·출장 비율)을 먼저 꺼내지 않는다. 입사 가능일은 **폼의 전용
  칸**(`When can you start a new role?`)에서 답한다.
- ⛔ 자가 측정 수치 없음 — 「40+ 스킬」 「노트 N건」 류를 전부 뺐다.
