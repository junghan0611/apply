# 제출 기록 — AIRS Medical (에어스메디컬) / AX Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **그리팅** (자체 도메인 `airsmed.career.greetinghr.com`) — 가입 불필요 |
| 첨부 컷 | **DevEx** (`resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf`, 3쪽) |
| 공고 URL | https://airsmed.career.greetinghr.com/ko/o/216673 |
| **지원 URL** | **https://airsmed.career.greetinghr.com/ko/o/216673** → 페이지 하단 「지원하기」 |
| 근무지 | **서울 강남구 테헤란로 223** · 정규직 · **경력 3년 이상** |
| 팀 | **AX (AI Transformation) 팀** — 회사 전체가 쓰는 **AI Native Workspace** 를 만든다 |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4416896075/`)와 같은 자리다.** offsite 라 그리팅 원본으로 낸다.

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf`)
- [ ] 커버레터 — 그리팅 `docsInfo` · `questionnairesInfo` 가 **비어 있다.** 기본 지원서만 받는
      구성으로 보인다. **폼을 열어 한 번 더 확인하고**, 칸이 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** 쏘카 · (보류 중) OpenAI 건과 **같은 DevEx 컷**이다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `백엔드 3년 이상` 은 통과하나 **백엔드 직함 3년은 아니다**(§경계) | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

> 전형: 서류 → 1차 면접 → 2차 면접 → **평판조회** → 처우협의 → 최종. 코딩테스트 없음.
> 「전형 중 커피챗을 요청할 수 있다」고 명시돼 있다.

## 왜 이 직무였는가

**이번 배치에서 우대 항목이 가장 정확히 사람을 지목한 건이다.** 우대 첫 줄을 그대로 옮기면:

> `Claude Code · Codex · Gemini · OpenCode 등 CLI 기반 AI 도구를 자체 skill/hook/agent/MCP
> server로 customize, … 하네스 + personal AI agent(openclaw · hermes · ironclaw 등) 사용·구축`

**DevEx 컷 이력서에 그 목록이 이미 적혀 있다** — Claude Code · Codex · pi · Antigravity ·
**OpenClaw**. 공고가 이름으로 부른 것을 매일 굴린다. 실제 코퍼스 위에서 **40+ 스킬**을 운영하고,
**스킬 SSOT 하나를 여섯 하네스로 팬아웃**한 것이 이 항목의 증거다.

- **`MCP Server 구현·활용 + Tool Use · RAG · Function Calling · Agentic Workflow + Vector DB`** —
  MCP · ACP · A2A · **하이브리드 RAG(벡터 + FTS)** · LanceDB · pgvector. **쓴 쪽이 아니라 만든 쪽**이다.
- **`사내 도구를 직접 만들어 동료에게 임팩트를 준 경험`** — 개발자 12명 조직에서 에이전트 축을
  혼자 세웠고, 셀프호스팅 Forgejo 작업 원장으로 이슈·리뷰·핸드백을 굴린다.
- **`사내 AI 사용 정책·스킬 가이드 작성, 월간 교육 세션 운영`**(주요 업무 5번) — **운영 헌장**을
  써 온 습관이 그대로 붙는다. 3,000편 규모 공개 가든이 전파가 부산물이 아니라는 증거다.
- **`Central Data Layer(OLAP + Vector DB + Graph DB)`**(주요 업무 1번) — 하나의 ID 축으로
  노트·세션·서지·시간축을 묶었다. **정형·비정형을 한 축으로 잇는 문제**를 개인 규모에서 이미 풀었다.

**「만들고 + 전파하는」 이중 직무**라는 점에서 NHN 건에서 조준한 구조와 같다(`../dossier/AGENTS.md`).
**컷을 DevEx 로 고른 이유**가 여기 있다 — 이 자리가 요구하는 것은 모델 주변 시스템보다
**「다른 사람과 에이전트가 일하는 표면」**이고, 그게 DevEx 컷의 첫 문장이다.

**경계는 먼저 밝힌다.** **Kubernetes 운영 경험이 없다**(필수 2). **Snowflake · Databricks · dbt ·
Airflow 등 Lakehouse ETL/ELT 실적이 없다**(우대). **OLAP DB 실무가 얇다**(필수 3). **Salesforce ·
SAP 통합 경험이 없다.** **의료·헬스케어 도메인 경험이 없다.** **백엔드 직함 3년이 아니라**
풀스택·임베디드·에이전트를 오간 이력이다.

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **그리팅 보드(`greeting:airsmed`, 10건)에서 원본 공고를 찾아** 경로를 바꿨다.
- [2026-07-28] 컷 **DevEx** 확정. 상태 `ready` — **제출 대기**.
