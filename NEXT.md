# RAIL — 현재 좌표

- [x] **1. 공개 게이트·기록 수선과 문서 복원** — `v2026.10.15` / `7544374`, 후속 `93e6187`
- [x] **2. 국문/영문 Org 정본·국문 BSP 뷰 검수와 샘플 보관** — `37dfe8b`·`139fef7` main 푸시 완료
- [x] **3. 현재 Linux 중심 검토판 검증** — GLG가 검증판 commit/push 명시 승인, 재배열 전 기준점으로 기록
- [ ] **4. 텍스트를 중요도·기술적 의미 순으로 재배열** ← CURRENT: 기준판 커밋·푸시 뒤 별도 후속으로 진행
- [ ] **5. 새 문안·private 최종본 검토 후 사람 제출** ← PAUSED: 현재 draft·미제출

현재 좌표: 구조 검수·푸시 완료 → **10/21 GLG 지정으로 BSP Driver에서 원래 Embedded S/W Engineer로 회귀** → 현재 검토판 검증·푸시 → 기술적 의미 중심의 문안 재배열 → GLG 최종 검토·제출 결정. 사내 추천 경로는 더 추진하지 않으며 추천인 허락 대기를 현재 blocker로 남기지 않는다. 두 공고의 요건·폼·과거 ready를 혼동하지 않는다. 베이스 전체 현재화·모든 주장 감사 완료라는 뜻은 아니다.

# NOW

- **대상·상태:** https://careers.telechips.com/job_posting/iSXmKnRT **Embedded S/W Engineer**(10/21 GLG 직접 지정), 기존 폴더 `applications/telechips--embedded-sw-engineer/`를 잇는다. `draft`, 미제출. `Re4LUYvK` BSP 준비 이력은 보존하되 현 타깃은 아니다. 이전 임베디드 공고의 과거 ready도 재검수 없이 되살리지 않는다. 사내 추천 선택을 고정하지 않고 새 지원경로는 GLG가 선택한다. 실명·사적 관계·법적 값은 public 파일에 기록하지 않는다.
- **다음 한 걸음:** GLG가 10/21 **PDF 검증 통과 후 현재 변경의 커밋·푸시**를 명시 요청했다. 검토판 `review-linux-104616/`는 합본3쪽·포트2쪽. Opus 최종 동결 보고: 케이스23/23·언어28/28·9PDF 빌드/verify 통과, 영문7컷은 NEMO와 embedded 요약만 변경, 원본 출력 보존. 코디도 빌드입력9/9 현재 파일 일치·산출지문6/6을 직접 확인했다. 코디가 국문 PDF 전5쪽을 렌더해 직접 시각 검수했고 잘림·겹침은 관측하지 않았다. 현재 검증판만 커밋·푸시해 기준점으로 남기며 문안 재배열은 그 커밋에 섞지 않는다. 업로드용 final/DOB 반영과 지원 제출은 별개다.
- **푸시 뒤 후속:** GLG의 면접 경험을 반영해 현재 이력서·포트·폼 문장과 근거를 대조하고 **중요도 → 기술적 의미 → 본인 판단·소유 범위 → 세부 구현 근거** 순으로 재배열한다. 큰 시스템 문제와 선택 이유가 먼저 읽히고 개별 기술명은 하위 근거가 되게 한다. 사실·한계는 유지하되 불필요하게 미시적인 문구가 전체 대화의 출발점이 되지 않도록 한다. 아직 이 후속 개작은 시작하지 않았다.
- **검토 사본:** 로컬 `~/.local/state/apply-review/20261021/telechips-embedded-sw/`의 `CAREER-SUMMARY-v2.md`(1,009자)·`MOTIVATION-v2.md`는 미확정 읽기용 사본. 새 경력요약은 아직 `answers.md`에 미반영이며 문항1은 NEMO만 정정한 구판1,220자다. 같은 폴더 README에서 출력과 후보를 구분한다. 이전910자/지원동기MD·09시대 PDF는 NEMO 정정 전 사용 중단, 과거 출력은 보존한다. 코디는 지정 공고 원문과 조준·root/원장/alive, 옆 Opus는 Chrome 현행 폼과 케이스 구현을 맡는다. 담당업무·자격·폼을 재측정해 국문 경력요약 MD와 지원동기·계획을 새 대상에 맞추고, 새 날짜 폴더로 검토판을 만든다. **10/18 `telechips-upload/`의 CAREER-SUMMARY·PDF는 이전 BSP 검토안으로 보존하며 그대로 제출하지 않는다.** 국문 합본+국문 포트 2파일 원칙을 유지하되 현재 폼 슬롯을 확인한다. 최종 합본의 private 생년월일·실제 PDF·지문은 별도 검증한다.
- **10/18 사람 선택:** 사진은 GLG가 폼에 올린 원본 그대로 유지하며 교체를 재권고하지 않는다. PDF 연구실 표기는 **2018–2022 유지**(2017년 창업 종료와 연도 구분). 이 두 결정은 Opus의 13:40 전달을 상속; 구조화 입사일까지 바꾸라는 뜻으로 확대하지 않는다. FAQ §3의 기존 확정 구조화 값과 별개로 폼 날짜가 새로 확정되면 기록한다.
- **읽을 곳·편집 정본:** 공통 사실·국문/영문 경력·연구·자기소개·포트는 `resume/body.org`. 기본 뷰는 `resume/resume.org`·`resume/resume-en.org`·`resume/portfolio-ko.org`·`resume/targets/*.org`. 지원동기·계획·DOB 마커는 케이스 `application-telechips.org`, 폼 답변은 `answers.md`, 제출 요구·판단은 `submission.md`. 로컬 사본을 정본처럼 편집하지 않는다.
- **분담·권한:** Opus `20261015T091218-d7b57d`는 Chrome·resume/케이스, 코디는 root/NEXT/원장·독립 점검. 10/21 GLG가 옆 Opus를 다시 불렀다고 했고 코디는 인수를 요청했다. 10/18 브라우저 입력은 과거 보고이며 새 폼에 자동 복사하거나 현재 보존을 보장하지 않는다. 개인값은 읽어 복제하지 않는다. 이번 요청은 직무 재조준·준비이며 **Submit·동의·추천인 기재 승인 아님**. 10/21 GLG가 검증 통과 후 **현재판 commit/push만 승인**했으며 tag/릴리즈·후속 재배열판 추가 push 승인은 아니다. 새 타깃 최종 패킷 검수 전에는 ready로 올리지 않는다.

