# 제출 기록 — Bear Robotics (베어로보틱스) / Systems Software Engineer (Linux Platform)

| 항목 | 값 |
|---|---|
| 상태 | **submitted** — GLG 가 브라우저에서 제출 완료. 개인·법적 값은 GLG 가 직접 입력했고 **값은 저장하지 않는다** |
| 지원일 | **2026-08-09** |
| 경로 | **Breezy HR** (`bear-robotics.breezy.hr`) — **이 저장소에서 처음 만나는 ATS** |
| 첨부 컷 | **Embedded** (`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`) |
| 추가 첨부 | **`submit/KimJunghan_Embedded_Experience_Detail.pdf` (3쪽)** → 폼의 **`기타 첨부 서류`(파일, 선택)** 칸. 칸은 2026-08-09 실측으로 확인했다(아래 §폼 실측). AX 축 깊이 문서는 여전히 이 자리의 답이 아니다 — **임베디드 축 중립판**을 새로 떴다. 정본·재현: `../telechips--embedded-sw-engineer/{experience-detail.md,build.sh}` |
| 공고 URL | https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform |
| **지원 URL** | **https://bear-robotics.breezy.hr/p/5d59d1cd221e-systems-software-engineer-linux-platform/apply** (HTTP 200 확인) |
| 근무지 | **Seoul, Korea** · 보고 라인 **Principal Software Engineer (USA)** |
| 회사 | 서빙로봇 20여개국 **2만대** · AMR · 한 공간 **1,000대 군집제어** · 200명+ ·
  **2025-05 LG전자 계열회사 편입** |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4411324046/`)와 같은 공고다.** offsite 라 Breezy 원본으로 낸다.

## 낸 것 — 2026-08-09 실제로 나간 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Embedded_Software_Engineer.pdf`
      (`6a318434…` · 2쪽 · **폼에 올린 유일한 파일**)
- [x] **커버레터** — `submit/cover-letter.txt` 본문을 폼의 `커버레터` textarea 에 붙여넣었다
      (2,762자). 07-29 에 「칸이 있는지 미실측」이던 자리가 실측으로 닫혔다.
- [x] **경험 요약** — `경험 요약` textarea (912자).
- [x] **구조화 경력 3건 · 학력 3건** — 아래 §구조화 경력·학력.
- [ ] ⛔ **`기타 첨부 서류`(선택) 는 올리지 않았다.**
      `submit/KimJunghan_Embedded_Experience_Detail.pdf` 를 깔아 두고 권고했지만
      **GLG 가 이력서 한 파일만 내기로 했다** — *「그냥 resume 파일 하나 냈어」*.
      파일은 세트에 남겨 둔다(다음 임베디드 건이 같은 산출물을 쓴다). **이 건에서는 안 나갔다.**

> ⚠ **`submit/README.md` 를 손으로 고쳤다.** 평소에는 `stage.py` 가 쓰고 손대지 않지만,
> `submitted` 건은 `stage.py` 가 건드리지 않으므로 **「이 폴더가 올라갈 파일 전부다」가
> 거짓인 채로 굳는다.** 08-01 IGNITE 에서 닫은 계약(*세트 문서가 사실일 때만 「세트 위에서
> 검수한다」가 성립한다*)을 지키려면 여기서 손으로 표시하는 것 외에 방법이 없다.

> **⚠ 공고 첫 줄이 `English CV must be submitted.` 다.** `resume/build/` 의 여섯 컷이 **전부 영문**이라
> 그대로 통과한다. **한글 서류를 만들지 않는다.**

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** Telechips · DEEPX BSP 건과 **같은 Embedded 컷**이다.

> **⛔ dossier 깊이 문서(AX Competency · Portfolio)를 붙이지 않는다 (2026-07-30 판정).**
> 2026-07-30 에 AX·에이전트 축 11건에는 이 2종을 세트에 깔았지만 **이 건은 뺐다.**
> 이 건의 컷은 **Embedded** 이고, 두 문서는 AX 전환·에이전트 플랫폼 축으로 쓰인 글이다.
> 같은 판단이 이미 Bear Robotics 커버레터에 적혀 있다 — *「에이전트·하네스·MCP 서사를
> 붙이면 지원자가 무엇을 하는 사람인지 흐려진다」*. **첨부를 늘리는 것이 성의가 아니라,
> 그 자리에 맞는 것을 내는 것이 성의다.**
> → 임베디드 축의 깊이 문서가 필요하면 **별도 조준 빌드**가 답이다. `dossier/` 정본은 한 벌
> 뿐이라 조준부를 바꿔 재빌드해야 하고, 선례는 `../deepx--*/build.sh`(이력서 컷 +
> `experience-detail.md` → `pdfunite`) 다. **NEXT.md 에 남겼다.**

