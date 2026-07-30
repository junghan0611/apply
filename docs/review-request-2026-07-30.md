# GPT 교차검수 요청 — 2026-07-30 오전 (오라클 서버 판)

> ## ✅ 검수 완료 · 반영 완료 (2026-07-30 09:23 GPT 회신 → 즉시 반영)
>
> **GPT 지적 P0 5건 · J3 · 지문 검사 · 문장 2건을 전부 반영했다.** 반영 내역:
>
> | 지적 | 무엇이었나 | 어떻게 닫았나 |
> |---|---|---|
> | **P0-1** | **서버 변경이 uncommitted 라 `git pull` 로 오늘 판이 안 간다** — 최대 블로커 | `SUBMIT-QUEUE.md` §0 맨 앞에 **커밋·푸시 선행 게이트**를 박았다. 실제 커밋·푸시는 **GLG 승인 대기** |
> | **P0-2** | §0 의 「빌드 없이는 세트가 비어 있다」가 확정 사실 R1 과 모순 — 빌드 실패 시 **제출 포기**를 유발 | §0 을 표로 다시 썼다 — **이력서는 tracked 라 pull 로 오고, 깊이 문서만 빌드**가 필요하다. `AGENTS.md`·`SOURCES.md` 의 절대명제도 「**새 깊이 PDF 는** git 에 없다」로 한정 |
> | **P0-3** | `stage.py` 가 소스 없어도 **경고만 하고 exit 0** · stale 판을 그대로 복사 | ① 나열된 소스 부재 → **FAIL + nonzero** ② `is_stale()` — org 보다 낡은 PDF **거부** ③ `aim_leak()` — 깔린 직후 **자동 누출 검사**. AIRS 판을 발사대에 심어 **exit 1 실증** |
> | **P0-4** | SOCAR 세트 모순 — 「추가 첨부」엔 2종인데 본문은 Portfolio 만 낸다 → **오업로드 위험** | `추가 첨부` 를 **Portfolio 하나로** 줄이고, `stage.py` 가 **목록에서 빠진 깊이 문서를 치운다**(🧹). SOCAR 세트에서 Competency 실제로 제거됨 |
> | **P0-5** | 폴백 `cp` 가 MANIFEST/README/SOURCES 를 갱신하지 않고, 뒤에 `stage.py` 가 덮는다 | 폴백을 **`dossier/build/` 에 놓고 `stage.py` 로 깔는 방식**으로 바꿨다 — 메타가 함께 갱신된다 |
> | **J3** | `--deep` 앞 6,000자 컷은 휴리스틱이라 「JD 관련성」 절을 놓친다 | **`참고자료` 헤딩 이전 본문 전체**로 바꿨다(`aim_scope()`). 문서 구조 경계가 안정적이다 |
> | **지문** | `check.py` 가 지문을 **검사하지 않았다** — MANIFEST 존재만 봤다 | `digest_faults()` 신설. **있는 파일은 바이트 대조, 없는 파일은 증언만 보존.** GPT 가 본 legacy 실패 6건의 원인도 닫았다 — **빈 MANIFEST 5건 제거** + `nhn AX` 의 `(미추적)` 라벨 정상화. 이제 **전 세트 `sha256sum -c` 통과** |
> | **J5** | 「재현본이 같은지 검증」은 과대 표현 | **「바이트 동일 여부를 판정한다」**로 낮추고, MANIFEST=identity commitment / SOURCES=재생성 경로로 역할을 분리해 적었다 |
> | **R3** | 그리팅 계열 동의 항목을 「없다」고 추론하면 안 된다 | **8건에 확인 체크를 삽입**했다 — 폼 마지막 단계에서 눈으로 확인 |
> | **J4** | 「한 겹의 문제 ↔ 두 겹의 역할」 논리 충돌 | GPT 제안 문장을 반영하고 **재빌드**했다(5쪽 유지·회사명 0). 다음 문단도 「두 층을」로 맞췄다 |
> | **Bear** | `I have built that third layer.` 는 access-policy 전체를 만들었다고 읽힌다 | `the device-identity part of that third layer` 로 좁히고 `holds` → `remains valid` |
>
> **판단 J1(Embedded 제외)·J2(SOCAR 합본)·J5(비대칭 유지)는 GPT 가 내 판단을 지지**했다.
> J2 합본은 「카페 2시간에서는 후순위」라는 GPT 판단대로 **대안으로 기록만** 해 두었다.
>
> ### 🔴 검수가 열어 준 추가 발견 — 내가 놓친 것
>
> Toss 커버레터의 「여섯 개 하네스」를 고치고 「정정 완료」라 보고했는데, **같은 오류가 리포
> 전역에 퍼져 있었다.** 특히 **`resume/targets/developer-experience-engineer.org` 의
> `fanned into six harnesses`** — **이력서 PDF 로 실려 나가는 자리**다. DevEx 컷은 오늘 SOCAR 에
> 낼 파일이고, **이미 제출한 AIRS 에도 그 숫자로 나갔다.**
> → 정본을 고쳐 **여섯 컷 재빌드**, 미제출 8개 문서 일괄 정정, **제출 완료 4개 문서는 보존**,
> 델타를 `LEDGER.md` §메모 ③ 에 기록(면접 대비 답변 포함).
> **한 곳을 고치고 「정정했다」고 말하면 안 된다는 사례로 남긴다.**

