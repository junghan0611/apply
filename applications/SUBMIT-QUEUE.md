# SUBMIT-QUEUE — 제출 실행 시트 (2026-07-29 확정)

**낼 순서와 지원 URL 을 여기서 잡고, 폼을 채우기 전에 그 건의 `submission.md` 를 연다.**

- 이 표가 주는 것: **어느 순서로 · 어디로 · 무엇을 붙여서 · 무엇을 조심해서.**
- 이 표가 주지 **않는** 것: **폼 문항별 값.** 그건 각 건 `submission.md` 의
  §폼 스키마 · §폼에 답한 질문에 있다. **여기에 복제하지 않는다** — 두 곳에 두면 갈라진다.
- 파생 문서이고 **SSOT 는 `LEDGER.md` 와 각 건의 `submission.md`** 다. 어긋나면 그쪽이 맞다.

> 2026-07-29 GPT 교차검수 반영판. 「이 한 장이면 폼까지 다 채운다」는 앞 판의 주장은
> 사실이 아니었다 — Holiday 외에는 폼 값이 여기 없다. **범위를 정직하게 줄였다.**

- 상태 계보: `ready` **16** = **실행 14** + **보류 2**(Cohere · OpenAI).
- 공고 생존: `./alive.py` — **2026-07-29 06:00 KST 기준 18건 전부 열림, 닫힌 것 0.**
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

## 실행 14건

컷 경로는 전부 `resume/build/` 아래다. `_AI`=`KimJunghan_Resume_AI_Engineer.pdf` ·
`_FDE`=`..._Forward_Deployed_Engineer.pdf` · `_EMB`=`..._Embedded_Software_Engineer.pdf` ·
`_DEVEX`=`..._Developer_Experience_Engineer.pdf`

| # | 회사 | 컷 | 지원 URL | 폼 무게 · 주의 |
|---|---|---|---|---|
| 1 | **Holiday Robotics** 🤖 | `_FDE` + **커버레터** | `https://holiday-robotics.com/careers/forward-deployed-robotics-engineer/apply` | **가장 가볍다.** 로그인 없음. 필수는 이름·이메일 둘. **연봉·입사일 안 물음.** 커버레터는 `cover-letter.md` §붙여넣을 본문 **전체 복사** |
| 2 | **AIRS Medical** | `_DEVEX` | `https://airsmed.career.greetinghr.com/ko/o/216673` → 「지원하기」 | 그리팅. 우대가 `openclaw`·skill/hook/MCP 로 사람을 지목했다 |
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
| 13 | **Lunit** | `_AI` | `https://apply.workable.com/lunit/j/E3C22F589F/apply/` | Workable. ✅ **별도 첨부 슬롯 있음(Optional) — 통합본 불필요**(2026-07-29 실측). 이력서만으로 제출 가능. 경력기술서를 붙일지는 `submission.md` §경력기술서 판단 |
| 14 | **SOCAR** | `_DEVEX` | `https://socar.career.greetinghr.com/ko/o/220124` → 「지원하기」 | ⚠ **낼지 먼저 정한다** — 아래 §쏘카 |

## ⏸ 보류 2건 — 이번 배치 아님 (2026-07-28 GLG)

| 회사 | 컷 | 지원 URL | 상태 |
|---|---|---|---|
| **Cohere** 🌐 | `_FDE` | `https://jobs.ashbyhq.com/cohere/[uuid removed]/application` | 준비 끝 · **공고 열려 있음**(alive 확인) |
| **OpenAI** 🌐 | `_DEVEX` | `https://jobs.ashbyhq.com/openai/[uuid removed]/application` | 준비 끝 · **공고 열려 있음**(alive 확인) |

되살릴 때 **출장 수용 범위**를 먼저 정한다(Cohere 20–40% · OpenAI APAC 30%).

## 🚧 아직 못 내는 3건 — 각각 하나가 빈다

