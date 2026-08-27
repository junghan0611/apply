# RAIL — 현재 좌표

- [x] **1. 후보·폼·첨부 실측과 제출 패킷 준비**
- [x] **2. 2026-08-09 즉시 제출 묶음 5건 발사** — MakinaRocks · Wonderful · Cohere · Telit · Bear Robotics
- [ ] **3. 남은 ready 건을 한 건씩 실제 제출** ← CURRENT: OpenAI DevEx의 180일 5건 제한을 GLG가 재확인
- [ ] **4. 새 후보를 원본 ATS 확인 뒤 케이스 승격**

현재 좌표: 2 완료 → 3 승인 대기 → 4 후속

# NEXT — 전체 이력을 정제해 `apply`를 공개한다 (2026-08-27 GLG 결정·GPT 교차검수)

> **GLG**: *"회사 이력·상세 업무 내용은 다 공개된 거라 상관없어. 개인정보만 제거하면 된다.
> 깃 히스토리 정리하는 도구로 정리한 다음 이 리포를 공개해버리는 전략."*

## 2026-08-27 열린 판단 3건 종결 — GLG opt-in

검수가 올린 문맥형 항목을 GLG 가 **현재 수준 유지**로 닫았다. 거주 도시 · 경력 공백 사유 서사 ·
국적/취업 자격 · 장애/보훈 「해당 없음」 · 연구실+방문랩 조합의 재식별 가능성이 대상이다.
근거는 본인을 검색하면 공개면에서 이미 확인되는 정보라는 것, 그리고 「해당 없음」이 상태가 아니라
칸이 채워졌다는 사실만 남긴다는 것이다. 함께 닫힌 것: **JD 인용 현재 수준 유지**(원문 복제는 이미
tombstone, 남은 것은 요구사항 대조 기록), **현직 서술 현재 수준 유지**(도해·binary·archive·고객
식별자·내부 endpoint 는 제거된 상태이고, 남은 클러스터·납품·도구 서술은 문서 파이프라인과 시스템
역량을 보이는 핵심 증거라 공개한다), **생성 문서 binary 는 공개 history·tree 양쪽에서 0**.

🔴 **이 opt-in 은 열려 있던 한 행을 닫은 것이지 계약을 넓힌 것이 아니다.** 전화·생년월일·상세 주소·
개인 이메일·병역 상세·GPA·동의값·제3자 개인정보·제출 binary 는 제거된 채로 남는다. 근거와 범위는
`PUBLICATION.md` §2026-08-27 GLG opt-in 결정과 `docs/HISTORY-REDACTION.md` §What was kept on purpose.
이 결정으로 문맥형 항목의 추가 rewrite 는 하지 않는다.

## 검토 결론 — 공개한다. 단, 오염된 GitHub object database를 public으로 뒤집지는 않는다

이 기록은 **탈락까지 포함한 증거 우선 문서 파이프라인 사례**로 공개 가치가 있다. 79개 커밋의
의사결정 흐름도 보존한다. 다만 현재 GitHub 저장소를 force-push한 뒤 같은 repository id를
private→public로 바꾸는 방식은 쓰지 않는다. force-push 뒤에도 GitHub가 옛 unreachable object와
cached view를 즉시 제거했다는 보장이 없고, 알려진 옛 SHA가 공개면에서 살아날 수 있기 때문이다.

**채택 경로:** 현재 원격을 새 이름의 **private archive**로 보존 → 정제된 79커밋 history를
**새 GitHub object database의 private `junghan0611/apply`**에 push → GitHub에서 다시 clone한
판을 검증 → 마지막에 public 전환. 즉 **allowlist로 한 커밋짜리 새 역사를 만드는 것이 아니라,
정제된 전체 역사를 새 그릇에 싣는다.** 현재 원격은 branch 1 · tag/PR/issue/release/workflow/
artifact/deployment/fork 0 · collaborator 1로 실측돼, repository id를 버려도 잃을 협업 표면이 없다.

같은 repository id를 꼭 유지해야 한다면 GitHub Support의 sensitive-data purge와 cached-view
제거 확인을 public 전환의 별도 선행 관문으로 둔다. 단순 force-push만으로는 승인하지 않는다.

## 2026-08-27 1차 실측 — 최초 계획보다 제거면이 크다

- `git rev-list --all`: **79 commits** · merge 0 · root 1 · 커밋 타임존 전부 `+0900` ·
  pack **64.00 MiB**(`git count-objects -vH`). `git rev-list --objects --all`은 **1,484 objects**
  (blob 834 · commit 79 · tree 571), 과거 고유 path명은 **381개**다. object 수와 path명을 같은
  숫자로 부르지 않는다.
  ⚠ path명을 세는 명령은 정확히 이것이다 —
  `git log --all --name-only --pretty=format: | sed '/^$/d' | sort -u` (381).
  `--pretty=format:`을 빼면 커밋 메시지 줄까지 섞여 **1,120**이 나온다.
- 🔴 **제거 경로 목록을 `git rev-list --objects --all`에서 뽑으면 42개가 조용히 빠진다.**
  같은 내용의 blob이 여러 path에 있으면 rev-list는 **그 blob을 한 path 이름으로만 출력**한다.
  실측: rev-list 기반 blob path label 339개 vs `git log --name-only` 기반 과거 path명 381개,
  차이 42개. 그 안에는 `submit/KimJunghan_Resume_*.pdf` 10개, `submit/MANIFEST.sha256` 9개,
  옛 `nhn/` 경로 18개(`nhn/images/master/{company-ax-arch.jpg,company-ax-layer.png,
  platform-lineage.jpg,product-stack.jpg,openclaw-ops.jpg,...}`와 `nhn/pipeline/templates/ieee.csl` 포함),
  동일 코드/설정 사본 5개가 있다. 예: `applications/deepx--linux-bsp-engineer/count.sh`는 blob
  `7009bc1f`를 다른 건의 `count.sh`와 공유해 rev-list 출력에 자기 이름으로 등장하지 않는다.
  **remove-path 목록·검토 목록·검증 목록은 전부 `git log --all --name-only --pretty=format:`에서 뽑는다.**
