# AGENTS.md — 보관한 dossier 샘플

> **2026-10-16 GLG: 아래는 과거 레인의 계약을 보존한 기록이다.** 현재 경력·연구·자기소개·시스템
> 포트폴리오의 편집 입구는 루트 기준 `resume/body.org`, 생성 뷰는 `resume/`다. 이 샘플을 두 번째
> 활성 정본으로 고치지 않는다. `dossier/`의 tracked 소스만 이곳으로 옮겼으며 원래 위치의 로컬
> build/package와 건별 submit은 그대로 보존한다. 옛 경로·직무·분량 지시는 현재 제출 지시가 아니다.
> 예제 실행은 /tmp 사본에서만 한다. 공개·라이선스는 루트의 현재 계약을 따르고, 상세 역할은 README를 읽는다.

## 이하: 과거 dossier 발사대 계약 (역량기술서 · 포트폴리오 · 증거패키지)

이 레인은 공개 프로필 페이지가 아니라 **실제 채용 제출본을 만드는 작업면**이다.
공개 웹 문서와 섞지 않는다 — 그쪽은 **다른 저장소**(프로필 repo `junghan0611/junghan0611`의
`apply/ax/`)에 있다. 이름이 겹치지만 이 저장소가 아니다.

## 이 레인의 자리 — 깊이 축이다 (2026-07-29 GLG)

`resume/` 가 **여섯 컷**을 뽑는 발사대라면, 여기는 **한 건에 조준한 두꺼운 문서 한 벌**을
뽑는 발사대다. 둘 다 `applications/` 로 쏘고, 실제로 낸 사본은 각 건의 `submit/` 이 쥔다.

> **GLG**: *"nhn 그 폴더는 timeline 스킬과 쌍으로 만들면서 신경을 쓴 거야. 어느 정도 우리가
> 표준 제출 구조가 잡히면 각 문서들에 더 표준 문서 + timeline 기준 디테일 정보를 담는
> 방식으로 문서 자체의 깊이를 차별화할 수 있다. 지금 applications 의 방향은 여러 곳 제출
> 플랫폼을 갖추는 방향이고, 다 갖춰지면 힣의 스타일의 고도화를 이어가는 거야."*

**두 축을 헷갈리지 않는다.**

| 축 | 지금 하는 일 | 어디 |
|---|---|---|
| **넓이** — 제출 플랫폼 확보 | ATS 아홉 종의 경로·폼 스키마를 실측해 낼 수 있게 만든다 | `applications/` |
| **깊이** — 문서 자체의 차별화 | timeline 기준 디테일을 표준 문서에 얹어 남과 다른 문서를 만든다 | **여기** |

**순서가 있다.** 넓이가 먼저다 — 낼 곳이 갖춰지기 전에 깊이를 파면 낼 곳이 없다.
깊이 축을 열 때는 `timeline` 스킬(고정 KST 축 · 반개방 구간 · provenance)이 이 문서들의
디테일 공급원이라는 것을 전제로 쓴다. **이 레인은 그 쌍을 염두에 두고 만들어졌다.**

## 회사 이름을 폴더에 붙이지 않는다

이 폴더는 2026-07-20 NHN 지원 때 `nhn/` 이라는 이름으로 처음 만들어졌다. 그러나 안에 있는
것은 **NHN 전용물이 아니라 재사용 가능한 생성기**였고, 한화비전·NHN 2번째 건이 이미 재사용을
예정하고 있었다. **2026-07-29 에 `dossier/` 로 옮겼다.**

그 지원 한 건의 기록(공고·추천·실제 낸 파일)은
`../../../applications/nhn--ax-transformation-ai-infra/` 로 갔다. **생성기와 제출 기록은 다른 물건이다.**

## 목표 산출물

최종 업로드 파일은 세 개다.

1. `KimJunghan_AX_Competency.pdf` — JD 관련 역량 및 성과 기술서
2. `KimJunghan_AX_Portfolio.pdf` — 이미지와 프로젝트 중심 포트폴리오
3. `KimJunghan_AX_Evidence_Package.zip` — 상세 Markdown과 재현 파이프라인을 담은 증거 패키지

ZIP 루트에는 최소한 다음이 있어야 한다.

