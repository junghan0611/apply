# NOW — apply 워크스페이스 (리포 루트가 중심)

- **활성 타깃: nhn** (유일). 루트가 중심축이고, 타깃별 빌드 계약은 `<target>/AGENTS.md`.
- **Stem**: NHN 제출본 3종을 "빌드된다"가 아니라 **"이 사람이 이걸 냈다"가 성립하는** 완성도까지.
- **Next — 방향부터 GLG와 확정** (실제 생성 전에 순서를 못박는다):
  권고 순서 **(1) 내용 밀도** (`MATERIAL.md` 근거로 Org 3종의 문제·역할·판단·수치·증거) →
  **(2) 이미지** (확정된 사실 구조를 인포그래픽으로; 배너 아님) →
  **(3) timeline 수치 대조**로 `:noexport:` "GLG 재확인" 항목 검증.
  근거: 배너를 인포그래픽으로 바꾸려면 그릴 사실이 먼저 확정돼야 하므로 내용이 앞선다.
- **Blocker**: none. 환경·공유도구 검증 완료(아래 RECENT).
- **Read**: 루트 `AGENTS.md` → `nhn/AGENTS.md`(빌드 SSOT) → `junghan0611/apply/MATERIAL.md`(소재 SSOT).
- **Do not touch**: 공개 `junghan0611/apply/ax/`; 추천인·지원 경로·근무지(제출 본문); 원시 고객 식별자·자격증명.
  파생물(ODT/PDF/MD) 수기 수정 금지 — Org·이미지·파이프라인만 고치고 재빌드.

# WORKSPACE — 구조 (2026-07-16 점검)

- **정체**: private, 멀티타깃 채용 워크스페이스. 공고 한 건 = 하위 디렉터리 하나. 지금 `nhn/` 하나만 활성.
- **소재 SSOT**: `junghan0611/apply/MATERIAL.md` — 검증된 사실만. 수치·계보·프레이밍은 여기서. 지어내지 않는다.
- **공유 검증 도구**: `timeline` 관측소 (agent-config 스킬, HOME 앵커라 어느 CWD에서든 동일한 축).
  dossier 수치를 실축과 대조하는 데 쓴다. **인용은 `content_sha256` + `as_of` + `code_sha256` + 소스상태**로.
  `events.jsonl`은 로컬·gitignore(리포에 커밋 금지). 매번 8초에 재생성.
- **두 레인**: 제출(`apply/nhn`, 우선) ↔ 공개(`junghan0611/ax`). MATERIAL.md 공유, 파생물 상호 불가침, 비공개→공개 자동 동기화 금지.

# ACTIVE — nhn 타깃

- **Current**: Org→ODT/PDF 2종 + 상세 MD + allowlist ZIP 파이프라인 동작, verify/package 게이트 통과.
  폰트를 **GLG Nerd Font Mono 10.5pt**로 재빌드(Competency 5p / Portfolio 8~9p, PDF에 서브셋 `emb=yes`·`uni=yes` 내장). **미커밋.**
- **두 갭 (AGENTS.md 정직한 진단)**:
  (a) Org 3종이 **초안 수준** — 프로젝트별 문제·역할·판단·수치·증거 밀도 부족.
  (b) 이미지 6장이 **배너 껍데기**(전부 1206×526, ~75~83KB) — 사실 구조·경계·변화가 아님. 폴백: graphviz/mermaid 결정적 다이어그램.
- **Image CLI**(nhn CWD): `node ~/repos/gh/agent-config/skills/command-glgimage/gemini-image-gen.mjs --prompt-file PROMPT.txt --aspect-ratio <ratio> --image-size 2K --output images/<name>.png --json`. API key는 `~/.env.local`, JSON의 `path`가 실제 확장자.
- **Verify**: `cd nhn && ./run.sh check/all/verify/package`; placeholder 0건·글자깨짐·사실왜곡 0·`:noexport` 미누출·ZIP `unzip -t` 통과. 포트폴리오 가독성 우선(현 9p; 10~14p는 목표일 뿐).
- **Fact check (timeline로 대조)**: 헤이홈 약 140만 사용자·문서 임베딩 2,945건·n8n 40+ 노드·openclaw 운영창(2026-02→06)·"20+ 버전 사이클"의 제출 시점 최신성. 사내값(140만·2,945)은 GLG 몫.
- **Read**: `nhn/AGENTS.md`, 각 Org 마지막 `COMMENT 이미지 생성 프롬프트`, `README.package.md`.
- **Env note**: 이전 Noto Sans 변경은 폐기됨(`66dd61e` clean). 현 GLG 폰트 변경은 ThinkPad 로컬만. LibreOffice 없는 호스트는 `nix shell nixpkgs#libreoffice -c ./run.sh all`.

# RECENT

- [2026-07-16] **timeline 검증(apply 담당자 손)** — apply/nhn CWD collect exit 0(28,913 events, sha CWD-무관), 계약테스트 all green, TZ(UTC/Seoul/+14) 결정성 events sha 완전 동일, 골든데이 2/07·7/11 SKILL 표 일치, 2026-06 entity 1897. apply에서 쓸 수 있음 확정.
- [2026-07-16] **NEXT 루트 이관** — `nhn/NEXT.md` → 루트 `NEXT.md`. 리포 루트를 중심축으로, nhn은 ACTIVE 하위로 재편.
- [2026-07-16] **폰트 재빌드** — 휴먼명조 폴백을 GLG Nerd Font Mono 10.5pt로 교체(`pipeline/set_reference_font.py`, untracked). PDF 폰트 내장·Unicode mapping 확인. 미커밋.
