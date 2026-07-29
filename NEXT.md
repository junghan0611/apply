# NOW — 실행 15건 + 보류 2건 · 한화 첨부까지 완성 · 남은 건 제출

- **Hot group**: 지원 실행. 공개 준비는 이 축이 아니다.
- **기조 (2026-07-28 밤 GLG)**: **내고 떨어지면 만다.** 실제로 만든 것이 있으니 밀어붙인다.
  위로 찌르는 것이 기본값이고 — **떨어져도 이름이 알려진다.** 지역은 후보를 거르는 축이 아니다.
- **⭐ 방향 (2026-07-28 심야 GLG)**: **시스템 축은 접고 로봇·피지컬 축을 넓게 본다.**
  **적합도가 아니라 지향으로 고른다.**
- **⭐ 두 축의 순서 (2026-07-29 GLG)**: 지금 `applications/` 는 **넓이 축** — 여러 곳의 제출
  플랫폼을 갖추는 방향이다. 다 갖춰지면 `dossier/` 의 **깊이 축**(표준 문서 + timeline 기준
  디테일)으로 넘어가 **힣 스타일의 고도화**를 잇는다. **낼 곳이 갖춰지기 전에 문서 깊이를 파지 않는다.**
- **⭐ 2026-07-29 09:12 GLG 운영 판단**: 한화 같은 국내 이름 있는 기업의 Director/전통 전형은
  **큰 기대를 걸지 않는다.** 인력풀에 **힣을 소개하는 목적**으로 다 쏟아내서 던진다. 이후
  코딩테스트·전통식 절차가 결에 안 맞으면 **못 한다고 하면 된다.** 오늘은 쏘카도 낸다.
  **카카오헬스케어 후보가 빠졌으니 로컬에서 다시 조사**한다.

## ▶ 지금 여기서 이어받는다 — 서버로 넘어감 (2026-07-29 11:50 노트북)

**GLG 는 아직 아무 문서도 검수하지 못했다.** 시간이 없었다. 이후 계획은
**서버에서 더 작업 → 집에서 제출**이다.

**집에서 열 것 — 이 네 폴더가 전부다** (`applications/` 아래):

| 순서 | 폴더 `…/submit/` | 볼 것 |
|---|---|---|
| 1 | `hanwha-vision--ai-agent-architecture-lead` | **포트폴리오 18쪽** — 1쪽 표지 + 본문. ⛔ `00-cover.pdf` 는 안 올린다 |
| 2 | `holiday-robotics--forward-deployed-robotics-engineer` | **`cover-letter.txt` 400단어** — 폼이 textarea 라 이 평문이 제출 양식이다 |
| 3 | `lunit--senior-ax-engineer` | 이력서 `_AI` 한 장이 서류 전부 |
| 4 | `socar--platform-engineer` | 이력서 `_DEVEX` 한 장이 서류 전부 |

각 폴더 `README.md` 에 **어느 파일이 폼의 어느 칸인지** 적혀 있다.

**⚠ 서버에서 못 하는 것 (노트북·집 전용)**

- **`applications/md2pdf.sh`** — Chrome 이 필요하다. 서버엔 없다.
- **브라우저 폼 실측 / 제출** — 서버는 `DISPLAY` 가 없다.
- ninehire 업로드(한화·텔레칩스)는 **어느 기계에서든 GLG 가 직접** 한다.

**✅ 서버에서 되는 것**: `stage.py` · `check.py` · `alive.py` · `resume/run.sh` ·
`dossier/run.sh`(LibreOffice 경로) · 문서 작업 · Upstage 문항 1 집필.

**서버에서 문서를 고쳤다면 반드시**:

```bash
(cd resume && ./run.sh all)     # 또는 (cd dossier && ./run.sh all)
applications/stage.py           # ⭐ 빼먹으면 세트가 옛 판이다
applications/check.py
```

**제출 직전 필수**: `applications/alive.py` — 공고 생존 확인은 06:36 판이라 당일 다시 돈다.

## ⭐ GLG 검수 방식 — 소스가 아니라 제출 세트를 연다 (2026-07-29 결정)