| 회사 | 컷 | 지원 URL (확정) | 남은 하나 |
|---|---|---|---|
| **Hanwha Vision** | `_AI` + 포트폴리오 | `https://hanwhavision.ninehire.site/job_posting/6NDP9uTE` | **포트폴리오 재편.** URL·폼·근무지(판교R&D센터)는 확정. 폼에 **서술형 칸이 없어** 포트폴리오가 유일한 발언이다. 축 셋은 `submission.md` §남은 하나. 지원경로 = **링크드인** |
| **NHN (2번째)** | `_AI` + 포트폴리오 | `https://careers.nhn.com/recruits/4370711607830110861` | **셋이다**: ① 포트폴리오를 이 건에 맞게 재편 → `submit/` ② 직무 맞춤 자기소개 ③ GLG 계정 로그인. ⚠ **「기본 지원서」가 재사용**되니 첫 건(2026-07-20) 제출 내용이 사후 변경되지 않는지 화면 확인 |
| **Upstage** ⭐ | `_AI` | `https://careers.upstage.ai/ko/o/194880` → 「지원하기」 | **필수 서술형 6문항이 전부 미작성.** 관문은 ①**제품 체험 평가**(10,000자 — 실제로 돌려 본 뒤). 나머지 ②업무 경험(1,000자) ③관심분야 선택 ④언어=**Python**(Go 없음) ⑤**합류 시점**(⚠GLG) ⑥지원 경로. 상세·평가 골격은 `submission.md` §관문 |

---

## ⚠ 제출 전에 GLG 가 정할 값

`FAQ.md` §4 가 아직 ⚠ 다. **실행 14건 중 이 값 없이 확실히 나가는 것은 1번 Holiday 뿐이다** —
그 폼이 묻지 않는 것을 실측했다. **AIRS 를 포함한 나머지는 폼을 열어야 안다**
(각 건 `submission.md` 의 §폼에 답한 질문에 ⚠ 로 표시돼 있다). 못 내는 3건 중에는
**한화비전**이 묻지 않는 것으로 실측됐고, **Upstage 는 「합류 시점」을 필수로 묻는다.**

| 값 | 상태 |
|---|---|
| 희망 연봉 | ⚠ 미정. 「면접 후 협의」로 둘 수 있으면 그렇게 |
| 입사 가능일 | ⚠ 미정. 재직 중 — 통상 「협의 가능」 또는 4주 이내 |
| 이직 사유 | ⚠ 미정 |
| 출장 수용 범위 | ⚠ 보류 2건을 되살릴 때 필요 |

**빈칸이 틀린 값보다 낫다.** 사전에 없는 값을 에이전트가 채우지 않는다(`AGENTS.md` §경계).

## ⚠ 쏘카 — 낼지 먼저 정한다 (2026-07-29 재검토)

본문을 다시 읽었더니 **필수 첫 줄이 「인프라·운영 또는 SRE/DBA 경력 5년 이상」**이고
Aurora MySQL · EKS/Karpenter · Terraform/OpenTofu 운영이 필수다. **DevEx 컷으로 덮이지 않는다.**

접점은 우대에 있다 — 「AI 도구(Claude Code 등)를 운영·인프라 작업에 깊이 통합」,
「Internal Developer Platform / 플랫폼-as-product 관점의 DevEx 개선」. 그러나 **필수 첫 줄이
축 밖인 구조는 카카오페이 FDE(첫 줄 Java/Kotlin 백엔드)와 같다.**

「위로 찌른다」 기조로 그냥 낼 수도 있다 — **GLG 판단이다.** 안 내기로 하면 `closed` + `_archive/`.

## ⭐ Holiday Robotics — 자리가 하나 늘었다

보드에 `Software Engineer: Test & Manufacturing Systems`(강남 · 정규직)가 새로 떴다.
*"tests at each production stage, HIL runs in the lab, and a build history that follows every
robot. You build those systems, and the tools operators use to run them."*

**24시간 aging-test 자동화 · 다중 허브 fan-out 실기기 검증 · 양산 이력**이 정면으로 걸린다.
다만 28명 회사에 두 경로로 들어가면 인상이 갈리고, 기본은 한 회사 한 자리다
(`AGENTS.md` §한 회사에 공고가 여러 개일 때). **FDE 로 간다는 판단을 유지**했다 — 바꿀지는 GLG.
