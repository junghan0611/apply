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
sources/                      Org 정본 (competency · portfolio · detail)
images/                       인포그래픽 (본문 참조)
references.bib                공식 문서 + 공개 증거(repo·PR·live) URL
run.sh · pipeline/            Org → PDF/MD 재현 파이프라인
outputs/                      최종 PDF 2종
MANIFEST.sha256               전체 파일 목록 + 해시
```

## 증거를 읽는 규칙

- **`[공개]`** — 클릭 가능한 저장소·PR·라이브 URL로 검증됩니다.
- **`[사내]` / 비공개 수행 사실** — 회사 코드·고객 데이터라 공개 URL이 없습니다. 구조와 판단만
  서술하고 식별 정보는 비웠습니다. *억지 근거를 만들지 않았다는 점 자체가 신뢰의 근거입니다.*
- **수용(reception)** — 제3자가 제 확장 경계에 실제로 기여했거나 제 코드를 받아들인 기록으로,
  자기 저장소로는 증명되지 않는 축입니다.

## 선택적 재현 (원하는 경우에만)

PDF와 MD는 이미 들어 있으므로 재현은 필수가 아닙니다. 직접 다시 만들려면 `pandoc`,
`poppler-utils`(pdftotext·pdfinfo), Emacs(Org 내보내기), LibreOffice가 필요합니다. 이들이 PATH에
있으면 `./run.sh all` 이 그대로 돌고, 없으면 `run.sh` 가 필요한 도구를 안내합니다. 무결성은
`sha256sum -c MANIFEST.sha256` 로 확인할 수 있습니다.