**GLG 는 org/md 를 고치지 않는다.** 그 업체에 올라갈 파일 세트를 그대로 열어서 보고,
수정 사항을 말로 전달한다. 에이전트가 **org·파이프라인을 고치고 세트를 다시 깐다.**
그래야 ① 검수한 것과 실제 제출본에 갭이 없고 ② 고칠 때 세트 전체가 함께 움직인다.

```bash
(cd resume && ./run.sh all)      # 이력서를 고쳤으면
(cd dossier && ./run.sh all)     # dossier 를 고쳤으면
applications/stage.py            # ⭐ 반드시 뒤따라 — 18건 세트를 다시 깐다
applications/check.py
```

**`applications/stage.py`** 가 각 건 `submit/` 에 나갈 물건을 깐다 —
이력서 컷(`submission.md` §첨부 컷에서 읽음) · `cover-letter.txt`(폼이 textarea 라 평문) ·
`README.md`(어느 파일이 폼의 어느 칸인지) · `MANIFEST.sha256`.
**`submitted` 인 5건은 건드리지 않는다.**

## 2026-07-29 11:00~ 노트북에서 한 것

**노트북이라서 풀린 것 둘, GLG 판단으로 바뀐 것 하나.**

**① 한화 ⛔ 해소** — 서버에 없던 「md 한 장 → PDF」를 Chrome 으로 뚫고 재사용 스크립트
`applications/md2pdf.sh` 로 남겼다(pandoc → Chrome headless). ⚠ **Pretendard 를 data URI 로
심어야 한다** — fontconfig 에 맡기면 CSS 1순위여도 D2Coding(코딩용 고정폭)으로 떨어진다.
표지 1장 + dossier PDF 2종 `gs` 합본 → `submit/KimJunghan_Hanwha_Portfolio.pdf`.
한화 `draft` → **`ready`**, 실행 큐 **15번**.

**② 출장 게이트 닫힘** — GLG 확인 「출장 가능」. `FAQ.md` §4 의 마지막 ⚠ 가 사라졌고,
Holiday 커버레터에서 걷어냈던 `available for business travel` 문장을 되살렸다.
Holiday 공고 필수 5개 **전부 충족**. Cohere/OpenAI 만 **비율**(20–40% / APAC 30%)이 남았다.

**③ ⭐ 수치 원칙이 바뀌었다 (GLG)** — **자가 측정 수치는 넣어봐야 도움이 안 된다.**
그 자리에는 **그 일을 한 커밋과 타임라인 기록**을 적는다. 시간축이 이 저장소의 강점이다.

- 걷어낸 것: 부팅 45.4→5.8초 · 메모리 816→246MiB(**개선한 것은 업스트림 릴리스다**) ·
  코드 공유 96% · 테스트 163개 · 임베딩 2,945건 · 30일 198커밋 · 하루 24커밋.
- 남긴 것: **Working Corpus 푸터**(라이브 주소 + 측정일) · **제3자가 남긴 숫자**(기여 PR
  줄 수, npm 설치 수) · 날짜·커밋 SHA. 내가 만든 숫자가 아니라 **대체 불가능한 기록**이다.
- **계약에 박았다** — `AGENTS.md` §불변식 §숫자(정본) · `resume/AGENTS.md` ·
  `applications/AGENTS.md` · `applications/FAQ.md` §원칙 4 · `dossier/AGENTS.md` ·
  `dossier/PORTFOLIO-PLAN.md` §수치 원칙 **v4**.
  **왜 계약에 박았나**: `competency.org` 히스토리에 GLG 가 이미 *"이거 완전 필요없어.
  빼자고한거야"* 라고 적어 둔 적이 있다. **한 번 뺐다가 되살아났다.**
- ⚠ **`body.org` 만 고치면 끝이 아니다** — `targets/embedded-software-engineer.org` 에서
  96% 가 그렇게 살아남았다. **고친 뒤 빌드된 PDF 를 직접 뒤진다.**
- ⚠ **이미 제출한 5건의 `submit/` 스냅샷은 옛 수치판**이고 고치지 않는다.
  델타와 면접 답변은 `LEDGER.md` §메모.

