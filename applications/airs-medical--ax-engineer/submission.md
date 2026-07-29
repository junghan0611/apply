# 제출 기록 — AIRS Medical (에어스메디컬) / AX Engineer

| 항목 | 값 |
|---|---|
| 상태 | **submitted** — 2026-07-30 GLG가 브라우저에서 제출 완료 |
| 지원일 | 2026-07-30 |
| 경로 | **그리팅** (자체 도메인 `airsmed.career.greetinghr.com`) — 가입 불필요 |
| 첨부 컷 | **DevEx** (`resume/build/KimJunghan_Resume_Developer_Experience_Engineer.pdf`, 3쪽) |
| 공고 URL | https://airsmed.career.greetinghr.com/ko/o/216673 |
| **지원 URL** | **https://airsmed.career.greetinghr.com/ko/o/216673** → 페이지 하단 「지원하기」 |
| 근무지 | **서울 강남구 테헤란로 223** · 정규직 · **경력 3년 이상** |
| 팀 | **AX (AI Transformation) 팀** — 회사 전체가 쓰는 **AI Native Workspace** 를 만든다 |

**GLG 가 건넨 LinkedIn 링크(`/jobs/view/4416896075/`)와 같은 자리다.** offsite 라 그리팅 원본으로 낸다.

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Developer_Experience_Engineer.pdf` (실제 업로드 사본)
- [x] **경력기술서 PDF** — `submit/KimJunghan_AX_Competency.pdf` (5쪽, 실제 업로드 사본)
- [x] **포트폴리오 PDF** — `submit/KimJunghan_AX_Portfolio.pdf` (12쪽, 실제 업로드 사본)
- [x] **폼 실측·제출 완료 (2026-07-30, 브라우저).** 서술형/커버레터 칸은 **없다** — 이름·영문이름·
      이메일·연락처·이력서(필수)·경력기술서(선택)·포트폴리오(선택), 개인정보 동의 3종이 폼 전부다.
      연락처와 동의 3종은 **GLG가 브라우저에서 직접 확인·체크했다. 값은 Git에 저장하지 않는다.**
      커버레터는 업로드하지 않고 **1차 면접 「왜 우리인가」의 답 골격**으로 보존한다(코딩테스트 없는 전형이다).
- [x] **경력기술서·포트폴리오 (2026-07-30, GLG 지시)** — `dossier/` 의 Competency·Portfolio를
      NHN 조준(§AI 인프라/백엔드)에서 **AIRS 조준**(AX 팀·AI Native Workspace·Central Data
      Layer·MCP Server)으로 재타깃해 재빌드했다. 프롤로그 1문장(`competency.org`)과 JD 대응
      표(`portfolio.org`)를 교체했고, 나머지 다섯 프로젝트 본문은 재사용했다 — NHN에 이미 낸 적
      있는 재사용 가능한 생성기다(`dossier/AGENTS.md`). Project 1에 **셀프호스팅 Airbyte·n8n
      운영팀 자동화 검수·전략기획실 엑셀→JSONB→JSONL 데이터레이크 설계** 문단을 새로 추가해
      우대 사항(Lakehouse ETL/ELT)에 정직하게 대응했다. `./run.sh verify` 통과
      (Portfolio의 「이메일/GitHub 안 보임」 경고는 `nix develop` 경유 poppler의 알려진
      플레이키니스 — 수동 `pdftotext`로 두 필드 모두 존재 확인).
- [x] **커버레터 경계 문단 수정 (2026-07-30, GLG 지적).** 「Lakehouse ETL/ELT 실적 없음」이
      너무 자기비하적이었다. Snowflake·Databricks 같은 관리형 도구가 없다는 사실은 그대로
      두되, 실제로 있는 것(Airbyte/n8n/JSONB 파이프라인 운영, JSONL 데이터레이크 설계)을
      먼저 말하도록 순서를 바꿨다. `cover-letter.md` §수정 기록.

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
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |

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

## 제출 시점 총평 — 예상 결과와 피드백 기준 (2026-07-30)

**결론**: 이번 건은 **그냥 이력서만 던진 것이 아니라, 제출 직전에 깊이 축을 붙인 상위권 제출**이다.
처음에는 DevEx 이력서 한 장으로도 낼 수 있었지만, GLG 판단대로 경력기술서·포트폴리오 슬롯을
비우지 않고 AIRS JD에 맞춰 재타깃했다. 특히 `AX 팀` · `AI Native Workspace` · `Central Data
Layer` · `MCP Server` 는 GLG의 현재 작업면과 직접 겹친다. 다만 필수/우대 중 **Kubernetes 운영,
OLAP/Lakehouse 실무, 의료 도메인**은 실제 갭이라 통과를 낙관하진 않는다.

### 강점

- **JD가 사람을 이름으로 부른다.** Claude Code · Codex · Gemini · OpenCode · MCP server ·
  personal AI agent · skill/hook/agent customize 는 GLG가 매일 쓰고 만든 표면이다.
- **제출 세트가 얇지 않다.** 이력서 한 장에서 끝내지 않고 Competency 5쪽 + Portfolio 12쪽을
  AIRS 조준으로 붙였다. 그리팅 선택 슬롯을 실제 증거 패키지로 채운 제출이다.
- **NHN용 dossier 생성기가 재사용 가능함을 증명했다.** 프롤로그와 JD 대응표를 바꾸는 정도로
  AX/AI Infra 계열 회사에 빠르게 조준할 수 있었다. 이건 이후 배치의 속도와 품질을 둘 다 올린다.
- **Lakehouse 갭을 더 정직하고 덜 자기비하적으로 처리했다.** 관리형 Snowflake/Databricks/dbt는
  없다고 밝히되, Airbyte/n8n/JSONB 파이프라인과 JSONL 데이터레이크 설계라는 실제 경험을 먼저 댔다.

### 약점 / 리스크

- **Kubernetes 운영 경험이 없다.** 공고 필수 2번 축이라, 스크리너가 쿠버네티스 운영을 강하게 보면 걸릴 수 있다.
- **의료·헬스케어 도메인 경험이 없다.** AIRS는 의료 AI 회사라 도메인 전환 비용을 물을 수 있다.
- **OLAP/Lakehouse 실무가 얇다.** Central Data Layer 언어는 잘 맞지만, Snowflake·Databricks·dbt·Airflow
  실무 포트폴리오는 없다.
- **백엔드 3년 이상 요구와 직함 불일치.** 총 경력은 충분하지만, 커리어 표면은 풀스택·임베디드·에이전트가 섞여 있다.

### 이후 피드백을 받으면 대조할 질문

- 연락이 오면: 회사가 GLG를 **AX 도구 제작자/전파자**로 본 것인지, **데이터 플랫폼 백엔드 엔지니어**로 본 것인지 확인한다.
- 거절이면: 컷오프가 Kubernetes/OLAP/의료 도메인이었는지, 아니면 백엔드 직함/연차 해석이었는지 기록한다.
- 면접에서는: 관리형 Lakehouse 실적 없음은 먼저 인정하고, 대신 **현장 데이터 수집→정규화→JSONB/JSONL→에이전트 도구화**를 실제 사례로 설명한다.
- 이 제출의 학습: AX/AI Infra 계열은 이력서 한 장보다 **짧은 Competency + Portfolio 세트**가 훨씬 낫다. 이후 비슷한 공고는 선택 슬롯을 비우지 않는다.

## 이후 기록

- [2026-07-28] 건 생성. GLG 가 건넨 LinkedIn 링크를 `ljobs.py detail` 로 뜨고,
  **그리팅 보드(`greeting:airsmed`, 10건)에서 원본 공고를 찾아** 경로를 바꿨다.
- [2026-07-28] 컷 **DevEx** 확정. 상태 `ready` — **제출 대기**.
- [2026-07-29] `FAQ.md` §4·§7 확정값을 §폼에 답한 질문 에 반영(희망 연봉·입사 가능일·이직 사유).
  **⚠ 세 줄이 아직 「GLG 확정 필요」로 남아 있었다** — FAQ 는 10:40 에 닫혔는데 건별 표가
  따라오지 않았다. 같은 누락이 **15건에 있었고 한 번에 동기화**했다.
- [2026-07-29] **커버레터 국문 초안 작성** (`cover-letter.md`). 골격은 Holiday 판을 따랐다 —
  §붙여넣을 본문 + §왜 이렇게 썼는가 + §쓰지 않은 것. `stage.py` 가 `submit/cover-letter.txt`
  로 깐다. **다음 판에서 GPT 교열**(2026-07-29 분업).
- [2026-07-30] **제출 완료.** GLG 가 브라우저에서 연락처와 동의 3종을 직접 확인·체크하고 Submit 했다.
  이력서만 올리기에는 약하다는 판단으로 Competency 5쪽과 Portfolio 12쪽을 함께 업로드했다.
  실제 제출 세트는 `submit/KimJunghan_Resume_Developer_Experience_Engineer.pdf`,
  `submit/KimJunghan_AX_Competency.pdf`, `submit/KimJunghan_AX_Portfolio.pdf` 이다.
  커버레터는 폼 슬롯이 없어 제출하지 않고 면접 답변 골격으로 보존한다. 제출 시점 총평을 위 절에 남겼다.
