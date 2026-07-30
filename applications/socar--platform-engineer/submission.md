# 제출 기록 — SOCAR (쏘카) / Platform Engineer

| 항목 | 값 |
|---|---|
| 상태 | **submitted** — 2026-07-30 제출 완료 |
| 지원일 | **2026-07-30** |
| 경로 | **그리팅** (자체 도메인 `socar.career.greetinghr.com`) — 가입 불필요 |
| 첨부 컷 | **DevEx** (`resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf`, 3쪽) |
| 추가 첨부 | ✅ **슬롯 실측 확인** — `dossier/build/KimJunghan_AX_Portfolio.pdf` (포트폴리오 12쪽) **하나만.** 이 폼의 선택 슬롯은 「포트폴리오」 하나뿐이라 **Competency 는 세트에 깔지 않는다** — 세트에 있으면 오업로드 위험이다 (2026-07-30 GPT 교차검수 P0-4) |
| 공고 URL | https://socar.career.greetinghr.com/ko/o/220124 |
| **지원 URL** | **https://socar.career.greetinghr.com/ko/o/220124** → 페이지 하단 「지원하기」 (HTTP 200 확인) |
| 근무지 | **서울 성동구 왕십리로 83-21** (쏘카 본사, 성수) · 재택 아님 |
| 조건 | 정규직 · 경력 5년 이상 · 게시 2026-06-05 · **마감일 없음(수시, 조기 마감 가능)** |
| 팀 | **쏘카 Tech Platform** — Product Engineer 한 명이 전 스택을 책임지는 AI Native 조직으로 전환 중 |

## ⭐ 제출 실행 — 이대로 하면 끝난다 (2026-07-29 확정)

**막는 것이 하나도 없다.** 로그인 불필요 · 서술형 0 · 부가정보 0 · GLG 미정값 불필요.

1. `cd ~/repos/gh/apply/applications && ./alive.py SOCAR` → `status=OPEN` 확인
   (⚠ `deploy=False` 는 **채용홈 미배포일 뿐 공고 상태가 아니다** — 닫힘으로 읽지 않는다)
2. `https://socar.career.greetinghr.com/ko/o/220124` → 페이지 하단 **「지원하기」**
3. 이름 `김정한` · 이메일 `[email removed]` · 연락처 **GLG 직접**
4. **「이력서 및 경력기술서」(필수)** 슬롯에 업로드 —
   `resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf` **(3쪽 · 35KB)**
   - ⚠ 파일명 확인. **`_Developer_Experience_` 가 맞다** (`_AI_`·`_Embedded_` 아님)
   - ⭐ **「포트폴리오」(선택) 슬롯에 `submit/KimJunghan_AX_Portfolio.pdf`(12쪽)를 올린다**
     (2026-07-30 갱신 — 어제는 「비워 둔다」였다). 슬롯 이름이 「포트폴리오」이므로
     **Portfolio 를 넣는다**. Competency 5쪽은 이 폼에 들어갈 칸이 없다 —
     `submit/` 에 함께 깔려 있으니 **면접에서 요청받으면 그때 낸다**