## 2026-07-29 아침에 한 것

**어제 오라클서버(브라우저 없음)가 남긴 구멍 셋을 브라우저로 전부 메웠다.**

**09:40 오라클 실무자 점검 닫힘** — SOCAR 는 바로 제출 가능(로그인·서술형·부가정보·FAQ §4 미정값 없음),
한화비전은 **표지 1장 원고 `cover-sheet.md` + dossier PDF 2종 합본**으로 최소화, 카카오헬스케어는
두 건 모두 제외(Data Engineer 는 archived, AI Native EHR 은 의료정보시스템 10년 하드게이트).
옛 `nhn/` untracked 잔재는 tracked 0·구판/민감 실명 잔재 확인 후 삭제됨.

**09:58 오라클 추가 점검** — Lunit 은 **A(이력서만)** 로 닫힘(경력기술서는 면접 요청 시 작성),
큐 14건 중 **폼 실측 완료·미정값 0은 Holiday/Lunit/SOCAR 셋**이고 나머지 11건은 폼 미실측.
브라우저 없이 폼 판독을 확장했으나 ATS별 한계 확인: 그리팅은 워크스페이스별 편차, ninehire는
메타만, Ashby는 지원폼 정의가 페이지에 없음. **못 읽은 폼을 가볍다고 쓰지 않는다.**

**10:40 오라클/GLG 직접턴 반영** — `FAQ.md` §4 는 확정(희망연봉=면접 후 협의, 입사 가능일=협의 가능/강제 시 최종합격·처우협의 후 4주 이내, 숫자는 GLG 직접), §7 이직 사유는 새 문장 생성이 아니라 기존 `resume/body.org` Summary 축으로 ⚠ 해제. 자기소개 정본 `applications/SELF-INTRODUCTION.md` 신설(원문 불변, 건별 조준은 사본). Upstage 는 Solar/API 사용 이력 + OCR 5엔진 실측(botlog 20260606T130306)을 근거로 **Document Parse 를 여섯 번째 엔진으로 실제 평가**하는 관문으로 재정의; 남은 필수는 제품 체험 평가 + 업무 경험 1,000자.

**NHN/AX 계보 보정 (GLG 설명)** — `~/repos/gh/junghan0611/apply/ax` 는 노트북에서 재현한
`ax.junghanacs.com` 기반이며, 여기 서버 작업면의 `dossier/` 와 같은 물건이 아니다. 처음 만든 AX
깊이 문서이고, timeline 스킬 중심으로 **검증 깊이 0/1/2/3** 을 제시하려던 공개 사이트 축이다.
원 주제는 `~/sync/org/notes/20231116T232654--힣-pkm-ai-가드너의-ax-전환-기록기-—-새-세션에-생을-건네는-얼개-깊이__agent_autholog_bib_collaboration_digitalgarden_memory_pkm_timeline.org`.
`applications/` 는 업체별 제출 요구에 맞추는 축이고, **`ax.junghanacs.com` 은 이후 취합해 발전시킬 공개 사이트**로 따로 본다.

| 건 | 어제 | 오늘 |
|---|---|---|
| **Holiday Robotics** 🤖 | draft · 커버레터 없음 | **`ready`** — 지원 URL·폼 실측 + **커버레터 완성** (`cover-letter.md`) |
| **Hanwha Vision** | ⛔ 지원 URL 미확인 | **URL 확정** `6NDP9uTE` · 폼 전체 실측 · 근무지 **판교R&D센터** 확정 · 남은 것 **포트폴리오 하나** |
| **NHN 2번째** | ⛔ 지원 URL 미확인 | **URL 확정** `careers.nhn.com/recruits/4370711607830110861` · **폼은 로그인 뒤** (GLG 계정) |