- `README.md`
- `AGENTS.md` — 저장소 개발 지침이 아니라 `AGENTS.package.md`에서 만든 담당 에이전트용 탐색 계약
- `KimJunghan_AX_Competency.md`
- `KimJunghan_AX_Portfolio.md`
- `KimJunghan_AX_Detail.md`
- `competency.org` · `portfolio.org` · `detail.org` — 재빌드 경로를 보존하려 패키지 루트에 둔다
- `images/*`
- `references.bib`
- `run.sh`
- `pipeline/`
- `outputs/`의 최종 PDF·ODT·DOC
- `MANIFEST.sha256`

## 문서 역할

- **역량·성과 기술서:** 3~5분 안에 JD 적합성을 판정하는 압축 문서. 4~5쪽 목표.
- **포트폴리오:** 프로젝트별 문제·역할·아키텍처·판단·성과·인계·근거를 이미지와 함께 증명. 10~14쪽을 기본 범위로 보되 가독성이 페이지 수보다 우선.
- **상세 MD:** PDF의 반복본이 아니라 기술 인터뷰와 에이전트 탐색을 위한 원장. 파일·테스트·실패 사례·설계 판단·전체 URL을 회수한다.

## 편집 우선순위

포트폴리오의 기본 순서는 다음과 같다. GLG와 PM 검토에 따라 여러 번 재배열한다.

1. 사내 AI 인프라와 업무 시스템 AX 접점
2. 실사용 에이전트 플랫폼 운영과 인시던트
3. `andenken` 메모리·RAG 계층
4. `entwurf` + `forge-config` 개발 에이전트 워크플로
5. Linux·Backend·IoT 제품까지의 기반

각 프로젝트는 같은 문법을 따른다.

`맥락/문제 → 내 역할 → 아키텍처 이미지 → 핵심 판단 → 운영·성과 수치 → 협업·인계 → JD 관련성 → 증거`

JD 적합성, 차별성, 본인의 판단과 소유 범위, 검증 가능성, 시각화 가능성이 낮은 소재는
삭제하기보다 포트폴리오 후반이나 상세 MD로 내린다.

## 이미지 계약

- Org 원문 안에 `:noexport:` 이미지 생성 프롬프트를 둔다.
- 프롬프트는 장식 그림이 아니라 사실 구조·경계·변화를 보여주는 인포그래픽을 기술한다.
- 생성 이미지는 `images/`에 저장하고 Org에서 캡션과 함께 참조한다.
- 역량기술서는 대표 이미지 1장, 포트폴리오는 주요 프로젝트별 이미지 약 1장을 목표로 한다.
- 최종 PDF에 이미지를 임베드하고, 상세 MD에서는 상대경로와 충분한 alt/텍스트 설명을 함께 제공한다.

### 공개 판정이 있는 그림만 들인다 (2026-10-15)

- `images/` 의 파일은 `images/README.md` 의 행과 1:1 이다 — 출처 · sha256 · 공개 판정(누가·언제)이
  없는 그림은 두지 않는다. 공개 게이트도 그 일곱 경로만 예외로 둔다(정본은 루트 공개 정책).
- **그림은 개념도다.** 캡션이 그림의 증명 상한을 말한다. 미구현 계층을 그렸으면 미구현이라고,
  시점이 지난 그림이면 그 시점을, 세 층을 그렸지만 일부만 출하했으면 그 경계를 캡션이나 바로 옆
  문장이 적는다. 그림을 비공개 배포·운영 실적의 증거로 내세우지 않는다.
- 2026-08-27 공개 전환 때 도해 블록이 `[diagram removed at publication …]` 인용으로 바뀐 채
  남아 있었고, 재빌드하니 그 문구가 PDF·MD 에 찍혔는데 verify 는 통과했다. 그래서:
  - `./run.sh figures` — export 범위(`:noexport:`·COMMENT 서브트리, 주석·예제 블록 밖)의 정제
    자리표시 `[… removed …]` 는 하드 실패, 참조한 `images/` 파일이 없으면 실패. `check` 와 모든
    빌드 명령이 먼저 부른다.
  - `verify` — 산출물마다 자리표시 하드 실패, PDF 캡션 「그림 N.」 수 · MD 이미지 수 = 소스 기대량
    (export 범위 이미지 링크 수), PDF 이미지(`pdfimages`)·ODT 임베드 ≥ 참조 파일 수. 기대가 0 이면
    0 도 정상이다.
  - 회귀: `./test_figures.py`.

