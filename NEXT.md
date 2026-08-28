# RAIL — 현재 좌표

- [x] **1. 공개 안전 계약·history 정제·새 object database 검증**
- [x] **2. 기존 지원 기록 회수와 리멤버 14건 원장 반영**
- [ ] **3. 열린 지원의 사람 결정·후속 제출** ← CURRENT: OpenAI DevEx 쿼터와 Dorco 재지원 여부를 GLG가 결정
- [ ] **4. 새 후보를 원본 ATS 확인 뒤 케이스 승격**

현재 좌표: 2 완료 → 3 사람 결정 대기 → 4 후속

# NOW

- **Current:** 공개 `apply`는 정제된 전체 history와 public gate를 갖는다. 리멤버 쉽게 지원 14건은 `applications/LEDGER.md`와 각 case record에 회수됐다.
- **Next:**
  1. GLG가 OpenAI `Developer Experience Engineer (Seoul)`의 180일 최대 5건 제한을 재확인해 이 슬롯을 쓸지 결정한다.
  2. 승인하면 GLG가 브라우저에서 최종 Submit → `LEDGER.md`·건별 `submission.md`·private 제출 보관면을 함께 닫는다.
  3. Dorco의 자체 채용홈페이지 재지원 요청을 이행할지 GLG가 결정한다. 리멤버 경로만으로는 전형 대상이 아니라는 회사 안내가 기록돼 있다.
- **Blocker:** 최종 Submit·개인/법적 값·동의와 위 두 판단은 GLG 소관.
- **Verify:** 기록 변경 뒤 `applications/check.py --deep`; 공개 경계 변경 뒤 `./scripts/check-public.sh --repo .`.
- **Read:** `applications/LEDGER.md`; `applications/openai--developer-experience-engineer-seoul/submission.md`; `applications/dorco--robot-control-development-engineer/submission.md`.
- **Do not touch:** raw 폼·법적 값·실제 제출 바이너리는 public repo에 넣지 않는다. 제출 완료 건의 `submit/` 스냅샷을 재빌드·덮어쓰지 않는다.

# RECENT

- [2026-08-27] 79커밋의 결정 history를 정제한 새 GitHub object database를 검증해 `apply`를 public으로 전환했다. 경계와 방법은 `PUBLICATION.md`, `docs/HISTORY-REDACTION.md`.
- [2026-08-28] Gmail의 리멤버 지원 완료·후속 알림을 대조해 14건을 원장에 회수했다. Specter는 AI면접 미응시로 `closed`; Dorco는 자체 홈페이지 재지원 요청이 미이행 상태다.
- [2026-08-28] `README.md`에 Junghan Kim (김정한, GLG)의 디지털 가든·홈페이지·GitHub·LinkedIn 입구를 추가했다.
