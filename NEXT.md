# RAIL — 현재 좌표

> **베이스 전체 현재화 완료가 아니다.** 오늘은 제출을 서두르지 않고 Org 정본 구조를 잡은 뒤 GLG가 글을 직접 읽고 다듬는다(2026-10-16 GLG).

- [x] **1. 공개 게이트·기록 수선과 dossier 복원** — `v2026.10.15` / `7544374`, 후속 `93e6187` main 푸시 완료
- [x] **2. Telechips BSP 대상으로 전환·폼 실측·국문 초안** — `Re4LUYvK`, 국문 업로드 2파일
- [x] **3. 한 body.org의 국문/영문 정본·뷰 연결 검수** — 코디 독립 검사 완료, GLG가 문서를 보고 틀에 동의
- [ ] **4. 시스템 커밋 → dossier 샘플 보관 별도 커밋** ← CURRENT: GLG가 두 로컬 커밋 요청. 글 검수는 계속 필요
- [ ] **5. GLG 문장 교정·private 반영·제출 결정** ← PAUSED: 당장 제출하지 않음. 글 검수와 제출 승인 별도

현재 좌표: 국문 Org 구조·독립 검사·GLG 틀 확인 완료 → 시스템/글 편집을 나눠 두 커밋 → GLG 문장 편집 → 추후 제출 결정. XCENA는 10/13 면접 후 결과 대기라는 10/15 GLG 보고가 마지막 확인이다.

# NOW

- **고칠 문서:** **`resume/body.org` 하나**. 공통 ID·기간·역할, 국문 `#+begin_ko` / 영문 `#+begin_en`, 연구·공통 자기소개·시스템 포트폴리오 설명과 `* 판 이력 :noexport:`를 쥔다. GLG가 일상적으로 생각을 보태고 이력을 남길 입구다. 반대 언어로 무음 대체하지 않는다.
- **뷰:** `resume/resume.org`(국문 기본 → `KimJunghan_CV_KO`), `resume/resume-en.org`(영문 기본 → 기존 `KimJunghan_Resume` 유지), `resume/portfolio-ko.org`(국문 포트), `resume/targets/*.org`(기존 영문6컷). 선택·배열·짧은 요약·조판을 쥔다. 케이스 `application-telechips.org`는 지원동기·계획·생년월일 빌드 마커만 쥔다. 국문은 현재 시스템/BSP 선택 모듈부터 번역했으며 모든 영문 모듈의 국문화 완료는 아니다.
- **주의:** 같은 파일이어도 두 언어 문장·경력/포트 표현의 동등성은 자동 보장이 아니다. `body.org` 판 이력의 대조 목록을 함께 고친다. `noexport`는 PDF 제외이며 공개 Git의 비밀 보관 기능이 아니다. 외부 MATERIAL·기존 dossier는 입력/독립 문서이지 자동 동기화 경로가 아니다.
- **분담·동결:** Opus `20261015T091218-d7b57d`가 `resume/**`와 Telechips 케이스 구현을 소유하고 09:56 v2 완료 후 편집 동결했다. 코디는 root 계약·스킬·NEXT·LEDGER·alive 타깃·독립 검증 소유. GLG가 원문을 편집하기 시작했으므로 추가 자동 개작 전 충돌 확인한다.
- **다음 한 걸음:** GLG 요청대로 현재 시스템을 먼저 커밋하고, 이어 tracked `dossier/`를 `docs/samples/dossier/`로 보관하며 README·경로 계약을 맞춰 별도 커밋한다. 독립 과거 문서 샘플이지 resume에서 파생된 파일로 설명하지 않는다. 로컬 ignored build/submit 보존, 푸시하지 않는다. 그 뒤 GLG가 `body.org`를 읽고 문장·강조 순서를 고친다. 수정 요청이 오면 정본에 반영하고 새 /tmp 사본으로 두 국문 PDF에 어떻게 나오는지 확인한다. 지금의 틀은 GLG가 좋다고 확인했고 당장 제출하지 않는다. 구조는 한 파일+공통 메타+언어 블록으로 결정됐으며 Markdown을 장기 정본으로 두지 않는다. PDF 2파일·Org 본문을 user Emacs에 열었다.
- **최신 검토판(로컬, clone에 없음):** `~/.local/state/apply-review/20261016/telechips-org-base-v2/REVIEW.md`. `review/`에 국문 합본3p·포트2p·폼 답변4개, `resume-views/`에 지원처 중립 국문2뷰. 합본 생년월일은 「검토본 — 미기입」이며 업로드용 최종본이 아니다. 3쪽째 지원동기만 남는 판면은 글 검토 뒤 결정한다.
- **검증 상태:** 코디도 v2 동결 사본에서 언어28/28·케이스23/23·전체9PDF 빌드/verify·영문7컷 텍스트 동일·국문2PDF 텍스트 검사를 통과했다. 기존274개 산출물 해시와 원본PDF50개 해시/mtime 불변. 첫 실행은 `bash test_build.sh`의 Nix 재진입 경로로127 종료했으나 문서화된 `./test_build.sh`로 같은 사본의 남은 검사를 통과했다. 호출 경로 수정이지 본문/코드 수정이 아니다. 영수증: 로컬 `org-base-v2-independent-verification.md`.
- **권한:** GLG가 오늘 변경의 시스템 커밋과 이어지는 dossier 샘플 보관 커밋을 명시 요청했다. **두 로컬 커밋만 승인, push/tag/릴리즈·stage·업로드·Submit 승인 없음.** 원본 `resume/build`·`dossier/build`·건별 build/submit을 보존하고 새 렌더는 /tmp 사본에서만 한다. 생년월일·정확한 개인값은 지금 구조 검토의 선행조건이 아니다.