## 폼 실측 — 2026-08-09 (지원 URL 의 DOM 을 그대로 읽었다 · 이 저장소 **Breezy 첫 실측**)

**커버레터 칸은 실제로 있다.** 07-29 에 「칸이 있는지는 미실측」으로 남겨 둔 자리가 닫혔다 —
`<textarea name="cCoverLetter">` 가 렌더된다. `submit/cover-letter.txt` 를 **전체 복사해 붙여넣는다**.

| 구역 | 항목 | 필수 | 메모 |
|---|---|---|---|
| 파일 | **이력서** (`cResume`) | ★ | `resume_required=required`. 네이티브 file input 이 DOM 에 **있다** |
| 기본 | 이름 · 이메일 · 전화 | ★ | `cName` · `cEmail` · `cPhoneNumber` |
| 기본 | 주소 (`cAddress`) · SMS 수신동의 | | |
| 이력 | 경력(회사·직함·기간·요약) · 학력(학교·전공·기간·요약) | | `work_required=optional` · `education_required=optional` |
| 서술 | **Experience Summary** (`cSummary`) | | `summary_required=optional` |
| 서술 | **Cover Letter** (`cCoverLetter`) | | ✅ **칸 확인** — `submit/cover-letter.txt` 자리 |
| 첨부 | **기타 첨부 서류** (파일) | | ✅ **선택 슬롯 존재** — §추가 첨부 행 참조 |

**필수 질문지(questionnaire)** — `questions` hidden input 에 스키마가 통째로 들어 있다.

| # | 질문 | 형식 | 필수 | 답의 출처 |
|---|---|---|---|---|
| 1 | 개인정보 수집 및 이용에 동의합니다 | 드롭다운 `동의합니다` | ★ | 🔴 **동의는 GLG 가 직접 누른다** |
| 2 | 장애인 및 보훈 대상자에 해당하나요? | 드롭다운 | ★ | **GLG 직접** — 「네」를 고르면 **증빙파일 필수 칸**이 분기로 열린다 |
| 3 | **병역 관련 사항** | 텍스트(서술) | ★ | **GLG 직접.** 값은 `hyundai-autoever--ai-agent-engineer/submit/KimJunghan_AutoEver_Detail_Form.md` 가 SSOT — 케이스로 복사하지 않는다 |
| 4 | Location (현재 거주지) | 텍스트 | ★ | **GLG 직접** (현주소는 위 스냅샷) |
| 5 | 국적 | 멀티선택 `Korean` / `Non-Korean` | ★ | **Korean** (Non-Korean 을 고르면 Visa sponsorship 칸이 분기로 열린다) |
| 6 | Join 가능한 시점 | 텍스트 | ★ | `FAQ.md` §4 — 「협의 가능 / 최종 합격·처우 협의 후 4주 이내」 |
| 7 | 지원 경로 | 텍스트 | ★ | 폼 예시가 `Wanted, Programmers, 피플앤잡, Linkedin, 사람인…` — **Linkedin** (GLG 가 건넨 링크가 LinkedIn 이다) |
| 8 | relocation / work authorization in Korea | 체크박스 `Yes` / `No` / `한국인 입니다.` | ★ | **`한국인 입니다.`** |

- ⚠ **EEOC 인종·성별 라디오가 `required` 로 렌더된다** (`eeoc=true`). 미국 본사 계열 폼이고
  `%EEOC_NO_ANSWER%`(응답 거부) 선택지가 있다. **GLG 가 직접 고른다.**
- 폼 안내문이 명시한다 — *「주민등록번호·가족관계·혼인여부·연봉·신체조건·출신지역을 요구하지
  않으니 제출서류에 포함하지 마세요」*. 이력서 컷은 이 항목들을 담고 있지 않아 통과한다.
- 봇 방지 honeypot 필드(`hp_*`)와 `form_token` 이 있다 — **폼은 브라우저에서 사람이 채운다.**

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `1년 이상` 을 크게 넘는다 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 — 요건은 학사다 | `FAQ.md` §3 |
| 영어 | 필수 항목이다(`비즈니스 영어 커뮤니케이션`). 보고 라인이 **미국**이다 | `FAQ.md` §6 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