- 🔴 **공백과 한글이 든 path가 하나 있다** —
  `applications/ignite--ai-developer/assignment/AI FDE_사전과제_260701.pdf`
  (IGNITE 과제 PDF, CSV 2개와 별개다). `awk '{print $2}'`·`cut -d' '`처럼 공백으로 자르는 파이프는
  이 경로를 `.../assignment/AI`로 잘라먹는다. 실제로 이번 실측 중에 한 번 그렇게 잘렸다.
  filter-repo `--paths-from-file`은 한 줄 = 한 path이므로 **목록 생성 단계에서 공백 안전한 방식으로
  뽑고**, 셸 glob으로 이 경로를 다루지 않는다.
- 현재 tracked binary: **PDF 37개**, ODT 1개, PNG/JPEG 14개. history에는 PDF blob 50개,
  ODT 5개, ZIP 1개가 있다. **현재 PDF 다수에서 이메일이 추출됐다.** `--replace-text`는 PDF·ODT·
  ZIP 내부를 고치지 못하므로 PDF를 “같은 스캔 대상”이라고만 적은 기존 계획은 부족하다.
- text history 후보 스캔: 이메일이 있던 path 66개, 전화 패턴 path 7개, 생년 키워드 path 27개,
  병역 키워드 path 38개. 패턴 hit는 누출 판정이 아니지만 수동 분류할 검토면이다.
- PII 밀집 파일은 AutoEver 스냅샷 하나가 아니다.
  `nhn--ax-transformation-ai-infra/submit/KimJunghan_AX_Applicant_Form.md`에도 정확한 병역 기간과
  지도교수·공동수상자 실명이 있다. 둘 다 history에서 경로째 제거하고 공개용 재작성본만 새로 둔다.
- `nhn--ax-transformation-ai-infra/referral.md`는 추천인 실명·소속뿐 아니라 제3자가 승인한 추천서
  원문이다. 익명화만 해도 관계·문체로 재식별될 수 있다. **공개 동의를 새로 받지 않으면 원문을
  빼고 “추천서 주장 ↔ 증거” 구조만 요약해 남긴다.**
- 회사 담당자의 전화·개인 회신 이메일, candidate-specific ATS URL/UUID, 본인 이메일·거주지,
  author/committer의 Gmail 주소도 제거 대상이다. commit metadata의 Gmail 등장은 44회지만
  그것은 **22커밋 × (author, committer) 2필드**다 — 아래 「commit metadata의 실제 구조」 참조.
- `gitleaks git --redact`는 Upstage API 문서의 `Authorization: Bearer …` 예제 11건을 후보로 냈다.
  현재 판독은 예제 placeholder다. `trufflehog 3.95.3` 재실행은 1,770 chunks/7.3MB에서 **verified
  secret 0**, unverified 1건이었고, 그 1건은 `42dot.../submission.md:23`의 필드 라벨
  `GitHub/Gitlab/Arxiv`를 GitLab token으로 오인한 false positive였다. 정제본에서도 둘 다 재실행한다.
- **전체 blob 834개 category 스캔(Claude 교차검수, 값 미출력·path만).** 계약 표에 없던 면이 나왔다.
  - **보상 정보 43 path** — `연봉|current salary|expected salary`. 옛 게이트 `scripts/check-public.sh:83`은
    '현재 연봉'을 이미 private 표식으로 막고 있었다. 새 계약이 옛 게이트보다 후퇴하면 안 된다.
  - bare UUID **33 path**, 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 절대경로 **6 path**(HEAD의 `dossier/run.sh` 포함),
    내부 호스트형 문자열 **4 path**, 보훈/장애 **33 path**, 동의값 **23 path**, 혼인/가족 **2 path**.
  - `Authorization: Bearer` 후보는 **1 path**뿐이다 —
    `applications/upstage--ai-engineer-agents/evidence/upstage-for-agents-raw.md`.
    raw 제3자 API 문서 복제라 secret 판정 논쟁 없이 **path 제거로 닫힌다.**
  - RRN·계좌·여권·AWS/GitHub/Slack/OpenAI 토큰·private key **0건**.
- **verified negative — 얼굴 사진은 history 전체에서 깨끗하다.** `applications/**/*.{png,jpg,jpeg}`
  blob **0건**. `.gitignore:50-61`이 2026-08-09부터 막았고 그 이전에도 커밋된 적이 없다.
  이건 숨길 사실이 아니라 **공개 receipt에 「verified negative」로 적어 독자가 검토하게 할 사실**이다.
- **`*/JD.md`가 history에 33개.** 경로째 지우면 그 33건의 「요구→주장→증거→결과」 diff가 통째로
  빈다. 커밋은 남지만 속이 빈다 — §C-2의 tombstone 선택지가 여기서 필요하다.
- **commit metadata의 실제 구조.** 메시지 본문의 이메일은 4건이고 **전부 `Co-authored-by:` 이며
  도메인은 전부 `@users.noreply.github.com`**(개인 Gmail 0건). ident 쪽이 gmail인 것은
  **author 22커밋 · committer 22커밋**이고 나머지 57커밋은 이미 noreply다. 위의 "Gmail 44회"는
  22커밋 × 2필드다. 그래서 검증 기준은 "44 → 0"이 아니라
  **"author/committer ident 전수가 noreply 도메인"**이다.
