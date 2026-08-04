# LEDGER — 지원 원장

**어디에 · 언제 · 무엇을 냈는가.** 이 표가 지원 이력의 SSOT다. 건마다 행 하나.
행을 지우지 않는다 — 불합격도 이력이다. 폴더는 `_archive/`로 옮겨도 행은 남긴다.

상태: `draft`(자리만 만듦) · `ready`(글·첨부 준비됨, 제출 대기) · `saved`(플랫폼에 임시저장)
· `submitted`(제출 완료) · `replied`(회신 옴) · `interview` · `offer` · `rejected` · `closed`(공고 마감/철회)
· `held`(후보 목록만 — 낼 자리를 아직 안 고름)

**상태와 「이번에 낼 것」은 다르다.** `ready` 는 *서류가 준비됐다*는 사실이고, 낼지 말지는
운영 판단이다. 운영상 보류는 **원장의 사실 상태를 바꾸지 않고** 그 건의 `submission.md` 상태칸에
`ready — 보류` 로 적고 `NEXT.md` 에 이유를 남긴다(`AGENTS.md` §`ready`의 뜻).

> **2026-07-29 계보**: `ready` **17건** = **실행 15건**(11:00 한화비전 합류) + **보류 2건**(Cohere · OpenAI —
> 외국계 두 건은 이번 배치에서 뺀다, 2026-07-28 GLG). 이 계보가 `NEXT.md`·`SUBMIT-QUEUE.md` 의 「15건」과 맞다.