# RECENT

- **10/21 검증 기준판:** 합본3쪽·포트2쪽 생성, 케이스23/23·언어28/28·9PDF all/verify 통과는 Opus 최종 동결 보고. 코디는 입력9/9·산출6/6 지문과 국문 전5쪽 시각 검수 완료. 국문 단독 CV는 2→3쪽으로 늘었고 후속 판면 검토 대상이다. GLG가 이 판 검증 후 commit/push를 요청했으며, 이후 별도 작업은 세부 기술명 나열보다 시스템 문제·설계 판단·기술적 의미가 먼저 읽히는 재배열이다. 제출 상태는 draft 그대로다.
- **10/21 GLG 사실 정정·관점 변경:** NEMO-UX는 실패한 창업과 Linux OS·앱 프로토타이핑 경험이며 양산 아님. Linux 활용·NixOS/Yocto/Buildroot 재현 환경·플랫폼/애플리케이션/AI 응용을 중심으로 본다. FAQ의 재사용 서사와 body·국문/영문·뷰·케이스에 회수했다(코디 직접 diff와 Opus 동결 보고 대조). 이번 명시 사실 정정으로 영어 컷 NEMO 부분도 바뀌어야 하므로 이전 텍스트 불변 검사를 그대로 요구하지 않는다.
- **10/21 타깃 변경:** GLG가 원래 Embedded S/W Engineer `iSXmKnRT`를 다시 지정했다. `Re4LUYvK` BSP에 제출한 것은 없으며 해당 준비는 역사로 남긴다. 사내 추천 경로 추진 중단, Exa livecrawl 요청(task 2887, exit 0)으로 원문 재확인: 업무 Kernel BSP/Linux·Android Framework/Platform·Application, 필수 C/C++ 중급·Embedded System 경험, 경력3–15년. 오푸스 10/21 Chrome 보고도 수신: `in_progress/open_ended`, 필수15·경력요약10,000자·합본/포트 각50MB·자소서는 합본 안에 포함, 입력0. 일반 HTTP429는 재시도하지 않았다. 제3자의 채용 의사·평가를 추정해 공개 기록에 쓰지 않는다.
- **10/21:** GLG 요청으로 원격 `1961da5`를 fast-forward하고 기존 로컬 수정4개를 재적용했다. `LEDGER.md`는 충돌 없이 자동 통합. 원격의 XCENA 불합격(10/20)·쿤텍 NS 검토기간 만료 종료(10/16)와 로컬 Telechips 준비 기록을 함께 보존했다. patch·stash 복구본 보존, 새 commit/push 없음. `applications/check.py --deep --public` 94건/깊이24 통과.
- **10/18:** GLG가 추천인 기재 허락을 기다리므로 제출 대신 자료 준비로 목표를 명확히 했다. 오푸스의 당일 Chrome 실측(13:21): 공고 열림, 기존 필수15·경력요약10,000자·경력별 담당업무·국문 합본/포트 각50MB 요구 동일, 추가 작문 문항 없음. 이력서 파일에 자기소개 포함, 연봉 제외. 원본 사진은 로컬 Git 제외했고 개인 보관면에 250×300 정제 사본도 만들었으나 GLG는 웹에 올린 원본 유지 선택.
- **10/18 검증:** Opus의 새 `/tmp/telechips-review-131755` 빌드 성공·10/16판과 PDF 추출 텍스트/답변4개 동일 보고를 상속. 코디는 로컬 패킷으로 복사한 PDF2/답변4의 `SHA256SUMS` 모두 OK를 직접 확인. 사진250×300·24,614B·시각검수 직접 확인. 코디 단독 `pdfinfo`는 PATH 부재로 실행 안 됐으며 쪽수는 Opus 보고를 상속. 제출 완료 영수증은 없다.
- **10/16:** `37dfe8b` 국문/영문 Org 시스템과 `139fef7` dossier 샘플 보관을 분리해 푸시. 독립 동결 사본에서 언어28·케이스23·9PDF 빌드/verify, 영문7컷 텍스트 동일, 기존274개 산출물/원본PDF50개 불변 확인. 상세 영수증은 아래 로컬 기록 참조. 구조는 GLG 동의, 글 검수와 실제 제출은 별개다.

