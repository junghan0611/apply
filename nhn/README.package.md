# AX 증거 패키지 — 김정한 (Junghan Kim)

이 압축 파일은 지원 서류 3종 중 세 번째, **재현·검증 가능한 증거 패키지**입니다. 사람과
에이전트가 함께 읽도록 만들었습니다. 채용사에만 제출하는 비공개 자료이며 공개 웹에는 없습니다.

- 이메일: [email removed]
- GitHub: https://github.com/junghan0611
- 공개 지식 정원: https://notes.junghanacs.com · 라이브 통계: https://agenda.junghanacs.com

## 3분 읽기 순서 (바로 읽기)

재빌드 없이 파일만 열어도 됩니다. 사람은 아래 순서로, 담당 에이전트는 먼저 `AGENTS.md`의
탐색 계약을 읽은 뒤 같은 순서로 확인하면 됩니다.

1. **`KimJunghan_AX_Competency.md`** — JD 관련 역량·성과를 3~5분 안에 판독하는 압축 지도
2. **`KimJunghan_AX_Portfolio.md`** — 다섯 프로젝트의 문제·소유 범위·판단·운영·인계
3. **`KimJunghan_AX_Detail.md`** — 구현 파일·테스트·명령·실패 사례·검증 URL과
   **Tech Interview anchors**를 담은 증거 원장
4. **`outputs/KimJunghan_AX_Competency.pdf`** · **`outputs/KimJunghan_AX_Portfolio.pdf`** —
   이미지·표·강조·쪽 배치를 포함한 사람용 최종 판면
5. **`AGENTS.md`** — 담당 에이전트가 사실과 경계, Org 초고와 최종 주장을 혼동하지 않게 하는 지도

## 담긴 것

```
README.md                         이 파일
AGENTS.md                         담당 에이전트용 사실 탐색·검증 계약
KimJunghan_AX_Competency.md       역량·성과 내보내기 본
KimJunghan_AX_Portfolio.md        포트폴리오 내보내기 본
KimJunghan_AX_Detail.md           상세 증거 내보내기 본
competency.org · portfolio.org · detail.org
                                  편집 이력과 :noexport:를 포함한 Org 저작 정본
images/                           본문에서 참조하는 문서용 이미지
references.bib                    공식 문서 + 공개 증거(repo·PR·live) URL
run.sh · pipeline/                Org → PDF/ODT/DOC/MD 재현 파이프라인
flake.nix · flake.lock            조판 클래스·한글 엔진·활자를 고정한 빌드 입력
outputs/                          최종 PDF·ODT·DOC
MANIFEST.sha256                   전체 파일 목록 + 해시
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