| 회사 | 직무 | 상태 | 지원일 | 경로 | 첨부 컷 | 폴더 |
|---|---|---|---|---|---|---|
| NHN | AX Transformation / AI Infra (BE) | submitted | 2026-07-20 | NHN 채용홈 + **직원 추천** | **dossier 3종** (이력서 컷 아님) | `nhn--ax-transformation-ai-infra` |
| Insighter | AX Engineer | saved | — | LinkedIn Easy Apply | — | `insighter--ax-engineer` |
| Hyundai AutoEver | AI Agent Engineer | replied | 2026-07-28 · **서류합격 2026-07-31** · 상세정보 제출 2026-08-01 · **ACT ~08-09 23:00 / 코딩테스트 08-08 14:00** | 그리팅 (자체 도메인) | AI Engineer + 국문 자기소개서 | `hyundai-autoever--ai-agent-engineer` |
| DEEPX | AI Agent Workflow Automation Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | AI Engineer + 경력기술서 통합 (7쪽) | `deepx--ai-agent-workflow-automation-engineer` |
| DEEPX | Linux BSP Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | Embedded + 경력기술서 통합 (5쪽) | `deepx--linux-bsp-engineer` |
| Enhans | Forward Deployed Engineer (7년 이상) | rejected | 2026-07-28 · **불합격 통보 2026-08-04** | ninehire (자체 채용홈) | FDE | `enhans--forward-deployed-engineer` |
| FuriosaAI | Agent System Developer | submitted | 2026-07-30 | Ashby (자체 채용페이지 경유) | AI Engineer + Portfolio 12쪽 + **Career Summary 1,351자** | `furiosaai--agent-system-developer` |
| Lunit | (Seoul) Senior AX Engineer | submitted | 2026-07-30 | **Workable** (자체 채용홈) | AI Engineer + Portfolio 12쪽 + **문의칸 답** | `lunit--senior-ax-engineer` |
| Cohere | Forward Deployed Engineer, Agentic Platform (Korea) | ready | — | Ashby (가입 불필요) | FDE | `cohere--forward-deployed-engineer-agentic-platform-korea` |
| OpenAI | Developer Experience Engineer (Seoul) | ready | — | Ashby (가입 불필요) | DevEx | `openai--developer-experience-engineer-seoul` |
| Telechips | [판교] Embedded S/W Engineer (BSP Driver) | ready | — | 자체 채용홈 (ninehire 화이트라벨) | Embedded | `telechips--embedded-sw-engineer` |
| Reflection AI 🌐 | FDE, Lead - AI Engineer (Seoul) | submitted | 2026-07-30 | Ashby (가입 불필요) | FDE 3쪽만 — **영문 폼이라 국문 깊이 문서를 붙이지 않았다** | `reflection-ai--forward-deployed-engineer-lead-ai-engineer` |
| 42dot | Senior AI Agent Engineer (Intelligence Service) | submitted | 2026-07-30 | Ashby (가입 불필요) | **이력서+경력기술서 8쪽 합본** + Portfolio 12쪽(전용 칸) + **Motivation 805자** | `42dot--senior-ai-agent-engineer-intelligence-service` |
| MakinaRocks | [FDE] AI Agent Application Engineer | ready | — | 그리팅 (자체 도메인) | FDE | `makinarocks--ai-agent-application-engineer-fde` |
| SOCAR | Platform Engineer | submitted | 2026-07-30 | 그리팅 (자체 도메인) | DevEx + Portfolio 12쪽 | `socar--platform-engineer` |
| Upstage | AI Engineer - Agents | submitted | **2026-08-01** | 그리팅 (자체 도메인) | AI Engineer + **국문 자기소개서 2쪽** + 포트폴리오 12쪽 | `upstage--ai-engineer-agents` |
| FriendliAI | Software Engineer - AI Agents | submitted | 2026-07-30 | Ashby (가입 불필요) | AI Engineer (⛔ 폼에 첨부 슬롯 1개 — 깊이 문서 칸 없음) | `friendliai--software-engineer-ai-agents` |
| Toss | AI Engineer (Platform) | rejected | 2026-07-30 · **불합격 통보 2026-08-04** | **토스 자체 채용홈** | **이력서+경력기술서 8쪽 합본** · 경력 3건 직접 입력 · ⛔ 커버레터 칸 없음 | `toss--ai-engineer-platform` |
| Bear Robotics | Systems Software Engineer (Linux Platform) | ready | — | **Breezy HR** (자체 보드) | Embedded (영문 CV 필수) | `bear-robotics--systems-software-engineer-linux-platform` |
| Penguin Solutions 🌐 | Sr. System Engineer | draft | — | 자체 채용홈 (SuccessFactors) | — (보류 — GLG 판단) | `penguin-solutions--sr-system-engineer` |
| Sonatus 🌐 | Staff DevOps Engineer | ready | — | **LinkedIn Easy Apply** | Embedded | `sonatus--staff-devops-engineer` |
| Telit Cinterion 🌐 | Edge AI Software Engineer | ready | — | **Paylocity** (자체 보드) | Embedded | `telit-cinterion--edge-ai-software-engineer` |
| AIRS Medical | AX Engineer | submitted | 2026-07-30 | 그리팅 (자체 도메인) | DevEx + Competency + Portfolio | `airs-medical--ax-engineer` |
| GE HealthCare 🌐 | Senior Software Engineer | draft | — | **Workday** (공식 외부 사이트) | 미정 — Systems Software 컷 판단 | `ge-healthcare--senior-software-engineer` |
| XCENA (엑시나) | System Software 계열 — **회사 스캔 23건** | held | — | 그리팅 (자체 도메인) | — (목록만 · GLG: "너무 시스템") | `xcena--system-software` |
| Holiday Robotics | Forward Deployed Robotics Engineer (3–8년) | submitted | 2026-07-30 | 자체 채용홈 `holiday-robotics.com` (로그인 없음) | FDE + **커버레터** | `holiday-robotics--forward-deployed-robotics-engineer` |
| Hanwha Vision (한화비전) | AI Agent Architecture Lead (석사+10년, Director) | submitted | 2026-07-30 | **ninehire** `6NDP9uTE` (로그인 없음) | AI Engineer + **전용 포트폴리오 합본 18쪽** (`submit/`) — 서술형 칸 없음 | `hanwha-vision--ai-agent-architecture-lead` |
| NHN | LLM 기술 개발 (LLM / Agent) — **NHN 2번째 건** | draft | — | **`careers.nhn.com`** — ⚠ **로그인 필요** | AI Engineer + **포트폴리오 필수** | `nhn--llm-technology-development-llm-agent` |
| 카카오헬스케어 (Kakao Healthcare) | [경력] AI Agent Engineer | submitted | 2026-07-30 | **자체 채용홈** `recruit.kakaohealthcare.com` (ninehire 화이트라벨) | **합본 20쪽 한 파일** (이력서 3 + Competency 5 + Portfolio 12) — 폼 슬롯이 하나뿐 · 커버레터는 칸 없음 | `kakao-healthcare--ai-agent-engineer` |
| 카카오뱅크 (Kakao Bank) | **인재풀 등록** — 지원분야 `Platform Development` | submitted | 2026-07-30 | **`kakaobank.recruiter.co.kr`** (recruiter.co.kr) · 접수 ~2026-12-31 | AI Engineer + Competency + Portfolio + 공개 좌표 2 | `kakao-bank--talent-pool-platform-development` |
| 카카오뱅크 (Kakao Bank) | **데이터 엔지니어 - Data Warehouse** (`260510`, 마감 2026-08-06) | ready | — | **`recruit.kakaobank.com`** 개편 채용홈 → 폼은 `kakaobank.recruiter.co.kr` | ✅ **AI Engineer** + Competency(경력기술서 란) + Portfolio(포트폴리오 란) · ✅ **자기소개서 2문항 작성 완료** (952자·879자, `answers.md`) · **GLG 제출 대기** | `kakao-bank--data-engineer-data-warehouse` |
| IGNITE | AI Developer | submitted | **2026-08-01** | 회사 자체 ATS (ninehire, `ignite.ninehire.site` · 상시) · 지원경로 `채용포털` | **이력서+경력기술서 8쪽 합본** + Portfolio 12쪽 + **실제 서술형 260·286·260자** | `ignite--ai-developer` |
| Wonderful 🌐 | Forward Deployed Engineer (South Korea) | ready | — | Ashby (가입 불필요) | FDE (기존 PDF 재사용) | `wonderful--forward-deployed-engineer` |

