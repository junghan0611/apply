# RAIL — 현재 좌표

- [x] **1. 공개 안전 계약·history 정제·새 object database 검증**
- [x] **2. 기존 지원 기록 회수와 리멤버 14건 원장 반영**
- [ ] **3. 열린 지원의 사람 결정·후속 제출** ← CURRENT: OpenAI DevEx 쿼터와 Dorco 재지원 여부를 GLG가 결정
- [ ] **4. 새 후보를 원본 ATS 확인 뒤 케이스 승격**
- [ ] **5. 플랫폼 원클릭 경로를 「낼 때 남긴다」로 되돌리기** — 사후 회수가 두 번째다(리멤버 14 → 원티드·그리팅 5). 잃는 것은 공고 원문과 **복원 불가능한 첨부 컷**이다

현재 좌표: 2 완료 → 3 사람 결정 대기(첨부 컷 5칸 포함) → 4·5 후속

# NOW

- **Current:** 2026-09-04 Gmail 대조로 **불합격 3건**(Elice·Nota·BHSN)과 **09-01 신규 지원 5건**(원티드 4 · 그리팅 1)을 원장에 회수했다. `check.py` 52건 통과. 신규 5건은 **첨부 컷이 미확인**인 채로 열려 있다.
- **Next:**
  1. ⭐ **GLG가 09-01 5건의 첨부 컷을 한 줄로 말한다** — 「원티드 프로필 그대로」인지, PDF였다면 여섯 컷 중 무엇인지. 사후 복원이 불가능한 유일한 값이라 이것부터다. 답이 오면 `LEDGER.md` 첨부 컷 칸과 각 건 `submit/*-NOTE.md`를 함께 닫는다.
  2. GLG가 OpenAI `Developer Experience Engineer (Seoul)`의 180일 최대 5건 제한을 재확인해 이 슬롯을 쓸지 결정한다. 승인하면 브라우저에서 최종 Submit → `LEDGER.md`·건별 `submission.md`·private 제출 보관면을 함께 닫는다.
  3. Dorco의 자체 채용홈페이지 재지원 요청을 이행할지 GLG가 결정한다. 리멤버 경로만으로는 전형 대상이 아니라는 회사 안내가 기록돼 있다.
  4. **09-01 5건의 공고가 아직 열려 있는지 확인해 원문을 `JD.md`에 붙인다.** 마감됐으면 없는 채로 둔다.
- **Blocker:** 최종 Submit·개인/법적 값·동의·첨부 컷 확인과 위 판단들은 GLG 소관.
- **Verify:** 기록 변경 뒤 `applications/check.py --deep`; 공개 경계 변경 뒤 `./scripts/check-public.sh --repo .`.
- **Read:** `applications/LEDGER.md`; `applications/openai--developer-experience-engineer-seoul/submission.md`; `applications/dorco--robot-control-development-engineer/submission.md`.
- **Do not touch:** raw 폼·법적 값·실제 제출 바이너리는 public repo에 넣지 않는다. 제출 완료 건의 `submit/` 스냅샷을 재빌드·덮어쓰지 않는다.

# RECENT

- [2026-08-27] 79커밋의 결정 history를 정제한 새 GitHub object database를 검증해 `apply`를 public으로 전환했다. 경계와 방법은 `PUBLICATION.md`, `docs/HISTORY-REDACTION.md`.
- [2026-08-28] Gmail의 리멤버 지원 완료·후속 알림을 대조해 14건을 원장에 회수했다. Specter는 AI면접 미응시로 `closed`; Dorco는 자체 홈페이지 재지원 요청이 미이행 상태다.
- [2026-08-28] `README.md`에 Junghan Kim (김정한, GLG)의 디지털 가든·홈페이지·GitHub·LinkedIn 입구를 추가했다.
- [2026-09-04] Gmail 대조로 불합격 3건을 닫았다 — **Elice**(08-28 서류합격 → 09-03 폰 스크리닝 → 09-04 불합격, **리멤버 경로에서 처음으로 사람 대화까지 간 건**), **Nota**(09-03), **BHSN**(09-02).
- [2026-09-04] 09-01 신규 지원 5건을 사후 회수했다 — 원티드 4건(수퍼빈·다우기술·쿤텍·씨어스) + 그리팅 1건(원프레딕트). 공고 원문·URL·첨부 컷은 잃었고, 첨부 컷만 GLG가 채울 수 있어 열어 뒀다. 같은 형태의 사후 회수가 리멤버 14건에 이어 두 번째라 `LEDGER.md` §계보에 행으로 올렸다.
- [2026-09-04] `AGENTS.md`가 담당자 문서를 제목이 아니라 denote id(`20260331T172313`, 곁노트 `20230725T102900`)로 기억한다.
