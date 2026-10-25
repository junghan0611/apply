# RAIL — 현재 좌표

- [ ] **1. 전형 결과 대기** ← CURRENT: 새 통보·GLG 보고가 오면 해당 case와 원장부터 갱신
- [ ] **2. 서류 합격 시 면접 준비** — 실제 제출 문구·키워드·본인 수행 범위를 정리, 아직 미착수

이번에 닫힌 문서 구조·Telechips 제출·추가 지원 회수·범용판 교체는 `CHANGELOG.md`의 **v2026.10.25**로 이관했다. 다음은 결과 대기이며 새 지원이나 전면 개작을 자동 시작하지 않는다.

# NOW

- **현재 상태:** Telechips10/22 제출과, 추가11곳의 범용판 수정 제출 완료를 GLG 보고로 닫았다. 정확한 회사·직무·최초 지원일·결과는 `applications/LEDGER.md`, 현재 파일과 교체 이력은 해당 `submission.md`가 소유한다. 긴트·XCENA BSP는10/20 불합격이다. 결과가 왔다고 과거 제출 파일을 새로 만들지 않는다.
- **다음 한 걸음:** 새 전형 소식이 오면 원장을 먼저 대조하고 해당 case만 갱신한다. 서류 합격 때는 해당 JD와 **실제 제출한 모든 문구**에서 키워드 → 중요도·기술적 의미 → 문제 → 본인 판단·수행 범위 → 기간·근거 → 한계 → 예상 질문·설명 순서로 준비한다. 면접관이 링크를 읽었다고 가정하지 않는다. 지금 면접 분석·대응표를 만들지는 않는다.
- **회수할 입력:** 추가11건은 회사·직무·접수 사실과 파일 계보를 회수했지만 공고 원문·URL·건별 폼은 미회수다. 서류 합격 시 최소 입력은 해당 공고의 공개 URL 또는 담당업무·필수요건 텍스트와 실제 제출 폼이다. 텔레칩스 전체 입력 원문은 GLG 보고 기준 private Denote **`20250514T162018`**의10/22 해당 지원서 원문 절에 있다. 다른 회사의 폼까지 거기에 있다는 뜻으로 확대하지 않는다.
- **파일 선택:** 휴대폰 제출용 범용판은 `~/sync/org/pdf/`의 **`KimJunghan_Embedded-Linux_Application-261025.pdf`(3쪽)**·**`KimJunghan_Embedded-Linux_Portfolio-261025.pdf`(2쪽)**다. 새 지원에서도 회사 전용 층을 그대로 재사용하지 않는다. 경력 정본은 `resume/body.org`, 중립 뷰는 `resume/resume.org`·`resume/portfolio-ko.org`다.
- **스냅샷 경계:** 새11개 case의 `submit/MANIFEST.sha256`는 최초261022 파일을 보존한다. 현재 교체본은 **`submit/MANIFEST-2026-10-25-corrected.sha256`**로 별도 지목한다. 완료는 GLG 보고, 파일 identity는 로컬 실측이다. 원격 첨부 바이트·폼·사진까지 직접 검사했다고 확대하지 않는다. Telechips 자체의 기존 제출 지문도 그대로다.
- **제외 유지:** 에이텍모빌리티 Firmware는 GLG 미제출 정정·삭제 요청, 데이터스트림즈는 재제출 시 마감·삭제 요청으로 이번 원장에서 제외했다. 과거 메일 알림만으로 두 케이스를 되살리지 않는다. 원프레딕트 재지원은 `--2`이며9/10 불합격인 기존 건을 보존한다.
- **권한:** GLG가10/25 현재 기록판의 tag-release를 명시 요청했다. 이 배치 밖의 새 변경 커밋·푸시·태그는 별도 요청이 필요하다. Opus는 퇴근했으며 새 형제·브라우저·동의·취소·재지원·Submit을 자동 재개하지 않는다.

# RECENT

- 닫힌 이력·검증 범위·공개 이유는 `CHANGELOG.md` **v2026.10.25**, 지원 상태는 원장·개별 case가 소유한다. 같은 완료 로그를 이 문서에 다시 쌓지 않는다.

# LEDGER — 남은 경계와 별도 수선

- 실제 학점·학적·법적 값의 정본은 `applications/FAQ.md` §0의 private Denote `20250514T162018`이다. 원본 내 차이는 학위·단위·시점·재직 대상을 대조하고 GLG 확인을 받는다. 원문 폼·메일·개인화 ATS 링크·실제 제출 바이너리는 공개 Git과 Release 첨부에 넣지 않는다.
- NEMO-UX는 스타트업 프로토타입, 현직 게이트웨이는 펌웨어 양산이다. 외부 업체의 제품 서버·앱과 개인 Go/Flutter 검증 프로토타입을 구분한다. SDK 통합을 Android Framework 자체 개발로, 공개 SDK 빌드를 신규 SoC 포팅·양산 드라이버 전체 유지보수로 확대하지 않는다. 상세 사실은 body와 판 이력을 읽는다.
- 별도 수선(새 제출의 전제조건 아님): 일반 `resume/run.sh verify`의 쪽수 빈값·정본 이메일 대조·0건 grep 진단, 일반 staging의 provenance·낡음 판정. 이번2PDF 독립 검수는 이 도구 전체를 고친 것이 아니다. 국문 이력서 자기소개가2–3쪽에 걸치는 현재 기본 뷰 판면도 별도 개선 여지다. dossier는 `docs/samples/dossier/`의 독립 과거 샘플이다.

## 읽을 곳·영수증

- `applications/LEDGER.md` · 해당 `submission.md`·`submit/MANIFEST*.sha256` · `applications/FAQ.md` §0 · `CHANGELOG.md` v2026.10.25
- 로컬 **`~/.local/state/apply-review/20261025/linux-systems-generic-8IUW5O/README.md`**: 범용2PDF·source 사본·지문·검수·전5쪽 이미지. `phone-original-261022/`는 초기 폰 파일 private 사본이다. 구 파일을 동기화 폴더에서 찾지 못해도 이 보관본으로 대조한다.
- 새 합본 지문 `2ead9937…`, 새 포트 `e964a551…`. 이전 Telechips 보관면은 `~/.local/state/apply-review/20261022/telechips/submit/`다. 같은 날짜의 다른 PDF를 같은 바이트로 추정하지 않는다.
- 검사: `applications/check.py --deep --public` · `git diff --check`. 교체 지문도 private 실물과 별도로 대조한다. 재빌드가 필요하면 새 사본/새 폴더를 쓰고, 제출 완료 스냅샷은 덮어쓰지 않는다.
