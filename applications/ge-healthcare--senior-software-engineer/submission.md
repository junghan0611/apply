# 제출 기록 — GE HealthCare (지이헬스케어코리아) 🌐 / Senior Software Engineer

| 항목 | 값 |
|---|---|
| 상태 | **draft** — 공식 공고·본문·직무 판정 완료, **제출본 컷 결정 전** |
| 지원일 | — |
| 경로 | **Workday** (`GEHC_ExternalSite`) — 공식 원본 |
| 첨부 컷 | **미정** — Embedded 기존 컷 vs GE용 Systems Software 좁은 컷 |
| 공고 URL | https://gehc.wd5.myworkdayjobs.com/GEHC_ExternalSite/job/Seongnam/Senior-Software-Engineer_R4042393-1 |
| LinkedIn 발견 경로 | https://www.linkedin.com/jobs/view/4430473327/ |
| 근무지·조건 | **성남 초음파 연구소 · onsite · Full time · 7~12년** |
| 열림 근거 | Workday `R4042393`: `posted=true` · `canApply=true` (2026-07-28 확인) |

## 낼 것

- [ ] **이력서 PDF** — 아래 §제출본 결정 후 확정
- [ ] 커버레터 / 지원 동기 — Workday 폼에서 슬롯 확인
- [ ] 추가 서류 — Workday 폼에서 슬롯 확인

### 제출본 결정 — GLG와 논의할 한 가지

현재 그대로 붙일 수 있는 것은
`resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf`다. 양산·C 경계·시스템 통합·
실장치 검증은 강하지만 표제가 `Firmware and Protocols That Shipped`라 GE 공고의
**application and systems software**보다 펌웨어 쪽으로 좁게 읽힐 수 있다.

`KimJunghan_Resume_Software_Engineer.pdf`는 application/system 세로축을 넓게 보여 주지만
Agent Systems 비중이 GE의 C++ 제품 SW 첫 판정에는 불필요하다.

**권고:** GLG가 이 건을 「가자」로 정하면 기존 사실 모듈을 복사하지 않고
`resume/targets/`에 **Systems Software Engineer 컷 하나**를 만든다. 첫 화면을
`7~12년 · application/system SW · module ownership · debugging/performance · integration/test`
에 맞추고, Embedded의 제품 수명주기와 C 경계를 선택한다. 의료기기·C++ 전문성을 새로
주장하지 않는다.

## 폼에 답할 질문

| 질문 | 답 | 출처 |
|---|---|---|
| 이름 / 영문명 | 김정한 / Junghan Kim | `FAQ.md` §1 |
| 이메일 | [email removed] | `FAQ.md` §1 |
| GitHub / 포트폴리오 URL | https://github.com/junghan0611 · https://notes.junghanacs.com | `FAQ.md` §1 |
| 총 경력 | **8+ years** — 요건 `7~12 years` 통과 | `FAQ.md` §3 |
| 최종 학력 | 석사 보유 | `FAQ.md` §3 |
| 영어 | 읽기·쓰기 업무 수행 가능, 공개 PR 리뷰·merge 증거 | `FAQ.md` §6 |
| 대한민국 취업 자격 | Yes / 스폰서 불필요 | `FAQ.md` §5 |
| 연락처 · 법적 값 | **브라우저에서 GLG 직접 입력. Git에 값 미보존** | `FAQ.md` §1·§5 |
| 희망 연봉 | ✅ **「면접 후 협의」** — 숫자를 강제하는 폼에서만 GLG 가 직접 입력 (Git 에 숫자를 적지 않는다) | `FAQ.md` §4 |
| 입사 가능일 | ✅ **「협의 가능」** — 날짜를 강제하면 **「최종 합격·처우 협의 후 4주 이내」** | `FAQ.md` §4 |
| 이직 사유 | ✅ **확정 문장 있음** — `FAQ.md` §7 (`resume/body.org` Summary 축) | `FAQ.md` §7 |
| Workday 조건부 질문 | ⚠ 로그인 브라우저에서 확인 후 이 표와 `FAQ.md` 보강 | — |

## 왜 이 직무였는가

GE HealthCare가 같은 성남 초음파 연구소에 연차별 Software·AI/ML 아홉 자리를 한 묶음으로
열었다. **회사가 아니라 자리를 판정한 결과 이 하나가 정면이다.**

- `Software Engineer`는 0~7년이라 현재 연차보다 낮다.
- `Staff Software Engineer`는 12~15년과 조직횡단 기술 리딩을 요구한다.
- `Software Architect`는 15~20년 Director급이다.
- AI/ML Engineer 계열은 연차보다 **모델 개발·학습·평가·배포**가 중심이라 증거 밖이다.
- `Senior Data Engineer`는 데이터 관리 5년, 팀 리더십 2년, 채용·성과관리, SQL 최적화가
  정면 요구라 현재 증거가 얇다.
- `System Engineer`라는 제목의 새 공고는 실제로 초음파 프로브 테스트 **1년 계약직**이다.
- `Verification Engineer`는 0~5년 QA 전담이다.

`Senior Software Engineer`만 `7~12년`과 제품 application/system SW, 모듈 소유, 디버깅,
성능·신뢰성, 시스템 통합, 테스트를 함께 요구한다. C++/C#과 의료 규제 경험의 간극은 있지만,
GLG의 양산 임베디드→Linux OS→애플리케이션→서버·앱 세로축을 가장 정직하게 낼 수 있는 자리다.

## 이후 기록

- [2026-07-28] GLG가 GE HealthCare LinkedIn 회사 페이지를 지목해 한국 최근 공고 16건을
  수집하고 기술직 본문 9건을 비교했다.
- [2026-07-28] LinkedIn `4430473327`에서 본문을 뜨고 공식 req `R4042393`을 찾았다.
  예전 Phenom 경로는 `filled`지만 현재 Workday 원본은 `posted=true`, `canApply=true`임을
  확인했다. **지원 경로는 Workday가 SSOT다.**
- [2026-07-28] 한 회사 한 직무 원칙으로 `Senior Software Engineer` 하나만 draft 케이스로 열었다.
  다음 상태 변화는 **GLG의 「가자」와 제출본 컷 결정**이다.

