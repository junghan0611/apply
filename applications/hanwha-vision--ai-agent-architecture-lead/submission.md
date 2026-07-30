# 제출 기록 — Hanwha Vision (한화비전) / AI Agent Architecture Lead

| 항목 | 값 |
|---|---|
| 상태 | **submitted** — 2026-07-30 **제출 완료** (GLG 가 ninehire 에 직접 업로드) |
| 지원일 | **2026-07-30** |
| 경로 | **ninehire** (`hanwhavision.ninehire.site`) — 확정 |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`) + **포트폴리오** |
| 공고 URL | https://www.linkedin.com/jobs/view/4438028734/ |
| **지원 URL** | **`https://hanwhavision.ninehire.site/job_posting/6NDP9uTE`** ✅ (`/apply` 가 폼) |
| 근무지 | **한화비전 판교R&D센터 · 경기 성남시 분당구 판교로319번길 6** ✅ |
| 등급 | **Director** · 정규직 · **석사 이상 + 실무 10년 이상** |
| 공고 상태 | `status=in_progress` · `closedAt=null` · **`deadlineType=until_filled`**(채용 시 마감) · 게시 2026-07-13 |

## 왜 이 회사인가 (이 건의 글)

**지금까지 연 20여 건 중 공고 본문이 GLG 의 공개 작업물을 가장 정확히 가리키는 자리다.**

공고는 세 가지를 총괄하라고 한다. (1) 복잡한 비즈니스 로직을 분해해 **태스크별 에이전트를
정의**하고, (2) 에이전트 간 **상태 관리·조건부 라우팅·예외 처리 아키텍처**를 잡고, (3) 대규모
분산 서버와 **레거시 시스템·영상 관제(VMS) 인프라**를 에이전트와 **안전하게 연결하는 연동
프로토콜(MCP 등) 레이어를 설계하고 표준화**하라고.

세 번째가 결정적이다. **`entwurf` 가 정확히 그 물건이다** — 서로 다른 하네스가 **상대의
transcript·auth·runtime 을 소유하지 않고** id 로 서로를 주소하는 기층. OAuth 프록시도, CLI
transcript 스크래핑도, 백엔드 신원 교체도 없이. 그리고 그것이 **설계 주장에 그치지 않았다**:
한 번도 만난 적 없는 개발자가 **Snowflake Cortex Code ACP 백엔드**를 기여했고(11파일 +885줄),
**아키텍처가 있다고 말한 바로 그 확장 지점**을 찾아 들어왔다. 30일 npm 설치 1,395건.

「대규모 레거시 파이프라인과 AI 모델의 결합」도 추상이 아니다. 현직의 **인시던트 워크벤치**가
덤프를 쌓지 않고 실소스에서 읽어 **플랫폼 DDL 카탈로그 · 디바이스 로그 · 런타임 미러를 하나의
KST 축에** 세운다. 증거 계약이 깨지면 경고가 아니라 **멈춘다** — 관제 도메인이 요구하는 성질이
바로 그것이다.

**우대 항목 다섯 중 넷에 공개 증거가 있다** (RAG·지식그래프·벡터DB / MCP 기여 / 레이턴시·비용
저감 / 레거시+AI 결합). 나머지 하나(영상보안 도메인)가 경계다.

## 컷과 첨부

- **이력서**: `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
- **포트폴리오**: 공고가 **명시적으로 요청**한다 — *"깃헙, 노션 등 프로젝트가 정리된 자료"*.
  `dossier/` 에 이미 만든 **역량·성과 기술서 + 포트폴리오 PDF 2종 + 증거 패키지**가 있다.
  **이 건에 맞춰 재편해서 쓴다** (`dossier/` 원본은 건드리지 않고 이 폴더 `submit/` 에 사본).
- 공개 증거 입구: 저장소 12종 + `agenda.junghanacs.com/api/stats`

## ✅ 지원 URL — 해소됨 (2026-07-29 브라우저)

**`https://hanwhavision.ninehire.site/job_posting/6NDP9uTE`**

