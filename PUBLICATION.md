# PUBLICATION.md — 전체 이력을 정제해 공개하는 계약

> 2026-08-27 GLG 결정: 이 저장소는 탈락까지 포함한 **증거 우선·사람 최종 결정 채용 문서
> 파이프라인 사례**로 공개한다. 회사·직무·지원 답변·결과의 시간축은 숨기지 않는다.
> 개인정보, 제3자의 권리, 현직 비밀은 별도 경계로 제거한다.

## 결론

한 커밋짜리 allowlist export는 만들지 않는다. `git-filter-repo`로 79개 커밋의 전체 흐름을
정제해 보존한다.

그러나 **현재 private GitHub repository의 object database를 그대로 public으로 바꾸지 않는다.**
force-push는 ref를 바꿀 뿐, GitHub의 unreachable object와 cached view가 즉시 사라졌다는 증명이
아니다. 현재 원격은 협업 부속물이 사실상 없다(branch 1, collaborator 1, tag/PR/issue/release/
workflow artifact/deployment/fork 0). 따라서 다음이 더 안전하고 잃는 것도 없다.

```text
현재 GitHub apply
  → 다른 이름의 private archive로 보존
  → disposable clone에서 전체 history 정제
  → 새 GitHub object database의 private apply에 push
  → GitHub에서 clean clone해 재검증
  → 마지막 승인 뒤 public
```

공개 `apply`는 새 repository id를 갖지만, 내용은 정제된 **전체 commit topology와 시간축**이다.
private archive는 public repo의 branch가 아니며 절대 공개하지 않는다.

## 공개 데이터 계약

| 분류 | 예 | 처리 |
|---|---|---|
| 공개 서사 | 회사·직무·지원일·답변·합격/불합격·판단 오류와 수정 | 유지 |
| 공개 직업 증거 | 본인 이름, 회사·학교, 공개 프로젝트, GitHub·가든 링크 | 유지 |
| 본인 직접 개인정보 | 이메일·전화·생년월일·성별·상세/생활 주소·GPA·병역·장애/보훈·동의값 | 제거; 항목별 명시 opt-in만 예외 |
| 본인 문맥형 개인정보 | 국적/취업자격·운전면허·육아/생계 공백·거주 도시·언어 자기평가·근무 조건 | 정규식으로 판정하지 않고 항목별 opt-in |
| Git 신원 metadata | author/committer/tagger의 개인 이메일 | noreply로 rewrite |
| 제3자 개인정보 | 추천인·동료·지도교수·담당자 이름/소속/연락처 | 제거 또는 역할 수준으로 일반화 |
| 개인화된 ATS 표면 | candidate id, 회신 UUID 이메일, 일정/상태 URL | 제거 |
| 보상 정보 | 본인의 현재/희망 연봉, 처우 협상값 | 제거. JD가 제시한 보상 범위는 유지 가능 — 줄 단위 분류 뒤에 닫힌다 |
| 제출 binary | PDF·ODT·ZIP의 본문과 metadata | history에서 제거; 필요하면 안전본만 재생성 |
| 받은 과제 원본 | 회사가 준 과제 데이터·입력 파일 | 인용이 아니라 복제다. exact path로 모든 역사에서 제거 |
| 원시 제3자 자료 | 전체 JD 복제, API 문서 복제 | URL·필요 인용·요약만 남기고 원시 복제 제거 |
| 로그인 뒤 자동화 코드 | 비공개 API 지도, 인증 헤더 취득 기법 | history에서 제거하고 코드 없는 방법·경계만 서술 |
| 현직/고객 비밀 | 비공개 고객 식별자, 내부 endpoint·토폴로지·데이터, **내부 아키텍처 도해 이미지** | 도해·evidence archive는 history에서 제거; 권리 확인본만 rewrite 뒤 추가 |
| 로컬 환경 | 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 절대경로, 내부 호스트명 | 제거 또는 일반화 |
| secret | 자격증명·토큰·private key | 제거 후 유효성 확인/필요 시 폐기·회전 |

**실명이 공개됐다는 것과 연락처까지 공개한다는 것은 다르다.** 기본 공개 연락면은 GitHub와
가든이다. 개인 이메일을 남기려면 GLG가 그 항목만 별도로 승인한다.

