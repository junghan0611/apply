# 제출 기록 — Cohere / Forward Deployed Engineer, Agentic Platform (Korea)

| 항목 | 값 |
|---|---|
| 상태 | **ready — 보류** (준비 끝났으나 **이번 배치 아님**. 2026-07-28 GLG: 「지금 안 한다」) |
| 지원일 | — |
| 경로 | **Ashby** — 가입 불필요 (지원 URL HTTP 200 확인, 2026-07-28) |
| 첨부 컷 | **FDE** (`resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`, 3쪽) |
| 추가 첨부 | ⚠ **슬롯 미실측 — 폼에 선택 첨부칸이 있으면 올린다** · `dossier/build/KimJunghan_AX_Competency.pdf` (경력·역량기술서 5쪽) · `dossier/build/KimJunghan_AX_Portfolio.pdf` (포트폴리오 12쪽) |
| 공고 URL | https://jobs.ashbyhq.com/cohere/[uuid removed] |
| **지원 URL** | https://jobs.ashbyhq.com/cohere/[uuid removed]/application |
| 조직 | `Modeling` / `Applied-ML` (Ashby 보드 표기) · 제품은 **North** (엔터프라이즈 AI 워크스페이스) |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`)
- [ ] 커버레터 / 지원 동기 — Ashby 폼에 칸이 있으면 아래 §왜 이 직무였는가 를 영문으로 줄여 쓴다
- [ ] ⭐ **경력·역량기술서** `submit/KimJunghan_AX_Competency.pdf` (5쪽) ·
      **포트폴리오** `submit/KimJunghan_AX_Portfolio.pdf` (12쪽) — **세트에 깔려 있다.**
      `dossier/` 정본에서 2026-07-30 **회사 중립판으로 재빌드**했다(회사명 잔재 0건).
      ⚠ **이 폼의 선택 첨부 슬롯은 미실측이다.** 폼을 열어 칸이 있으면 **올린다.**
      칸이 하나면 **Portfolio 12쪽**을 올린다. 칸이 없으면 그냥 두고 면접에서 낸다.
      어제까지 이 자리는 「추가 서류 — 없음」이었는데, **그건 낼 물건이 없다는 뜻이었고
      폼에 칸이 없다는 확인이 아니었다** (2026-07-30 GLG: 「하나만 내기에는 성의가 없다」)

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** Enhans 에 낸 것과 **같은 FDE 컷**이라 파일명이
비슷하다. 올린 파일은 **그대로 `submit/` 에 복사**한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 어디에나 같은 값 | `FAQ.md` §3 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 최종 학력 | 석사 보유 → 「석사 이상?」 **Yes**, 「박사?」 **No** | `FAQ.md` §3 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |
| **영어 수준** (물으면) | 기술 문서·비동기 협업 능숙. 상시 회의 영어는 과장하지 않는다 | `FAQ.md` §6 |
| **출장 20–40% 수용?** | ⚠ **비율만 GLG 확정 필요.** 출장 자체는 ✅ 가능으로 닫혔다(2026-07-29, `FAQ.md` §4). 남은 것은 **20–40% 라는 폭**을 받아들일지다 | 이 건에서 새로 생긴 질문 |

> 사전에 없던 질문은 여기 적고 **`FAQ.md` 에도 추가한다.**
> Ashby 는 서술형 칸이 회사마다 다르다. 실제 폼을 열어 확인하고 이 표를 채운다.

## 왜 이 직무였는가

Cohere 는 한국 자리가 여럿 열려 있지 않다. **요구 문장이 GLG 가 실제로 판 것을 그대로 부르기
때문에** 골랐다 — 「LLM 에이전트를 설계·구축·**평가**하고, 툴·API·데이터 소스를 엮은 다단계
워크플로(ReAct)를 **실패 처리까지 포함해** 프로덕션 등급으로 만든다」.

- **에이전트 오케스트레이션 · 툴 실행 · 실패 처리** — 매일 굴리는 멀티 에이전트 세트가 증거다.
  데모가 아니라 **운영 중인 흐름**이고, 실패 처리와 재개가 그 흐름의 핵심이었다.
- **평가(eval) 축** — 공고가 「성공·실패·회귀를 재는 기준을 정의하고 적용한다」를 명시한다.
  회귀 검사를 붙여 도구를 고쳐 온 이력이 그 자리에 정확히 붙는다.
- **고객사 임베딩** — NEMO-UX 4년, 월패드 AAR 납품·PSIRT 대응. FDE 의 「고객 현장에 들어가
  모호한 문제를 풀 수 있는 문제로 바꾼다」가 이미 해 본 일이다.
- **경로가 싸다** — Ashby, 가입 불필요. 컷도 이미 있다(Enhans FDE 건에서 처음 쓴 그 컷).

**경계는 먼저 밝힌다.** 파인튜닝 실적은 없다. 규제 산업(금융·의료·통신) 경험도 없다.
「senior + 팀 단위 기술 리더십」은 조직 규모가 다르므로 부풀리지 않는다.
**영어·한국어 fluency 가 자격에 명시**돼 있어 영어 회의 부담은 실재한다 — GLG 판단 자리다.

## 이후 기록

- [2026-07-28] 건 생성. Ashby posting-api 로 **본문 원문 채집**(브라우저 없이).
  게시 2026-01-28 · `FullTime` · `isListed=true` 확인. 지원 URL HTTP 200 확인.
  컷 **FDE** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
- [2026-07-28] **보류.** GLG 판단 — 외국계 두 건(Cohere · OpenAI)은 이번 배치에서 뺀다.
  더 현실적인 곳부터 낸다. 준비물은 그대로 살아 있으니 되살릴 때 이 파일부터 읽는다.