전날의 추론이 맞았다. **ninehire 이면서 공개 목록에 없는 공고**다 — LinkedIn 공고의
「회사 사이트에서 지원」이 이 URL 로 바로 튄다. `__NEXT_DATA__` 는 `alwaysExposure=true` 인데도
보드 목록 API 에는 안 잡힌다. **ninehire 는 목록에 없는 공고가 URL 로 살아 있다**는 것이
이제 두 번째 실측이다(`weLEZzYc` 에 이어).

> **교훈**: ninehire 회사에서 「보드 목록에 없다」는 **공고가 닫혔다는 뜻이 아니다.**
> LinkedIn 의 apply 링크를 브라우저로 한 번 튕겨 보는 것이 목록을 뒤지는 것보다 빠르다.

## 폼 스키마 — 브라우저 실측 (2026-07-29)

`/job_posting/6NDP9uTE/apply` · **로그인 없음**(`applicantLoginEnabled=false`).

| 필드 | 필수 | 넣을 값 |
|---|---|---|
| 이름 | **필수** | `김정한` |
| **지원경로** | **필수** | 드롭다운 → **`링크드인`** (한화인 · 원티드 · 프로그래머스 · 점핏 · **링크드인** · 사람인 …) |
| 이메일 | **필수** | `[email removed]` |
| 연락처 | **필수** | GLG 가 직접 |
| **생년월일** | **필수** | GLG 가 직접 — *"면접 진행 시 방문자 등록을 위해"*. **Git 에 남기지 않는다** |
| **이력서** | **필수** | 파일 (50MB 이하, 자동 PDF 변환) — AI Engineer 컷 |
| **포트폴리오** | **필수**(공고가 명시) | 파일 — `dossier/` 산출물 재편 |
| 참고 링크 | 선택 | `https://github.com/junghan0611` · `https://notes.junghanacs.com` |
| [선택] 선택항목 수집 동의 | 선택 | **체크 권장** — 미동의 시 *"우대자격 인정 등에 있어 불이익"*. 포트폴리오·참고링크가 이 동의에 걸린다 |
| [선택] 인재풀 활용 동의 | 선택 | ✅ **체크한다** (2026-07-29 GLG, `FAQ.md` §5). 3년 보유 — 이 건의 목적이 인력풀 등재다 |
| [필수] 개인정보 수집 동의 | **필수** | 체크 |

**서술형 칸이 하나도 없다.** Enhans 실측과 같다 — **이력서와 포트폴리오가 서류의 전부**다.
자기소개서·지원동기를 쓸 자리가 없으므로, **이 건의 승부는 포트폴리오 한 벌에서 갈린다.**

**⚠ ninehire 는 파일 업로드를 에이전트가 못 한다** — Enhans 건에서 실측. GLG 노트북에서 올린다.

**⚠ 「선택항목 수집 동의」를 반드시 체크한다.** 이 폼에서 포트폴리오와 참고 링크는 *선택항목*
으로 분류돼 있고, 미동의 시 *"해당 자료의 처리가 불가능"* 하다고 명시돼 있다. 공고는
포트폴리오를 **필수**로 요구한다 — 동의를 빼면 필수 서류가 처리되지 않는 모순에 빠진다.

## 면접에서 물을 것 — 미리 답을 준비해 둔다

1. **"팀장 경험"** — `Director` 등급이다. GLG 의 리드는 창업자·아키텍트 형태이고 인사권을 가진
   팀 운영은 아니다. 대신 **3-agent 병렬 개발 세션에서 사람이 PM 을 맡은 구조**, 리뷰·핸드백을
   강제하는 `forge-config` 운영 정책이 "조직을 이끈 방식"의 실물이다.
2. **실무 10년 산정** — 대학원 4년(2018–2022)을 어떻게 계산할지. NEMO-UX 4년 + 독립 운영 +
   현직으로 세면 넘지만, 물어볼 수 있다.