**회사 공고가 웹에 공개됐다는 것과 원문 재배포 권리가 생긴 것은 다르다.** 이 저장소의 사례
가치는 공고 전문 보관이 아니라 `요구 → 주장 → 증거 → 결과 → 계약 수정`의 사슬에 있다.
제3자의 추천서도 기존 제출 승인이 공개 배포 승인과 같지 않다. 새 동의가 없으면 원문을 빼고
그 추천서가 짚은 주장과 증거 대조 구조만 남긴다.

### 2026-08-27 GLG opt-in 결정 — 문맥형 항목은 현재 수준으로 닫는다

위 표의 **본인 문맥형 개인정보** 행은 「항목별 opt-in」으로 열려 있었다. 검수에서 남은 항목을
범주별로 세어 올린 뒤 GLG 가 2026-08-27 에 **현재 수준 유지**로 닫았다. 대상은 거주 도시,
경력 공백의 사유 서사, 국적·취업 자격, 장애·보훈의 「해당 없음」 선택값, 그리고 대학원
연구실과 방문 연구 기간의 조합이 만드는 재식별 가능성이다.

근거: 이 항목들은 본인을 검색하면 공개면에서 이미 확인되는 정보이고, 「해당 없음」은 상태
자체를 밝히는 쪽이 아니라 그 칸이 비어 있지 않다는 사실만 남긴다. 남기는 편의 값 — 공백을
숨기지 않았다는 것, 통근 가능 범위, 스폰서가 필요 없다는 결론 — 이 사례의 읽을 값에 직접
기여한다.

**이 opt-in 은 표의 다른 행을 되살리지 않는다.** 전화번호, 생년월일, 상세 주소, 개인 이메일,
병역 상세, GPA, 동의값, 제3자 개인정보, 제출 binary 는 제거된 채로 남는다. opt-in 은 열려
있던 한 행을 닫은 것이지 계약을 넓힌 것이 아니다.

같은 날 함께 닫힌 두 가지:

- **JD 인용은 현재 수준 유지.** 원문 전체 복제(`*/JD.md` blob)는 이미 tombstone 으로 교체됐고,
  남은 것은 요구사항을 근거로 판단을 대조한 기록이다. 출처 표시와 제3자 무-라이선스 경계는
  그대로 유지한다(`NOTICE.md`).
- **현직 관련 서술도 현재 수준 유지.** 도해 이미지, 생성 binary, evidence archive, 고객 식별자,
  내부 endpoint 는 history 에서 이미 제거됐다. 남은 클러스터·납품·내부 도구 서술은 이 저장소가
  공개하려는 것 — 문서 파이프라인과 시스템 역량 — 의 핵심 증거라서 공개한다. 파이프라인 자체가
  보여 주려는 실력이고, 이 방식의 구현은 간단하지 않다.
- **생성 문서 binary 는 공개 history·tree 양쪽에서 0** 인 현재 정책을 승인한다.

이 결정으로 문맥형 항목에 대한 추가 rewrite 는 하지 않는다. 되돌리려면 replacement 입력을
갱신하고 정제본을 처음부터 다시 만들어야 한다 — 부분 재작성은 79/79 보존 대조를 깨뜨린다.

## 최초 실측에서 확인된 핵심 누출면

- `applications/hyundai-autoever--ai-agent-engineer/submit/KimJunghan_AutoEver_Detail_Form.md`
  — 생년월일·전화·상세주소·병역·GPA·지도교수.
- `applications/nhn--ax-transformation-ai-infra/submit/KimJunghan_AX_Applicant_Form.md`
  — 정확한 병역 기간·지도교수·공동수상자 실명.
- `applications/nhn--ax-transformation-ai-infra/referral.md`
  — 추천인 실명·소속·관계와 제3자 추천서 원문.
- `applications/kakao-healthcare--ai-agent-engineer/submission.md`
  — 담당자 회신 이메일과 전화.
- `applications/FAQ.md`, 추천 요청 프로필, 여러 submission/JD
  — 본인 이메일·거주지, 담당자 이메일, candidate-specific URL.
- `applications/ignite--ai-developer/assignment/{defect_log.csv,equipment_log.csv}`와
  과제 브리프 PDF `.../assignment/AI FDE_사전과제_260701.pdf`
  — 회사가 준 과제 원본. 인용이 아니라 복제라 라이선스로 해결되지 않는다.
- `applications/remember.js` — 로그인 뒤 서비스의 비공개 API 지도와 인증 헤더 취득 기법.
  개인정보 스캐너로는 잡히지 않는 별도 축이며 history에서 path 제거한다.