**요청자**: Claude (오라클 서버 세션) · **검수자**: GPT · **중계**: GLG
**목적**: **GLG 가 노트북으로 옮겨 카페에서 제출을 이어간다. 노트북에서의 삽질을 줄이는 것이
이 검수의 목적이다.** 문장 다듬기보다 **실행이 실제로 막히는 지점**을 먼저 봐 달라.

- 변경 규모: **68 파일** (48 tracked 수정 · 675 insertions / 54 deletions) + SOURCES.md 신규
- 검사 통과: `applications/check.py` **27건 일치** · `check.py --deep` **깊이 문서 26개 통과**
- ⛔ **커밋하지 않았다.** GLG 가 커밋 시점을 정한다.

---

## 1. 오늘 오전에 한 것 — 세 덩어리

### ① 카페 세션 준비 (초반)

- `alive.py` 재실행 — 19건 · 열림 12 · 미판정 7(어댑터 없음) · **닫힘 0**
- `SUBMIT-QUEUE.md` 에 **§카페 세션** 블록 신설 (A 즉시 → B Ashby 4연타 → C 한화 → D 커버레터 → E 잔여)
- **Toss 커버레터 사실 정정** — 3문단 「**여섯** 개 하네스」→ **다섯**.
  근거: `~/repos/gh/agent-config/README.md` §Harness Support 를 세면 구별되는 하네스는 다섯
  (pi 축 3행은 같은 pi + Claude Code · Codex · Antigravity · OpenClaw). 나열된 다섯과 일치.
  같은 README 에 전례가 박혀 있다 — *"OpenCode is not used. It once appeared in this table
  **and in the fan-out list**"*.
  **파일**: `applications/toss--ai-engineer-platform/cover-letter.md` (§왜 이렇게 썼는가 7번에 근거)

### ② 「딸랑 이력서 하나」 해결 — GLG 지적

> *"이력서만 낼 게 아니라 가능하면 포트폴리오랑 경력기술서 내면 좋거든. 오전에 하나 내는데
> 딸랑 이력서 하나 준비되어있더라. 그냥 하나만 내기에는 성의가 없다."*

**진단한 근본 원인**: `stage.py` 가 `submission.md` 의 「첨부 컷」 행에서 **`resume/build/` 만**
읽었다. dossier PDF 를 세트에 깔 경로가 아예 없었다. AIRS 에 나간 2종은 손으로 복사된
것이고, 그래서 **어느 세트를 열어도 이력서 한 장**이었다.