3. **영상보안/VMS 무경험** — 인정하고, 인시던트 워크벤치의 「실소스·단일 시간축·계약 위반 시
   정지」로 옮겨 붙인다.

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_AI_Engineer.pdf` → 폼 `이력서`(필수)
- [x] **포트폴리오 합본 18쪽** — `submit/KimJunghan_Hanwha_Portfolio.pdf` → 폼 `포트폴리오`(필수)
- [x] 참고 링크 · **동의 3종 전부 체크**(선택항목 · 인재풀 · 필수) — GLG 직접

> **✅ 2026-07-30 폼 재실측 — 7/29 스키마와 100% 일치했다.** 필드·동의 문구·순서가 그대로였고
> 서술형 칸도 여전히 없다. **`ninehire` 는 에이전트가 파일을 올릴 수 없다는 것도 재확인**했다 —
> `이력서`·`포트폴리오` 버튼 뒤에 **`input[type=file]` 이 DOM 에 없고** 네이티브 파일 다이얼로그를
> 여는 구조다(`find` 로 hidden file input 조회 → 0건). Enhans 실측에 이어 **두 번째 확인**이므로
> **ninehire 계열은 처음부터 GLG 업로드로 계획한다** — 카카오헬스케어·Telechips 도 같다.

### 이하 원래 계획 (참고)

- [x] ~~**이력서 PDF** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`~~
- [x] **포트폴리오 합본** — ✅ **`submit/KimJunghan_Hanwha_Portfolio.pdf` 생성 완료 (18쪽, 4.2M)**.
      `cover-sheet.md` → 표지 1장(`build/00-cover.pdf` — ⚠ `submit/` 아님) + **`dossier/build/` 산출물 PDF 2종**
      `gs` 합본. 11:46 GPT 검수에서 2쪽 첫 문장의 옛 공고 조준을 발견해,
      `dossier/competency.org` 프롤로그와 `dossier/portfolio.org` 앞 표/문장을
      **AI Agent Architecture Lead 축으로 최소 교체**한 뒤 재빌드·재합본했다.
- [x] ~~커버레터~~ — **N/A 확정.** 폼에 서술형 칸이 **하나도 없다**(2026-07-29 실측).
      쓸 자리가 없으므로 만들지 않는다

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 지원경로 | **링크드인** | 실제 발견 경로 |
| (그 외 서술형 문항 없음) | — | 브라우저 실측 2026-07-29 |

## 기조 — 기대값을 낮춘다 (2026-07-29 GLG)

**이 건의 목적은 합격이 아니라 인력풀에 힣을 소개하는 것이다.** GLG 판단: 국내 이름 있는
기업들이 이런 공고로 인력 정보를 모으는 구조이고, 실체는 크지 않다. **그래서 완성도를 올리려고
오늘 제출 흐름을 막지 않는다** — 가진 증거를 그대로 쏟아내서 던진다.

- **재래식 코딩테스트를 요구하면 「못 한다」고 답한다.** 결이 안 맞는 것이지 못 하는 것이
  아니라는 판단이고, 그 자리에서 굽히지 않는다. 전형이 그 방향으로 가면 거기서 끊는다.
- 포트폴리오를 **새로 쓰지 않는다.** 이미 있는 `dossier/` 산출물의 **조준부만 갈아 끼운다**.

## 포트폴리오 — 표지 + 조준부 최소 교체 + 합본

이 폼에는 글을 쓸 자리가 없다. **포트폴리오가 유일하게 「왜 이 사람인가」를 말하는 문서다.**

### 2026-07-29 GPT 검수 — 표지만으로는 부족했다

오전 서버 실측에서 이미 확인했듯 `dossier/` 는 회사명은 중립이지만 **공고 중립은 아니었다**.
처음 채택안은 표지 1장을 앞에 붙여 뒤쪽 NHN 조준부를 읽는 지도로 덮는 것이었으나, GPT가
제출 세트 실물을 다시 열어 보니 병합본 **2쪽 첫 문장**이 바로
`'AX 전환 / AI 인프라(백엔드)' 공고`로 시작했다. 서술형 칸이 없는 한화 폼에서 이건 너무
눈에 띄는 결함이다.

그래서 아래 세 좌표를 **AI Agent Architecture Lead 축으로 최소 교체**했다.

| 위치 | 교체 내용 |
|---|---|
| `dossier/competency.org` 프롤로그 첫 문장 | `AI Agent Architecture Lead` 공고 — 에이전트를 조직의 실제 시스템에 안전하게 붙이는 일 |
| `dossier/portfolio.org` 앞 표 `공고 대응` 컬럼 | 한화 주요 업무 ①②③ + 우대(RAG·지식그래프·벡터DB) 매핑 |
| `dossier/portfolio.org` 표 뒤 문장 | AI 문서 작성·배포·교육 문구 제거, 전달 계층 설명으로 일반화 |