5. Submit → **낸 파일을 이 폴더 `submit/` 에 즉시 복사** (AIRS 와 같은 컷이라 폴더를 헷갈리기 쉽다)
6. `LEDGER.md` → `submitted` + 날짜 / 이 문서 → `submitted` → `./check.py`

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Developer_Experience_Engineer.pdf` (3쪽 · 35.5kB)
      → 폼 **「이력서 및 경력기술서」**(필수)
- [x] ⭐ **포트폴리오 PDF** — `submit/KimJunghan_AX_Portfolio.pdf` **(12쪽 · 3.8MB)**
      → 폼 **「포트폴리오」**(선택). 어제 「비워 둔다」 판정을 뒤집은 그 칸이다
      `dossier/` 정본에서 **2026-07-30 회사 중립판으로 재빌드**했다. 회사명 잔재 0건.
      어제는 *「선택 항목이라 올리지 않는다 — 이력서의 저장소 링크가 대신한다」* 였다.
      **링크는 열어 보는 사람만 보고, 첨부는 서류 심사에 그대로 놓인다.** 슬롯이 실재하고
      공고가 경력기술서를 함께 요구하는데 비우는 것은 근거가 없다 (2026-07-30 GLG)
- [ ] 경력·역량기술서 — **이 세트에는 없다.** `docsInfo` 슬롯이 필수 이력서 + 선택 포트폴리오
      **둘뿐**이라 낼 칸이 없고, **세트에 두면 오업로드 위험**이라 `추가 첨부` 행에서 뺐다.
      필요하면 `dossier/build/KimJunghan_AX_Competency.pdf` 를 그때 만들어 낸다
      (면접 요청 시 · 또는 아래 §합본 대안)

> **⭐ 대안 — 합본으로 경력기술서 요구를 정면으로 받는다 (GPT 권고, 2026-07-30)**
> 필수 슬롯 이름이 **「이력서 및 경력기술서」**이고 중립 Competency 가 이미 있으므로,
> **새 조준 문서를 쓰는 일이 아니라 `pdfunite` 한 번**이면 된다 —
> `Resume(3쪽) + Competency(5쪽)` = **8쪽 합본을 필수 슬롯**, `Portfolio(12쪽)` 를 선택 슬롯에.
> 선례는 `../deepx--ai-agent-workflow-automation-engineer/build.sh`.
> **카페 2시간에서는 후순위**다 — 시간이 남으면 한다. 하면 `build.sh` 와 소스 경로를 남긴다.
- [ ] 커버레터 — **폼에 칸이 없다** (서술형 문항 `questionnairesInfo` 가 빈 배열이다).
      아래 §왜 이 직무였는가 는 **면접용 대본**이지 제출물이 아니다

**⚠ 서류 슬롯은 하나다.** 그리팅 `docsInfo` 는 필수 「**이력서 및 경력기술서**」(PDF) 하나와
선택 「포트폴리오」(PDF) 하나뿐이다. 공고 문구는 경력기술서를 함께 요구하지만 **DevEx 컷의
Experience / Independent Work 절이 그 역할을 겸한다**고 보고 단독 제출로 간다.

> **통합본을 원하면 선례가 있다** — `../deepx--ai-agent-workflow-automation-engineer/build.sh`
> (이력서 컷 + `experience-detail.md` → `pdfunite`, 쪽수·활자·전화번호 검수 포함).
> 다만 그 문서는 **공고마다 새로 조준해 쓰는 255줄짜리 글**이다. 이 건은 아래 §경계대로
> **서류 승산이 6건 중 가장 낮다.** 그 비용을 여기 쓸지는 GLG 가 정한다.

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** DevEx 컷은 **AIRS Medical**(오늘 큐 2번)·
**OpenAI**(보류)와 **같은 파일**이다. 오늘 AIRS 와 쏘카가 둘 다 나가므로 컷을 헷갈릴 자리가
아니라, **`submit/` 스냅샷을 어느 폴더에 복사했는지**가 헷갈릴 자리다. 낸 직후에 그 건 폴더로
바로 복사한다.

> ✅ **2026-07-30 실측으로 닫혔다 — GPT 가 맞았다. 그 동의는 실재한다.**
> 폼 하단 「개인정보 수집 및 이용 동의」가 **세 줄**이다:
> **① 필수항목 (필수) · ② 선택항목 (필수) · ③ 제3자 이용제공 (선택)**.
> 「선택항목」이 **(필수)로 표기**돼 있어 이것을 빼면 제출 자체가 막힌다.
> `docsInfo`·`additionalApplicantInfoConfig` 만 보고 「없다」고 추론했다면 틀렸을 자리였다.
> **「전체 동의」 한 번**이 가장 안전하고, 그렇게 냈다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `5년 이상` 통과. 단 **직함 기준 SRE/DBA 5년은 아니다**(§경계) | `FAQ.md` §3 |
| 연락처 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **묻지 않는다** — 폼에 칸이 없다 (2026-07-29 재실측) | `openingsInfo` |
| 입사 가능일 | ✅ **묻지 않는다** — 폼에 칸이 없다 (2026-07-29 재실측) | `openingsInfo` |
| 이직 사유 | ✅ **묻지 않는다** — 폼에 칸이 없다 (2026-07-29 재실측) | `openingsInfo` |

> **이 건은 민감 법적 값을 묻지 않는다.** 그리팅 `additionalApplicantInfoConfig` 가
> 생년월일·성별·병역·장애·보훈·주소·학력·경력·어학·자격증을 **전부 `NOT_RECEIVED`** 로 둔다.
> 폼을 열기 전에 확인한 사실이다 — 다른 그리팅 건(AutoEver·DEEPX)과 다르다.
>
> 전형: **서류 → 1차(기술) 인터뷰 → 2차(컬처핏) 인터뷰 → 처우 협의 → 최종 → 입사.**
> 코딩테스트 없음. 입사 후 **3개월 수습 평가**. 문의처 `[email removed]`.

### ✅ 폼 전수 재실측 — 2026-07-29 오전 (오라클, 브라우저 없이 구조화 필드로)

`socar.career.greetinghr.com/ko/o/220124` 의 `__NEXT_DATA__` 를 다시 떠서 **네 필드를 전부**
확인했다. 브라우저에서 볼 것이 남아 있지 않다.

| 필드 | 값 | 뜻 |
|---|---|---|
| `openingsInfo.status` | `OPEN` | 열려 있다 |
| `questionnairesInfo` | **`[]`** | **서술형 문항이 하나도 없다** |
| `commonResumeQuestionnaireOption` | `false` | 공통 이력서 문항도 안 쓴다 |
| `additionalApplicantInfoConfig` | 전 항목 `NOT_RECEIVED` | 생년월일·학력·경력·어학 등 안 받는다 |
| `openingSettingInfo.requireAuthentication` | `false` | **로그인 불필요** |
| `docsInfo` | 「이력서 및 경력기술서」 **필수** · 「포트폴리오」 선택 · 둘 다 `enableUrl:false` | **URL 제출 불가, 파일만** |

**⭐ 그래서 `FAQ.md` §4(희망 연봉·입사 가능일·이직 사유)가 이 건을 막지 않는다.**
폼에 그 칸이 아예 없다. 이름·이메일·연락처 + 파일 하나면 제출이 끝난다.

**⚠ `enableUrl:false` 를 주의한다** — GitHub·가든 링크를 폼에 URL 로 넣을 자리가 없다.
이력서 본문의 링크가 유일한 공개 증거 입구다.

## 왜 이 직무였는가

**쏘카에 열린 개발/데이터 9건 중 이 자리를 골랐다.** 같은 이름의 `Platform Engineer (DBA)`
(https://socar.career.greetinghr.com/ko/o/225577) 는 **열지 않았다** — DBA 축은 증거가 없다.
`Product Engineer` 두 건은 경력 무관이라 문턱이 낮지만, 서사가 겹치는 쪽은 이 자리다.

**공고가 스스로 밝힌 문제 정의가 GLG 가 실제로 해 온 일이다.**

- **`티켓을 받아 처리하는 운영자가 아니라, 티켓 자체가 필요 없게 만드는 엔지니어를 찾습니다`** —
  40+ 스킬과 CLI 한 벌을 만든 이유가 그것이다. 사람이 매번 물어보게 두지 않고 **에이전트가
  질의할 수 있는 표면**으로 바꿨다.
- **`AI 도구(Claude Code 등)를 운영·인프라 작업에 깊이 통합해본 경험 — AI 없이 일하던 방식으로
  돌아가라고 하면 부자연스럽다고 느끼는 분`** — 우대 항목이 사람을 지목한 문장에 가깝다.
  Oracle Cloud ARM 에서 셀프호스팅 하네스를 **업스트림 20+ 버전 사이클** 동안 운영했고,
  하나의 스킬 SSOT 를 **다섯 개 하네스로 팬아웃**했다.
- **`Internal Developer Platform / 플랫폼-as-product 관점의 DevEx 개선`** — `agent-config` 가
  6개 소비 표면을 문서화하고 `./run.sh setup` → `./run.sh env` 로 링크·바이너리·인덱스 상태를
  스스로 진단한다. **설치형 셀프서비스 경로**이지 안내문이 아니다.
- **`모든 변경은 PR로 관리되고, 인프라는 셀프서비스가 원칙이며, AI는 기본 도구입니다`** —
  NixOS 4대 머신 · 17+ Docker 서비스를 **선언형으로** 관리한다. 툴은 다르지만
  (Nix ↔ OpenTofu) 「인프라를 코드로, 변경을 리포지터리로」라는 명제는 같다.
- **`AI 시대의 Platform Engineering은 어떤 모습이어야 하는가를 정답이 정해지지 않은 상태에서
  직접 설계하고 있습니다`** — 플레이북이 없는 자리에서 구조를 세우는 일이 GLG 의 반복 패턴이다
  (NEMO-UX 4년, 지금 회사의 에이전트 축).

### 경계 — 먼저 밝힌다. 이 건은 간극이 크다

- **SRE/DBA 직함으로 대규모 프로덕션을 운영한 5년이 없다.** 필수 첫 줄을 직함으로 못 댄다.
- **Kubernetes/EKS 운영 · Terraform/OpenTofu · Atlantis · ArgoCD 실적이 없다.**
  선언적 인프라는 **Nix 로** 댄다. 공고가 지명한 툴체인을 「경험」으로 포장하지 않는다.
- **Aurora MySQL · 온라인 DDL · 실행계획 분석 등 DBA 실무가 없다.**
- **Datadog / Prometheus / OpenTelemetry 관측성 스택 구축과 SLO 정의 경험이 없다.**
- 커널·파일시스템 연구(NVM 파일시스템·NUMA 락)는 신뢰성 사고의 근거는 되지만 **운영 이력이 아니다.**

**그래도 내는 이유**는 기조다 — 위로 찌르는 것이 기본값이고, **떨어져도 이름이 알려진다.**
면접까지 가면 대는 것은 「AWS 를 몇 년 만졌는가」가 아니라 **「운영을 코드로 흡수한 방식」**이다.

> **⭐ 2026-07-29 GLG 확정 — 낸다.** 위 간극은 사실 그대로 남겨 둔다. 재검토에서 「낼지
> GLG 가 정한다」로 열어 두었던 운영 판단이 **「오늘 낸다」로 닫혔다.** 필수 첫 줄을 직함으로
> 못 대는 것을 알고 내는 것이지, 요건을 다르게 읽어서 내는 것이 아니다.

## 이후 기록

- [2026-07-28] 건 생성. **쏘카 채용홈(`socarcorp.kr/careers/jobs`)의 `__NEXT_DATA__` 에서
  전체 28건 목록을 채집**하고, 본문·`docsInfo`·`questionnairesInfo` 는 `boards.py body` 로 떴다.
  브라우저를 열지 않았다.
- [2026-07-28] 컷 **DevEx** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
- [2026-07-29 오전, 오라클] **폼 전수 재실측 + 운영 판단 확정.** `questionnairesInfo=[]` ·
  `additionalApplicantInfoConfig` 전 항목 `NOT_RECEIVED` · `requireAuthentication=false` ·
  `docsInfo.enableUrl=false` 를 구조화 필드로 확인 → **`FAQ.md` §4 미정값 셋이 이 건을
  막지 않는다**(칸이 없다). `alive.py` **`status=OPEN`** 재확인(09:07 KST).
  **GLG 가 「낸다」로 확정**했다 — 재검토 경고는 사실로 보존한다.
