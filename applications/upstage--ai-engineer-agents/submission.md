# 제출 기록 — Upstage (업스테이지) / AI Engineer - Agents

| 항목 | 값 |
|---|---|
| 상태 | **draft** — 첨부·경로는 확정, **필수 서술형 문항이 남아 막혀 있다** (아래 §관문) |
| 지원일 | — |
| 경로 | **그리팅** (자체 도메인 `careers.upstage.ai`) — 가입 불필요 |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 공고 URL | https://careers.upstage.ai/ko/o/194880 |
| **지원 URL** | **https://careers.upstage.ai/ko/o/194880** → 페이지 하단 「지원하기」 (HTTP 200 확인) |
| 근무형태 | **Anywhere On Earth But Together** — 원격 지원(장비 500만원 예산) |
| 조건 | 정규직 · **경력 무관** · 게시 2025-12-16 · 팀 **Agent Engineering** |

## 낸 것

- [ ] **이력서 PDF (필수)** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] 자기소개서 (선택) — 서술형 문항이 그 역할을 겸한다. 따로 만들지 않는다
- [ ] 포트폴리오 (선택) — 올리지 않는다. 이력서의 공개 저장소 링크가 그 역할이다

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** FuriosaAI · Lunit · 42dot 과 **같은 AI Engineer 컷**이다.

## 폼 실측 — 문항 9개 (필수 6 · 선택 3), 2026-07-29

`openingId=194880` · **`status=OPEN` · `deploy=true` · 마감일 없음** — 2025-12-16 게시분이
**7개월 넘게 열려 있다.** 상시 채용으로 본다.

| # | 필수 | 문항 | 상한 |
|---|---|---|---|
| 1 | 🔴 | **업스테이지 제품을 체험한 후 간략한 평가** (형식·분량 제한 없음) | 10,000 |
| 2 | 🔴 | 지원 분야와 관련된 업무 경험 또는 경력 | 1,000 |
| 3 | 🔴 | 선호하는 관심 분야 (다중선택) | — |
| 4 | 🔴 | 선호하는 프로그래밍 언어 (선택형) | — |
| 5 | 🔴 | 언제부터 합류하실 수 있나요 | 1,000 |
| 6 | 🔴 | 어떤 경로로 지원하시게 되었나요 | 1,000 |
| 7–9 | | GitHub URL · LinkedIn URL · 강연/세미나/소개영상 | 각 1,000 |

**서류 슬롯**: 이력서 **필수**(PDF) · 자기소개서 선택 · 포트폴리오 선택(URL 입력 가능).

### ⚠ 선택지 실측 — 기존 기록을 고쳤다

- **문항 4 선호 언어 = `Python` · `C++` · `Java` · `Javascript`.** **`Go` 가 선택지에 없다.**
  이전 기록의 「Go · Python」은 **고를 수 없는 답**이었다. → **`Python`** 을 고른다.
  공고 우대에도 Python 이 있고, `memex-kb` 파이프라인·n8n·pgvector 축이 Python 이라 정직하다.
  (주력이 Go 라는 사실은 문항 2 나 면접에서 말한다. 폼에서 없는 선택지를 만들지 않는다.)
- **문항 3 관심 분야 = `Computer vision` · `Natural language processing` ·
  `Multimodal modeling` · `Data Collection & Processing`.**
  → **`Data Collection & Processing` + `Natural language processing`.**
  전자가 `memex-kb`·RAG 파이프라인의 정면이고, 후자가 에이전트·검색 축이다.
  **Computer vision 은 고르지 않는다** — 축이 아니다.

## §관문 — 이 건의 진짜 작업은 이력서가 아니다

필수 첫 문항이 **「업스테이지 제품을 체험한 후 간략한 평가」**(상한 10,000자)다.
**답을 지어낼 수 없다.** 실제로 돌려 본 뒤에 써야 한다.

### 폼이 체험 경로를 직접 알려 준다 (문항 1 설명문 원문)

> 업스테이지는 **Chat/Reasoning, Document Digitization, Information Extraction** 등의 제품에
> 집중하고 있습니다. Upstage Console의 Upstage Studio와 Playground 또는 Upstage Console에서
> Web 또는 API를 통해 직접 사용해 볼 수 있습니다.

