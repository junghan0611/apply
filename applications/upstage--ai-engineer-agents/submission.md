# 제출 기록 — Upstage (업스테이지) / AI Engineer - Agents

| 항목 | 값 |
|---|---|
| 상태 | **draft** — 첨부·경로는 확정, **필수 서술형 문항이 남아 막혀 있다** (아래 §관문) |
| 지원일 | — |
| 경로 | **그리팅** (자체 도메인 `careers.upstage.ai`) — 가입 불필요 |
| 첨부 컷 | **AI Engineer** (`resume/build/KimJunghan_Resume_AI_Engineer.pdf`, 3쪽) |
| 공고 URL | https://careers.upstage.ai/ko/o/194880 |
| **지원 URL** | 같은 페이지의 「지원하기」 (HTTP 200 확인, 2026-07-28) |
| 근무형태 | **Anywhere On Earth But Together** — 원격 지원(장비 500만원 예산) |
| 조건 | 정규직 · **경력 무관** · 게시 2025-12-16 · 팀 **Agent Engineering** |

## 낸 것

- [ ] **이력서 PDF (필수)** — `resume/build/KimJunghan_Resume_AI_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_AI_Engineer.pdf`)
- [ ] 자기소개서 (선택) — 서술형 문항이 그 역할을 겸한다. 따로 만들지 않는다
- [ ] 포트폴리오 (선택) — 올리지 않는다. 이력서의 공개 저장소 링크가 그 역할이다

**⚠ 업로드 직전 파일명을 눈으로 확인한다.** FuriosaAI · Lunit · 42dot 과 **같은 AI Engineer 컷**이다.

## §관문 — 이 건의 진짜 작업은 이력서가 아니다

필수 서술형 **6개** 중 첫 문항이 **「업스테이지 제품을 체험한 후 간략한 평가」**(상한 10,000자)다.
**답을 지어낼 수 없다.** Document Parse / Solar API 를 실제로 돌려 본 뒤에 써야 한다.

> **이것이 이 건에서 가장 강한 카드가 될 수 있다.** `memex-kb` 로 **HWPX · 스캔 PDF · EPUB →
> Org → 오피스** 파이프라인을 직접 만든 사람이 쓰는 Document Parse 평가는 다른 지원자와 다르다.
> 준비하면 차별화되고, 대충 쓰면 바로 드러난다. **GLG 가 「가자」 하면 이 평가부터 만든다.**

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
| **선호 관심 분야** (필수, 다중 선택) | 폼을 열고 선택지를 본 뒤 고른다 | — |
| **선호 프로그래밍 언어** (필수, 선택형) | **Go · Python** (Rust 는 축이 아니다) | `resume/body.org` §Skills |
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