- **`gh api`로 원격 표면 재확인(2026-08-27).** `private=true, fork=false, forks_count=0,
  network=0, subscribers=0, branches=[main], tags=0, PR(all)=0, issues(all)=0, releases=0,
  deploy keys=0, webhooks=0, actions runs=0, collaborators=[junghan0611]`.
  repository id를 버려서 잃을 협업 표면이 실제로 0이라는 근거다.
- `scripts/check-public.sh`의 **기본 모드**는 지금도 `.git`·`applications/`·`dossier/`·`NEXT.md`가
  있으면 실패하는 옛 allowlist-export 게이트다. 이번 전략의 검증기는 그쪽이 아니라
  `--repo`(→ `scripts/check-public-repo.sh`)이고, reachable blob·path·commit metadata·커밋 메시지를
  본다. 기본 모드는 지금 전략과 반대 방향을 금지하므로 공개 저장소 트리에 돌리지 않는다.
- ⚠ **SSOT가 아직 옛 전략을 말하는 곳이 남아 있다.** 루트 `AGENTS.md` §공개는 나중에 가 여전히
  "allowlist 로 새 트리 + 새 history 를 만든다"고 적혀 있다. `README.md`는 2026-08-27에 고쳤으나
  `AGENTS.md`는 이번 검수 범위 밖이라 손대지 않았다 — **A-1에서 이 절을 exact target으로 고친다.**
- [x] 다른 PRIVATE repo 이름과 그 안의 사례 경로는 **치환으로 닫았다(2026-08-27).** 정제본에서는
  `<private assignment repo>` · `<private case path>` 로 바뀌어 있고, 실측이 blob 0 · 커밋 메시지 0 ·
  경로명 0 이다(원본 mirror 에는 12 blob). 이 줄은 미결이 아니라 완료 기록으로 남긴다.
- [x] 그 에이전트 세션 turn 발췌는 **경로째 제거로 닫았다** — 「세션 JSONL 커밋 금지」 계약의
  회색지대를 판독 목록에 미루지 않고 `session-excerpt` 범주로 지웠다. 다만 게이트의 그 범주
  정규식은 파일명 뒤 날짜 꼬리 때문에 **정작 그 경로를 못 잡고 있었다**(장식이던 규칙).
  2026-08-27 수정 후 제거된 86 경로 전수에 대해 86/86 커버, 생존 295 경로에 오탐 0 을 확인했다.
- `/tmp` disposable mirror에서 1차 filter-repo 명령을 실험했다. preliminary path 제거·이메일 치환·
  mailmap 뒤에도 **79 commits · root 1 · merge 0 · ref 1**이 유지됐고 PDF/ODT/ZIP 과거 path와 commit
  Gmail은 0건이었다. reverse-topo 순서로 author name·author/committer timestamp·subject·parent 수를
  대조한 79행도 전부 일치했다. 이는 명령 형태의 receipt이지, 개인정보 최종 검증 통과가 아니다.

## 공개 데이터 계약 — filter 실행 전에 먼저 고정한다

**유지:** 본인 실명(`김정한`/`Junghan Kim`), 회사·직무·학교명, 공개 프로젝트 상세, 지원 판단과
답변, 제출/합격/불합격 시간축, 공개 GitHub·가든 링크.

**기본 제거:** 본인 이메일·전화·생년월일·성별·상세/생활 주소·GPA·병역 상세·장애/보훈·동의값,
**본인의 현재/희망 연봉과 처우 협상값**, commit email, 담당자/추천인/동료/지도교수의 이름·소속·개인
연락처, candidate-specific URL·회신 주소, 문서 metadata, 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 로컬 절대경로.
본인 이메일을 공개 연락처로 유지하려면 GLG가 **그 항목만 별도 opt-in**한다.

⚠ **보상 정보는 정규식 하나로 못 가른다.** 43 path 중 JD가 제시한 보상 범위나 일반 언급은 남길 수
있고, **GLG 본인이 적어 넣은 현재/희망 연봉은 남기지 않는다.** 두 종류가 같은 파일에 섞여 있으므로
43 path 전수를 사람이 한 줄씩 분류한 뒤에야 치환 목록이 닫힌다. 협상력에 직접 손해가 나는 값이다.

**문맥형 개인정보도 별도 opt-in 표로 판정:** 국적/취업자격, 운전면허 보유, 육아·생계형 노동이
포함된 공백기, 거주 도시, 영어 자기평가, 연봉·입사 가능일·출장 가능 같은 생활/법적 사실은
정규식으로 안전 판정할 수 없다. GLG가 “이 서사의 일부로 공개”라고 항목별로 고르기 전에는 뺀다.

**개인정보와 별도인 공개 관문:** 공개돼 있던 JD라고 재배포 허락까지 생기는 것은 아니다.
원문 전체를 긁은 JD·API 문서·채용 과제 PDF/CSV는 출처 URL과 필요한 인용/요약만 남기고 원시
복제본은 뺀다. 현직 프로젝트 상세도 GLG의 공개 결정과 별개로 고용계약·고객 비밀·보안 경계를
한 번 더 수동 검토한다. 이 두 관문을 개인정보 스캔 통과로 갈음하지 않는다.

**받은 과제 데이터는 인용이 아니라 복제다 — exact path로 못 박는다.**
`applications/ignite--ai-developer/assignment/defect_log.csv`(41행),
`.../assignment/equipment_log.csv`(63행), 그리고 과제 브리프 PDF
`.../assignment/AI FDE_사전과제_260701.pdf`(공백 포함 경로)는 회사가 준 원본이고,
`.gitattributes:2`가 CSV 경로를 binary로 고정해 두었다. 라이선스나 요약으로 해결되는 물건이 아니라 **모든 역사에서
경로째 제거**한다. 「채용 과제 PDF/CSV」라는 일반론만 적어 두면 실행 목록에서 빠진다.

