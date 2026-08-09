# 제출 기록 — Cohere / Forward Deployed Engineer, Agentic Platform (Korea)

| 항목 | 값 |
|---|---|
| 상태 | ✅ **submitted** — 2026-08-09 GLG 가 브라우저에서 최종 제출 완료 (**07-28 보류가 풀렸다**) |
| 지원일 | **2026-08-09** |
| 경로 | **Ashby** — 가입 불필요 (지원 URL HTTP 200 확인, 2026-07-28) |
| 첨부 컷 | **FDE** (`resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`, 3쪽) |
| 추가 첨부 | ⛔ **없다 — 폼 실측 완료 (2026-08-09).** 파일 슬롯이 `Resume` 하나뿐이다. 세트의 Competency·Portfolio 는 **낼 칸이 없어** 면접용으로 남긴다 |
| 공고 URL | https://jobs.ashbyhq.com/cohere/[uuid removed] |
| **지원 URL** | https://jobs.ashbyhq.com/cohere/[uuid removed]/application |
| 조직 | `Modeling` / `Applied-ML` (Ashby 보드 표기) · 제품은 **North** (엔터프라이즈 AI 워크스페이스) |
| 🔴 근무 형태 | **`Location Type: Remote`** — **제출 화면에서 처음 보였다** (2026-08-09). 07-28 에 채집한 posting-api 본문에도, 지원 폼 상단에도 없던 필드다. 원격이면 공고의 **출장 20–40%** 가 「사무실 대신 현장」이라는 뜻일 수 있다 — **면접에서 확인할 질문**이다 |

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Forward_Deployed_Engineer.pdf` (3쪽 · 33.3 kB)
- [x] **업로드·Submit 완료** (2026-08-09). 파일은 에이전트가 폼에 올렸고,
      **이름·전화·이메일·`Korean citizen` 답·최종 `Submit Application` 은 GLG** 가 했다.
      개인값은 저장하지 않는다.
- ⛔ **커버레터를 내지 못했다** — 폼에 서술형 칸이 없다(실측). §왜 이 직무였는가 는 면접용이다.
- ⛔ **경력·역량기술서 5쪽 · 포트폴리오 12쪽을 내지 못했다** — **파일 슬롯이 `Resume` 하나뿐**이다.
      07-30 에 세트로 깔아 두었던 두 문서는 **낼 칸이 없어** `stage.py` 가 세트에서 치웠다.
      **「준비했는데 못 냈다」가 이 건의 사실이다** — 면접에서 낸다.

**⚠ 업로드 직전 파일명을 눈으로 확인했다.** Enhans·Reflection·Wonderful 과 **같은 FDE 컷**이다.

## ✅ 폼 스키마 — 브라우저 실측 (2026-08-09, 읽기 전용)

지원 URL `…/[uuid removed]/application` · **로그인 불필요**

| 칸 | 필수 | 값 |
|---|---|---|
| `Autofill from resume` | — | 쓰지 않는다 |
| Name | ✅ | Junghan Kim |
| **Phone Number** | ✅ | GLG 직접 (Git 미보존) |
| Email | ✅ | [email removed] |
| Location | 선택 | Seoul, South Korea |
| LinkedIn | 선택 | GLG 판단 |
| **Resume** (파일 1개) | ✅ | `submit/KimJunghan_Resume_Forward_Deployed_Engineer.pdf` |
| **`I am a Korean citizen or permanent resident`** Yes/No | 선택 | **Yes** (`FAQ.md` §5 — 스폰서 불필요) |
| `Recruiting Privacy Policy` | — | 링크 · **동의는 GLG 가 읽고 판단** |
| reCAPTCHA | — | 폼에 붙어 있다 |

- ⛔ **서술형·커버레터 칸이 없다.** §왜 이 직무였는가 를 넣을 자리가 없다 — 이력서 한 장이 전부다.
- ✅ **출장 20–40% 를 폼이 묻지 않는다.** 공고 본문의 조건일 뿐이라 **제출을 막지 않는다.**
  비율 수용 여부는 **면접 단계 결정**으로 미룬다(`FAQ.md` §4 는 여전히 「비율 미확정」).
- ⛔ 희망연봉·입사가능일도 묻지 않는다.

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
| **출장 20–40% 수용?** | ⚠ 비율 미확정이나 **폼이 묻지 않는다**(2026-08-09 실측) — 제출을 막지 않고 **면접 질문으로 남는다**. 출장 자체는 ✅ 가능(2026-07-29, `FAQ.md` §4) | 이 건에서 새로 생긴 질문 |

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
- [2026-08-09] **보류를 푸는 판.** Ashby 보드에서 생존 확인(`isListed=true` · `FullTime` ·
  `location=Korea` · 게시일 2026-01-28 그대로). 폼을 실측해 **선택 첨부 슬롯이 없다는 것**과
  **출장 비율을 폼이 묻지 않는다는 것**을 확정했다.
- [2026-08-09] ✅ **제출 완료.** 완료 화면: *"Your application has been submitted! Thank you for
  your interest in a career growth opportunity at Cohere!"*
  **07-28 GLG 의 「외국계 두 건은 이번 배치에서 뺀다」 보류가 12일 만에 풀렸다** —
  근거는 *「서류통과도 잘 안 되고 있는데 따질 상황이 아니야」*(2026-08-09 GLG).
  ⭐ **그리고 그 판단이 옳았음이 폼에서 확인됐다** — 보류 사유였던 「외국계 부담」의 실체
  (출장 20–40% · 영어)를 **폼은 하나도 묻지 않았다.** 제출 비용은 이력서 한 장이었다.
  🔴 완료 화면에서 **`Location Type: Remote`** 를 처음 봤다 — §근무 형태 행에 기록.