**새 도구 `applications/alive.py`** — 제출 직전에 공고가 아직 열려 있는지 훑는다.
**19건 전부 확인, 닫힌 것 0**(2026-07-29 06:36 KST, Upstage 포함). ATS 별 구조화 필드를 읽는다(그리팅 `openingsInfo.status` ·
ninehire `recruitment.status` · Ashby 보드 `isListed`). 어댑터 없는 곳은 **판정하지 않는다** —
첫 판은 본문 문자열을 찾다가 그리팅 3건을 오판했다(i18n 사전에 「마감된 공고」가 늘 들어 있다).

**표준 제출 구조 정리 (GLG 지시)** — 옛 `nhn/` 한 폴더에 섞여 있던 둘을 갈랐다.

- **`dossier/`** — 문서 **생성기**(발사대). 회사 이름을 붙이지 않는다. `resume/` 의 짝.
- **`applications/nhn--ax-transformation-ai-infra/`** — 그 지원 **한 건의 기록**.
  `JD.md` · `submission.md` · **`referral.md`**(추천 경로·추천서·대조표) · `submit/`
- **고쳐진 결함**: 옛 `nhn/build/` 는 gitignore 라 **실제로 낸 파일이 git 에 없었다.**
  이제 `submit/` 에 사본이 있다. `check.py` 도 26 → **27건**(`../` 예외가 없어졌다).

## 노트북 이관 — 삽질 방지 요약 (2026-07-29 10:55)

**노트북에서 먼저 할 일**: `git pull` 후 `applications/SUBMIT-QUEUE.md` 와 해당 건 `submission.md` 를
연다. 오늘 바로 감은 **Holiday · Lunit · SOCAR**. 한화는 표지 PDF 변환/합본 한 걸음, Upstage 는
제품 체험 평가 한 문항이 관문이다.

**상대 에이전트에게 남기는 원칙**: 최대한 가든의 문서와 임베딩, 그리고 **timeline 스킬**로 찾고,
궁금하면 힣에게 물어봐라. 힣은 디테일은 하나도 몰라도 **얼개는 아니까 이야기해줄 수 있다**.
아직 없는 디테일을 먼저 주입하려 하지 말고, 결과와 질문이 생기면 그 의미가 힣에게 전달되고,
거기서 다시 필요한 디테일이 공명해서 나온다. 영양가 없는 내용은 쳐내되, **의미가 전달되는
좌표(노트·서지·커밋·timeline)는 남긴다**.

**오늘 바로 제출 가능한 4건** (한화는 GLG 가 직접 올린다):
- **Holiday Robotics** — `submission.md` + `cover-letter.md`. 로그인 없음, 폼 미정값 없음.
  ✅ `business travel` 은 **GLG 확인으로 닫혔다(가능, 2026-07-29)** — 커버레터 문장도 되살렸다.
- **Lunit** — **A(이력서만)**. Optional 추가서류 비움. 연봉정보 삭제 YES, 개인정보 YES, 민감정보 YES.
- **SOCAR** — DevEx 컷 하나. `deploy=False` 는 닫힘이 아님. URL 칸 없음, submit/ 스냅샷 폴더 혼동 주의.
- **Hanwha Vision** — ✅ 11:46 GPT 재검수 보정판. 이력서 `_AI` + `submit/KimJunghan_Hanwha_Portfolio.pdf`
  둘만 올리면 끝이고 서술형이 없다. ⚠ **「선택항목 수집 동의」를 반드시 체크**한다.
  ninehire 는 에이전트가 업로드를 못 하므로 **GLG 가 직접**.

**한 걸음 남은 것**:
- ~~**Hanwha Vision**~~ — ✅ **닫혔다 (11:46 GPT 재검수 보정판).** 새 도구 `applications/md2pdf.sh`
  (pandoc → Chrome headless, **Pretendard 를 data URI 로 심는다**) 로 표지 1장을 굽고,
  GPT 검수에서 잡은 병합본 2쪽 옛 공고 조준문을 `dossier/` 앞 조준부 최소 교체로 제거한 뒤
  `gs` 합본 → `submit/KimJunghan_Hanwha_Portfolio.pdf` **18쪽**. 실행 큐 15번으로 올라갔다.