| 한 일 | 파일 |
|---|---|
| `competency.org` 프롤로그를 **회사 중립**으로 (AIRS 조준문이 박혀 있었다) | `dossier/competency.org:189` |
| Competency 5쪽 · Portfolio 12쪽 **재빌드** (회사명 잔재 0건 `gs` 확인) | `dossier/build/` (gitignore) |
| `stage.py` 가 **「추가 첨부」 행**에서 `dossier/build/*.pdf` 를 읽게 확장 | `applications/stage.py` |
| **AX·에이전트 축 11건**에 「추가 첨부」 행 + 세트 3종화 | 각 `submission.md` |
| 낡은 판정 **3건 뒤집기** — Lunit · SOCAR · Upstage | 각 `submission.md` |
| **Embedded 축 4건은 제외** + 이유 기록 | Bear · Telechips · Telit · Sonatus |
| 계약에 박기 | `applications/AGENTS.md` §이력서 한 장으로 끝내지 않는다 |

### ③ PDF 를 git 에서 뺐다 — GLG 결정

> *"git 에 넣지말고 org 있으니까 제출할때 생성하게 하자. 그리고 org 를 각 위치에 저장하면돼.
> 그걸로 재현되니까. pdf는 넣을수록 리포가 지저분해지니까"*

- `.gitignore`: `applications/*/submit/*.pdf` — **43.4MB → 100KB**
- 증언을 대신하는 두 파일: `submit/MANIFEST.sha256`(지문) + `submit/SOURCES.md`(재현 경로, 신규)
- **지문 없던 제출 4건 메움** (AutoEver · DEEPX ×2 · Enhans) — `check.py` 가 이제 FAIL 로 잡는다
- 새 검사 **`check.py --deep`** — `gs` 로 깊이 문서 **앞 6,000자**를 읽어 다른 건 회사명 탐지

---

## 2. 🔴 노트북에서 터질 수 있는 지점 — 여기부터 봐 달라

### R1. dossier 빌드가 노트북에서 실패할 수 있다 (가장 큰 리스크)

`dossier/run.sh:91` 이 **Doom Emacs straight 빌드**를 요구하고 없으면 `exit 1` 한다.
서버에서는 됐지만 **노트북 `EMACSDIR` 상태는 미확인**이다. 실패하면 깊이 문서를 못 만들고
「이력서 한 장」으로 되돌아간다.

- **내가 넣은 폴백**: AIRS 세트의 `KimJunghan_AX_Portfolio.pdf` 는 **tracked 이고 회사명 0건**
  이라 노트북에 이미 있다. 그것을 복사한다. `SUBMIT-QUEUE.md` §0 에 스크립트로 적었다.
- ⛔ Competency 는 폴백 불가 — AIRS·NHN 세트 것 모두 **그 회사 조준판**이다.

**✅ 「낼 파일이 하나도 없는」 최악 시나리오는 없다 — 확인했다.**
gitignore 는 **이미 추적 중인 파일에 무효**다. `git ls-files` 로 확인하니 오늘 낼 **11건 전부에
이력서 PDF 가 tracked** 로 남아 있다(Lunit·SOCAR·FriendliAI·FuriosaAI·42dot·Reflection·
MakinaRocks·Toss 각 1개). 그래서 `resume/run.sh` 가 노트북에서 실패해도 **이력서는 있다.**

- 이 사실의 부수 효과: **이력서 PDF 는 앞으로도 계속 커밋된다**(tracked 라 gitignore 무시).
  37KB × 27건 ≈ 1MB 이고, 동시에 **빌드 실패 시의 폴백 자산**이다. 그래서 그대로 뒀다.
  「지저분」의 주범은 **3.8MB Portfolio** 였고 그것만 막았다.
- **GPT 에게**: 이 비대칭(이력서는 tracked 유지 · 깊이 문서는 ignore)을 그대로 둘 것인가,
  아니면 `git rm --cached` 로 이력서도 빼고 **빌드를 필수로** 만들 것인가.
  후자는 폴백을 잃는다. **내 판단은 「그대로 둔다」** 이고, 근거는 위 두 줄이다. 반박해 달라.

### R2. 노트북 `dossier/build/` 에 아침 AIRS 재타깃판이 남아 있다