**로그인 게이트 뒤 서비스의 자동화 코드는 개인정보와 다른 축이다.**
`applications/remember.js`는 로그인 뒤에만 열리는 서비스의 비공개 API 지도를 담고, 앱 자신의 XHR이
`Authorization` 헤더를 붙이는 순간을 가로채는 기법을 적어 두었다(파일 상단 주석). PII 스캐너로는
절대 걸리지 않는다. 공개하면 (a) 타사 ToS 위반, (b) 비공개 엔드포인트 공개, (c) 토큰 취득 기법
배포로 읽힌다. **보수적 기본값으로 모든 역사에서 path 제거하고, 공개판에는 코드 없는 방법·경계만
서술한다.** `.claude/skills/linkedin-jobs/ljobs.py`는 무로그인 guest 엔드포인트라 등급이 다르다 —
`README.md`의 best-effort·무쿠키 고지를 유지하는 선에서 공개할 수 있다. **둘을 같은 칸에 넣지 않는다.**

**현직 아키텍처 도해는 텍스트 스캔으로 판정되지 않는다.**
`dossier/images/{company-ax-arch,company-ax-layer,platform-lineage,product-stack,openclaw-ops,
andenken-rag,entwurf-hero}.png`와 `dossier/images/master/*.jpg`, 옛 경로 `nhn/images/*`
(history PNG 25 · JPG 6), 그리고 history 최대 blob인
`nhn/build/KimJunghan_AX_Evidence_Package.zip`(9.1MB)은 **보수적 기본값으로 모두 history에서
제거한다.** 공개 권리가 확인된 도해만 metadata를 벗겨 rewrite 뒤 새 commit으로 되살릴 수 있다.
현재 공개판은 도해 0개로 닫는다. 참조 위치는 `dossier/portfolio.org:85-88,233,284` ·
`dossier/detail.org:92,310,380` · `dossier/competency.org:202`이며 깨진 참조도 함께 걷는다.

## 2026-08-27 구현 상태 — sanitized candidate가 실제로 존재한다

계획이 아니라 **돌아간 결과**다. candidate는 private local state(0700) 아래에 있고 remote가 없다.
구체 경로와 SHA는 private handoff에만 적는다.

- **rewrite 2패스 완료.** 패스1 = 경로 제거 + JD tombstone(`--filename-callback` + `--blob-callback`),
  패스2 = `--replace-text` + `--replace-message` + `--mailmap`. 두 패스 모두
  `--prune-empty never --prune-degenerate never --replace-refs delete-no-add`.
- **보존 검증 통과.** commits 79 · merges 0 · roots 1 · timezone `+0900` 단일 ·
  reverse-topo 79행에서 author name·author ts·committer ts·parent 수 **mismatch 0** ·
  commit subject **차이 0** · ident 158/158 전수 noreply · remote 0.
- **제거 실측.** 381 historical path 중 **86개 제거, 295개 잔존**. 범주: 생성 바이너리 45 ·
  내부 도해 33 · dense PII 폼 2 · 받은 과제 2(+PDF는 바이너리로 계상) · 추천서 원문 1 ·
  raw 제3자 복제 1 · 세션 발췌 1 · 로그인 뒤 자동화 코드 1.
- **JD tombstone.** `*/JD.md` 33개 경로의 **distinct source blob 44개**에 opaque ordinal 부여.
  그 44개 중 비-JD 경로와 blob을 공유한 것은 **0개**라 다른 파일에 영향이 없다.
- **값 치환.** 이메일 12 · 전화 1 · candidate UUID 13 · 로컬 홈 경로 1 · 제3자 실명 2.
  `ieee.csl`의 upstream 기여자 이메일 4개는 **의도적으로 남겼다**(CC-BY-SA 저작자 표시).
- **게이트 통과.** `scripts/check-public.sh --repo`(신규 `check-public-repo.sh`) 전 항목 OK ·
  `applications/check.py --public` OK · `linkedin-jobs` 회귀 65/65 · 전 `.sh` `bash -n` ·
  전 `.py` `py_compile` · `gitleaks` OK · `trufflehog` **verified 0**(unverified 1은 GLG 본인의
  공개 프로필 슬러그를 GitLab 토큰으로 오인한 기록된 false positive).
- **미실행:** `dossier/run.sh check`는 `libreoffice` 미설치로 멈춘다. 정제와 무관한 환경 의존이다.
  resume/dossier 전체 PDF 빌드는 이 호스트에서 확인하지 않았다.

**작업 트리에 되돌려 넣은 파일:** `docs/HISTORY-REDACTION.md` · `scripts/check-public-repo.sh` ·
`scripts/check-public.sh` · `applications/check.py` · `dossier/run.sh`.
⚠ `dossier/*.org`의 도해 링크 치환은 **공개 tip에만** 넣었다. private 트리에는 도해가 실재하므로
여기서 링크를 끊으면 빌드가 깨진다.

## 실행 레일 — 각 관문을 닫기 전 다음 단계로 가지 않는다

### A. 공개 이후에도 다시 새지 않는 구조를 먼저 만든다

1. `README.md`·루트/레인 `AGENTS.md`·`PUBLICATION.md`를 public 운영 계약으로 바꾼다.
   앞으로 raw 제출 폼과 법적 값은 private Org에만 두고, public repo에는 **redacted case record**만
   둔다. 현재 “PRIVATE이므로 전부 담는다”는 계약을 둔 채 공개하면 다음 지원에서 다시 샌다.
