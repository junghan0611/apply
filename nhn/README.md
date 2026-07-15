# AX application dossier

비공개 채용 제출문서 작업 저장소.

- `competency.org` → JD 관련 역량·성과 기술서 PDF
- `portfolio.org` → 프로젝트·이미지 중심 포트폴리오 PDF
- `detail.org` → 상세 Markdown
- `references.bib` → 공식 문서와 공개 증거 URL
- `images/` → Org의 `:noexport:` 프롬프트로 생성한 제출 이미지
- `pipeline/` → Org → ODT/PDF 변환 파이프라인

```bash
./run.sh check
./run.sh all
./run.sh verify
```

최종 제출은 PDF 2종과 상세 증거 패키지 ZIP 1개다. 공개 웹 포트폴리오
`ax.junghanacs.com`은 별도 트랙으로 유지한다.
