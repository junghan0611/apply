# dossier — 조준 제출문서 발사대

한 건에 조준한 **두꺼운 문서 한 벌**을 뽑는 발사대. `resume/` (여섯 컷)의 짝이고,
결과물은 각 건의 `applications/<건>/submit/` 으로 간다. 계약은 `AGENTS.md`.

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
`ax.junghanacs.com`은 별도 트랙으로 유지하되, 제출문서가 그 공개 증거면을 단방향으로 가리킨다.
트랙 분리는 내용을 섞지 않는다는 뜻이지 참조를 끊는다는 뜻이 아니다.

> **산출물 이름의 `AX_` 는 회사 약자가 아니다** — AI 전환(AX) 축을 뜻한다. 2026-07-20 NHN
> 제출본이 이 이름으로 나갔고 그 사본이
> `../applications/nhn--ax-transformation-ai-infra/submit/` 에 있다. 이름을 바꾸면 이미 낸
> 파일과 대조가 끊기므로 **그대로 둔다.**