- `dossier/images/*`·`dossier/images/master/*`·옛 `nhn/images/*`와
  `nhn/build/KimJunghan_AX_Evidence_Package.zip` — 현직 아키텍처·제품 스택 도해. 텍스트 스캔이
  판정하지 못하므로 공개 초기판에서 모두 제거한다.
- 보상 정보 — 전체 blob 스캔에서 43 path. 옛 게이트 `scripts/check-public.sh:83`이 이미 막던 항목이다.
- bare UUID 33 path, 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 절대경로 6 path.
- commit metadata — 개인 Gmail 주소가 **22커밋의 author/committer ident**에 있다(44 = 22×2필드).
  메시지 본문 쪽 이메일 4건은 전부 `Co-authored-by:`의 noreply이므로 `--mailmap` 대상이 아니다.
- binary history — PDF blob 50개, ODT 5개, ZIP 1개. 현재 tracked PDF 37개 다수에서 이메일이
  추출됐다. text replacement는 이 내부를 고치지 못한다.

**verified negative도 목록의 일부다.** 얼굴 사진은 history 전체에서 `applications/**/*.{png,jpg,jpeg}`
blob **0건**이고(`.gitignore:50-61`이 2026-08-09부터 차단), RRN·계좌·여권·클라우드 토큰·private key도
0건이다. 무엇을 지웠는지만 적고 무엇이 애초에 없었는지 적지 않으면 공개 독자가 검토할 수 없다.

이 목록은 시작점이지 denylist의 완성본이 아니다. 현재 tree와 모든 과거 blob을 다시 분류한다.

## 공개 이후 저장소가 지켜야 할 구조

현재 계약은 “private이므로 전부 담는다”이다. 이 계약을 그대로 둔 채 visibility만 바꾸면 다음
지원에서 다시 샌다. 공개 전에 다음을 먼저 바꾼다.

1. raw 폼·법적 값·실제 개인 연락처·민감 제출 원본은 private Org만 소유한다.
2. public `applications/`에는 redacted case record, 공개 가능한 답변, 출처 URL, 결과와 배운 계약만
   둔다.
3. generated PDF/ODT/ZIP은 기본적으로 Git에 넣지 않는다. 공개 안전본이 꼭 필요할 때만 source에서
   재생성하고 본문·metadata·렌더를 검사한다.
4. `README.md`와 루트/레인 `AGENTS.md`에서 PRIVATE 전제를 걷고 public-safe 작성 계약을 둔다.
5. `applications/check.py`는 **모드를 가른다.** `check.py:100-131`의 `digest_faults()`는
   `submit/MANIFEST.sha256`을 실제 파일 바이트와 대조하고, `check.py:133-155`의 `aim_leaks()`는
   `gs`로 PDF 본문을 읽는다 — 둘 다 **private archive 쪽 불변식**이다. public 모드에서는 파일
   부재가 정상이며, 대신 「private artifact가 repo에 없다」를 검사한다.
6. 전역 git 훅을 **재배선**한다. `agent-config/git-hooks/_scan.sh:61-62`의 `junghan0611/apply`
   loose 예외를 빼면 새 public repo와 rename된 archive가 **둘 다 strict**가 되고, strict의
   identity-term 게이트는 **본인 실명 유지**라는 이 저장소의 공개 계약과 충돌한다. 그래서
   (a) archive의 새 이름을 loose에 추가, (b) public repo용 예외 또는 새 public 게이트,
   (c) **훅 재배선 → archive rename → 새 repo 생성** 순서를 같은 변경에서 정한다.
7. repo-wide gate와 CI가 staged diff뿐 아니라 reachable history, commit metadata와 binary를
   보수적으로 검사한다.
8. 🔴 **public 전환은 되돌릴 수 없다.** 공개 순간부터 3자 아카이브·미러·검색 캐시가 독립 사본을
   갖는다. 다시 private으로 돌리는 것은 재정제가 아니다. “일단 공개하고 나중에 더 지운다”는
   경로는 존재하지 않으므로, 검증이 닫히기 전에 가시성을 바꾸지 않는다.

## Rewrite 입력물

세 입력물은 서로 섞지 않으며 **repo에 commit하지 않는다.**

1. `remove-paths` — 모든 역사에서 제거할 exact/glob path.
2. `replace-text` / `replace-message` / `mailmap` — filter-repo 입력.
3. `verify-values` — 제거됐는지 검사할 원문 값과 패턴.

