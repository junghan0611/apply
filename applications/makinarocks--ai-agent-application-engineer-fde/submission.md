# 제출 기록 — MakinaRocks (마키나락스) / [FDE] AI Agent Application Engineer

| 항목 | 값 |
|---|---|
| 상태 | **ready** (첨부·경로 확정 · **제출 대기 — GLG 노트북에서 제출**) |
| 지원일 | — |
| 경로 | **그리팅** (자체 도메인 `makinarocks.career.greetinghr.com`) — 가입 불필요 |
| 첨부 컷 | **FDE** (`resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`, 3쪽) |
| 공고 URL | https://makinarocks.career.greetinghr.com/ko/o/214041 |
| **지원 URL** | 같은 페이지의 「지원하기」 |
| 근무지 | 서울 서초구 강남대로 343 |
| 제품 | **DrawX** — 도면(PDF/DWG) B2B SaaS. Agent 아키텍처를 지금 설계하는 단계 |

## 낸 것

- [ ] **이력서 PDF** — `resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`
      (절대경로: `~/repos/gh/apply/resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`)
- [ ] 커버레터 — **폼이 요구하는 서류는 `Resume/CV` 하나다**(그리팅 `docsInfo` 확인).
      칸이 따로 있으면 아래 §왜 이 직무였는가 를 줄여 쓴다
- [ ] 추가 서류 — 없음

**⚠ Enhans·Reflection 과 같은 FDE 컷이다.** 업로드 직전 파일명을 눈으로 확인하고
올린 파일을 `submit/` 에 복사한다.

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `LLM/VLM 프로젝트 1년 이상` 은 여유 있게 통과 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git 에 저장하지 않는다** | `FAQ.md` §5 |
| 희망 연봉 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 입사 가능일 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |
| 이직 사유 | ⚠ **GLG 확정 필요** | `FAQ.md` §4 |

> 그리팅은 회사마다 폼이 다르다. 이 건은 `docsInfo` 가 **Resume/CV 하나**였다.
> 전형: **서류검토 → 사전인터뷰(온라인) → 기술인터뷰 → Fit인터뷰**. 코딩테스트는 없다.

## 왜 이 직무였는가

**마키나락스는 FDE 만 12건이 열려 있다.** 국내에서 FDE 축이 가장 두꺼운 회사이고, 그중
이 자리를 고른 이유는 **요구 문장 세 줄이 GLG 가 만든 것과 그대로 겹치기 때문**이다.

- **`Agentic 검색 — 쿼리 생성부터 결과 판단, 재검색까지 Agent 가 자율 수행`** ·
  `Vector DB · Hybrid Search` — 하이브리드 검색(벡터+FTS) 색인을 **직접 만들어 매일 운영한다.**
- **`Agent 가 공유하는 도구·메모리·판단 체인을 추상화`** — 하나의 ID 축으로 말이 통하는
  CLI 한 벌과, 기억을 API 로 추상화한 축이 그 자리에 정확히 붙는다.
- **`Agent 아키텍처의 근본 설계를 지금 함께 결정한다`** — 완성된 시스템에 기능을 얹는 자리가
  아니다. 「플레이북이 아직 없는 곳에서 구조를 세우는 일」이 GLG 가 반복해 온 방식이다.
- **FDE 본부의 정의가 정면이다** — 「모델을 만드는 것이 아니라 현장의 문제를 구조화해
  자율 실행 Agent 로 구현해 제품에 탑재」. 고객 현장 축(NEMO-UX 4년·월패드 납품)과 이어진다.

**경계는 먼저 밝힌다.** **CAD/도면 데이터 경험이 없다**(우대 항목). **VLM(비전) 실적이 얇다** —
텍스트·검색 축이 두껍다. `LangGraph 등 프레임워크`는 **쓴 쪽이 아니라 직접 만든 쪽**이라
「사용 경력」으로 포장하지 않는다.

## 이후 기록

- [2026-07-28] 건 생성. **`boards.py` 로 그리팅 본문을 브라우저 없이 채집** — 본문뿐 아니라
  제출 서류(`Resume/CV`)와 서술형 문항까지 폼을 열기 전에 확인했다.
- [2026-07-28] 컷 **FDE** 확정. 상태 `ready` — **GLG 노트북에서 제출 대기**.