| 입구 | URL |
|---|---|
| Upstage Studio | `https://studio.upstage.ai/` |
| **Playground** (로그인 없이 가능) | `https://console.upstage.ai/playground/chat` |
| Web · API | `https://console.upstage.ai/docs/getting-started` |
| 가이드 | `console.upstage.ai/docs/studio` · `edu.upstage.ai/course/upstage-user-guide-playground` · `.../upstage-user-guide-api` |

**비용**: Playground 는 로그인 없이 열린다. **Console 가입 시 $10 크레딧**이 붙는다.
⚠ **계정 생성은 GLG 가 직접 한다** — 에이전트는 계정을 만들지 않는다(`AGENTS.md` §경계).

### ⭐ 왜 이 평가가 GLG 에게 유리한가 — 조사로 확인한 것 (2026-07-29)

**Document Parse 가 `HWP/HWPX` 를 네이티브로 지원한다** (`document-parse-250404` 업데이트:
*"HWP/HWPX support: Upload and automatic conversion of Korean .hwp/.hwpx files"*).

**`memex-kb` 의 `hwpx2org` 가 정확히 같은 문제를 판 것이다.** 한국 조직의 문서를
기계가 읽게 만드는 일 — HWPX·스캔 PDF·EPUB → Org → 오피스 왕복. 이 회사의 본진과
GLG 가 혼자 판 축이 **같은 지점에서 만난다.**

**그래서 이 평가는 다른 지원자가 쓸 수 없는 글이 된다.** 대부분은 "정확도가 좋았다"를 쓴다.
GLG 는 **직접 구현해 본 사람만 아는 곳**을 짚을 수 있다 — 표 병합셀, 다단 레이아웃,
회전·기울어진 스캔, 각주·미주, 한글 특유의 표-안-표, 수식, 문서 구조가 깨지는 경계.

**제안하는 평가 골격** (GLG 가 실제로 돌린 뒤 채운다):

1. **무엇으로 시험했는가** — 손에 있는 실제 한국어 문서를 쓴다(HWPX 원본, 스캔 PDF, 표가 많은 보고서).
   *만든 예제가 아니라 실물로 시험했다*는 것 자체가 신호다.
2. **어디까지 됐는가** — 되는 것을 먼저, 구체적으로. 수치가 있으면 수치로.
3. **어디서 깨졌는가** — `hwpx2org` 를 만들며 알게 된 **경계에서** 시험한 결과.
   이 항목이 이 글의 값이다.
4. **왜 그 경계가 어려운가** — 한글 문서 포맷 자체의 구조 때문이라는 설명.
   비판이 아니라 **같은 문제를 판 사람의 언어**로 쓴다.
5. **에이전트 축과 어떻게 만나는가** — Document Digitization 은 RAG 의 입구다.
   pgvector 2,945 임베딩 · `andenken` 하이브리드 검색을 운영한 입장에서
   **파싱 품질이 검색 품질을 어디까지 결정하는지**.
6. **Solar 도 한 번은 만진다** — Playground 의 Chat/Reasoning 모드.
   Solar Pro 2 는 31B · 64K 컨텍스트 · 한국어 벤치(Ko-MMLU·Hae-Rae·Ko-IFEval) 강점이 축이다.
   **온디바이스/sLLM 이식 경험**(NPU 포팅, sLLM 음성 제어)이 여기 붙는다.

> **분량 제한이 10,000자지만 채우는 글이 아니다.** 3–5번이 각각 한 문단이면 충분하고,
> **3번(깨진 곳)에 실물 예시 하나**가 들어가면 그 글은 이미 다른 지원자와 다르다.