---

## 기록 규율

- **낼 때 남긴다.** 내고 나서 기록하려 하면 남지 않는다. `./new.sh` 가 먼저다.
- **공고 URL은 죽는다.** `JD.md` 에 본문을 떠 두는 것이 링크보다 중요하다.
- 같은 회사 다른 직무는 **별도 건**이다. 같은 직무 재지원도 별도 건이고, 폴더명 뒤에
  `--2`를 붙인다.
- 회신·면접 일정은 그 건의 `submission.md` 하단 「이후 기록」에 시간순으로 덧붙인다.

## ⭐ 계보 — 앞의 제출이 다음 제출을 강화한다 (시간축)

> **2026-08-01 GLG**: *"제출하면서 앞서 제출한 것들을 통해서 계속 개선이 되거든. 시간 축으로
> 이 작업의 타임라인이 이 작업 자체를 강화시키고 있다. 그래서 원장에 잘 기록해야 된다."*

**이 저장소의 산출물은 지원 서류가 아니라 「낼수록 좋아지는 제출 기계」다.** 위 표가 *무엇을
냈는가*라면 이 절은 *그 제출이 다음 제출의 무엇을 바꿨는가*다. 한 건에서 드러난 것은 그 건에
남기지 않고 게이트·스크립트·계약으로 올려서 **다음 건이 자동으로 물려받게** 한다.