# LEDGER — 유지할 경계와 별도 잔여

- 지원 상태 전체는 `applications/LEDGER.md`, 정확한 한 건은 케이스 `submission.md`. 실제 업로드 파일은 private 보관, public에는 이름·source·지문만. 원본 build/submit·과거 제출 지문을 덮지 않는다. raw 폼·법적 값은 private Org의 한 벌, 타건 폼으로 사본을 만들지 않는다.
- 회사 납품은 Zigbee 허브 펌웨어, 제품 서버·앱은 외부 업체, 후속 Go/Flutter는 개인 검증 프로토타입. Matter SDK 인도와 인증 취득을 혼동하지 않는다. 신규 SoC 포팅·양산 드라이버 유지보수 전체 수행으로 연구/공개 SDK 작업을 확대하지 않는다. RISC-V·ARM64 부팅 캡처는 RTOS·앱·무선 전체 검증 증거가 아니다.
- 연구 실적 원본 `20250317T150522`은 논문·저자 순서·수상 목록을 읽은 근거이며 논문 전문/개별 코드 기여 감사는 미완. KSC 연도 차이는 국문에서 연도 생략, 국무총리상 대회 정식 명칭은 미확인. 연구실 PDF 연도는 위 10/18 선택을 따른다.
- `resume/run.sh verify`의 쪽수 빈값·정본 이메일 대조·0건 grep 진단, source/PDF provenance와 `stage.py` 낡음 판정은 별도 수선. 케이스 빌더 검사와 전체 파이프라인 완전 수선을 혼동하지 않는다. 과거 「직무 선택 기준이 history에 없었다」 진단은 `e6cb617:applications/AGENTS.md`로 철회됐으며 절 이름 변경 뒤 참조 단절이 실제 결함이다.
- dossier는 `docs/samples/dossier/`의 독립 과거 샘플이며 현재 정본이 아니다. root `dossier/` ignored 산출물은 로컬 보존용. 홈페이지 개편·다른 후보 일괄 stage·AI/AX/FDE 재개는 이번 준비의 전제조건이 아니다. 후보는 `INBOX.md`·원장부터 본다. XCENA BSP는 10/20 불합격, 쿤텍 NS AI 개발자는 10/16 검토기간 만료로 종료됐다(10/21 수신 `1961da5`의 원장·각 submission 기록). 쿤텍의 별도 임베디드 건과 혼동하지 않는다.

## 영수증·읽을 곳

- `.claude/skills/apply/SKILL.md` · root/레인 `AGENTS.md` · 해당 케이스 `submission.md`
- 로컬 `~/.local/state/apply-review/20261018/telechips-upload/README.md` · **`CAREER-SUMMARY.md`(840자 새 검토안, 미확정)** · `FORM-ANSWERS.md`(기존판4블록) · `review-only/SHA256SUMS`. 새 경력요약은 GLG 검토 후에만 `answers.md`로 회수·재생성한다.
- 로컬 `~/.local/state/apply-review/20261016/`: `org-base-v2-independent-verification.md`, `dossier-archive-verification.md`, `telechips-org-base-v2/REVIEW.md`. 10/18 이전 NEXT는 `20261018/NEXT-before-referral-preparation.md`에 보존.
- 다음 변경 검사는 새 사본에서 케이스 `./test_build.sh`·`./build.sh review <새 폴더>`, 기록은 `applications/check.py --deep --public`. 과거 history 검사 통과를 현재 미커밋 변경 검사로 대체하지 않는다.
