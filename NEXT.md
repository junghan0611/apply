# RAIL — 현재 좌표

- [x] **1. 후보·폼·첨부 실측과 제출 패킷 준비**
- [x] **2. 2026-08-09 즉시 제출 묶음 5건 발사** — MakinaRocks · Wonderful · Cohere · Telit · Bear Robotics
- [ ] **3. 남은 ready 건을 한 건씩 실제 제출** ← CURRENT: OpenAI DevEx의 180일 5건 제한을 GLG가 재확인
- [ ] **4. 새 후보를 원본 ATS 확인 뒤 케이스 승격**

현재 좌표: 2 완료 → 3 승인 대기 → 4 후속

# NEXT — 이 저장소 자체를 공개로 전환 (2026-08-27 GLG 결정)

> **GLG**: *"회사 이력·상세 업무 내용은 다 공개된 거라 상관없어. 개인정보만 제거하면 된다.
> 깃 히스토리 정리하는 도구로 정리한 다음 이 리포를 공개해버리는 전략."*

`PUBLICATION.md`의 기존 결론(별도 allowlist 신규 history)과 다른 전략이다 — **이 저장소를
그대로 두고, git history 자체를 도구로 정제한 뒤 private→public 전환**한다. 회사명·직무
상세·제출 답변·불합격 이력은 전부 공개 대상. **제거 대상은 개인 식별정보뿐.**

## 도구

`git-filter-repo` (2.47.0, GitHub 공식 권장 — BFG보다 텍스트 치환이 정밀하다).
`nix-shell -p git-filter-repo`로 즉시 설치 확인됨(설치 불필요, 실행 시점에 셸로 진입).

## 제거 대상 (2026-08-27 검수로 확정된 것 — 실행 전 전체 재스캔으로 갱신)

| 항목 | 예시 위치 | 처리 방식 |
|---|---|---|
| 상세주소·생년월일·휴대폰·병역 상세·GPA·지도교수 실명 | `hyundai-autoever--ai-agent-engineer/submit/KimJunghan_AutoEver_Detail_Form.md` | **파일째 이 저장소에서 뺀다** — org 가든 `~/sync/org/private/`로 이관(denote `..._private.org`, 기존 `20250408T...개인정보-백업코드..._private.org`류와 같은 자리) |
| 제3자(추천인) 실명·소속 | `nhn--ax-transformation-ai-infra/referral.md` | **익명화**(이니셜/역할만, 2026-08-27 GLG 확정) — 파일은 남기고 이름만 치환 |
| 회사 담당자 개인 연락처(전화·업무 이메일) | `kakao-healthcare.../submission.md`, `hyundai-autoever.../submission.md` | 문자열 치환(`[REDACTED]`) |
| 그 외 산발적 개인정보(전화·주소 패턴) | 전체 재스캔으로 확정 | 위 둘 중 밀도에 따라 이관 또는 치환 |

**유지:** 본인 실명(`김정한`/`Junghan Kim`), 재직 회사명(`주식회사 고퀄` 등), 프로젝트 상세,
학교명, 회사명·직무명·JD 원문·제출 답변·합격/불합격 이력 전부.

**판단 기준(2026-08-27 GLG):** "private 해야 할 것은 org 가든 private 폴더로 간다" — 즉
**개인 식별정보 밀도가 높은 문서 전체는 텍스트 치환으로 누더기를 만들지 않고, 파일 자체를
이 저장소 밖(`~/sync/org/private/`)으로 옮긴다.** git history에서는 그 경로를
`--invert-paths`로 통째로 제거한다(치환이 아니라 삭제). 문서 안에 정당하게 섞인 공개 정보
(프로젝트 서술 등)가 필요하면 **개인정보를 뺀 재작성본을 이 저장소에 새로 만든다** —
원본을 억지로 편집해 흔적을 남기지 않는다.

## 실행 순서

1. **전체 재스캔** — 작업 트리뿐 아니라 **git history 전체**(`git log --all -p`)에서 위
   패턴(전화번호 정규식·주소·생년월일·평점·실명)을 뽑아 이관 대상 파일 목록과
   `PRIVATE_TERMS.txt`(잔여 산발 항목 치환 규칙)로 나눠 정리한다. 작업 트리 스캔만으로는
   부족하다 — 과거 커밋에서 지웠다가 다시 쓴 문구가 blob에 남아있을 수 있다.
2. **이관** — PII 밀도가 높은 파일을 `~/sync/org/private/`로 옮기고(denote `_private.org`
   명명), 이 저장소에 필요하면 개인정보를 뺀 재작성본을 새로 만든다.
3. **미러 백업** — `git clone --mirror` 로 현재 상태를 로컬에 보존(되돌릴 수 없는 작업 전 안전망).
4. **git-filter-repo 실행** — 이관한 파일 경로는 `--invert-paths`로 history에서 통째로 삭제,
   잔여 산발 문자열은 `--replace-text PRIVATE_TERMS.txt`로 치환(미러 클론 위에서 실행).
5. **검증** — 정제된 미러에서 `git log --all -p | grep -f PRIVATE_TERMS.txt` 및 이관 대상
   경로 문자열 검색으로 **0건**을 확인한다. 하나라도 남으면 6단계로 넘어가지 않는다.
6. **강제 반영** — 검증 통과 후 origin에 force-push. **이 시점부터 옛 커밋 SHA는 전부
   무효**이니 로컬 클론이 더 있다면 전부 재클론해야 한다(이 세션 기준 클론은 하나).
7. **GitHub 가시성 전환** — Settings → Change visibility → Public. **6단계 검증 없이
   먼저 전환하지 않는다.**

## 경계

- **되돌릴 수 없는 작업이다.** 강제 push·가시성 전환 각각 실행 전에 GLG의 명시 승인을
  다시 받는다 — 이 계획을 세운 것이 실행 승인은 아니다.
- **PDF는 `.gitignore`로 대부분 안 걸리지만 일부 tracked PDF가 있다**(§AGENTS.md
  「이미 tracked 인 PDF」 목록). PDF 내부 텍스트/메타데이터도 같은 스캔 대상이다.
- 실행은 별도 세션에서, 위 순서를 하나씩 확인하며 진행한다.

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