| 날짜 | 어느 건이 드러냈나 | 무엇이 바뀌었나 (다음 건이 물려받은 것) |
|---|---|---|
| 07-28 | **DEEPX ×2** | 같은 그리팅인데 자기소개서 슬롯 대신 **이력서+경력기술서 통합 PDF**를 요구했다 → 「폼 구조는 ATS 가 아니라 **회사**가 정한다」. 이후 모든 건에서 **폼을 먼저 실측**한다 |
| 07-29 | 제출 5건 누적 | GLG 원칙4 — **자가 측정 수치를 뺀다**. 이력서 6컷 + dossier 3문서 재빌드. 이미 나간 5건은 **그대로 둔다**(그때 나간 문서가 사실이다) → §메모 ② |
| 07-29 | 검수 방식 | *「제출할 양식 그대로 열어서 볼 거야」* → **`stage.py` 탄생.** 검수는 소스(org·md)가 아니라 **나갈 물건** 위에서 한다 |
| 07-30 | **AIRS Medical** | 「이력서만 달랑」이 아니라 **Competency 5쪽 + Portfolio 12쪽**을 함께 냈다 → 다음 11건의 세트가 3종이 됐다 |
| 07-30 | GLG 지적 | *「하나만 내기에는 성의가 없다」* — 구조적 원인은 **`stage.py` 가 `첨부 컷` 행만 읽던 것**이었다. `추가 첨부` 행 확장 → **Lunit·SOCAR·Upstage 의 낡은 판정 3건이 뒤집혔다** |
| 07-30 | 저장소 위생 | **PDF 를 git 에 넣지 않는다** → `MANIFEST.sha256`(지문) + `SOURCES.md`(재현 경로)가 증언을 대신한다. 지문 없던 제출 4건을 소급 보완 |
| 07-30 | 재타깃 사고 | **`check.py --deep`** 신설 — AIRS 조준판이 Lunit 세트에 실제로 심어지는 것을 잡았다. 이후 세트를 깔 때마다 기계가 본다 |
| 07-30 | **카페 12건 실측** | 계약 넷이 굳었다 — ① 첨부는 「칸이 있는가」 다음 「독자가 읽을 언어인가」 ② **ninehire 는 에이전트가 파일을 못 올린다** ③ 서술형은 **칸이 묻는 것만** 답한다 ④ **회사 축이 이력을 쓰는 방식을 바꾼다**(FuriosaAI — 임베디드 이력을 뺀 판단이 틀렸다) |
| 07-31 | **현대오토에버 첫 서류합격** | `submitted` 다음이 침묵이 아니게 됐다 → **§제출 이후 여섯 단계 루프** + `FAQ.md` §11(**대비 학습을 하지 않는다**). 다음 회사의 같은 메일은 이 절부터 편다 |
| 08-01 | **IGNITE** | ⭐ **계약은 새 건에 자동으로 붙지 않는다.** 07-30 에 고친 「이력서 한 장」이 07-31 에 만든 새 건에서 **그대로 재발**했다 — `submission.md` 에 `추가 첨부` 행이 없으면 `stage.py` 는 dossier 를 깔 **경로 자체가 없다**. → **새 건을 만들 때 `추가 첨부` 행을 먼저 판정한다** |
| 08-01 | **IGNITE (답 회수)** | GLG: *「텍스트 일단 여기 폴더에 회수 꼭 해둬. 비슷한 질문 왔을 때 QNA FAQ 할 수 있으니까.」* → `stage.py` 가 `answers.md` 의 문항별 ```text 블록을 **`submit/answers.txt`** 로 뽑는다(커버레터와 같은 계약). **글자 수를 자동으로 세는데 폼 카운터와 정확히 일치**했다(264·257·229) — 셈법이 실측으로 검증됐다. 「도구·판단·운영의 경계」 3문항은 **AI 툴링 직무에서 반복될 묶음**이라 `FAQ.md` §9 에 재사용 축으로 올렸다 |
| 08-01 | **FAQ 자기모순** | §9 골격 3번이 *「자가 측정 수치를 넣지 않는다」* 고 명시하는데 **바로 아래 예문에 「하루 24커밋·163개 테스트·파일 충돌 0」이 살아 있었다.** 07-29 원칙4 를 적용할 때 이력서·dossier 만 훑고 **재사용 예문을 놓친 것**이다. **규칙과 예문이 어긋나면 예문이 이긴다** — 그대로 복사해 쓰는 자리다. 제출 완료된 스냅샷 2건(NHN·AutoEver)은 계약대로 그대로 둔다 |
| 08-01 | **IGNITE (세트 문서)** | 합본을 내는 건에서 `submit/README.md` 의 *「이 폴더가 실제로 올라갈 파일 전부다」* 가 **거짓**이었다 — 실제로 칸에 올라가는 것은 `build/` 의 합본이고 세트에 있는 건 그 **입력**이다. 42dot·카카오헬스케어도 같았다. `stage.py` 가 §합본 재현을 감지해 **합본 경로를 README 맨 위에 박게** 했다. **「검수는 세트 위에서 한다」는 계약은 세트 문서가 사실일 때만 성립한다** (제출 완료된 두 건은 계약대로 건드리지 않는다) |
| 08-01 | **IGNITE (게이트)** | 🔴 **원장을 꾸미면 게이트가 그 건을 조용히 면제했다.** 상태 셀이 `**ready**(…목표 제출)` 처럼 꾸며진 행은 `check.py` 가 통째로 건너뛰면서 출력은 `ok` 였다 — **4건이 그렇게 빠져 있었다**(AutoEver·Upstage·XCENA·IGNITE). fail-closed 가드를 넣어 **검사 대상 30 → 33건**. `aim_leak` fail-open(07-30 P0-C)과 **같은 종류**다 |

| 08-01 | **ax 증거면 누락** | 🔴 **`ax.junghanacs.com` 이 생성 표면 어디에도 없었다** — 공개 포트폴리오가 살아 있는데(200) 이력서 6컷·깊이 문서 3종 **전부 0건**이었다. 원인은 결함이 아니라 **계보**다: 07-29 에 `ax` 를 「별도 트랙」으로 갈라 둔 판단이 맞았는데, 그 뒤 **링크를 거는 일까지 함께 갈라져 버렸다.** 트랙 분리는 *내용* 을 섞지 않는다는 뜻이지 *가리키지 않는다* 는 뜻이 아니다. → 연락처 줄 5자리 + `@live-ax` + 세 문서의 근거 절에 실었고, **`run.sh` verify 가 산출물 텍스트에서 직접 확인**한다(게이트 부재를 실측으로 확인 — 빼고 돌리니 6컷 전부 실패). ⚠ 다섯 번째 항목이 줄을 넘겨 `Overfull \hbox` 가 났고 `\newline`·`\raggedright` 로 잡았다 — **링크를 늘리면 폭이 따라온다.** 교차검수에서 ① `resume/AGENTS.md` 하단의 옛 「연락처 넷」 계약 ② `dossier/README.md`의 참조 없는 「별도 트랙」 표현 ③ dossier 게이트가 PDF만 검사하고 ODT·MD는 보지 않던 구멍을 함께 닫았다 |

| 08-01 | **경력 ⚠칸 6건이 한 번에 닫혔다** | 업스테이지 폼의 「부서·직급·정확한 월」이 *「SSOT 에 없다」* 로 6칸 막혀 있었다. **없던 게 아니라 안 본 것이다** — 07-31 서류합격 뒤 GLG 가 오토에버에 **직접 입력한 값**이 `submit/KimJunghan_AutoEver_Detail_Form.md` 에 그대로 있었다(개발팀·프로 / 계약직·분산컴퓨팅연구실·박사과정연구원 / 부서 미제출·공동창업자). ⭐ **제출 스냅샷은 증언이자 다음 건의 입력값이다.** 그리고 그 대조에서 **`FAQ.md` §3 이 틀린 것이 드러났다** — 성균관대를 「2018 – 2022.06 · 4년 4개월」로 적어 뒀는데 실제 제출값은 **2017.08 – 2022.07 · 5년** 이다. 「2018 시작」은 NEMO-UX 법인 종료(2017.08) 직후로 이어지는 연속을 **끊어 놓는 값**이었다. **추정으로 채운 SSOT 는 실측이 오면 진다** |
| 08-01 | **NEMO-UX 는 값이 둘이다** | GLG: *「법인은 2년이고 앞에 준비했던 기간에 대한 이야기니까 그렇게 적어둬 헷갈리지 않게.」* → 구조화 경력 칸은 **2015.08 – 2017.08**(법인 재직), 이력서·서사는 **2013 – 2017**(준비 포함). **둘 다 사실이고 모순이 아니다** — 칸이 무엇을 묻는지로 고른다. 구조화 폼에 2013 을 쓰면 **재직하지 않은 기간을 재직으로 신고**하는 것이 되고, 이력서를 2015.08 로 줄이면 실제로 한 일이 사라진다. `FAQ.md` §3 에 표로 박았다 |

**읽는 법 — 이 표가 말하는 한 가지**: 실패는 그 건의 실수로 끝나지 않고 **스크립트·게이트·계약
중 하나로 올라간다.** 올라가지 않은 교훈은 반드시 재발한다(08-01 IGNITE 두 행이 그 증거다).
그러니 한 건을 닫을 때 묻는 마지막 질문은 *「이번에 알게 된 것이 어디에 박혔는가」*다.

## 메모

- ⚠ **제출본과 현재 문서의 차이 ③ — 하네스 개수 (2026-07-30)** — 면접에서 되물릴 수 있다.
  - **「여섯 개 하네스」→ 「다섯 개」로 고쳤다.** SSOT(`agent-config/README.md` §Harness
    Support)를 세면 구별되는 하네스는 **다섯**이다 — pi 축 3행(pi+entwurf · pi+anthropic ·
    pi-entwurf)은 같은 pi 이고, 거기에 **Claude Code · Codex · Antigravity · OpenClaw**.
  - **어디서 왔나**: 같은 README 에 *"OpenCode is not used. It once appeared in this table
    **and in the fan-out list**"* 가 적혀 있다. **연결되지 않은 하네스가 팬아웃 목록에 올라
    있던 판의 잔재**다.
  - **이미 나간 문서에는 「여섯」이 그대로 있다** — **AIRS Medical**(커버레터 + 이력서 DevEx
    컷의 `fanned into six harnesses`) · **DEEPX**(JD 대조표). **고치지 않는다.**
  - **물어보면**: *"다섯이 맞습니다. pi 를 실행 방식별로 세어 여섯으로 적었던 것이고,
    구별되는 하네스는 Claude Code · Codex · pi · Antigravity · OpenClaw 다섯입니다."* 가 사실이다.
  - ⚠ **이력서 정본(`resume/targets/developer-experience-engineer.org`)까지 퍼져 있었다.**
    커버레터만 고치고 끝낼 문제가 아니었다 — **DevEx 컷 PDF 에 실려 나가는 자리였다.**
    2026-07-30 에 정본을 고치고 여섯 컷을 재빌드했다.
  - ⭐ **「소비 표면 6개」는 「하네스 5개」와 다른 개념이고 둘 다 맞다** — 고치지 않았다.
    `agent-config/run.sh` 가 skills 를 링크하는 경로를 세면 **정확히 여섯**이다:
    ① `~/.pi/agent/skills/pi-skills` ② `~/.pi/agent/claude-plugin/skills`(entwurf SDK 격리
    모드용 — pi 가 스폰하는 Claude 는 `~/.claude/skills` 를 자동 발견하지 않는다)
    ③ `~/.claude/skills` ④ `~/.codex/skills` ⑤ `~/.gemini/skills`
    ⑥ `~/.gemini/antigravity-cli/skills`.
    **물어보면**: *"하네스는 다섯이고, 스킬 정본이 링크되는 소비 경로는 여섯입니다. pi 가
    격리 모드로 스폰하는 Claude 가 별도 경로를 쓰고, Gemini CLI 도 링크를 받기 때문입니다."*
    ⚠ **OpenClaw 는 이 여섯에 없다** — Nix store mount/symlink 축이라 경로가 다르다.

- ⚠ **제출본과 현재 문서의 차이 ② — 수치 (2026-07-29)** — 면접에서 되물릴 수 있다.
  - **자가 측정 수치를 전부 걷어냈다** (GLG 판단, `AGENTS.md` §불변식 §숫자):
    부팅 45.4→5.8초 · 메모리 816→246MiB · 코드 공유 96% · 테스트 163개 · 임베딩 2,945건 ·
    30일 198커밋 · 하루 24커밋. 이력서 여섯 컷과 dossier 세 문서를 재빌드했다.
  - **이미 제출한 5건**(AutoEver · DEEPX ×2 · Enhans · NHN 1차)의 `submit/` 스냅샷에는
    **옛 수치판이 그대로 있다.** 그때 나간 문서가 사실이므로 **고치지 않는다.**
  - 물어보면: *"측정은 맞지만 제가 센 숫자라 검증 축이 없고, 부팅·메모리 개선은 업스트림
    릴리스가 한 것입니다. 그래서 이후 문서에서는 날짜·커밋으로 대신합니다."* 가 사실이다.
  - 남긴 수치는 두 종류다 — **라이브 주소로 확인되는 누적 기록**(Working Corpus)과
    **제3자가 남긴 숫자**(기여 PR 줄 수, npm 설치 수).

- ⚠ **제출본과 현재 이력서의 차이 (2026-07-28 이후)** — 면접에서 되물릴 수 있으니 알고 있는다.
  - 2026-07-28 제출한 3건(AutoEver · DEEPX ×2)의 PDF 에는 연구실 기간이 **`2018 – 2021`** 로
    적혀 있다. 이후 이력서를 **`2018 – 2022`** 로 고쳤다(연 단위 — `resume/AGENTS.md` §날짜 입도).
  - **각 건의 `submit/` 스냅샷이 실제로 낸 문서다.** 다시 빌드해서 덮지 않는다 — **단, 그 건에
    다음 업로드가 실제로 걸려 있으면 예외다.** 2026-08-01, AutoEver 는 상세정보 기재를 위해
    같은 파일을 다시 올려야 했고, 그 시점에 `./build.sh` 를 재실행해 `2018 – 2022` 로 잡았다
    (근거: `hyundai-autoever--ai-agent-engineer/submission.md` §상세 정보 기재). **DEEPX
    ×2 는 다음 업로드가 없어 원래 제출본(`2018–2021`) 그대로 둔다** — 이 규칙이 여전히 적용된다.
  - 물어보면 "2022년까지가 맞고 당시 서류에 2021로 나갔다"가 사실이다. 정확한 월은 `FAQ.md` §3
    (`2022.06`), 증빙은 **공단 가입이력 증명서**로 낸다.
  - 스택의 `A2A` 는 제출본에도 있고 현재 이력서에도 **유지**한다. `home agent-config` /
    `edge agent-config` 세트로 실제로 파고 있는 주제다(프로토타입 전 단계).
  - ⭐ **같은 계열의 델타 하나 더 (2026-08-01 발견)** — 이력서의 **`NEMO-UX 2013 – 2017`**
    (연 단위, 박사과정과 병행한 준비기간 포함 서사)도 정밀 값과 다르다. NHN 에 실제로 신고한
    공식 재직기간은 **`2015.08.01 – 2017.08.31`**(정확히 법인 2년) —
    `nhn--ax-transformation-ai-infra/submit/KimJunghan_AX_Applicant_Form.md` 가 원본이다.
    구조화 경력 입력 폼(월 단위를 요구하는 자리)에는 **이 정밀값을 쓴다.** 이력서의 「2013」은
    허위가 아니라 준비기간을 포함한 서사적 표기 — 물으면 그렇게 답한다.

- **DEEPX 2건 (2026-07-28)** — 그리팅이지만 다른 회사 폼과 구조가 달랐다. 자기소개서
  슬롯 대신 **이력서+경력기술서 통합 PDF 하나**와 300자 답변을 요구했다.
  - 개인·법적 필드는 GLG가 브라우저에서 직접 사실값으로 입력해 두 건 모두 제출했다.
    민감값은 Git에 저장하지 않는다.
  - 에이전트들은 처음에 AI Agent 건만 먼저 내고 BSP는 3~5일 뒤 재판단하자고 권고했다.
    GLG가 두 증거 패키지를 읽고 **같은 날 둘 다 제출**하기로 명시적으로 override했다.
  - 같은 회사에 복수 지원한 예외와 각 직무의 경계는 두 `submission.md`에 보존한다.
  - 세 번째 System SW 공고는 증거 밖이라 자리를 만들지 않았다.

- **그리팅 공고 원문 뜨는 법** — WebFetch 는 **403**. 브라우저 UA 를 붙인 `curl` 은 200 이고,
  본문·폼 스키마가 전부 `<script id="__NEXT_DATA__">` 안에 있다
  (`props.pageProps.dehydratedState.queries[1].state.data.data` → `openingsInfo.detail`,
  `docsInfo`, `questionnairesInfo`, `additionalApplicantInfoConfig`).
  **필수/선택 여부와 글자수 상한까지 정확히 나온다** — 브라우저로 폼을 열기 전에 여기서 읽는다.

- **Insighter / AX Engineer** — 2026-07-28 브라우저 워크플로를 검증하면서 Easy Apply 4/5까지
  열고 임시저장했다(**제출 아님**). 이어서 내려면 공고 페이지의 「계속」에서 재개한다.
  4/5 질문 「경력 2년 이상 또는 석사 이상」은 **Yes**.
  - ⚠ **지역 기준 미달** — 근무지가 서울 마포구 DMC다. GLG 기준(성남·판교·강남권)에서
    벗어난다. 내용 적합도는 중상(`JD.md` §판단)이나 **낼지 말지는 GLG 판단이다.**
    내지 않기로 하면 이 건은 `closed`로 바꾸고 `_archive/`로 옮긴다.