> **GLG 의 방침 (2026-07-29)**: *"여기 국내 LLM 모델사인데 내가 하는 거 관심 있을 거야.
> 링크드인에는 별로 안 떠서 이야기를 덜한 것 같은데, 여기는 되든 안 되든 내 이야기 던져야 돼."*
> → **적합도 계산이 아니라 지향으로 내는 건이다.** 경계(관측 설계·모델 서빙·VLM)를 감추지 않고
> 쓰되, 문항 1 에서 **이 사람이 무엇을 만드는 사람인지**가 드러나게 한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 공고는 **경력 무관**이라 필터가 아니다 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| **업스테이지 제품 체험 평가** (필수, 10,000자) | ⚠ **미작성 — §관문** | — |
| **지원 분야 관련 업무 경험** (필수, 1,000자) | ⚠ 미작성. 아래 §왜 이 직무였는가 를 1,000자로 줄인다 | — |
| **선호 관심 분야** (필수, 다중선택) | **`Data Collection & Processing` + `Natural language processing`** | 아래 §폼 실측 |
| **선호 프로그래밍 언어** (필수, 선택형) | ⚠ **`Python`** — 선택지에 **Go 가 없다** | 아래 §폼 실측 |
| **합류 가능 시점** (필수, 1,000자) | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| **지원 경로** (필수, 1,000자) | 「채용 홈페이지」 — 보드를 직접 훑어 찾았다 | — |
| LinkedIn URL (선택) | https://linkedin.com/in/junghan-kim-1489a4306 | `FAQ.md` §1 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

> **⚠ 민감 법적 값을 받는다.** `additionalApplicantInfoConfig` 가 **성별 · 생년월일 · 경력 ·
> 병역 · 장애 · 보훈을 전부 `REQUIRED`** 로 둔다. 병역 고지문까지 붙어 있다.
> **GLG 가 브라우저에서 직접 입력한다.**
>
> 전형: 서류 → **알고리즘 코딩 테스트** → 기술 인터뷰 1·2차 → 컬처 → 최종 → 레퍼런스 체크.
> **42dot 과 같이 코딩 테스트가 있는 건**이다.

## 왜 이 직무였는가

**업스테이지 44건 중 이 자리를 골랐다.** `AI Research Engineer - Agents & Workflows` 는
연구직이고, `AI Model Production - Agents & Document AI` · `Platform Software Engineer` ·
`AI Solution Engineer` 는 축이 갈린다. **`AI Engineer - Agents` 가 만드는 자리이면서
에이전트 축 정면**이다.

- **`agent를 인상적인 데모가 아니라 믿고 쓸 수 있는 도구로 만드는 역할`** — GLG 가 3년간
  한 일의 정의에 가깝다. 데모가 아니라 **매일 쓰는 도구**로 굴러가는 것이 증거다.
- **`실행 자동화 및 운영 효율화(MLOps · Workflow Orchestration · Agent Framework)`** —
  하네스를 **직접 만들어** 업스트림 20+ 버전 사이클 동안 운영했다.
- **`기술 내재화·공유 문화에 기여 (오픈소스 · 기술 블로그 · 내부 프레임워크)`** —
  공개 저장소 + 3,000편 규모 디지털 가든 + 외부 저장소에 머지된 PR. **전파가 작업 방식이다.**
- **`상태 저장 · 재시도 · 장애 복구를 포함한 장기 실행 AI 워크플로우 설계`** — 세션·기억 축을
  API 로 추상화한 자리가 여기 붙는다.
- **Document AI 가 이 회사의 본진**이고, `memex-kb` 가 같은 문제를 다른 각도에서 판 것이다.

**경계는 먼저 밝힌다** — 필수 4번 **`LLM/Agent 시스템의 관측(trace · log · metric) 설계·운영`**
이 얇다. 하네스 로그·세션 축은 굴리지만 **OpenTelemetry/Datadog 급 관측 설계가 아니다.**
**모델 서빙·경량화 실적이 없고 VLM 축이 얇다.** **Rust 는 축이 아니다.**

## 이후 기록

- [2026-07-28] 건 생성. 보드 훑기(`boards.py list greeting:upstage`, 44건)에서 골랐다.
  본문·`docsInfo`·`questionnairesInfo`·`additionalApplicantInfoConfig` 를 **브라우저 없이** 확인.
- [2026-07-28] 컷 **AI Engineer** 확정. 상태 **`blocked`** — **제품 체험 평가가 남았다.**