## 서지 — 문서가 선언한 bib 만 쓴다 (2026-10-15)

`pipeline/proposal-export.el` 은 Doom 설정의 개인 서지(`config-bibfiles`)를 전역으로 얹는다(대화형
편집용). org-cite 는 문서 서지와 전역 서지를 합쳐 키를 찾으므로, 같은 키가 개인 서지에 있으면
`references.bib` 대신 그 항목이 렌더됐다 — 2026-10-15 재빌드에서 저자가 빠지고 `references.bib`
에 없는 열람일이 붙었다. **같은 소스가 빌드하는 기계마다 다른 문서가 되는 것이다.**

- 문서가 `#+bibliography:` 를 선언하면 export 사본 버퍼에서 전역 서지를 버퍼 로컬로 비운다
  (`proposal--document-bibliography-only`, export 직전 훅). `latex-export.el` 도 같은 파일을 싣으므로
  PDF·ODT 두 트랙 공통이다. Markdown 트랙(pandoc)은 원래 `--bibliography=references.bib` 만 쓴다.
- 회귀: `./test_bibliography.py` — `ORG_DIRECTORY` 를 같은 키의 가짜 개인 서지가 든 임시 디렉터리로
  바꿔 「다른 기계」를 흉내 내고, 문서 서지만 렌더되는지와 두 환경의 `.tex` 가 같은지 본다. Emacs·Doom
  코어가 필요하다.

## 숫자 — 자가 측정 수치를 쓰지 않는다 (2026-07-29 GLG)

`AGENTS.md` §불변식 §숫자 가 정본, 세부는 `PORTFOLIO-PLAN.md` §수치 원칙 **v4**.
v3 는 성능 수치만 뺐는데 **v4 는 자가 측정 작업량 수치까지 뺀다** — 테스트 163개,
코드 공유 96%, 임베딩 2,945건, 하루 24커밋 류. 남기는 것은 라이브 주소로 확인되는
누적 기록 · 제3자가 남긴 숫자 · 날짜/커밋 SHA 다.

✅ **2026-07-30 정정 — 산출물은 이미 깨끗하다. 재빌드를 두려워하지 않는다.**
이전 판은 *「`detail.org`·`competency.org` 에 아직 남아 있어 고치면 산출물이 바뀐다」* 고
경고했다. **실측하니 사실이 아니다.**

- `detail.org` **0건**. `portfolio.org` 5건 · `competency.org` 1건이 걸리지만 **전부
  `* COMMENT … :noexport:` 구역과 `#+BEGIN_EXAMPLE` 검토 회의록** 안이다 — export 되지 않는다.
- 2026-07-30 에 **실제로 재빌드해서 확인**했다: Competency 5쪽 · Portfolio 12쪽 PDF 본문에
  걷어낸 수치 **0건**(`gs -sDEVICE=txtwrite` 전수).
- **그래서 이 경고는 비용만 있었다** — 재빌드가 필요한 순간(회사 중립판 전환)에 「위험하다」로
  읽히는 자리였다. 정본을 고치면 재빌드하고, **PDF 텍스트를 직접 뒤져서 확인**하면 된다.
- 여전히 유효한 것 하나: **이미 나간 제출본(`applications/*/submit/`)은 고치지 않는다.**
  그때 나간 파일이 사실이고, 델타는 `applications/LEDGER.md` §메모가 쥔다.

## 조준부는 회사 중립이 정본이다 (2026-07-30)

`competency.org` **프롤로그 첫 문장**이 유일한 회사 조준 자리다(`portfolio.org` 는 회사명 0건).

- 한 건을 조준해 빌드했으면 **그 건에 낸 뒤 중립으로 되돌린다.** 되돌리지 않으면 다음 건에
  **앞 회사 이름이 실려 나간다** — 2026-07-30 아침에 AIRS 조준판이 그대로 남아 있었고,
  그 상태로는 나머지 12건에 붙일 수 없었다.
- 중립판 문장: *「조직이 AI 를 실제로 쓰는 작업면을 만드는 일을 저는 한 겹의 문제로 읽습니다」*
- 검사: `gs -q -sDEVICE=txtwrite -o - build/*.pdf | grep -ciE '회사명'`.
  **`pdftotext` 는 이 서버에 없고, 없는 채로 부르면 빈 결과가 「깨끗함」으로 읽힌다.**

