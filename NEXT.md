# NOW — 2026-08-01 카카오뱅크 DW가 `ready`다. **GLG가 오늘 제출한다**

- **Current**: 카카오뱅크 `데이터 엔지니어 - Data Warehouse`(`260510`)의 관문이 닫혔다. **자기소개서 2문항을 썼고**(952자·879자, `answers.md`) **이력서 컷을 `AI Engineer`로 확정**했다(`Data Engineer` 컷은 만들지 않는다). `stage.py` 완료 · `check.py` 33건 일치 · 공고 HTTP 200. 같은 날 Telechips는 보류했고, **보직 기준이 계약으로 들어갔다**(`AGENTS.md` §어떤 자리에 내는가).
- **Next**: 🔴 **GLG가 카카오뱅크 폼을 연다 — 마감 2026-08-06 23:59, 영입 완료 시 조기 마감.** `submit/`의 4개 파일과 `answers.txt`를 그대로 쓴다. **폼 전체 입력표는 `answers.md` §0**이 쥔다 — 기본정보·병역·학력 3단·직장경력 3건·첨부·동의까지 한 번에 따라간다. ⚠ 남은 주의는 둘: **병역 기본값이 `비대상`이라 반드시 바꾼다**, 동의 2건은 거부 시 지원 불가.
- **Verify**: 폼을 열기 직전 `applications/alive.py`를 당일 다시 실행 → **폼 카운터(`0/1000`)를 눈으로 확인**하고 붙여넣기 → GLG 제출 보고 직후 `LEDGER.md`와 `submission.md`를 함께 `submitted`로 닫고 `applications/check.py`.
- **Blocker**: 없음. 남은 것은 GLG의 폼 입력·제출뿐이다.
- **Read**: `applications/kakao-bank--data-engineer-data-warehouse/{submission.md,answers.md}`, `submit/README.md`, `applications/FAQ.md`.
- **Do not touch**: `submitted` 건의 `submit/` 스냅샷을 재빌드·덮어쓰지 않는다. PDF는 Git에 새로 넣지 않고 소스·지문·재현 경로를 보존한다. **Telechips `submit/` 스냅샷은 그대로 둔다** — 보류지 철회가 아니다.

# ACTIVE

## 지원 실행

- ⏸ **Telechips** — **보류(2026-08-01)**. 임베디드 컷으로 내지 않기로 했다. 공고는 열려 있어 되살릴 수 있다. 되살리면 **포트폴리오가 필수 칸**이라 임베디드 조준 빌드를 먼저 떠야 하고, **경력요약 10,000자**를 써야 한다(`submission.md` §폼 실측).
- 🔴 **카카오뱅크 DW** — **오늘 낸다.** 위 NOW 참조. 남은 것은 GLG의 폼 입력뿐이다.
- ✅ **Telit Cinterion** — **유지.** `Edge AI Software Engineer`는 담당업무에 *LLM 기반 Agent 프레임워크 도입*이 박혀 있어 새 보직 기준에 정면으로 맞는다. ⚠ **컷 재검토**: 지금 `_EMB`인데 JD는 AI 축이다. 낼 때 `_AI` 컷과 대조한다. Country 기본값(`United States`) 확인.
- ⛔ **Sonatus / Bear Robotics** — **제외(2026-08-01).** 회사만 AI고 담당업무는 인프라 운영이다. 근거는 `AGENTS.md` §어떤 자리에 내는가.
- **MakinaRocks** — FDE 컷. 폼 미실측.
- **서버 개발자-뱅킹**(카카오뱅크 `260505`, 마감 08.10) — GLG 결정 미정. JD 서사는 이 회사에서 가장 정면이지만 **필수가 JVM**이라 이력서 언어에 0건이다. 「이름을 남긴다」 목적이면 던질 수 있다.

## 후속 전형 대기

- **현대오토에버 AI Agent Engineer** — 2026-08-01 상세정보 기재 제출 완료, 상태 `replied`. ACT·코딩테스트의 실제 응시 창 통보를 기다린다. GLG 방침상 전통 시험 대비 학습 계획은 미리 만들지 않는다.

# RECENT

- [2026-08-01] **카카오뱅크 DW `ready`.** 자기소개서 2문항을 쓰고(952자·879자) 이력서 컷을 `AI Engineer`로 확정했다. 회사 인용은 공고 원문 2건 + 웹 확인한 시퀀스 FDS 모델만 썼고, 미확인 영입블로그는 인용하지 않았다. 하드 갭(DW 구축·운영 없음)은 문항 2에서 먼저 닫았다.
- [2026-08-01] **보직 기준이 계약으로 들어갔다** — `AGENTS.md` §어떤 자리에 내는가. *「산업은 넓게, 보직은 좁게」*. 판정은 회사 소개가 아니라 **JD 담당업무**에서 한다. 이 기준으로 Bear·Sonatus를 걸렀고 Telit을 살렸다.
- [2026-08-01] **Telechips 보류 · 폼 실측으로 예상이 깨졌다.** 「ninehire는 서술형 칸이 거의 없다」는 Enhans 한 건에서 일반화한 것이었고 텔레칩스에서 깨졌다 — **15개 항목 전부 필수**, 경력요약 10,000자, 구조화 학력·경력, 증명사진, **포트폴리오가 선택이 아니라 필수**. ninehire는 화이트라벨이라 **건마다 폼을 열어봐야 한다**. `FAQ.md`에 영어 상/중/하·증명사진·지원경로 3항목을 추가했다.
- [2026-08-01] **Upstage 제출 완료.** 제품 사용기는 2024 Solar/gptel 사용 → 2025 커리어 기록 → 2026-05~06 scanbook 파이프라인 → 07-30 Solar provider·Document AI 실측의 시간축으로 4,243자 제출했다. 실제 선택값·첨부·텍스트는 `applications/upstage--ai-engineer-agents/`에 회수했다.
- [2026-08-01] **AX 증거면을 생성 루틴에 연결.** 이력서 6컷과 깊이 문서 3종의 연락처·참조·검증 게이트에 `ax.junghanacs.com`을 넣고 실측했다.
- [2026-08-01] **현대오토에버 상세정보 제출 완료.** 다음 전형 실제 통보 대기.

# LEDGER

- 지원 상태: `applications/LEDGER.md` · 건별 사실: `applications/<회사>--<직무>/submission.md`
- 제출 실행: `applications/SUBMIT-QUEUE.md` · 폼 재사용 답: `applications/FAQ.md`
- 닫힘 검사: `applications/check.py` · 공고 생존: `applications/alive.py`
- 제출 세트: `applications/stage.py` · 이력서: `resume/` · 깊이 문서: `dossier/`
- 지원 계약: `AGENTS.md` · 공고 탐색: `.claude/skills/linkedin-jobs/SKILL.md`