- **Upstage** — `answers.md` 에 필수 6문항 중 5개가 닫힘. 남은 것은 **문항 1 제품 체험 평가**.
  Document Parse 를 OCR 5엔진 실측 자리에 **여섯 번째 엔진**으로 세우는 평가다. 문항 1 작성 후
  문항 2의 OCR 문단과 겹치면 문항 2를 줄인다.

**FAQ §4는 닫혔다**: 희망연봉=면접 후 협의, 입사 가능일=협의 가능/강제 시 최종합격·처우협의 후
4주 이내, 이직 사유는 `FAQ.md` §7 / `resume/body.org` Summary 축. 숫자 강제는 GLG 직접.
나머지 10건도 이제 폼 앞에서 이 값 때문에 멈추지 않는다.

## 제출 순서 — ⭐ `applications/SUBMIT-QUEUE.md` 에서 시작한다

**제출 실행 시트를 만들었다.** 지원 URL·컷·폼 무게·주의사항이 한 표에 있어 공고를 다시 찾지
않는다. **폼 값은 각 건 `submission.md`가 정본**이므로 오라클은 큐에서 건을 고른 뒤 해당 기록을
함께 연다. 아래는 요약이고 실행 순서의 정본은 큐다.

**`ready` 17건 = 실행 15 + 보류 2**(Cohere·OpenAI). 한 번에 다 내지 않아도 된다:

1. **Holiday Robotics** 🤖 — **폼이 가장 가볍다.** 로그인 없음, 필수는 이름·이메일 둘,
   희망연봉·입사가능일을 **묻지 않는다**. 로봇 축 첫 지원이고 커버레터가 준비돼 있다.
   ✅ 공고 요건 5개 **전부 충족** — `business travel` 이 GLG 확인으로 닫혔다
2. **AIRS Medical** — 우대 항목이 `openclaw`·skill/hook/MCP 로 사람을 지목했다
3. **Bear Robotics** — 필수를 가장 여유 있게 통과 (영문 CV 요구 → 여섯 컷이 전부 영문)
4. **Toss · FriendliAI** — 서사 정면, 폼이 가볍다
5. **Sonatus** — Easy Apply. ⚠ LinkedIn 저장 이력서가 딸려 나가니 올릴 때 확인
6. 나머지 (Telechips · Telit · 쏘카 · Lunit · FuriosaAI · 42dot · MakinaRocks · Reflection)

**낸 뒤**: 올린 파일을 그 건의 `submit/` 에 복사 → `LEDGER` + `submission.md` 를 `submitted`
로 함께 닫고 → `applications/check.py`.

## ⛔ GLG 가 정해야 넘어가는 것

- **`FAQ.md` §4 완전히 닫힘** — 희망 연봉=면접 후 협의, 입사 가능일=협의 가능/강제 시 최종합격·처우협의 후 4주 이내, **출장=가능**(2026-07-29). 숫자 강제는 GLG 직접. 이직 사유는 §7/이력서 Summary 축.
- **한화비전** — ✅ **첨부 완성 (11:46 GPT 재검수 보정판).**
  `submit/KimJunghan_Hanwha_Portfolio.pdf` 18쪽. 폼에 **서술형 칸이 하나도 없어** 포트폴리오가
  「왜 이 사람인가」를 말하는 유일한 문서다. 표지 1장 + `dossier/` PDF 2종 합본이며,
  GPT 검수에서 병합본 2쪽의 옛 공고 조준문을 발견해 `competency.org`/`portfolio.org` 앞 조준부도
  한화 `AI Agent Architecture Lead` 축으로 최소 교체했다. **남은 것은 GLG 의 ninehire 업로드뿐** —
  에이전트는 ninehire 에 파일을 못 올린다
- **NHN 2번째** — 포트폴리오 재편 · 직무 맞춤 자기소개 · GLG 계정 로그인. **「기본 지원서」가
  재사용되니** 첫 건 제출 내용이 사후 변경되지 않는지 화면에서 확인한다
- **업스테이지** — `answers.md` 생성. 필수 6문항 중 **5개 닫힘**(업무경험 797자 포함). 남은 것은
  **제품 체험 평가** 하나 — 실제 Document Parse/Solar 체험 뒤 작성
