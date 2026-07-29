# SUBMIT-QUEUE — 제출 실행 시트 (2026-07-29 확정)

**낼 순서와 지원 URL 을 여기서 잡고, 폼을 채우기 전에 그 건의 `submission.md` 를 연다.**

- 이 표가 주는 것: **어느 순서로 · 어디로 · 무엇을 붙여서 · 무엇을 조심해서.**
- 이 표가 주지 **않는** 것: **폼 문항별 값.** 그건 각 건 `submission.md` 의
  §폼 스키마 · §폼에 답한 질문에 있다. **여기에 복제하지 않는다** — 두 곳에 두면 갈라진다.
- 파생 문서이고 **SSOT 는 `LEDGER.md` 와 각 건의 `submission.md`** 다. 어긋나면 그쪽이 맞다.

> 2026-07-29 GPT 교차검수 반영판. 「이 한 장이면 폼까지 다 채운다」는 앞 판의 주장은
> 사실이 아니었다. **폼 값은 각 `submission.md` 가 정본**이고, 이 큐에는 실행에 필요한
> 순서·URL·첨부·주의만 둔다. Holiday/Lunit/SOCAR 는 폼 실측 요약도 함께 적었다.

- 상태 계보: `ready` **17** = **실행 15** + **보류 2**(Cohere · OpenAI). 한화비전은 11:00 합류했고, 11:46 GPT 재검수 보정판으로 갱신됐다.
- 공고 생존: `./alive.py` — **2026-07-29 06:36 KST 기준 19건 전부 열림, 닫힌 것 0.**
  **제출 당일 다시 돌린다.**
- 제출 순서는 아래 표 순서를 권한다(폼이 가벼운 것 → 무거운 것).

---

## 낼 때 매번 하는 것 (건마다 반복)

0. **그 건의 `submission.md` 를 연다** — §폼 스키마 · §폼에 답한 질문이 값의 정본이다
1. `./alive.py <회사이름 일부>` — 그 건이 아직 열려 있는지
2. 지원 URL 을 연다 → 아래 표의 **첨부**를 업로드
3. **파일명을 눈으로 확인한다** — 다른 건의 컷이 올라가는 사고가 가장 흔하다
4. 개인·법적 값 입력(생년월일·연락처·병역 등)은 **GLG 가 직접**. Git 에 남기지 않는다
5. Submit
6. 낸 뒤 **두 곳을 함께 닫는다**: `LEDGER.md` → `submitted` + 날짜 / 그 건 `submission.md` →
   `submitted` + 완료 문장. 올린 파일을 그 건 `submit/` 에 복사
7. `./check.py` 통과 확인

---

## 실행 15건

컷 경로는 전부 `resume/build/` 아래다. `_AI`=`KimJunghan_Resume_AI_Engineer.pdf` ·
`_FDE`=`..._Forward_Deployed_Engineer.pdf` · `_EMB`=`..._Embedded_Software_Engineer.pdf` ·
`_DEVEX`=`..._Developer_Experience_Engineer.pdf`