2. `scripts/check-public.sh`를 현재 트리와 **모든 reachable blob/commit metadata/binary**를 검사하는
   게이트로 교체하고 CI/로컬 훅 양쪽에 건다.
   `applications/check.py`는 **어떻게 깨지는지가 이미 정해져 있다** — `check.py:100-131`의
   `digest_faults()`가 `submit/MANIFEST.sha256`의 지문을 `submit/<파일>`의 **실제 바이트**와
   대조하고, `check.py:133-155`의 `aim_leaks()`는 `gs`로 PDF 본문을 읽는다. 공개판에서 submit
   바이너리가 없으면 전 건이 실패한다 — **고 판단했으나, 실물을 읽어 보니 절반은 틀렸다.**
   `digest_faults()`는 이미 「있는 파일만 비교하고 없는 파일은 증언만 보존으로 통과」시킨다
   (`check.py:100-131` 주석, 2026-07-30 교차검수에서 그렇게 정해졌다). 즉 공개판에서 바이너리가
   없어도 이 검사는 통과한다. 진짜로 없던 것은 **반대 방향**이었다 — 「있으면 안 되는 것이 다시
   들어왔는가」. 그래서 `--public` 모드를 붙여 그쪽을 검사한다(2026-08-27 구현·검증 완료).
   MANIFEST 바이트 대조와 `aim_leaks`는 그대로 private 보관면의 불변식으로 둔다.

   ⚠ **MANIFEST가 텍스트 파일을 지문으로 잡으면 그 파일은 정제할 수 없다.**
   `nhn--ax-transformation-ai-infra/submit/KimJunghan_AX_Detail.md`가 그 경우다 — 공개용으로
   본문의 도해 참조를 고치는 순간 지문이 깨지고, 지문을 새로 찍으면 「그때 실제로 낸 바이트」라는
   증언이 거짓이 된다. 정제본에서는 **본문을 고치지 않고 바이트를 보존**했고, 그 안의 이미지
   참조는 끊긴 채로 남는다(끊긴 이유는 `docs/HISTORY-REDACTION.md`가 설명한다).
   앞으로의 계약: **지문을 찍는 텍스트 제출본은 제출 시점에 이미 공개 안전해야 한다.** 아니면
   private 보관면에 둔다. 나중에 고칠 수 있다고 가정하면 안 된다.

   ⚠ **현재 private 작업 트리에서 지문 불일치 16건이 이미 나 있다**(HEAD의 원본 `check.py`로도
   동일하게 재현된다 — 이번 변경과 무관한 선행 상태다). 제출 후 로컬에서 다시 빌드한 PDF가
   그때 낸 파일을 덮었다는 뜻이다. 공개판은 이 바이너리를 아예 싣지 않으므로 공개 위험은 아니지만,
   **private 기록 쪽의 바이트 증언이 그 16건에서 이미 깨져 있다.** GLG가 판단할 항목이다.
3. `~/repos/gh/agent-config/git-hooks/_scan.sh`를 **재배선**한다. 지금 `_scan.sh:61-62`가
   `*github.com[:/]junghan0611/apply)` → `loose`(secret만)이고, `_scan.sh:68-69`가 나머지
   `junghan0611/*` → `strict`(secret + `sensitive-terms.txt` 20줄의 identity terms)이다.
   `apply` 한 단어만 빼면 **새 public `apply`도, rename된 private archive도 둘 다 strict**가 된다.
   그런데 이 저장소의 공개 계약은 **본인 실명 유지**라 strict의 identity-term 게이트와 정면 충돌한다.
   그래서 세 가지를 같은 변경에서 정한다: (a) archive의 **새 이름을 loose에 명시 추가**,
   (b) public `apply`는 strict 대신 **새 public 게이트**를 물리거나 `.git-hooks-allow`로 실명 항목만
   예외, (c) 순서는 **훅 재배선 → archive rename → 새 repo 생성**. 「예외 제거」로만 적으면 (a)와
   (b)가 빠진 채 실행돼 archive 커밋이 막히거나 public 커밋이 실명에서 막힌다.
4. **라이선스는 결정됐다(2026-08-27).** 루트 `LICENSE`=MIT(코드), `LICENSES/CC-BY-4.0.txt`(방법·서사
   문서), 개인 이력·지원 답변은 `LicenseRef-Personal-Record`로 **권리 유보**,
   `LICENSES/CC-BY-SA-3.0.txt`+`NOTICE.md`(제3자 자료), 경로 매핑은 `LICENSING.md`.
   ⚠ 이 파일들은 **rewrite가 끝난 뒤 새 commit**으로 들어간다(§C-4와 같은 규칙).
   ⚠ `applications/remember.js`의 공개 여부가 정해지기 전에는 그 파일에 MIT를 적용한다고 쓰지 않는다.
5. **`docs/HISTORY-REDACTION.md`를 새로 만든다(아직 없다).** tombstone 본문과 §D-4가 이 파일을
   가리키므로, 없으면 공개판에 깨진 참조가 남는다. 담을 것은 **범주 · 방법 · 건수 · 사용한 도구와
   버전 · ref 범위 · binary 처리 방식**이다. **원문 값도, 값의 hash도 담지 않는다** — 전화·생년처럼
   entropy가 낮은 값은 hash도 공개 증명이 아니라 대조표가 된다.

### B. 원본 보존과 비공개 이관

1. **어떤 편집보다 먼저** 현재 원격과 로컬 refs의 mirror를 접근권한 0700인 로컬 private 위치에
   백업하고 HEAD·refs·bundle checksum을 private handoff에 기록한다. 백업 경로와 SHA는 public
   문서에 쓰지 않는다.
2. PII 밀집 원문은 `denotecli`/Emacs 계약으로 `~/sync/org/private/`에 이관한다. plain `mv`로 Org
   헤더를 흉내 내지 않는다. 공개 repo에 필요한 것은 별도의 redacted 재작성본이다.
3. history 전체에서 **경로 제거 목록**, **문자열 치환 목록**, **검증용 원문 목록**을 분리한다.
   원문이 든 파일은 repo 안에 만들거나 commit하지 않는다. `git-filter-repo --replace-text` 문법과
   `grep -f` 검증 패턴은 같지 않으므로 기존 `PRIVATE_TERMS.txt` 하나로 둘을 겸하지 않는다.