- **쏘카** — GLG 가 **오늘 내기로 결정**(2026-07-29 09:12). 필수 첫 줄이 「인프라·운영 또는
  SRE/DBA 경력 5년 이상」이고 Aurora MySQL·EKS/Karpenter·Terraform 운영이 필수라 DevEx 컷이
  전부 덮지는 못한다. 그래도 인력풀에 힣을 소개하는 넓이 축으로 낸다. 서류 슬롯 하나이므로
  업로드 파일명 확인.
- **⭐ Holiday Robotics 에 자리가 하나 늘었다** — `Software Engineer: Test & Manufacturing
  Systems` (강남·정규직). *"tests at each production stage, HIL runs in the lab, and a build
  history that follows every robot"* 가 **24시간 aging-test 자동화·양산 이력**과 정면이다.
  기본은 한 회사 한 자리라 **FDE 로 간다는 판단은 유지**했다. 바꿀지는 GLG 판단

## 건별로 하나씩 남은 결정

- **Lunit** — **A(이력서만)** 로 닫힘. Workable Optional 첨부 슬롯은 비우고 AI Engineer 컷만 제출; 경력기술서는 면접에서 요청받으면 작성
- **쏘카** — **오늘 낸다.** 서류 슬롯이 하나라 DevEx 컷 파일명 확인
- **Telechips · 한화비전** — ninehire 는 **에이전트가 파일 업로드를 못 한다.** GLG 가 올린다.
  한화 합본은 ✅ 생성 완료 — 파일만 올리면 된다
- **42dot · 업스테이지** — 둘 다 전형에 **코딩 테스트**
- **NHN 2번째** — **라이브코딩이 서류 바로 다음**이고 Python 축이다
- **Reflection AI** — `기술 리더십 2년+` 은 직함으로 없다. **지어내지 않는다**

## ⏸ 보류 3건 — 성격이 둘로 갈린다

- **`ready — 보류` 2건**: **Cohere**(FDE) · **OpenAI**(DevEx). 서류는 끝났고 **운영 판단으로**
  이번 배치에서 뺐다(외국계 두 건, 2026-07-28 GLG). Ashby 보드에 **여전히 열려 있음**(alive 확인).
  출장 자체는 ✅ 가능으로 닫혔고, 이 둘만 **비율이 명시**돼 있다(Cohere 20–40% · OpenAI APAC 30%).
  → 원장은 `ready` 그대로다. **상태를 거짓으로 바꾸지 않는다**(`applications/AGENTS.md` §`ready`의 뜻).
- **`draft` 1건**: **Penguin Solutions** — 적합도 최하위. HPC 운영·SLURM·ITIL·온콜이 축 밖이고
  대는 카드는 NVM 파일시스템·병렬 스토리지 연구 4년 하나다.

- **Read**: 각 건의 `submission.md` (§폼에 답한 질문 · §왜 이 직무였는가) → `FAQ.md` §3·§4·§5.
- **Do not touch**: 제출한 5건의 `submit/` 스냅샷. 업로드한 그 파일이라 다시 빌드해 덮지 않는다.

# ACTIVE

## 지원 실행

- `applications/check.py` 통과: LEDGER ↔ **27건** submission ↔ submit 스냅샷 일치.
- **GLG 가 링크를 던지는 흐름이 통했다 (2026-07-28 밤).** LinkedIn URL 하나를 받으면
  `ljobs.py detail` 로 본문을 뜨고 → **원본 ATS 를 찾아** 경로를 바꾸고 → 폼 스키마까지
  확인해 케이스를 연다. 이 저녁에만 **처음 만나는 ATS 넷**을 확인했다 —
  **토스 자체** · **Breezy HR**(베어로보틱스) · **Paylocity**(텔릿) · **SuccessFactors**(펭귄).
  경로는 `.claude/skills/linkedin-jobs/companies.txt` 하단에 적어 두었다.