| # | 회사 | 컷 | 지원 URL | 폼 무게 · 주의 |
|---|---|---|---|---|
| 1 | **Holiday Robotics** 🤖 | `_FDE` + **커버레터** | `https://holiday-robotics.com/careers/forward-deployed-robotics-engineer/apply` | **가장 가볍다.** 로그인 없음. 필수는 이름·이메일 둘. **연봉·입사일 안 물음.** 커버레터는 `cover-letter.md` §붙여넣을 본문 **전체 복사**. ✅ `business travel` 은 GLG 확인으로 닫혔다(가능) |
| 2 | **AIRS Medical** | `_DEVEX` + **커버레터(조건부)** | `https://airsmed.career.greetinghr.com/ko/o/216673` → 「지원하기」 | 그리팅. 우대가 `openclaw`·skill/hook/MCP 로 사람을 지목했다. **국문 커버레터 초안 있음**(`submit/cover-letter.txt`, 1,710자) — ⚠ **칸 유무 미실측**. 있으면 붙이고, 없으면 1차 면접 답 골격으로 쓴다 |
| 3 | **Bear Robotics** | `_EMB` | `https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform/apply` | Breezy. **영문 CV 필수** — 여섯 컷 전부 영문이라 그대로 통과 |
| 4 | **Toss** | `_AI` | `https://toss.im/career/apply/basic/7646941003` | 토스 자체 폼 |
| 5 | **FriendliAI** | `_AI` | `https://jobs.ashbyhq.com/friendliai/[uuid removed]/application` | Ashby. 가입 불필요 |
| 6 | **Sonatus** 🌐 | `_EMB` | `https://www.linkedin.com/jobs/view/4380679251/` → **「간편 지원」** | Easy Apply 5단계. ⚠ **LinkedIn 저장 이력서가 기본 선택**이라 올릴 때 파일 확인 |
| 7 | **Telit Cinterion** 🌐 | `_EMB` | `https://recruiting.paylocity.com/Recruiting/jobs/Apply/4158364` | Paylocity |
| 8 | **Telechips** | `_EMB` | `https://careers.telechips.com/job_posting/iSXmKnRT/apply` | ninehire. ⚠ **에이전트가 파일 업로드 못 한다** — GLG 가 직접 |
| 9 | **FuriosaAI** | `_AI` | `https://jobs.ashbyhq.com/furiosa-ai/[uuid removed]/application` | Ashby |
| 10 | **42dot** | `_AI` | `https://jobs.ashbyhq.com/42dot/[uuid removed]/application` | Ashby. 전형에 **코딩 테스트** |
| 11 | **MakinaRocks** | `_FDE` | `https://makinarocks.career.greetinghr.com/ko/o/214041` → 「지원하기」 | 그리팅 |
| 12 | **Reflection AI** 🌐 | `_FDE` | `https://jobs.ashbyhq.com/reflectionai/[uuid removed]/application` | Ashby. `기술 리더십 2년+` 은 직함으로 없다 — **지어내지 않는다** |
| 13 | **Lunit** | `_AI` | `https://apply.workable.com/lunit/j/E3C22F589F/apply/` | Workable. ✅ **A(이력서만)로 닫혔다 (2026-07-29)** — 새 문서 작업 없이 나간다. 로그인 없음·한 화면. **연봉·입사일 안 물음**. ⚠ 이력서에서 연봉정보 삭제 확인 YES · **민감정보 동의 YES** |
| 14 | **SOCAR** | `_DEVEX` | `https://socar.career.greetinghr.com/ko/o/220124` → 「지원하기」 | ✅ **오늘 낸다 (2026-07-29 GLG 확정)**. 로그인 없음 · **서술형 0 · 부가정보 0** — 이름·이메일·연락처 + 이력서 하나면 끝. ⚠ `enableUrl:false`(URL 칸 없음) |
| **15** | **Hanwha Vision** | `_AI` + **포트폴리오** | `https://hanwhavision.ninehire.site/job_posting/6NDP9uTE` | ✅ **2026-07-29 11:46 GPT 재검수 보정판.** 포트폴리오 = `submit/KimJunghan_Hanwha_Portfolio.pdf` (18쪽). 서술형 칸 **없음**. ⚠ **「선택항목 수집 동의」 체크 필수** — 미동의 시 포트폴리오 미처리. ⚠ ninehire 는 **에이전트가 업로드 못 한다 — GLG 가 직접**. 지원경로 = **링크드인** |

## ⏸ 보류 2건 — 이번 배치 아님 (2026-07-28 GLG)

| 회사 | 컷 | 지원 URL | 상태 |
|---|---|---|---|
| **Cohere** 🌐 | `_FDE` | `https://jobs.ashbyhq.com/cohere/[uuid removed]/application` | 준비 끝 · **공고 열려 있음**(alive 확인) |
| **OpenAI** 🌐 | `_DEVEX` | `https://jobs.ashbyhq.com/openai/[uuid removed]/application` | 준비 끝 · **공고 열려 있음**(alive 확인) |

출장 자체는 ✅ 가능으로 닫혔다. 다만 이 둘은 **비율이 명시**돼 있어(Cohere 20–40% · OpenAI APAC 30%)
되살릴 때 그 폭을 받아들일지 따로 정한다.

## 🚧 아직 못 내는 2건 — 남은 관문이 있다

> **한화비전은 여기서 빠졌다** (2026-07-29 11:46 GPT 재검수 보정판). 노트북에서 `md2pdf.sh` 로 표지를 굽고,
> `dossier/` 앞 조준부까지 한화 축으로 최소 교체한 뒤 `gs` 합본까지 끝나 **실행 큐 15번**으로 올라갔다.

| 회사 | 컷 | 지원 URL (확정) | 남은 관문 |
|---|---|---|---|
| **NHN (2번째)** | `_AI` + 포트폴리오 | `https://careers.nhn.com/recruits/4370711607830110861` | **셋이다**: ① 포트폴리오를 이 건에 맞게 재편 → `submit/` ② 직무 맞춤 자기소개 ③ GLG 계정 로그인. ⚠ **「기본 지원서」가 재사용**되니 첫 건(2026-07-20) 제출 내용이 사후 변경되지 않는지 화면 확인 |
| **Upstage** ⭐ | `_AI` | `https://careers.upstage.ai/ko/o/194880` → 「지원하기」 | 필수 6문항 중 **5개 완료**(`answers.md`). 남은 관문은 **문항 1 제품 체험 평가** 하나 — Document Parse/Solar 를 실제로 돌린 뒤 작성. 문항 2 OCR 문단과 겹치면 `answers.md` 문항 2를 줄인다 |

---

## ✅ 제출 전에 정할 값 — **2026-07-29 확정됐다. 이제 폼 앞에서 멈추지 않는다**