`git pull` 로 중립 org 를 받아도 **재빌드하지 않으면 낡은 PDF 가 그대로 깔린다** —
Lunit·SOCAR 에 *"AIRS Medical AX 팀이 만드는…"* 이 붙는다. **눈으로는 안 보이는 사고다.**

- 막은 방법: `SUBMIT-QUEUE.md` **§0** 절차 + `check.py --deep`
- **검증했다**: AIRS 조준판을 Lunit 세트에 심어서 `--deep` 이 잡는 것을 실물로 확인
- **GPT 에게**: `stage.py` 가 스스로 감지하지 않는다(사람이 `--deep` 을 돌려야 한다).
  §0 을 건너뛰면 사고가 난다. **`stage.py` 안에 넣는 게 맞는가?** 판단해 달라.

### R3. Lunit 폼에 동의 항목이 하나 더 필요해졌다

선택 첨부를 올리므로 「(선택) 추가 지원 서류 수집 동의 = **YES**」가 필요하다.
**어제 기록은 「체크 불필요」였다** — 그대로 내면 올린 2종이 처리되지 않을 수 있다.
근거는 그 건 §폼 스키마(2026-07-29 브라우저 실측) 표의 마지막 행.

- **GPT 에게**: 같은 함정이 **다른 건에도 있는지** 봐 달라. 내가 확인한 것은 Lunit ·
  한화비전(「선택항목 수집 동의」) 둘이다. 그리팅 계열(SOCAR · MakinaRocks · Upstage · AIRS)에
  같은 동의 항목이 있는지는 **폼 미실측이라 모른다.**

---

## 3. 재검이 필요한 내 판단 — 틀렸으면 말해 달라

### J1. Embedded 축 4건에 깊이 문서를 붙이지 않았다

Bear · Telechips · Telit · Sonatus. 근거: 두 문서는 AX·에이전트 축이고, **Bear 커버레터가
이미** *「에이전트·하네스·MCP 서사를 붙이면 지원자가 무엇을 하는 사람인지 흐려진다」* 고
판단했다. 그 일관성을 깨지 않았다.

- **반대 근거도 있다**: GLG 의 지적은 「하나만 내기엔 성의가 없다」였고, 이 4건은 여전히
  이력서 한 장이다. **Bear 는 Peer Interview 3시간**짜리 전형이라 문서가 더 필요할 수도 있다.
- **판단해 달라**: 축 일관성 vs 두께. 내가 GLG 지시를 좁게 읽었나?

### J2. SOCAR 에 Portfolio 만 넣었다

그리팅 `docsInfo` 슬롯이 **필수 「이력서 및 경력기술서」 + 선택 「포트폴리오」 둘뿐**이라
Competency 5쪽은 낼 칸이 없다고 봤다. **공고 문구는 경력기술서를 함께 요구**한다.

- **대안**: 이력서 + Competency 를 **한 PDF 로 합쳐** 필수 슬롯에 넣는 방법이 있다
  (선례: `applications/deepx--ai-agent-workflow-automation-engineer/build.sh` — `pdfunite`).
  DEEPX 는 실제로 그렇게 냈다(7쪽 통합본).
- **판단해 달라**: 슬롯 이름을 존중해 Portfolio 만 낼 것인가, 합본으로 경력기술서 요구를
  정면으로 받을 것인가. **카페 2시간이라 합본은 시간이 든다**는 제약이 있다.

### J3. `check.py --deep` 이 앞 6,000자만 본다

첫 판은 본문 전체를 봤고 참고문헌의 `OpenAI, "Codex cli." 2025`(문서 **93%** 위치)를 조준으로
읽어 **12건을 오판**했다. 그래서 앞 6,000자로 좁혔다(Competency 5쪽의 11% · Portfolio 12쪽의 6.5%).

- **놓칠 수 있는 것**: `portfolio.org` 는 프로젝트별로 **「JD 관련성」** 절을 두는 문법이다
  (`dossier/AGENTS.md` §편집 우선순위). 그 절에 회사 조준문이 들어가면 **6,000자 밖**이라
  놓친다. 지금 정본은 회사명 0건이지만 **구조적으로 뚫려 있다.**