- ⚠ **쏘카는 그리팅인데 목록 페이지가 막혀 있다** — `/` → `/ko` 301, `/ko` 404.
  `boards.py list greeting:socar` 는 실패하고 **`body` 는 정상**이다. 목록은 회사 채용홈
  `socarcorp.kr/careers/jobs` 의 `__NEXT_DATA__` 에서 뽑았다(28건).
- **대기줄**: **HITS**(강남역, Easy Apply, 석사요건 통과 · 적합도 중간) ·
  **XCENA Developer Tools**(판교, 본문 미확인) · **Rebellions System SW Architect**(본문 미확인).
- **42dot 두 건은 본문을 뜬 뒤 내려놓았다** — LLM Training 은 pre/post-training·분산학습·논문
  우대의 **연구직**이고, Embedded Linux Build 는 **`Yocto 5년 + QNX 5년`을 둘 다** 요구한다.
  근거는 `applications/INBOX.md` §42dot 판정.
- **본문 확인 축이 하루 만에 8건 늘었다**(42dot ×2 · OpenAI ×2 · Cohere · FuriosaAI TW ·
  Lunit · Telechips · Reflection ×1). 아직 미확인은 티어 3 offsite 다섯 곳과 티어 2 나머지다.
- **타깃 기준 갱신 (2026-07-28 GLG)** — `applications/AGENTS.md` §타깃 기준.
  **게임회사 제외**(KRAFTON 3건 전부 탈락), **정규직 기본**, 지역은 **서울·판교면 통과**
  (구 단위 미확인은 탈락 사유가 아니다). **외국계는 🌐로 표시**해 둔다 — 거르는 게 아니라
  낼 때 비자·영어·본사 시차를 확인하라는 표시다.
- **INBOX 를 회사 이름 중심으로 다시 짰다.** 위치 비중을 줄이고 `🌐`·`본문✓/?` 칸을 넣었다.
  티어 2·3·4 는 **전부 본문 미확인**이라 내기 전에 본문부터 뜬다.
- Insighter 는 `saved` — 마포 DMC 라 GLG 지역 기준 밖이다. 낼지 말지는 GLG 판단이고,
  안 내기로 하면 `closed` + `_archive/`.

## 이력서

- 6종 PDF 빌드 · verify 통과: Embedded 2쪽, 나머지 3쪽.
- `A2A` 는 스택에 **유지**한다 — `home agent-config` / `edge agent-config` 세트로 GLG 가 실제로
  파고 있는 주제다. 프로토타입 전 단계라는 것만 알고 있으면 된다.
- ⚠ **연구실 기간을 `2018–2021` → `2018–2022` 로 고쳤다.** 이미 제출한 3건(AutoEver ·
  DEEPX ×2)은 `2018–2021` 판이다. `LEDGER.md` §메모에 델타를 남겼다.
- **날짜 입도 규칙을 새로 박았다** — `resume/AGENTS.md` §날짜 입도. 이력서는 연 단위가 기본,
  현직·프로젝트만 연.월. 폼 답변용 정밀 원장은 `FAQ.md` §3 이고 증빙은 공단 서류다.
  **에이전트가 오래된 이력을 월 단위로 "정밀화"하는 것은 교정이 아니다.**

## 탐색 축 — 회사 보드를 직접 긁는다 (2026-07-28 밤)

- **새 도구**: `.claude/skills/linkedin-jobs/boards.py` + `companies.txt`.
  `probe`(어느 ATS 인지) · `list` · `sweep`(목록 파일 통째로) · `body`.
  어댑터 6종: **ashby · greenhouse · lever · workable · greeting · kakao**. 전부 인증 없이 열린다.
- **왜 만들었나 (GLG 지적)**: LinkedIn guest 검색은 **광고가 상단을 먹고 키워드당 10건에서
  끊긴다.** 리벨리온은 LinkedIn 8건 / 보드 41건이었고, **정면인 자리 셋이 LinkedIn 목록에
  아예 없었다.** 25개 보드 1,400여 건 → **331건이 축 키워드에 걸렸다.**
- **원칙 두 개가 바뀌었다** (`applications/AGENTS.md` §타깃 기준):
  **지역을 1차 필터로 쓰지 않는다** · **지금 회사보다 큰 곳으로 위로 찌른다.**