### C. disposable clone에서 history rewrite

1. **도구는 PATH에 상시 설치돼 있지 않다.** `command -v git-filter-repo` → 없음.
   `nix-shell -p git-filter-repo` 안에서만 돈다(2026-08-27 실물 확인 version `a40bce548d2c`,
   `--help`에서 `--sensitive-data-removal`·`--prune-empty ... never`·`--replace-refs` 존재 확인).
   **문서와 실행 스크립트에 Nix shell 경로를 그대로 적는다** — bare `git filter-repo`로 적으면
   다음 세션이 "명령이 없다"에서 멈춘다. poppler(`pdftotext`)·`exiftool`도 같은 방식으로 부른다.
   상시 설치를 강제할 필요는 없고, **쓴 도구와 버전을 게이트 receipt에 남기는 것**이 요구사항이다.
2. 모든 fetchable ref를 받은 fresh disposable clone에서 실행한다. **79개 commit을 그대로 남기기 위해
   `--prune-empty never --prune-degenerate never`를 명시한다.** 원본 checkout과 private archive에는
   실행하지 않는다.
   실측상 prune 위험 자체는 낮다 — 제거 시나리오 3종(바이너리+dense PII 3파일 / +모든
   `applications/*/submit/*`·`*/assignment/*`·`*/build/*` / +모든 `*/JD.md`)을 79커밋 전수로
   돌려 본 결과 **empty가 되는 커밋 0개**였다. 그래도 플래그는 보험으로 명시하고, 진짜 관문은
   §D-0의 보존 대조다.
3. **경로째 삭제(`--invert-paths`)와 내용만 치환(tombstone)을 구분해서 고른다.**
   - **바이너리** — PDF·ODT·ZIP·받은 과제 CSV는 경로째 삭제. 텍스트 치환으로 내부를 못 고치고,
     자리만 남겨봐야 깨진 파일이 된다.
   - **텍스트** — `*/JD.md` 33개처럼 **그 파일의 존재 자체가 결정 계보인 것**은 경로를 지우지 말고
     `--file-info-callback`(또는 blob 단위 치환)으로 **본문만 tombstone으로 바꾼다.** 서로 다른 원본
     revision에는 비가역 ordinal marker를 넣어, 원문이나 hash 없이 **파일 존재와 revision 사건**을
     남긴다. 원문 줄 단위 diff 모양까지 보존할 수 있다는 주장은 하지 않는다. 경로째 지우면 해당
     커밋의 사건 자체가 빈다.
   - tombstone 본문은 **무엇을 왜 뺐는지의 범주와 방법**·비가역 revision ordinal을 적고
     `docs/HISTORY-REDACTION.md`를 가리킨다. 원문 값도, 값의 hash도 적지 않는다.
   - dense PII 문서와 추천서 원문은 tombstone이 아니라 **경로째 삭제**다. 남은 자리에서 재식별이
     가능한 종류이기 때문이다.
   - 필요 이미지도 history에서 제거한 뒤 metadata를 벗긴 현재 안전본만 새 commit으로 다시 넣는다.
4. 산발 text blob은 검수된 exact/regex 목록으로 치환하고, commit/tag message는 `--replace-message`,
   author/committer ident는 `--mailmap`으로 noreply 주소로 다시 쓴다.
   ⚠ **`--mailmap`은 커밋 메시지 안의 이메일을 고치지 않는다.** 이 저장소는 실측상 메시지 쪽
   이메일 4건이 전부 `Co-authored-by:`의 noreply라 문제가 없지만, 그 사실을 확인한 채로 지나가는
   것과 모르고 지나가는 것은 다르다. 대상은 ident가 gmail인 **22커밋**이다.
   첫 변경 commit 이후 SHA가 바뀌는 것은 피할 수 없다. filter-repo `commit-map`은 private
   receipt로만 보존하고 public repo에는 옛 private SHA를 연결하는 표를 싣지 않는다.
5. 공개용 재작성본과 라이선스 파일(`LICENSE`, `LICENSES/`, `LICENSING.md`, `NOTICE.md`)은
   **rewrite가 끝난 뒤** 새 commit으로 넣는다. 제거할 옛 path와 같은 path에 먼저 만들어 두면
   `--invert-paths`가 안전본까지 함께 지우고, 라이선스 파일을 rewrite 전에 넣으면 79커밋 전체에
   소급 존재하는 것처럼 보인다.

### D. 공개 전 검증 — 누출 검사와 **보존 검사**는 다른 관문이다

**D-0. 보존 검사(먼저 닫는다).** 지금까지 D는 "무엇이 남았나"만 봤다. GLG의 절대 요구는
"히스토리가 살아야 한다"이므로 **"무엇이 사라지지 않았나"를 같은 무게로 검사한다.** 정제본에서:

```text
git rev-list --all --count            → 79
git rev-list --all --merges --count   → 0
git rev-list --all --max-parents=0 --count → 1
git log --all --format='%ad' --date=format:'%z' | sort -u  → +0900 하나
```

그리고 원본 mirror와 정제본을 **reverse-topo 같은 순서로 79행 대조**한다 — author name,
author timestamp, committer timestamp, subject, parent 수. mismatch 0이어야 한다.
메시지가 달라진 행은 **`--replace-message` 목록으로만 설명돼야 하고**, 설명되지 않는 차이가
한 줄이라도 있으면 rewrite를 다시 만든다.

**D-1. 누출 검사.** `git log -p`가 아니라 `git rev-list --objects --all`의 모든 reachable blob,
path명, commit/tag message, author/committer/tagger metadata를 스캔한다. 필수 기준:

- 원문 verification set **0건**;
- 제거 path와 옛 이름(`nhn/` 포함) **0건**;
- **author/committer ident 전수가 noreply 도메인**(“44 → 0”이 아니다);
- candidate-specific URL **및 bare UUID 패턴** 0건;
- 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 절대경로 0건;
- 보상 정보 43 path 분류 결과가 전부 닫혔는가.

**D-2. 바이너리.** 남긴 PDF/ODT/이미지가 있다면 추출 본문·metadata·육안 렌더까지 검사한다.
도구는 Nix shell로 부르고 **쓴 도구와 버전을 receipt에 남긴다**(`pdftotext`·`exiftool`은 PATH에
상시 설치돼 있지 않다). 추론 비용을 줄이려면 generated PDF/ODT/ZIP은 **0개를 공개 초기값**으로
삼는다. 이미지를 남기기로 하면 §공개 데이터 계약의 **도해 수동 관문**을 먼저 통과해야 한다.

**D-3. 스캐너.** `gitleaks` + `trufflehog` + PII 후보 스캐너를 모두 돌리고, false positive도
근거와 함께 allowlist한다. 스캐너 미설치/오류는 “0건”이 아니라 실패다.
정제 후 이메일 스캔은 `dossier/pipeline/templates/ieee.csl`의 upstream 기여자 이메일에 **반드시**
걸린다 — 근거를 적고 allowlist한다. 지우면 upstream 저작자 표시가 깨져 라이선스 위반이 된다.

**D-4. 테스트.** linkedin-jobs 회귀 · `applications/check.py`(public 모드) · resume/dossier source
build · 새 public contract gate. 깨진 private 경로 링크와 candidate URL도 검사한다.
`docs/HISTORY-REDACTION.md`의 범주·방법·건수가 실제 rewrite 입력과 일치하는지도 대조한다.

### E. 새 GitHub object database에서 최종 확인

1. **GLG 승인 1:** 현재 GitHub repo를 private archive 이름으로 rename한다. 공개하지 않는다.
2. 🔴 **rename 직후, 다른 무엇보다 먼저 — 이 dirty checkout의 `origin`을 끊는다.**
   지금 이 작업 디렉터리의 remote는 `git@github.com:junghan0611/apply.git`이고, 여기에는 **정제 전
   79커밋의 모든 object가 그대로 있다**(`git count-objects -vH` → size-pack 64.00 MiB).
   archive를 rename하는 순간 **그 URL은 새 public `apply`에 붙는다.** 그 상태로 이 클론에서
   `git push --force` 한 번, 또는 새 브랜치 push 한 번이면 **정제 전 원본 blob이 공개면에 올라간다.**
   그래서 rename과 같은 호흡으로 `git remote remove origin`을 하거나 이 디렉터리를
   `apply-dirty/`로 옮긴다. 공개 전환 전에 **작업면 자체를 clean clone으로 교체**하고, §B의 로컬
   mirror 백업에는 push 대상 remote를 두지 않는다.
3. 새 `junghan0611/apply`를 먼저 **PRIVATE**로 만들고 정제 refs를 push한다. `--mirror`로 밀지 않는다 —
   push할 ref를 명시한다.
4. 그 GitHub 원격에서 제3의 clean clone을 받아 D 전체를 다시 실행한다. public 이름에서 옛 SHA가
   조회되지 않는지도 확인한다.
5. README의 경고·가시성, repo description/topics, LICENSE 인식(GitHub 배지는 루트 `LICENSE` 하나만
   읽는다), branch protection, secret scanning/push protection을 확인한다.
6. **GLG 승인 2:** 검증 receipt를 읽은 뒤에만 새 repo를 Public으로 전환한다.
7. private archive와 로컬 backup은 냉각 기간 동안 유지한다. 삭제는 별도 결정이다.

## 중단선

- 이 문서는 **rename/push/public 승인 자체가 아니다.** 원격 변경과 push는 GLG가 해당 시점에
  현재 세션에서 명시해야 한다.
- 원문 값 하나라도 애매하면 공개를 미룬다. “전장에서 박살난 기록을 공개한다”는 결정과
  다른 사람의 개인정보·저작물·현직 비밀을 대신 공개하는 결정은 같은 것이 아니다.
- 🔴 **public 전환은 실질적으로 되돌릴 수 없다.** 공개 순간부터 3자 아카이브·미러·검색 캐시가
  독립적으로 사본을 갖는다. repository를 다시 private으로 돌리는 것은 **재정제가 아니다.**
  그러므로 "일단 공개하고 나중에 더 지운다"는 경로는 없다. D가 닫히기 전에는 E-6을 하지 않는다.
- **보수적 기본값으로 닫은 결정:** `applications/remember.js`는 path 제거, 현직 도해·evidence
  zip은 전부 제거한다. 보상 키워드가 있던 현재 43 path를 값 미출력 형태로 전수 판독한 결과
  GLG의 숫자 연봉값은 0건이고, 남은 것은 「면접 후 협의」·미기재 규칙·회사의 공개 보상 문구였다.
  개인 보상 수치는 verification set에서도 0건이어야 한다.

# NOW — Upstage 면접(08-25) + IGNITE 종료 결정