## 서버에서 PDF 가 나온다 — LibreOffice 는 PDF 경로가 아니다 (2026-07-30)

`./run.sh check` 는 `libreoffice 없음` 을 정보로만 알리고 넘어간다(예전 판은 exit 1 이었다).
**조판 정본 PDF 는 xelatex(`build_tex`)가 만든다.** LibreOffice 는 ODT→DOC 트랙 전용이다.

- 오라클 서버에서 `./run.sh competency` · `./run.sh portfolio` 는 **PDF 까지 정상 생성**된다.
  마지막 `doc` 변환에서 `EXIT=127` 이 나지만 **PDF 는 이미 나와 있다.**
- `NEXT.md` 가 한때 「dossier/run.sh(LibreOffice 경로)는 서버에서 된다」고 적어 두었는데
  **경로 이름이 틀렸다.** 되는 것은 xelatex 이고, 안 되는 것은 DOC 다.

## 증거와 참고문헌

- 공식 문서·프로토콜뿐 아니라 공개 저장소, 특정 commit, PR, npm, 라이브 통계와 서비스 URL도 `references.bib`에 기록한다.
- 중요한 주장과 수치 바로 뒤에 번호 인용을 붙이고 PDF/MD 끝에 클릭 가능한 URL을 렌더한다.
- 공개 URL이 없는 사내 수행 사실은 억지 근거를 만들지 않고 `비공개 수행 사실`로 명확히 표시한다.
- `능력(self-owned)`, `수용(third-party action)`, `비공개 수행 사실`, `경계(not implemented/directly used)`를 혼동하지 않는다.
- **공개 증거면 `ax.junghanacs.com` 은 세 문서 전부에 실린다** (2026-08-01). 이 깊이 문서는
  gitignore 된 제출본이라 **받는 사람이 공개면으로 건너갈 자리가 여기 말고 없다.** 연락처 줄
  (`\affiliation` + ODT export 두 표면) · `competency.org` §근거 · `portfolio.org` §검증 ·
  `detail.org` §읽는 법에 각각 있고 `references.bib` 의 `@live-ax` 로 인용한다.
  `run.sh` 의 verify 가 **PDF·ODT·MD 산출물**에서 직접 확인한다 — 소스에만 있고 어느 한 표면에서
  빠지는 일을 막는다.
  ⚠ 연락처 줄은 다섯 항목이라 **한 줄에 안 들어간다.** `ax` 뒤에 `\newline` 을 넣어 두 줄로
  가른 상태이며, 이걸 지우면 `Overfull \hbox` 로 LinkedIn URL 이 판면 밖으로 나간다.
- **연락처 줄의 홈페이지 자리는 대표 URL `https://www.junghanacs.com` 이다** (2026-10-15 GLG, 표시는
  `www.junghanacs.com`). 두 표면(`\affiliation` · ODT `OrgCenter`)이 같아야 하고 verify 가 PDF 텍스트와
  ODT 에서 확인한다. 본문·참고문헌이 가리키는 가든 URL(`notes.junghanacs.com`, `@live-garden`)은 기술
  근거라 이 자리와 별개다 — 일괄 치환하지 않는다.

## 문서 판 이력 — 세 문서 맨 뒤 (2026-10-15)

`competency.org` · `portfolio.org` · `detail.org` 는 `* 참고자료` 뒤, `* COMMENT … :noexport:` 앞에
`* 문서 판 이력` 을 둔다. 판은 날짜로 부른다(「2026-10-15 수선판」) — 저장소 릴리즈 태그와 섞지 않는다.

- 적는 것은 **그 문서에 실제로 일어난 변경 범위와 날짜**뿐이다. 자평·작업량 수치는 쓰지 않는다.
- 기준점은 2026-08-01 보존본이다(그날 빌드해 보존한 판 — 「최초 작성」이 아니다).
- 본문 현재화가 빠진 판이면 그 사실을 한 줄로 적는다.
- verify 가 PDF·MD 산출물에서 「문서 판 이력」을 확인한다 — `:noexport:` 뒤로 숨으면 소스에는 있고
  산출물엔 없다.

## 연락처 — 정본은 resume 표제 블록이다 (2026-10-15)