```text
[표지 1장]  +  KimJunghan_AX_Competency.pdf(5쪽)  +  KimJunghan_AX_Portfolio.pdf(12쪽)
                                                                      = 18쪽 한 파일
```

- `dossier/run.sh all` 재빌드: Competency 5p · Portfolio 12p, verify 통과.
- `gs` 재합본: `submit/KimJunghan_Hanwha_Portfolio.pdf` 18쪽.
- 재검색: 병합 PDF 안에서 `NHN`, `AX 전환 / AI 인프라(백엔드)`, 옛 `공고 두 번째 주요 업무` 문구 없음.
- 표지는 여전히 자기소개서 자리이고, 뒤쪽 본문 첫 조준부도 한화 축으로 맞췄다.

**① 표지 매핑표**

| # | 프로젝트 | 한화비전 공고 대응 |
|---|---|---|
| 1 | AX 전환 인프라·도메인 에이전트 | 주요 업무 ① **비즈니스 로직 분해 → 태스크별 에이전트 정의** |
| 2 | OpenClaw 운영 | 주요 업무 ② **예외 처리 아키텍처** — 상류 변경·장애를 운영 규칙으로 |
| 3 | andenken | 우대 — **RAG·지식그래프·벡터DB** · 레이턴시·비용 저감 |
| 4 | entwurf·forge-config | ⭐ 주요 업무 ③ **연동 프로토콜(MCP 등) 레이어 설계·표준화** |
| 5 | Embedded·제품 | 주요 업무 ② **상태 관리·조건부 라우팅**(`HubState` 단일 상태기계) · ③ **레거시·분산 인프라 결합** |

**② 표지 여는 문단 (그대로 쓴다)**

> 'AI Agent Architecture Lead' 공고의 주요 업무를 저는 한 겹의 문제로 읽었습니다 — **에이전트를
> 조직의 실제 시스템에 안전하게 붙이는 일**입니다. 태스크별 에이전트를 정의하는 것도, 상태와
> 라우팅과 예외를 설계하는 것도, 레거시·관제 인프라와 잇는 프로토콜 레이어를 표준화하는 것도
> 결국 같은 문제의 세 면입니다. 저는 그 세 면을 각각 다른 자리에서 한 번씩 지나왔습니다.
> 이어지는 역량·성과 기술서와 포트폴리오를 위 표의 대응대로 읽어 주십시오.

**③ 표지 닫는 한 줄** — 경계를 먼저 밝힌다.

> 영상보안·VMS 도메인 경험은 없습니다. 그 자리를 4번(연동 프로토콜 레이어)과 5번(레거시·분산
> 인프라 결합)으로 대신 채웁니다.

**⏸ 대안(오늘 쓰지 않는다) — org 소스 3자리 직접 교체.** `portfolio.org:45-51` 표 ·
`portfolio.org:53` · `competency.org:189` 를 고치고 재빌드하면 문서 자체가 조준된다. 더 깔끔하지만
**파이프라인이 무겁다는 GLG 판단으로 보류**한다. 나중에 dossier 를 공고별 변수 구조로 바꿀 때
이 세 좌표가 그대로 작업 목록이 된다.

### 축 셋의 근거 (본문에서 이미 증명된 것)