`git-filter-repo --replace-text`의 `literal:`/`regex:`/`==>` 문법은 `grep -f` 문법이 아니다.
하나의 `PRIVATE_TERMS.txt`를 rewrite와 검증에 함께 쓰면 조용한 미검사를 만들 수 있다.
원문 inventory는 public artifact에 값이나 hash를 싣지 않는다. 특히 전화·생년 같은 낮은 entropy
값은 hash도 공개 증명이 아니다.

## 실행 절차

### 1. 정책과 미래 게이트

- 공개 허용/제거 표를 GLG가 확정한다.
- JD·과제·추천서·현직 상세의 별도 권리 검토를 닫는다.
- **LICENSE는 결정됐다(2026-08-27).** 루트 `LICENSE`=MIT(코드), `LICENSES/CC-BY-4.0.txt`(방법·서사
  문서), 개인 이력·지원 답변은 `LicenseRef-Personal-Record`로 권리 유보,
  `LICENSES/CC-BY-SA-3.0.txt`와 `NOTICE.md`(제3자 자료), 경로 매핑은 `LICENSING.md`.
  공개 여부가 아직 안 정해진 파일(예: `applications/remember.js`)에는 라이선스를 선언하지 않는다.
- `README.md`, `AGENTS.md`, 검사기, 전역 훅을 public 운영 계약으로 고친다.

### 2. 원본 보존

- 편집 전에 원격 포함 모든 ref를 mirror/bundle로 private local 위치에 보존한다.
- 디렉터리 권한은 0700, bundle checksum과 원래 HEAD는 private handoff에만 기록한다.
- PII 원문은 `denotecli`/Emacs 계약으로 `~/sync/org/private/`에 이관한다.
- 이 mirror와 Org 원문은 공개 repo의 branch, release, artifact, gist 어디에도 올리지 않는다.

### 3. History rewrite

fresh disposable clone에서 `git-filter-repo --sensitive-data-removal`을 쓴다. 도구는 **PATH에 상시
설치돼 있지 않다** — `nix-shell -p git-filter-repo` 안에서 부르고, 쓴 도구와 버전을 receipt에 남긴다
(`pdftotext`·`exiftool`도 같다). 문서와 스크립트에 Nix shell 경로를 그대로 적는다.

- `--prune-empty never --prune-degenerate never`를 명시하고 rewrite 전후 commit/root/topology 수를
  대조한다. 개인정보를 지우면서 그 파일만 만진 commit을 없애면 공개 목적 자체가 훼손된다.
- **경로째 삭제와 내용만 치환(tombstone)을 구분해서 고른다.**
  - 바이너리(PDF·ODT·ZIP·받은 과제 데이터)는 경로째 삭제한다. 자리만 남겨봐야 깨진 파일이다.
  - **그 파일의 존재 자체가 결정 계보인 텍스트**(예: history의 `*/JD.md` 33개)는 경로를 지우지 말고
    `--file-info-callback`/blob 단위 치환으로 **본문만 tombstone**으로 바꾼다. 서로 다른 원본
    revision에는 비가역 ordinal marker를 넣어 원문이나 hash 없이 **파일 존재와 revision 사건**을
    남긴다. 원문 줄 단위 diff 모양까지 보존한다는 주장은 하지 않는다. 경로째 지우면 commit은
    남아도 그 사건이 빈다.
  - tombstone 본문은 범주·방법·비가역 revision ordinal만 적고 `docs/HISTORY-REDACTION.md`를
    가리킨다. 원문 값도 hash도 적지 않는다.
  - dense PII 파일과 추천서 원문은 tombstone이 아니라 **경로째 삭제**다. 남은 자리에서 재식별이
    가능한 종류다.
- 산발적 text는 검수된 exact/regex로 치환한다.
- commit/tag message는 `--replace-message`, ident는 `--mailmap`으로 고친다.
  ⚠ **`--mailmap`은 커밋 메시지 안의 이메일을 고치지 않는다.** 대상은 ident가 개인 주소인 22커밋이고,
  메시지 쪽 4건은 전부 `Co-authored-by:`의 noreply라 대상이 아니다 — 확인하고 지나간다.
- 첫 변경 commit 이후 SHA 변경은 불가피하다. filter-repo `commit-map`은 private receipt로만
  보존하고, 옛 private SHA를 public repo에 연결하는 표는 싣지 않는다.