소유자 이메일의 정본은 `resume/pipeline/preamble.org` 표제 블록의 `mailto` 다. 이 레인의 소스
(`competency.org`·`portfolio.org` 의 `#+email`·LaTeX `\href`·ODT `xlink:href`, `detail.org` 의
`#+email`)는 같은 주소의 **사본**이다 — 증거 패키지가 `resume/` 없이 혼자 돌아야 해서 없애지 못한다.
대신 `run.sh` 가 정본과 대조해 묶는다.

- `./run.sh contact` — 소스 대조. `check` 와 모든 빌드 명령(`competency`·`portfolio`·`detail`·`all`)이
  먼저 부른다. 정제 자리표시 `[email removed]` 는 어디 있든 하드 실패, `#+email`·`mailto` 가 정본과
  다르면 실패.
- `verify` — PDF 텍스트에 자리표시가 보이면 하드 실패, 통과 조건은 형식이 아니라 **정본 주소 그 자체**를
  토큰으로 찾는 것이다(앞뒤에 주소 글자가 더 붙은 다른 주소는 정본 노출이 아니다).
- 실패 메시지는 어긋난 값을 싣지 않는다 — 파일·행 번호만 댄다. 정본이 아닌 값은 누구의 주소인지 모른다.
  공개 승인된 정본 주소는 통과 메시지에 그대로 나온다.
- 정본 해석: `resume/` 가 있으면 반드시 그 파일에서 읽고, 못 읽으면 실패한다. `competency.org`
  `#+email` 폴백은 **`resume/` 자체가 없을 때(패키지 실행)만** 탄다.
- 회귀: `./test_contact.py` — 임시 사본 트리에서 자리표시·다른 주소·정본 파싱 불가·패키지 폴백을
  주입한다. 실파일과 `build/` 는 건드리지 않는다.
- 왜: history 정제가 소스 주소와 verify 의 검사 패턴을 같은 자리표시로 바꿔, verify 가
  「자리표시가 보이면 이메일 노출 ok」로 뒤집혀 있었다. resume 은 09-20 에 같은 사고를 고쳤고 이
  레인에는 남아 있었다.

## 공개 경계

- 이 저장소는 공개다. 고객사 비밀·내부 endpoint·원시 데이터·개인정보·법적 값은 쓰지 않는다.
- 추천인 실명·지원 경로·개인화 ATS 식별자는 제출문서와 repository 모두에서 제외한다.
- private 제출 원본을 공개 프로필이나 `ax.org`로 자동 동기화하지 않는다. 공개 가능한 사실만
  별도 source에서 생성한다.
- 패키지는 allowlist 방식으로 조립한다. `.git`, 캐시, 임시 빌드, 편집기 잠금, 로컬 절대경로,
  원본 `PRIVATE.md`, 실제 제출 바이너리와 미검수 내부 도해를 넣지 않는다.

## 파이프라인

Org 정본 → Emacs `org-odt-export` → `reference.odt` 스타일 → 표/캡션 후처리 →
LibreOffice ODT/PDF. 상세 MD는 Org → Pandoc GFM + citeproc.

```bash
./run.sh check
./run.sh competency
./run.sh portfolio
./run.sh detail
./run.sh all
./run.sh verify
./run.sh package
```

파생 ODT/PDF/MD를 손으로 고치지 않는다. Org, BibTeX, 이미지 또는 파이프라인을 수정한 뒤 재빌드한다.

## 검증

- PDF 페이지 수와 A4 판형
- 검색·복사 가능한 한국어 텍스트
- 표/그림 캡션 연번과 본문 참조 일치
- 이미지 해상도와 임베드
- 인용 번호와 참고자료 URL
- 연락처와 대표 URL
- `:noexport:` 프롬프트·TODO·검토 메모 누출 없음
- 작은 글씨·과밀 표·잘린 이미지 없음
- ZIP을 빈 디렉터리에 풀어 상대경로와 재빌드 명령 확인

## 협업

GLG가 현재 Codex/pi 세션을 PM으로 지정했고 Claude Code Opus 세션을 구현 담당으로 지정했다.
구현 담당은 구조 변경, 첫 PDF, 이미지 프롬프트, 빌드 결과와 막힘을 PM에게 체크포인트로 보고한다.
최종 강조 순서와 커밋·푸시는 GLG가 결정한다.