## Telechips — 대상·폼·판독

- GLG가 기존 Embedded S/W Engineer `iSXmKnRT`에서 **BSP Driver Engineer `Re4LUYvK`**로 더 집중하려고 변경했다. 초기 코디의 「같은 공고가 바뀌었다」 설명은 철회. 본문·필수요건은 `applications/telechips--embedded-sw-engineer/JD.md`, 폼 실측·판단은 `submission.md`.
- 경력4~15년, 자격4중2(관련학위 / bootloader·kernel driver / kernel debugging / board bring-up). 연구·가상화·BSP·Yocto·실보드 → 양산·검증도구·하드웨어 협업을 전면화한다. 도구/AI 활용자 서사는 국문 기본판에서 덜되 수행 책임·사실을 왜곡하지 않는다.
- 지정 `/apply`에서 필수표시15개, 경력요약10,000자, **이력서 합본(생년월일·학력·경력기술·자기소개, 연봉 제외) + 별도 포트폴리오**, 각50MB 미만을 직접 확인. 국문 민감정보 동의는 필수, 인재풀은 선택. 영문판의 거부 가능 문장·인재풀 보유기간 차이는 별도 관측으로 보존한다. 선택은 GLG.
- 현재 `draft` — 지원 대상이 바뀌어 새 패킷 검수 중. 이전 ready는 역사절로 보존. 법적·인적 원본을 타건 폼에서 복사하지 않는다. 사진·구조화 학력/경력·동의는 최종 단계에 사람이 확인한다.

## 사실·확인사항

- **GLG 확정:** 회사 계약·양산 대상은 Zigbee 허브 펌웨어. 제품 서버·앱은 외부 업체, 후속 Go/Flutter는 개인 검증 프로토타입. 인간 동료·에이전트와 협력하며 아키텍처·개발을 주도한다. 실기기 다중 허브 fan-out은 개인 프로토타입 쪽 사실이다.
- **읽은 근거:** 연구 실적 Org `20250317T150522`의 논문·수상 목록. In-kernel device virtualization 제1저자, MyAV·exitless I/O·중첩 가상화 공동연구. 논문 전문·개별 코드 기여는 오늘 재검증하지 않았다. PM 인덱스2020 최우수는 v1 PDF에도 정확히 있었음 — 코디의 불일치 진단은 재대조로 철회.
- **공개 부트:** Duo S RISC-V 07/14 Linux·Buildroot·RTOS command-queue probe, ARM64 07/23 aarch64 Linux·eMMC 부팅 캡처를 코디도 읽었다. RTOS/앱/무선 전체 완료로 확대하지 않는다. Yocto 레이어는 소스 열람이며 이번에 실빌드하지 않았다. 네트워크 식별자는 복제하지 않는다.
- **유지할 경계:** Matter SDK 통합·인도/인증 대비 하네스는 인증 취득 완료 아님. COS가 전한 x86 NixOS ISO·서비스 통합은 랩 단계이며 현장 확대 계획을 운영 실적으로 쓰지 않는다. 회사명·리포명은 자동 비밀이 아니며 이름/관계/내부기술을 나눠 판단한다.
- **나중에 확인:** 연구실 기간 body 연도와 FAQ 구조화 값 차이(직함 「박사과정연구원」은 FAQ의 GLG 확정표에서 확인), KSC 발표 목록/수상 행의 연도 차이(본문 연도 생략), 국무총리상 대회 정식 명칭. 미확인 값을 채우지 않는다.

