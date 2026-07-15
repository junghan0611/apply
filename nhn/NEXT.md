# NOW — 실제 이미지로 제출본 완성

- Current: Org→ODT/PDF 2종, 상세 MD, allowlist ZIP 파이프라인이 동작한다. 현재 PDF 5p/9p와 ZIP은 **레이아웃 검증용 placeholder 이미지 6장**을 품은 WIP이며 제출본이 아니다.
- Next: (1) `competency.org`·`portfolio.org`의 `:noexport:` 프롬프트로 이미지 6장을 생성 → (2) Gemini가 반환한 실제 `.jpg/.png` 경로를 Org 링크에 반영 → (3) `./run.sh all && ./run.sh package` → (4) PDF 전 페이지 육안 검수 후 강조 순서를 GLG와 재편집.
- Image CLI: `node ~/repos/gh/agent-config/skills/command-glgimage/gemini-image-gen.mjs --prompt-file PROMPT.txt --aspect-ratio <ratio> --image-size 2K --output images/<name>.png --json`. Oracle의 `~/.env.local`에 API key가 있고, JSON의 `path`가 실제 확장자다.
- Oracle env: host PATH에는 LibreOffice가 없다. `nix shell nixpkgs#libreoffice -c ./run.sh check` 및 `nix shell nixpkgs#libreoffice -c ./run.sh all`로 실행한다. Emacs 30.2와 Pandoc은 PATH에 있다.
- Verify: placeholder 문자열 0건, 글자 깨짐·사실 왜곡 0건, `./run.sh verify` 통과, ZIP `unzip -t` 통과, 포트폴리오 가독성 우선(현재 9p; 10~14p는 목표일 뿐 강제 아님).
- Fact check: 헤이홈 약 140만 사용자, 문서 임베딩 2,945건, n8n 40+ 노드, OpenClaw 인시던트 수치의 제출 시점 최신성 확인.
- Read: `AGENTS.md`, 각 Org의 마지막 `COMMENT 이미지 생성 프롬프트`, `README.package.md`.
- Do not touch: 공개 `~/repos/gh/junghan0611/apply/ax/`; 추천인·지원 경로; 원시 고객 식별자·자격증명.

# RECENT

- [2026-07-16] private `junghan0611/apply` 저장소의 `nhn/`에 독립 제출 파이프라인을 세웠다. 역량기술서 5p, 포트폴리오 9p, 상세 MD 283줄, 증거 ZIP 약 8.8MB가 생성되고 verify/package 게이트를 통과했다. `references.bib`은 공식 문서·공개 저장소·PR·라이브 통계를 번호 인용으로 묶는다. 실제 인포그래픽 생성은 다음 작업으로 남겼다.
