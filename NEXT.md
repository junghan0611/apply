# NOW — 2026-08-01 Upstage 제출을 닫았다. 다음은 남은 지원 실행

- **Current**: Upstage `AI Engineer - Agents`를 **2026-08-01 제출**했다. 이력서·국문 자기소개서·AX 포트폴리오 3종, 제품 체험 평가 4,243자, 업무 경험·구조화 경력 3건을 실제 폼에 넣었다. `applications/check.py --deep`는 **33건 일치 · 깊이 문서 32개 조준 통과**.
- **Next**: 다음 세션에서 `applications/SUBMIT-QUEUE.md`와 `applications/LEDGER.md`의 `ready` 행을 열고 **한 건만** 골라 제출한다. 우선순위는 Telechips(ninehire — GLG 업로드) → Sonatus(LinkedIn Easy Apply — GLG 로그인·저장 이력서 교체) → Bear Robotics/Telit(폼 채움) → MakinaRocks다.
- **Verify**: 폼을 열기 직전 `applications/alive.py`를 당일 다시 실행 → 실제 업로드 파일명·선택 첨부 동의 확인 → GLG 제출 보고 직후 `LEDGER.md`와 해당 `submission.md`를 함께 `submitted`로 닫고 `applications/check.py`.
- **Blocker**: 없음. 제출 버튼·법적/개인값·ninehire 파일 업로드는 GLG가 직접 한다.
- **Read**: `applications/SUBMIT-QUEUE.md`, 선택한 건의 `submission.md`, `applications/FAQ.md`.
- **Do not touch**: `submitted` 건의 `submit/` 스냅샷을 재빌드·덮어쓰지 않는다. PDF는 Git에 새로 넣지 않고 소스·지문·재현 경로를 보존한다.

# ACTIVE

## 지원 실행

- **Telechips** — Embedded 2쪽. ninehire라 GLG가 직접 업로드한다.
- **Sonatus** — LinkedIn Easy Apply. 저장된 기본 이력서가 다른 컷인지 먼저 확인한다.
- **Bear Robotics / Telit** — 에이전트가 폼을 채울 수 있다. Bear는 영문 커버레터 텍스트 칸, Telit은 Country 기본값(`United States`)을 특히 확인한다.
- **MakinaRocks** — FDE 컷. 폼 미실측.
- **카카오뱅크 DW** — 자기소개서 2문항 × 1,000자 전 단계. GLG 결정 두 가지가 남았다: 서버 개발자-뱅킹도 낼지, AI Engineer 컷으로 갈지/Data Engineer 컷을 새로 만들지. 결정 전에는 새 글을 쓰지 않는다.

## 후속 전형 대기

- **현대오토에버 AI Agent Engineer** — 2026-08-01 상세정보 기재 제출 완료, 상태 `replied`. ACT·코딩테스트의 실제 응시 창 통보를 기다린다. GLG 방침상 전통 시험 대비 학습 계획은 미리 만들지 않는다.

# RECENT

- [2026-08-01] **Upstage 제출 완료.** 제품 사용기는 2024 Solar/gptel 사용 → 2025 커리어 기록 → 2026-05~06 scanbook 파이프라인 → 07-30 Solar provider·Document AI 실측의 시간축으로 4,243자 제출했다. 실제 선택값·첨부·텍스트는 `applications/upstage--ai-engineer-agents/`에 회수했다.
- [2026-08-01] **AX 증거면을 생성 루틴에 연결.** 이력서 6컷과 깊이 문서 3종의 연락처·참조·검증 게이트에 `ax.junghanacs.com`을 넣고 실측했다.
- [2026-08-01] **현대오토에버 상세정보 제출 완료.** 다음 전형 실제 통보 대기.

# LEDGER

- 지원 상태: `applications/LEDGER.md` · 건별 사실: `applications/<회사>--<직무>/submission.md`
- 제출 실행: `applications/SUBMIT-QUEUE.md` · 폼 재사용 답: `applications/FAQ.md`
- 닫힘 검사: `applications/check.py` · 공고 생존: `applications/alive.py`
- 제출 세트: `applications/stage.py` · 이력서: `resume/` · 깊이 문서: `dossier/`
- 지원 계약: `AGENTS.md` · 공고 탐색: `.claude/skills/linkedin-jobs/SKILL.md`
