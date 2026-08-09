# 제출 기록 — Wonderful / Forward Deployed Engineer

| 항목 | 값 |
|---|---|
| 상태 | ✅ **submitted** — 2026-08-09 GLG 가 브라우저에서 최종 제출 완료 |
| 지원일 | **2026-08-09** |
| 경로 | **Ashby** — 가입 불필요 |
| 첨부 컷 | **FDE** (`resume/build/KimJunghan_Resume_Forward_Deployed_Engineer.pdf`, Cohere·Reflection AI와 동일 파일 재사용) |
| 추가 첨부 | ⛔ **없다 — 폼 전체 실측 완료 (2026-08-09).** 첨부 슬롯이 `Resume` 하나뿐이라 깊이 문서를 낼 칸이 없다 |
| 공고 URL | https://www.linkedin.com/jobs/view/4446808150 |
| 지원 URL | https://jobs.ashbyhq.com/wonderful/[uuid removed]/application |
| 조직 | Department **S&M** · 근무지 **South Korea** · 고용형태 **Full time** |

## 폼 스키마 — GLG 브라우저 실측 (2026-07-31, 상단부만)

| 필드 | 필수 | 값 |
|---|---|---|
| Name | 필수(추정) | GLG 직접 |
| Email | 필수(추정) | GLG 직접 |
| **Resume**(파일 하나) + `Autofill from resume` 기능 | 필수 | `KimJunghan_Resume_Forward_Deployed_Engineer.pdf` |

### ✅ 폼 전체 실측 (2026-08-09, 에이전트 브라우저 · 읽기 전용)

07-31 의 「상단부만」 미확인이 닫혔다. **폼 전체가 이 셋뿐이다.**

| 칸 | 필수 | 값 |
|---|---|---|
| `Autofill from resume` (선택 기능) | — | 쓰지 않는다 — 자동 채움이 칸을 잘못 채울 수 있다 |
| Name | ✅ | GLG 직접 |
| Email | ✅ | [email removed] |
| Resume (파일 1개) | ✅ | `submit/KimJunghan_Resume_Forward_Deployed_Engineer.pdf` |

**아래쪽에 있을까 걱정했던 것들이 전부 없다** — 근무 자격 질문 ⛔ · 한국어 질문 ⛔ ·
LinkedIn 칸 ⛔ · 서술형/커버레터 칸 ⛔ · **선택 첨부 슬롯 ⛔** · 별도 개인정보 동의 체크박스 ⛔.
같은 Ashby 라도 **Cohere·OpenAI 폼과는 칸 수가 크게 다르다** — ATS 가 아니라 회사가 폼을 정한다.

## 낸 것

- [x] **이력서 PDF** — `submit/KimJunghan_Resume_Forward_Deployed_Engineer.pdf` (3쪽 · 33.3 kB)
      (기존 파일 재사용 — `body.org`·FDE 컷 모두 2026-07-29 이후 변경 없어 리빌드 불필요)
- [x] **업로드·Submit 완료** (2026-08-09). 파일은 에이전트가 폼에 올렸고,
      **이름·이메일·최종 `Submit Application` 은 GLG** 가 했다. 개인값은 저장하지 않는다.
- ⛔ 선택 첨부 · 서술형 · 동의 체크박스 — **폼에 칸 자체가 없다**(실측).
- ⚠ 상단 `Autofill from resume` 는 **쓰지 않았다** — 이력서를 파싱해 칸을 자동으로 채우는데
      잘못 채워도 표가 나지 않는다.

## 왜 이 직무였는가

이미 같은 컷으로 Cohere·Reflection AI·Enhans 세 건을 낸 축과 같다. `Translate open-ended
problems into clear technical designs`, `Own deployments... reliability, performance,
continuous improvement`, `working across systems, integrations, and data flows` — 도메인
오너 에이전트·VOC/인시던트 워크벤치에서 매일 하는 일과 같은 문장이다. 5년 요건은 여유 있게
넘는다(`FAQ.md` §3, 8+ years).

**Department가 S&M이라는 점은 `JD.md`에 판단을 남겼다** — quota 언급 없음, 업무 서술은 순수
기술 딜리버리 동사(design/build/deploy/iterate)뿐이다. 다만 회사가 조직을 세일즈 산하에 둔
것은 사실이라 인터뷰에서 확인할 질문(quota 유무·보고 라인·평가 기준·급여 구조)으로 남긴다.

## 이후 기록

- [2026-07-31] LinkedIn 알림으로 재유입 → 회사 실체·투자 이력($290M/$2B 밸류)·한국법인 확인 →
  GLG "준비하자" 지시로 케이스 오픈. 근무지 South Korea·Department S&M·폼 구조(Resume 파일
  하나)는 GLG 브라우저 스크린샷으로 확정. FDE 컷 기존 PDF 재사용. 상태 `ready` — GLG 노트북
  에서 제출 대기.
- [2026-07-31] 컨트롤타워(정응섭 GM·변규현 FDE1)·타 지역 1호 FDE 공개 증언으로 「결국 현지
  커스텀」가설 검증, S&M 판단 재평가 — `JD.md`에 기록. **GLG: "일단 내긴 내더라도 별로
  희망하는 자리는 아니다."** 낼 예정이나 우선순위는 낮음.
- [2026-08-09] Ashby 보드에서 **공고 생존 확인**(`isListed=true` · id `3ae60bb1…` 동일 ·
  같은 FDE 공고가 브라질·안데스·아르헨티나·칠레·멕시코·오스트리아·이탈리아 ×2 와 함께 열려 있다 —
  **지역별로 뿌리는 채용**이다). 폼 전체를 실측해 미확인 칸을 닫았다. **아직 제출하지 않았다.**
- [2026-08-09] ⭐ **GLG 가 우선순위 보류를 풀었다** — *「wonderful도 그냥 다 내자. 서류통과도
  잘안되고 있는데 따질상황이 아니야.」* 07-31 의 「별로 희망하는 자리는 아니다」는 **취소가 아니라
  순위 판단**이었고, **넓이 축을 유지한다**는 결정이 그 위에 온다. 이 건은 낸다.
- [2026-08-09] ✅ **제출 완료.** 완료 화면: *"Your application was successfully submitted.
  We'll contact you if there are next steps."* GLG 가 **「짧은 것부터 내자」** 로 순서를 바꿔
  이 건(3칸)이 Cohere 보다 먼저 나갔다. 개인 필드 값은 저장하지 않았다.