- 제거 path와 같은 이름의 public-safe 재작성본, 그리고 라이선스 파일(`LICENSE`, `LICENSES/`,
  `LICENSING.md`, `NOTICE.md`)은 rewrite **뒤** 새 commit으로 추가한다. rewrite 전에 넣으면 79커밋
  전체에 소급 존재하는 것처럼 보이고, 제거 path와 겹치면 함께 지워진다.

rename은 자동 추적되지 않으므로 역사에 존재했던 옛 경로(`nhn/` 등)도 모두 목록에 넣는다.
원본 checkout과 private archive에서 filter-repo를 실행하지 않는다.

🔴 **경로 목록은 `git rev-list --objects --all`이 아니라
`git log --all --name-only --pretty=format:`에서 뽑는다.** 같은 내용의 blob이 여러 path에 있으면
rev-list는 그 blob을 **한 path 이름으로만** 출력하기 때문에, 나머지 이름은 목록에서 조용히 빠진다.
이 저장소 실측으로 그렇게 사라지는 경로가 **43개**이고, 하필 전부 제거 대상이다 —
`submit/KimJunghan_Resume_*.pdf` 11개, `submit/MANIFEST.sha256` 10개, 받은 과제 PDF,
그리고 옛 `nhn/` 경로 18개(현직 도해의 `master/*.jpg` 사본과 `nhn/pipeline/templates/ieee.csl` 포함).
목록이 빠지면 그 경로는 정제본에 자기 이름으로 살아남는다.

🔴 **공백·비ASCII가 든 경로가 실제로 있다** —
`applications/ignite--ai-developer/assignment/AI FDE_사전과제_260701.pdf`.
`awk '{print $2}'`·`cut -d' '`처럼 공백으로 자르는 파이프는 이 경로를 잘라먹는다. 목록 생성과
검증 스크립트는 공백 안전해야 하고, 이 경로를 셸 glob으로 다루지 않는다.

### 4. 정제본 검증

검증은 working tree나 `git log -p` 한 번으로 끝내지 않는다.

```text
all refs
  → all reachable commit/tag metadata
  → git rev-list --objects --all 의 모든 path/blob
  → 남긴 archive/document의 추출 본문과 metadata
  → 이미지 육안 렌더
  → clean build/test
```

**보존 검사를 누출 검사와 같은 무게로 먼저 닫는다.** 지금까지의 검증은 "무엇이 남았나"만 봤다.
이 문서의 결론이 "전체 흐름을 보존한다"이므로 **"무엇이 사라지지 않았나"도 검사한다.**

```text
git rev-list --all --count                  → 79
git rev-list --all --merges --count         → 0
git rev-list --all --max-parents=0 --count  → 1
git log --all --format='%ad' --date=format:'%z' | sort -u   → 하나(+0900)
```

원본 mirror와 정제본을 reverse-topo 같은 순서로 **79행 대조**한다 — author name, author timestamp,
committer timestamp, subject, parent 수. mismatch 0이어야 하고, 달라진 메시지 행은
`--replace-message` 목록으로만 설명돼야 한다. 설명되지 않는 차이가 한 줄이라도 있으면 다시 만든다.

누출 쪽 필수 검사:

- 원문 verification set 0건;
- 제거 path와 옛 이름 0건;
- **author/committer/tagger ident 전수가 noreply 도메인**(“44건 → 0건”이 아니라 전수 확인이다);
- candidate-specific URL·**bare UUID** 0건;
- 홈 디렉터리 리터럴(`$HOME` 를 편 형태) 절대경로 0건;
- 보상 키워드 43 path 전수 판독에서 확인된 개인 숫자 연봉값 0건이 정제본에서도 유지되는가;
- `gitleaks`와 `trufflehog` 통과 또는 근거가 기록된 false positive만 존재
  (`dossier/pipeline/templates/ieee.csl`의 upstream 기여자 이메일은 **지우지 말고** 근거와 함께
  allowlist한다 — 지우면 저작자 표시가 깨져 CC-BY-SA 위반이 된다);
- 스캐너 미설치/오류는 실패;
- linkedin-jobs 회귀, `applications/check.py`(public 모드), resume/dossier source build;
- 깨진 private path 링크와 공개 URL 검사;
- `docs/HISTORY-REDACTION.md`의 범주·방법·건수가 실제 rewrite 입력과 일치하는지 대조.

초기 공개판에서 generated PDF/ODT/ZIP을 0개로 두면 binary privacy claim이 가장 단순해진다.
이미지를 남기면 metadata를 벗기고 전 파일을 육안 검토한다.