- **교훈**: 회사를 판정하지 말고 **자리를 판정한다.** 42dot 을 두 건 보고 닫을 뻔했는데
  보드에 에이전트 축이 넷이었다.

## 지원 경로 — ATS 지도가 넓어졌다 (2026-07-28 저녁)

- **회사 채용 보드 API 세 개를 인증 없이 뚫었다.** 브라우저 없이 「본문✓」를 만드는 축이다.
  - **Ashby**: `api.ashbyhq.com/posting-api/job-board/<슬러그>` — 본문·게시일·고용형태·`isListed`.
    실측: `furiosa-ai` 56 · `openai` 749 · `cohere` 138 · `42dot` 120 · `reflectionai` 62.
  - **Workable**: `apply.workable.com/api/v1/widget/accounts/<회사>?details=true` — **Lunit 한국 채용**.
  - **ninehire 화이트라벨**: 상세 페이지 `__NEXT_DATA__` → `recruitment` 에 `closedAt`·`status`·
    `career.range`·`jobLocations`. **Telechips 는 82건 중 3건만 열려 있었다.**
- 전부 `applications/INBOX.md` §지원 경로 에 적었다. **회사를 정했으면 그 회사 보드를 직접 본다.**

## linkedin-jobs

- 65개 network-free 회귀 검사 통과. 표준 흐름: 카드 수집 → dedupe → `enrich --keep-body` 한 번 →
  `rank --explain`.
- **고용형태를 목록에 내보낸다.** `enrich` 가 받아 두던 `criteria` 를 `emit()` 이 한 번도
  출력하지 않아 계약직이 표에 정규직처럼 섞였다. 이제 `⚠Contract` 로 뜬다.
- **뒷정리 계약 2개를 SKILL.md 에 박았다** — 「제목을 줄이지 않는다」(괄호 안에 연차·고용형태가
  있다), 「확정이라고 적으려면 본문을 읽었어야 한다」. 두 실물 사고에서 나왔다.
- 고친 것: `intern`→`internal` 오탐, 알려진 근무지 mismatch 감점, 빈 fetch 를 Easy Apply 로 오판,
  search 의 `apply` 누락, enrich 원자 저장 · 재개, 점수 근거.
- guest endpoint 는 비공식 · best-effort. 403/999 또는 markup 변경 시 exa/브라우저로 전환.

# RECENT

- [2026-07-28] 4개 역할(탐색 · 문서 · 브라우저 · 메타)이 분리된 채로 4건을 제출하고, 그 과정의
  실패를 테스트와 계약으로 회수했다. 기록은 `docs/case-study-2026-07-28.md`.
- [2026-07-20] NHN AX 건 제출 완료. 기록은 `applications/nhn--ax-transformation-ai-infra/`.

# LEDGER

- 제출 SSOT: `applications/LEDGER.md` · **제출 실행 시트: `applications/SUBMIT-QUEUE.md`** · 닫힘 검사: `applications/check.py`
- **공고 생존 검사: `applications/alive.py`** (제출 직전에 돌린다)
- **한 장짜리 md → 제출용 PDF: `applications/md2pdf.sh`** (노트북 전용 — Chrome 이 필요하다)
- **⭐ 제출 세트 깔기: `applications/stage.py`** — 각 건 `submit/` 에 나갈 물건 전부를 깐다.
  **GLG 검수는 여기서 한다.** 이력서·dossier 재빌드 뒤에는 반드시 이어서 돌린다
- 조준 문서 발사대: `dossier/AGENTS.md` — **깊이 축**. 이력서 발사대는 `resume/`
- 후보 큐: `applications/INBOX.md` · 폼 재사용 답: `applications/FAQ.md`
- 이력서 사실: `resume/body.org` · 빌드: `(cd resume && ./run.sh all && ./run.sh verify)`
- 탐색: `.claude/skills/linkedin-jobs/SKILL.md`
- 전체 계약: `AGENTS.md`
- **나중에** 공개할 때만: `PUBLICATION.md`, `scripts/check-public.sh`, `README.md`