1. **MCP 연동 레이어 표준화** — 공고 세 번째 줄. 설계 주장이 아니라 **모르는 개발자가 그
   확장점을 찾아 들어왔다**(entwurf#40, 11파일 +885줄)는 제3자 행동이 근거다.
2. **상태 관리·조건부 라우팅·예외 처리** — `HubState` 단일 상태기계(드라이버·프로토콜·클라우드
   3계층), n8n 40+ 노드 계층 에이전트, `forge-config` 의 캡처→오너십→리뷰→핸드백 루프.
3. **레거시 + AI 결합 / 대규모 파이프라인** — 인시던트 워크벤치. 덤프를 쌓지 않고 실소스에서
   읽어 DDL 카탈로그·디바이스 로그·런타임 미러를 **단일 KST 축**에 세우고, 증거 계약이 깨지면
   **경고가 아니라 멈춘다.** 관제 도메인이 요구하는 성질이 정확히 이것이다.

**영상보안/VMS 무경험은 포트폴리오에서 감추지 않는다** — 3번 축이 그 자리를 대신 메운다.

### 「다 쏟아낸다」— 포트폴리오 슬롯은 하나, 문서는 둘

폼의 포트폴리오 슬롯은 **파일 하나**(50MB 이하)다. 역량·성과 기술서와 포트폴리오를 **합본
한 파일**로 내면 둘 다 들어간다. 서버에서 병합 가능성을 실측했다:

```bash
gs -dNOPAUSE -dBATCH -dQUIET -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress \
   -dDetectDuplicateImages=true -sOutputFile=KimJunghan_Hanwha_Portfolio.pdf \
   KimJunghan_AX_Competency.pdf KimJunghan_AX_Portfolio.pdf
```

**결과 17쪽 · 4.0M** — 한글 활자·인포그래픽 손상 없음(1쪽·6쪽 렌더 확인). 폼 상한의 12% 다.
순서는 **역량기술서 먼저**다 — 서술형 칸이 없으니 글이 먼저 오고 프로젝트가 뒤를 받친다.

### ✅ 막혔던 곳 — 노트북에서 풀렸다 (2026-07-29 11:00)

서버(오라클)에서는 「마크다운 한 장 → PDF」 경로가 없어 막혀 있었다. **노트북에는 Chrome 이
있어서 풀렸고, 결과를 재사용 가능한 스크립트로 남겼다** — `applications/md2pdf.sh`.

| 후보 | 판정 |
|---|---|
| `dossier/run.sh` · `resume/run.sh` | ⛔ `emacs → ox-latex → xelatex(flake)`. 정본 문서용이고 표지 한 장에 쓸 것이 아니다 |
| `pandoc --pdf-engine=typst` | ⛔ 노트북에도 `typst` 가 없다. 도입은 `nixos-config` 변경이라 GLG 판단 |
| **`pandoc`(md→HTML) → Chrome headless(→PDF)** | ✅ **채택.** TeX·typst·LibreOffice 전부 불필요 |
| `gs` 병합 | ✅ 합치는 것은 서버에서도 된다 |

⚠ **폰트를 심어야 한다.** Chrome 이 fontconfig 로 고르게 두면 CSS 에 `Pretendard` 를 1순위로
적어도 **D2Coding(코딩용 고정폭)** 으로 떨어진다. 그래서 `md2pdf.sh` 는 Pretendard Regular/Bold 를
**data URI 로 HTML 안에 심는다.** 실측으로 확인한 것이고, 다음 한 장짜리 문서도 같은 함정을 만난다.

### 낼 때 순서 — 실행 완료 (2026-07-29 11:00)

```bash
cd ~/repos/gh/apply/applications/hanwha-vision--ai-agent-architecture-lead

# ① 표지 md → PDF (한 장) — ⚠ `submit/` 이 아니라 build 자리에 굽는다
#    2026-07-30: `stage.py` 가 `submit/00-cover.pdf` 를 **치운다.** 합본 입력용 중간
#    산물이 제출 폴더에 있으면 「폴더가 올라갈 파일 전부」라는 README 와 모순이고,
#    카페에서 폴더 기준으로 움직이면 그대로 올라간다 (GPT 재검).
mkdir -p build
../md2pdf.sh cover-sheet.md build/00-cover.pdf         # → 1쪽

# ② 표지 + 역량기술서 + 포트폴리오 = 한 파일  (순서 중요: 글이 먼저)
#    ⚠ 입력은 dossier/build/ 다. NHN 제출 스냅샷(../nhn--*/submit/)은 2026-07-29 수치
#      정리 이전 판이라 재사용하지 않는다.
D=../../dossier/build
gs -dNOPAUSE -dBATCH -dQUIET -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress \
   -dDetectDuplicateImages=true \
   -sOutputFile=submit/KimJunghan_Hanwha_Portfolio.pdf \
   build/00-cover.pdf "$D/KimJunghan_AX_Competency.pdf" "$D/KimJunghan_AX_Portfolio.pdf"

# ③ 검수 — 18쪽인지 (표지1 + 역량5 + 포트폴리오12)
gs -q -dNODISPLAY -dNOSAFER \
   -c "(submit/KimJunghan_Hanwha_Portfolio.pdf) (r) file runpdfbegin pdfpagecount = quit"
```

**검수 결과**: 18쪽 · 4.2M. 표지는 Pretendard 벡터로 굽혔고 표·볼드·한글 정상,
합본 2쪽(역량기술서 첫 장)에서 그림·링크 손상 없음을 렌더링으로 확인했다.

⭐ **11:22 재합본** — GLG 의 수치 판단(`AGENTS.md` §불변식 §숫자)으로 `dossier/` 세 소스에서
자가 측정 수치를 걷어내고 재빌드했다(Competency 5p · Portfolio 12p, **쪽수 불변**, verify 통과).
합본 입력을 **NHN 제출 스냅샷 → `dossier/build/`** 로 바꿔 다시 만들었다.

⭐ **11:46 GPT 재검수 재합본** — 병합본 2쪽 첫 문장에 남아 있던 옛 공고 조준을 발견했다.
`dossier/competency.org` 프롤로그와 `dossier/portfolio.org` 앞 표/문장을 한화 `AI Agent
Architecture Lead` 축으로 최소 교체하고 재빌드·재합본했다. 병합 PDF 전문 재검색에서 `NHN`,
`AX 전환 / AI 인프라(백엔드)`, 옛 `공고 두 번째 주요 업무` 문구가 나오지 않는다.

**업로드**

| 폼 슬롯 | 파일 |
|---|---|
| 이력서 (필수) | `resume/build/KimJunghan_Resume_AI_Engineer.pdf` |
| **포트폴리오 (필수)** | `submit/KimJunghan_Hanwha_Portfolio.pdf` (18쪽) |
| 참고 링크 (선택) | `https://github.com/junghan0611` · `https://notes.junghanacs.com` |

- ⚠ **「선택항목 수집 동의」를 반드시 체크한다** — 미동의 시 포트폴리오가 처리되지 않는다
- ⚠ **ninehire 는 에이전트가 파일 업로드를 못 한다** — GLG 가 직접 올린다
- 낸 뒤 `LEDGER.md` + 이 문서를 `submitted` 로 함께 닫고 `applications/check.py`

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 링크를 던졌다("직무가 맞아보여서"). LinkedIn guest API 로
  **본문 전문 확보**. 회사명은 카드에 없어 `ljobs.py search "AI 에이전트 오케스트레이션"` 으로
  역추적했다 — **Hanwha Vision**.
- [2026-07-28] 지원 경로 추적: ninehire 보드 목록에 **이 공고 없음**. 형식 대조로 ninehire
  계열은 확인. **지원 URL 은 브라우저 몫으로 남긴다.**
- [2026-07-29] **브라우저로 해소.** 지원 URL `6NDP9uTE` 확정 · 폼 스키마 전체 실측 ·
  근무지 **판교R&D센터** 확정 · 공고 `until_filled` 로 열려 있음 확인.
  남은 것은 **표지 PDF 생성 + 합본 한 파일**이다.
- [2026-07-29 11:00, 노트북] **첨부 완성.** `md2pdf.sh`(pandoc → Chrome headless, Pretendard
  data URI 심기)로 표지 1장을 굽고 `gs` 로 합본 → `submit/KimJunghan_Hanwha_Portfolio.pdf`
  **18쪽 4.2M**. `draft` → **`ready`**. 남은 것은 GLG 의 ninehire 업로드뿐이다.
- [2026-07-29 오전, 오라클] **기존 제출본 재사용 검사 → 「조건부」.** 회사명은 없지만
  `공고 대응` 컬럼과 프롤로그 첫 문장이 **NHN 공고 번호에 묶여 있다**는 결함을 확인했다.
  처음에는 표지 1장으로 덮는 전략을 택했으나, 이후 GPT 검수에서 병합본 2쪽 첫 문장이 너무
  눈에 띈다고 보고 세 좌표를 실제로 교체했다. **기조 갱신(GLG)**: 기대값 낮춤 · 목적은
  인력풀 소개 · 재래식 코딩테스트 요구 시 거절.