### 5. 새 원격과 마지막 승인

1. GLG 승인 후 현재 GitHub repo를 private archive 이름으로 rename한다.
2. 🔴 **rename과 같은 호흡으로, 정제 전 object를 쥔 작업 클론의 remote를 끊는다.**
   그 클론의 `origin`은 rename 순간 **새 public `apply`에 붙는다.** 정제 전 79커밋의 모든 object가
   거기 그대로 있으므로, `git push --force` 한 번이나 새 브랜치 push 한 번이면 원본 blob이
   공개면에 올라간다. `git remote remove origin`을 하거나 디렉터리를 dirty 이름으로 옮기고,
   **공개 전환 전에 작업면 자체를 clean clone으로 교체**한다. 로컬 mirror 백업에도 push 대상
   remote를 두지 않는다.
3. 새 `junghan0611/apply`를 **PRIVATE**로 생성해 정제본을 push한다. `--mirror`로 밀지 않고 ref를
   명시한다.
4. GitHub 원격에서 clean clone하고 §4를 다시 실행한다.
5. 공개 이름에서 옛 SHA가 조회되지 않는지 확인한다.
6. README·description·topics·LICENSE 인식(GitHub 배지는 루트 `LICENSE` 하나만 읽는다)·
   branch protection·secret scanning/push protection을 확인한다.
7. 검증 receipt를 GLG가 읽고 별도 승인한 뒤에만 Public으로 전환한다.

private archive 삭제는 공개와 같은 결정이 아니다. 냉각 기간 뒤 별도로 정한다.

## 공개 게이트 구현 주의

`scripts/check-public.sh`는 과거 allowlist export용이라 `.git`, `applications/`, `dossier/`,
`NEXT.md`가 있으면 실패한다. 그 모드는 그대로 두고, **공개 저장소 자체를 검사하는 모드를 따로
붙였다**(2026-08-27 구현).

```bash
./scripts/check-public.sh /path/to/public-export   # (구) allowlist export 트리
./scripts/check-public.sh --repo [<repo>]          # (현) 공개 저장소 자체 → check-public-repo.sh
```

`--repo`가 보는 것: history 전체 path 목록(제거 범주별), commit ident 전수 noreply,
모든 reachable blob의 이메일·전화·절대경로·UUID·자격증명, `gitleaks`, `trufflehog --results=verified`,
그리고 공개 계약 문서 4종의 존재. `applications/check.py --public`은 반대 방향 —
**있으면 안 되는 것이 다시 들어왔는가**를 본다.

경로 목록은 `git log --all --name-only --pretty=format:`에서 뽑는다. `rev-list --objects`를 쓰면
같은 내용의 blob이 한 경로 이름으로만 나와 나머지가 조용히 빠진다(§3 참조).
게이트는 자기 자신(`check-public.sh`, `check-public-repo.sh`)을 스캔 대상에서 뺀다 —
스캐너의 정규식 문자열이 스캐너에 걸려 자기 꼬리를 문다.

게이트는 탐지 결과 원문을 CI 공개 로그에 그대로 출력하지 않는다. path·category·line 정도만
보이고 실제 값은 로컬 private report에서 확인한다. “0건”만 남기는 것보다 사용한 도구·버전·ref
범위·binary 처리 방식을 함께 기록해야 공개 독자가 정제 주장을 검토할 수 있다.

## Public case-study frame

공개 이야기는 “에이전트가 자동으로 구직했다”가 아니다.

- 한 인간이 목표, 사실 경계, 최종 Submit을 소유했다.
- 탐색·문서·브라우저·메타 검수를 다른 레인으로 갈랐다.
- 숨은 공유 기억이 아니라 파일과 검증 명령으로 상태를 넘겼다.
- 하나의 사실 corpus에서 직무별 view를 만들었다.
- 실제 탈락과 급한 제출이 stale closure, 기본 파일 오염, ATS 편차, 위치 오판, 개인정보 캐싱의
  구멍을 드러냈다.
- 교차검수가 그 구멍을 계약과 테스트로 바꿨다.
- 마지막에는 작업면 자체도 숨기지 않고, 무엇을 왜 지웠는지 **범주와 방법**을 공개했다.

투명성은 원문 개인정보를 내놓는 일이 아니다. 실패와 판단의 계보를 검증 가능하게 남기면서,
공개할 권리가 없는 값은 정확히 경계 밖으로 옮기는 일이다.