- **Upstage / AI Engineer - Agents 면접은 오늘(2026-08-25) 예정.** 이미 낸 이력서·자기소개서·포트폴리오와 제품 체험 평가의 사실 경계를 유지한다. 면접 시각·접속 정보는 이 저장소에 회수돼 있지 않으므로 메일·캘린더 원문을 정본으로 확인한다.
- **IGNITE / AI Developer 1차 온라인 면접은 2026-08-24 완료.** 공식 결과는 아직 미수신이지만, GLG가 후속 전형에는 참여하지 않기로 결정했다. 전국 현장 방문과 대면 조율이 중심인 FDE 역할은 하네스·장기 작업면을 깊게 발전시키는 현재 방향과 맞지 않는다. 연락이 오면 이 결정을 정중히 전달한다.
- **OpenAI `Developer Experience Engineer (Seoul)`은 `ready`.** 폼·답·영문 291단어 Additional Information이 모두 준비됐다.
- **Next:** GLG가 **180일 최대 5건 지원 제한**을 확인해 이 칸을 DevEx에 쓸지 결정 → 승인하면 브라우저에서 제출 → `LEDGER.md`·건별 `submission.md`·실제 제출 세트/지문을 함께 닫고 `applications/check.py`.
- **확정값:** Legal Name `Junghan Kim` · 주 3일 로컬 오피스 `Yes` · 스폰서 `No` · 입사 가능일 `Negotiable — within 4 weeks of offer`.
- **Blocker:** GLG의 OpenAI 건별 최종 승인 하나.
- **Read:** `applications/upstage--ai-engineer-agents/{submission.md,answers.md,submit/}` · `applications/openai--developer-experience-engineer-seoul/{submission.md,cover-letter.md,submit/README.md}`.
- **Do not touch:** 제출 완료 건의 실제 `submit/` 스냅샷을 재빌드·덮어쓰지 않는다. 최종 Submit·개인/법적 값·동의는 GLG가 건별로 한다.

# ACTIVE — 다음 제출 큐

- **IGNITE** — 2026-08-24 1차 온라인 면접 완료 뒤 GLG가 후속 전형 불참을 결정했다. 공식 결과와 무관하게 이 건은 종료하며, 연락이 오면 정중히 전달한다. 원본·수행은 PRIVATE repo `<private assignment repo>`의 `<private case path>`.
- **Sonatus** — 다음 재개점. Easy Apply 5단계와 저장 이력서 함정을 `applications/sonatus--staff-devops-engineer/submission.md` §다음 한 걸음에서 확인한다.
- **Telechips** — 필수 포트폴리오·경력요약 1,976자·영어 `중`·증명사진까지 준비됨. 다음에는 폼에서 구조화 경력/학력을 AutoEver 스냅샷·`FAQ.md` §3과 한 줄씩 대조한다.
- **Penguin Solutions** — 새 req 2027 URL로 복구됨; 컷 미정.
- **GE HealthCare** — Workday `R4042393` 열림; Embedded vs Systems Software 컷 결정 필요.
- **XCENA** — 9건 열림. `110622 Device Runtime & SDK`가 후보 1순위지만, GLG가 정확한 직무를 고른 뒤에만 새 케이스를 만든다.
- **NHN LLM/Agent 2번째 건** — 로그인·필수 포트폴리오·프로젝트 단위 자기소개가 남은 별도 묶음.

# RECENT

- [2026-08-20] **Upstage 알고리즘 코딩 테스트 제출 완료.** 다음 스테이지로 이어질 예정.
- [2026-08-25] **Upstage 면접 예정.** 이미 낸 세트와 제품 체험 평가를 정본으로 하며, 일정·접속 정보는 메일·캘린더에서 확인한다.
- [2026-08-24] **IGNITE 1차 온라인 면접 완료.** 공식 결과 미수신이나 GLG가 후속 전형 불참을 결정했다.
- [2026-08-20] **IGNITE 1차 온라인 면접 확정** — 2026-08-24(월) 17:00–18:00, Google Meet. 실무형
  과제는 패스 확정.
- [2026-08-19] **Upstage 서류전형 합격.** 다음 전형은 알고리즘 코딩 테스트. `LEDGER.md`와 건별 기록을 `replied`로 갱신했다.
- [2026-08-19] **IGNITE 실무형 과제 자료 제출 완료.** PRIVATE repo `<private assignment repo>`의 `<private case path>`에서 문서(PDF, 최대 3장) + 결과물(zip) 두 파일을 자료제출 경로로 냈다.
- [2026-08-13] **카카오헬스케어 종료:** 영상 스크리닝 인터뷰 후 불합격. `LEDGER.md`와 건별 기록을 `rejected`로 닫았다.
- [2026-08-12] **IGNITE 다음 전형:** 코딩테스트와 1주일 실무형 과제 안내를 받았고, UUID로 바뀐 첨부 3개의 원래 파일명을 복구했다.
- [2026-08-09] **제출 5건:** MakinaRocks(FDE AI Agent) — 이력서·역량기술서·포트폴리오 3슬롯; Wonderful(FDE); Cohere(FDE Agentic Platform, 완료 화면 `Remote`); Telit(이력서+임베디드 깊이 문서); Bear Robotics(이력서+커버레터·경험요약 textarea).
- [2026-08-09] **자동 채움 구조화 경력은 초안이다.** Bear에서 현직 퇴사 처리·발주기관/교환연구의 고용 오인·NEMO 준비기간 재직 신고·재직 누락을 제출 전 잡았다. 업로드 뒤 경력/학력이 자동 입력되면 GLG 승인 전 AutoEver 스냅샷과 `FAQ.md` §3을 한 줄씩 대조한다.
- [2026-08-09] **첨부와 동의는 한 결정이다.** MakinaRocks는 선택 첨부를 올리자 선택항목 수집 동의가 제출 필수로 승격됐다. 전체 동의 대신 필요한 개별 동의만 쓴다.
- [2026-08-09] 현대오토에버는 시험 미응시 철회, 카카오뱅크 DW는 마감 미제출로 닫았다. 다음 카카오뱅크 공고는 새 케이스·추천 경로로 다시 판단한다.

# VERIFY / READ

- 상태 SSOT: `applications/LEDGER.md`; 건별 사실: `applications/<회사>--<직무>/submission.md`
- 제출 닫힘: `applications/check.py`; 공고 생존: `applications/alive.py`
- 새 후보: `applications/INBOX-WANTED.md`, `applications/INBOX-REMEMBER.md`
- 반복 계약: `applications/AGENTS.md`, `applications/FAQ.md`