`FAQ.md` §4 · §7 이 닫혔다. **11건이 물어도 답이 있다.**

| 값 | 확정 |
|---|---|
| **희망 연봉** | **「면접 후 협의」**. 숫자를 강제하는 폼에서만 GLG 가 그 자리에서 직접 입력 (GLG: *"연봉은 지금 고민 안 할 거야"*) |
| **입사 가능일** | **「협의 가능」**. 날짜 강제 시 **「최종 합격·처우 협의 후 4주 이내」** |
| **이직 사유** | **「개인의 기억·저자성·장기 협업에서 배운 에이전트 운영 방식을, 더 큰 조직의 데이터·거버넌스·워크플로로 옮기는 다음 경계를 찾고 있습니다」** (`resume/body.org` Summary 에서 나온 문장) |
| **출장 가능** | ✅ **가능** (GLG 확인 2026-07-29). Holiday 요건이 이 값으로 닫혔다. Cohere/OpenAI 보류 2건은 **비율이 명시**돼 있어(20–40% / APAC 30%) 되살릴 때 그 폭을 따로 본다 |

**에이전트가 숫자를 만들어 넣는 일은 없다.** 「기본값 + 강제 시 GLG 직접」 두 단이 계약이다.

### 확정 전 기록 — 판단 근거로만 보존 (현재값 아님)

아래 문단은 `FAQ.md` §4 가 닫히기 전의 판정이다. **현재 제출값은 위 표가 정본**이다.
다만 어떤 폼이 미정값을 묻지 않는지 확인한 근거라 보존한다.

`FAQ.md` §4 가 아직 ⚠ 이던 시점에 **실행 14건 중 이 값 없이 확실히 나가는 것은 셋** —
**1번 Holiday · 13번 Lunit · 14번 SOCAR.** 세 폼이 묻지 않는 것을 실측했다(SOCAR 는
2026-07-29 구조화 필드 전수 재실측: `questionnairesInfo=[]` · `additionalApplicantInfoConfig`
전 항목 `NOT_RECEIVED`. Lunit 은 브라우저 실측, 오히려 이력서에서 연봉정보를 **빼라**고 요구).

> **나머지 11건은 폼 미실측이다.** 2026-07-29 에 브라우저 없이 읽어 보려 했고, **그리팅
> 워크스페이스마다 되고 안 되고가 갈렸다**(AIRS·MakinaRocks 는 `docsInfo: null` 로 막힘,
> Ashby 4건은 폼 정의가 페이지에 없음). 판정표는 `INBOX.md` §브라우저 없이 폼까지 읽을 수
> 있는가. **못 읽은 폼을 「가벼울 것」으로 적지 않는다.**

**AIRS 를 포함한 나머지는 폼을 열어야 안다**는 판정도 그 시점의 폼 실측 범위에 대한 말이다.
값 자체는 이제 §4/§7 에서 닫혔다. 단, **숫자 연봉처럼 강제 입력이 나오면 GLG 직접 입력**이라는
계약은 그대로다.

## ✅ 쏘카 — 낸다로 닫혔다 (2026-07-29 GLG). 아래 경고는 사실로 보존한다

본문을 다시 읽었더니 **필수 첫 줄이 「인프라·운영 또는 SRE/DBA 경력 5년 이상」**이고
Aurora MySQL · EKS/Karpenter · Terraform/OpenTofu 운영이 필수다. **DevEx 컷으로 덮이지 않는다.**

접점은 우대에 있다 — 「AI 도구(Claude Code 등)를 운영·인프라 작업에 깊이 통합」,
「Internal Developer Platform / 플랫폼-as-product 관점의 DevEx 개선」. 그러나 **필수 첫 줄이
축 밖인 구조는 카카오페이 FDE(첫 줄 Java/Kotlin 백엔드)와 같다.**

「위로 찌른다」 기조로 그냥 낸다 — **2026-07-29 GLG 가 「오늘 낸다」로 확정했다.** 요건을 다르게
읽어서가 아니라, 필수 첫 줄을 직함으로 못 대는 것을 알고 내는 것이다. 위 간극은 지우지 않는다.

## ⭐ Holiday Robotics — 자리가 하나 늘었다

보드에 `Software Engineer: Test & Manufacturing Systems`(강남 · 정규직)가 새로 떴다.
*"tests at each production stage, HIL runs in the lab, and a build history that follows every
robot. You build those systems, and the tools operators use to run them."*

**24시간 aging-test 자동화 · 다중 허브 fan-out 실기기 검증 · 양산 이력**이 정면으로 걸린다.
다만 28명 회사에 두 경로로 들어가면 인상이 갈리고, 기본은 한 회사 한 자리다
(`AGENTS.md` §한 회사에 공고가 여러 개일 때). **FDE 로 간다는 판단을 유지**했다 — 바꿀지는 GLG.
