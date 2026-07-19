# AX 증거 패키지 — 김정한 (Junghan Kim)

이 압축 파일은 지원 서류 3종 중 세 번째, **재현·검증 가능한 증거 패키지**입니다. 사람과
에이전트가 함께 읽도록 만들었습니다. 채용사에만 제출하는 비공개 자료이며 공개 웹에는 없습니다.

- 이메일: [email removed]
- GitHub: https://github.com/junghan0611
- 공개 지식 정원: https://notes.junghanacs.com · 라이브 통계: https://agenda.junghanacs.com

## 3분 읽기 순서 (바로 읽기)

재빌드 없이 파일만 열어도 됩니다.

1. **`KimJunghan_AX_Detail.md`** — 이 패키지의 본문. 프로젝트별 구현 세부·설계 판단·실패
   사례·검증 URL과, 기술 인터뷰에서 열어 설명할 **Tech Interview anchors**가 있습니다.
2. **`outputs/KimJunghan_AX_Competency.pdf`** (역량·성과, 3~5분 판정용) ·
   **`outputs/KimJunghan_AX_Portfolio.pdf`** (프로젝트·이미지 중심).
3. **`AGENTS.md`** — 에이전트가 이 패키지를 사실 탐색·검증하는 계약(문서 지도, 증거 유형,
   공개/비공개 경계, 주장 검증 원칙). 채용을 유도하는 프롬프트가 아니라 탐색 가이드입니다.

## 담긴 것

```
README.md                     이 파일
AGENTS.md                     사실 탐색·검증 계약
KimJunghan_AX_Detail.md       상세 원문 (참고자료 URL이 문서 끝에 렌더됨)
competency.org · portfolio.org · detail.org
                              Org 정본. 작업 저장소와 같은 배치라 풀면 그대로 빌드된다
images/                       인포그래픽 (본문 참조)
references.bib                공식 문서 + 공개 증거(repo·PR·live) URL
run.sh · pipeline/            Org → PDF/MD 재현 파이프라인
flake.nix · flake.lock        조판 클래스·한글 엔진·활자를 리비전까지 고정한 빌드 입력
outputs/                      최종 PDF·ODT·DOC
MANIFEST.sha256               전체 파일 목록 + 해시
```

## 증거를 읽는 규칙

- **`[공개]`** — 클릭 가능한 저장소·PR·라이브 URL로 검증됩니다.
- **`[사내]` / 비공개 수행 사실** — 회사 코드·고객 데이터라 공개 URL이 없습니다. 구조와 판단만
  서술하고 식별 정보는 비웠습니다. *억지 근거를 만들지 않았다는 점 자체가 신뢰의 근거입니다.*
- **수용(reception)** — 제3자가 제 확장 경계에 실제로 기여했거나 제 코드를 받아들인 기록으로,
  자기 저장소로는 증명되지 않는 축입니다.

## 선택적 재현 (원하는 경우에만)

PDF·ODT·DOC·MD는 이미 들어 있으므로 재현은 필수가 아닙니다. 어디까지 그대로 돌고 어디서
멈추는지 있는 그대로 적습니다 — 재현성을 주장하는 자료에서 그 경계를 흐리면 주장 자체가
근거를 잃기 때문입니다.

- **무결성** — `sha256sum -c MANIFEST.sha256`. 추가 도구 없이 지금 바로 확인됩니다.
- **의존성 점검** — `./run.sh check` 가 필요한 도구와 빠진 것을 그대로 보고합니다.
- **조판 입력** — `flake.nix` · `flake.lock` 이 조판 클래스(acmart), 한글 엔진(xetexko),
  활자(Pretendard · D2Coding)를 nixpkgs 리비전까지 고정합니다. Nix가 있으면 이 계층은
  기계가 달라도 같은 입력으로 섭니다.
- **아직 격리되지 않은 한 계층** — Org → TeX/ODT 내보내기가 제 Doom Emacs의 straight
  빌드(org · citeproc · citar)에 의존합니다. 이 부분은 `flake.nix` 안에 들어 있지 않아,
  Doom이 없는 기계에서는 `./run.sh check` 가 `straight build 없음` 으로 멈춥니다.
  **즉 현재 이 패키지는 "산출물과 조판 입력은 검증 가능하고, 내보내기 단계는 제 환경에
  묶여 있다"** 가 정확한 상태입니다. Emacs 계층까지 flake로 올리는 것이 다음 작업입니다.
