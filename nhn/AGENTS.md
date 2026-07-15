# AGENTS.md — private AX application dossier

이 저장소는 공개 프로필이 아니라 **실제 채용 제출본을 만드는 비공개 작업 저장소**다.
고객사·사내 프로젝트·구체 성과를 포함할 수 있으며, 공개 웹 문서인
`~/repos/gh/junghan0611/apply/ax/`와 섞지 않는다.

## 목표 산출물

최종 업로드 파일은 세 개다.

1. `KimJunghan_AX_Competency.pdf` — JD 관련 역량 및 성과 기술서
2. `KimJunghan_AX_Portfolio.pdf` — 이미지와 프로젝트 중심 포트폴리오
3. `KimJunghan_AX_Evidence_Package.zip` — 상세 Markdown과 재현 파이프라인을 담은 증거 패키지

ZIP 루트에는 최소한 다음이 있어야 한다.

- `README.md`
- `AGENTS.md`
- `KimJunghan_AX_Detail.md`
- `sources/*.org`
- `images/*`
- `references.bib`
- `run.sh`
- `pipeline/`
- `outputs/`의 최종 PDF 두 개
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

## 증거와 참고문헌

- 공식 문서·프로토콜뿐 아니라 공개 저장소, 특정 commit, PR, npm, 라이브 통계와 서비스 URL도 `references.bib`에 기록한다.
- 중요한 주장과 수치 바로 뒤에 번호 인용을 붙이고 PDF/MD 끝에 클릭 가능한 URL을 렌더한다.
- 공개 URL이 없는 사내 수행 사실은 억지 근거를 만들지 않고 `비공개 수행 사실`로 명확히 표시한다.
- `능력(self-owned)`, `수용(third-party action)`, `비공개 수행 사실`, `경계(not implemented/directly used)`를 혼동하지 않는다.

## 비공개 경계

- 이 저장소는 GitHub **PRIVATE** 저장소다. 고객사와 사내 사실을 쓸 수 있다.
- 추천인 실명과 지원 경로는 제출문서 본문에서 제외한다.
- 이 내용을 공개 프로필 저장소나 `ax.org`로 자동 동기화하지 않는다. 공개본은 제출 후 별도 필터링한다.
- 패키지는 allowlist 방식으로 조립한다. `.git`, 캐시, 임시 빌드, 편집기 잠금, 로컬 절대경로, 원본 `PRIVATE.md`를 넣지 않는다.

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