- **판단해 달라**: 6,000자가 맞나? 아니면 「참고문헌 절 이전 전체」로 자르는 게 맞나?
  (`* 참고자료` 헤딩이 `portfolio.org:362` 에 있다.)

### J4. 중립화 프롤로그 문장 — 교열 대상

내가 다시 쓴 한국어다. `dossier/competency.org:189`:

> 조직이 AI 를 실제로 쓰는 작업면을 만드는 일을 저는 한 겹의 문제로 읽습니다. *흩어진
> 정형·비정형 데이터를 조직이 자연어로 쓸 수 있는 하나의 표면으로 만드는 일* 입니다. …
> 하나는 **데이터 계층과 MCP 서버**처럼 에이전트가 딛고 설 데이터·프로토콜 기반을 구축하고
> 운영하는 일이고, …

- 원문은 「**AIRS Medical AX 팀이 만드는 AI Native Workspace** 를 … 」 + 「**Central Data
  Layer 와 MCP Server**」였다(둘 다 AIRS 공고 용어).
- **봐 달라**: ① 중립화하면서 **글의 힘이 빠졌는지** ② 「작업면」이 이 문서 다른 곳의 어휘와
  맞는지 ③ 첫 문장이 프롤로그 나머지(2~4문단)와 이어지는지.

### J5. PDF 를 git 에서 뺀 것과 「제출 스냅샷은 고치지 않는다」 원칙의 정합성

- 이미 tracked 인 PDF(AIRS · NHN · 한화 · AutoEver · DEEPX ×2 · Enhans · Holiday)는 남겼다 —
  히스토리를 다시 쓰지 않았다. **그래서 새 건과 옛 건의 규칙이 갈린다.**
- 증언은 `MANIFEST.sha256`(지문) + `SOURCES.md`(재현 경로)로 대신한다. `check.py` 는
  `submitted` 건에 **지문이 없으면 FAIL** 한다(PDF 존재는 더 이상 요구하지 않는다).
- **판단해 달라**: 재현본이 **바이트 동일**하지 않을 수 있다(폰트·xelatex 버전·타임스탬프).
  그럼 지문이 「검증용」으로 얼마나 유효한가? 내가 이 한계를 과대평가했나?

---

## 4. 손대지 말 것 / 동시 편집 금지

- ⛔ **`applications/*/submit/` 산출물** — `stage.py` 가 생성한다. 손으로 고치면 다음 실행에
  덮인다. 고칠 것이 있으면 **org·`cover-letter.md`·`stage.py`** 를 고친다.
- ⛔ **제출 완료 7건의 `submit/` 스냅샷** — 그때 나간 파일이 사실이다.
- ⛔ **`dossier/build/`** — gitignore. 서버 판과 노트북 판이 다르다.
- ⚠ **내가 지금 잡고 있는 파일** (충돌 방지): `applications/stage.py` · `check.py` ·
  `SUBMIT-QUEUE.md` · `AGENTS.md` · `NEXT.md` · `.gitignore` · `dossier/AGENTS.md` ·
  `dossier/competency.org`.
  **문장 교열은 `cover-letter.md` 와 `competency.org` 프롤로그에서 해 달라** — 그쪽은 비켜 있겠다.

## 5. 검증 명령

```bash
cd ~/repos/gh/apply
applications/check.py             # 원장 ↔ 기록 ↔ 세트 정합 (27건)
applications/check.py --deep      # + 조준 누출 (26개 PDF · 약 20초)
applications/alive.py             # 공고 생존 (제출 당일)
git status --short | wc -l        # 68
git add -A --dry-run | grep -c '\.pdf'   # 0 이어야 한다
```

**읽을 순서 제안**: `NEXT.md` §NOW (오늘 판 전체) → `applications/SUBMIT-QUEUE.md` §0·§카페
세션 → `applications/AGENTS.md` §이력서 한 장으로 끝내지 않는다·§PDF 는 git 에 넣지 않는다 →
`applications/lunit--senior-ax-engineer/submission.md` (판정 뒤집기 실물) → `stage.py`·`check.py` diff.