## 왜 이 직무였는가

**이번 배치에서 필수 요건을 가장 여유 있게 통과하는 건이다.** 필수가 **Python/Go 시스템 데몬 ·
Bash 자동화 · 리눅스 시스템 · 경력 1년+** 다 — 전부 대는 축이고, **우대 여덟 줄 중 다섯이 직접
걸린다.**

- **`모바일·데스크탑 리눅스 시스템 구축 또는 커스터마이징`** — NEMO-UX 에서 **대형 터치
  디스플레이용 리눅스 기반 OS 를 직접 만들었다**(창업 4년). 지금은 NixOS 로 4대 머신을 선언형 구축.
- **`Debian/Ubuntu, Arch 등 패키지 배포·관리`** — Nix 로 매일 한다. 설치 시 **`vcs_revision` ·
  소스트리 다이제스트 · 바이너리 SHA-256** 을 기록해 **무엇이 깔렸는지 되짚을 수 있게** 만들었다.
- **`오픈소스 프로젝트 기여 또는 관리`** — 외부 저장소에 머지된 PR(ghostel #343 · #510).
- **`로봇 인증체계 개발·운영 및 접근정책 관리`** — **mTLS 브로커 + AWS IoT 이중 백엔드**를 설계했다.
- **`로봇 소프트웨어 배포·관리 인프라`** — ARM Linux · Yocto · static musl · board HAL.
  **실리콘부터 양산까지 한 번 끝까지 간** 이력이 그대로 붙는다.

**회사 규모 기준도 통과한다** — LG전자 계열, 200명+, 20개국 2만대. **위로 찌르는 기본값**에 맞다.

**경계는 먼저 밝힌다.** **Terraform 등 IaC 툴체인 실적이 없다**(우대) — 선언적 인프라는 Nix 로 댄다.
**로봇/ROS 경험이 없다** — 다만 이 자리는 자율주행 알고리즘이 아니라 **로봇을 떠받치는 리눅스
플랫폼·배포·인증 인프라**다. **리눅스 보안 인프라를 직무로 해 본 적은 없다.**
**영어 상시 회의 축은 확인이 필요하다**(`FAQ.md` §6).

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **exa-search 로 Breezy 원본 공고를 찾아** 지원 URL(HTTP 200)까지 확인했다.
- [2026-07-28] 컷 **Embedded** 확정. 상태 `ready` — **제출 대기**.
- [2026-07-29] **커버레터 초안 작성** (`cover-letter.md`). 골격은 Holiday 판을 따랐다 —
  §붙여넣을 본문 + §왜 이렇게 썼는가 + §쓰지 않은 것. `stage.py` 가 `submit/cover-letter.txt`
  로 깐다. **다음 판에서 GPT 교열**(2026-07-29 분업).
- [2026-08-09] ⭐ **GLG override — 임베디드/시스템 축을 이번에 실제로 낸다.**
  `AGENTS.md` §불변식 §「담당업무에 AI 가 없으면 거른다」가 07-28 에 이 건을 ⛔ 로 판정했고
  (*「AI 서비스 로봇 회사지만 보직은 로봇 리눅스·배포·인증 인프라」*), 그 판정 자체는 지금도
  사실이다. **바뀐 것은 판정이 아니라 GLG 의 결정이다** — 넓게 제출하는 이번 판에서 이 축을
  살린다. 계약대로 **override 와 이유를 지우지 않고 남긴다**(`AGENTS.md` §사람의 권한).
- [2026-08-09] **공고 생존 재확인** — Breezy `/apply` HTTP 200.
- [2026-08-09] **폼 전체를 실측했다** (위 §폼 실측). 07-29 의 미실측 두 자리가 닫혔다 —
  **커버레터 칸 있음** · **기타 첨부(선택) 슬롯 있음**. 이 저장소의 **Breezy 첫 실측**이라
  `../AGENTS.md` §외부 ATS 에 올릴 값이다. 아무 값도 입력하지 않았다.
- [2026-08-09] 🔴 **폼에 이미 채워져 있던 구조화 경력 6줄이 SSOT 와 어긋났다.** 아래
  §구조화 경력·학력 이 정본이다. **제출 직전에 잡았다.**
- [2026-08-09] ✅ **제출 완료.** GLG 가 브라우저에서 개인·법적 값(전화·주소·병역·Location·
  국적·입사가능시점·지원경로·장애/보훈·EEOC·개인정보 동의)을 직접 입력하고 최종 제출했다.
  **값은 이 저장소에 저장하지 않는다.** EEOC 는 화면 문구가 *"requested (not required)"* 였고
  응답 거부 선택지가 있었다 — 정부 보고용이며 선발 기준이 아니라고 폼이 명시한다.
  첨부는 **이력서 PDF 한 파일**만 나갔다(위 §낸 것).

## 구조화 경력·학력 — 폼 자동 채움이 SSOT 와 어긋났다 (2026-08-09)

**폼을 열었더니 경력 6줄이 이미 들어 있었다.** Breezy 가 업로드된 이력서 PDF 를 파싱해
**프로젝트를 재직 경력으로** 밀어 넣은 것이다. 그대로 냈으면 네 가지를 잘못 신고했다.

| 자동 채워져 있던 값 | 무엇이 틀렸나 |
|---|---|
| `GoQual / driver / 2025-12 ~ 2026-07`<br>`GoQual / PM / 2025-09 ~ 2026-07`<br>`GoQual / Full Stack Architect / 2025-06 ~ 2026-07` | **한 회사가 세 재직으로 쪼개졌고 셋 다 퇴사 처리**됐다. 실제는 **재직 중**이고, 저 셋은 사내 프로젝트다 |
| `IITP / agent system on n8n / 2025-06 ~ 2025-09` | 🔴 **IITP 를 고용주로 신고**하게 된다. IITP 는 국책과제 **발주 기관**이지 재직한 곳이 아니다 |
| `Virginia Tech COSMOSS Lab / exchange researcher / 2019-07 ~ 2020-03` | 재직이 아니라 **연구실 재직 기간 안의 교환연구 9개월**이다. 별도 재직으로 올리면 이중 계상이 된다 |
| `NEMO UX / Co founder / 2013-01 ~ 2017-12` | 🔴 `FAQ.md` §3 이 정확히 이 자리를 못 박아 뒀다 — *「구조화 폼에 2013 을 쓰면 **재직하지 않은 기간을 재직으로 신고**하는 것이 된다」*. 구조화 칸의 값은 **2015.08 – 2017.08** |
| (성균관대 분산컴퓨팅랩이 **통째로 없었다**) | 5년짜리 계약직 재직이 빠지고 그 안의 9개월만 남아 있었다 |

**GLG 승인 뒤 SSOT 3줄로 다시 넣었다** (*「응 다시 넣어 잘못들어갔네? 응 3개만 적어줘」*).

| # | 회사 | 직위 | 기간 |
|---|---|---|---|
| 1 | GoQual Inc. | Full Stack Architect, Development Team | 2025-06 ~ **재직 중**(종료일 비움) |
| 2 | Sungkyunkwan University — Distributed Computing Lab | Doctoral Researcher (contract) | 2017-08 ~ 2022-07 |
| 3 | NEMO-UX | Co-founder | 2015-08 ~ 2017-08 |

**학력 칸도 비어 있어 SSOT 대로 3건을 채웠다.**

| # | 학교 | 과정 | 기간 |
|---|---|---|---|
| 1 | Sungkyunkwan University, Graduate School | M.S., Electrical and Computer Engineering | 2008-03 ~ 2010-02 |
| 2 | Sejong University | B.E., Computer Software Engineering | 2004-03 ~ 2008-02 |
| 3 | Sungkyunkwan University, Graduate School | **Ph.D. coursework completed**(수료) | 2010-03 ~ 2012-08 |

박사는 `coursework completed; degree not conferred` 로 명시했다 — 수료를 학위처럼 읽히게
두지 않는다.

**값의 SSOT 는 `../hyundai-autoever--ai-agent-engineer/submit/KimJunghan_AutoEver_Detail_Form.md`**
(GLG 가 실제 제출 화면에서 복사한 스냅샷)와 `../FAQ.md` §3 이다. **여기로 값을 복사하지
않았다** — 위 표는 *어느 칸에 무엇이 들어갔는가*의 기록이고, 신원·법적 값의 정본은 스냅샷 하나다.

> ⭐ **이 사고는 이 건만의 것이 아니다.** 구조화 경력 칸을 이력서 파싱으로 자동 채우는 ATS 는
> 전부 같은 일을 한다. **자동 채워진 값은 값이 아니라 초안이다** — 제출 전에 SSOT 와 한 줄씩
> 대조한다. 계약으로 올렸다: `../AGENTS.md` §외부 ATS `breezy.hr` · `../LEDGER.md` §계보 08-09.