## 잔여 수선 — 이번 구조 검수와 혼동하지 않는다

- `resume/run.sh verify`의 쪽수 빈값·정본 이메일 대조·0건 grep 진단, source/PDF provenance와 `applications/stage.py` 낡음 판정은 아직 별도 감사 사항. 케이스 빌더의 엄격 검사와 모든 레인의 완전 수선을 혼동하지 않는다.
- root AGENTS/케이스에 남은 「직무 선택 기준이 history에 없었다」 오진 정정: `e6cb617:applications/AGENTS.md`에는 기준1~4가 실재, 실제 결함은 절 이름 변경 후 참조 단절. July28→Sep18은52일이다.
- 국문 기본판은 맞췄지만 최근 작업 전체의 의미·수행·공개 근거 회수는 끝나지 않았다. 홈페이지·가든 개편을 지원의 전제조건으로 키우지 않는다. 대표 공개 입구는 `https://www.junghanacs.com`.
- 후보/보류 큐는 원장 우선: reach4건 선택, 같은 회사 복수직무(Rebellions/HyperAccel), Wanted 폼 후속은 지금 작업 아님. AI/AX/FDE는 이번 배치에서 재개하지 않는다. 상세 과거 큐는 `applications/INBOX.md`·원장·git 이력 참조.

# RECENT

- **10/16:** Org 언어 선택 이행과 국문 시스템 기본판의 구조·독립 검수 완료, GLG가 틀에 동의했다. 내용 검토는 계속한다. `body.org`는 평소 편집 입구, 회사별 문서는 작은 지원처층·제출 기록. GLG는 지금 제출하지 않고 구조가 잡힌 뒤 글을 직접 다듬기로 했다.
- **10/15:** `v2026.10.15`는 게이트·기록·자기수선 출발점(`7544374`). 후속 dossier 이미지7장 복원·서지/도해/연락처 검사·대표 URL·판 이력·resume noexport7줄을 `93e6187`로 승인받아 푸시. 제출 스냅샷·기존 build 불변. 새 릴리즈는 만들지 않았다.
- **10/15:** XCENA 10/13 면접 진행·결과 대기 확인. 예전 지원 상태는 `applications/LEDGER.md`와 건별 `submission.md`가 소유한다.

## 영수증·읽을 곳

- `.claude/skills/apply/SKILL.md` · root/레인 `AGENTS.md` · `resume/body.org` 맨 위 편집 안내
- `~/.local/state/apply-review/20261016/`: `org-language-stage1-verification.md`, `telechips-org-base-v2/REVIEW.md`, 이전 v1·코디 검토판. 이전 길어진 NEXT는 `NEXT-before-org-v2-handoff.md`로 로컬 보존했다.
- `~/.local/state/apply-review/20261015/`: Opus/Grok/COS 감사·근거 영수증. 로컬 자료는 clone에 없으며 검증 수준을 함께 전달한다.
- 코드 검사는 **새 /tmp 사본**에서 `bash resume/test_language.sh`, `resume/run.sh all`, 케이스 `test_build.sh`·`build.sh review`. 원장/공개 후보는 `applications/check.py --deep --public`. history 게이트는 현재 미커밋 파일 전체 검사와 다르다.
