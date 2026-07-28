# LEDGER — 지원 원장

**어디에 · 언제 · 무엇을 냈는가.** 이 표가 지원 이력의 SSOT다. 건마다 행 하나.
행을 지우지 않는다 — 불합격도 이력이다. 폴더는 `_archive/`로 옮겨도 행은 남긴다.

상태: `draft`(자리만 만듦) · `ready`(글·첨부 준비됨, 제출 대기) · `saved`(플랫폼에 임시저장)
· `submitted`(제출 완료) · `replied`(회신 옴) · `interview` · `offer` · `rejected` · `closed`(공고 마감/철회)

| 회사 | 직무 | 상태 | 지원일 | 경로 | 첨부 컷 | 폴더 |
|---|---|---|---|---|---|---|
| NHN | AX Transformation / AI Infra (BE) | submitted | 2026-07-20 | 직접 제출 | `nhn/` 3종 세트 | `../nhn/` |
| Insighter | AX Engineer | saved | — | LinkedIn Easy Apply | — | `insighter--ax-engineer` |
| Hyundai AutoEver | AI Agent Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | AI Engineer + 국문 자기소개서 | `hyundai-autoever--ai-agent-engineer` |
| DEEPX | AI Agent Workflow Automation Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | AI Engineer + 경력기술서 통합 (7쪽) | `deepx--ai-agent-workflow-automation-engineer` |
| DEEPX | Linux BSP Engineer | submitted | 2026-07-28 | 그리팅 (자체 도메인) | Embedded + 경력기술서 통합 (5쪽) | `deepx--linux-bsp-engineer` |
| Enhans | Forward Deployed Engineer (7년 이상) | submitted | 2026-07-28 | ninehire (자체 채용홈) | FDE | `enhans--forward-deployed-engineer` |

---

## 기록 규율

- **낼 때 남긴다.** 내고 나서 기록하려 하면 남지 않는다. `./new.sh` 가 먼저다.
- **공고 URL은 죽는다.** `JD.md` 에 본문을 떠 두는 것이 링크보다 중요하다.
- 같은 회사 다른 직무는 **별도 건**이다. 같은 직무 재지원도 별도 건이고, 폴더명 뒤에
  `--2`를 붙인다.
- 회신·면접 일정은 그 건의 `submission.md` 하단 「이후 기록」에 시간순으로 덧붙인다.

## 메모

- **DEEPX 2건 (2026-07-28)** — 폼이 그리팅이지만 **AutoEver 와 구조가 다르다.** 자기소개서
  슬롯도 1,000자 사전질문도 없고, **「입사지원서」가 이력서+경력기술서를 통합한 PDF 하나**다
  (`하나의 파일만 업로드 가능`). 서술형은 300자 하나뿐.
  - ⚠ **병역사항이 폼 필수다.** `FAQ.md` §5가 미확정이라 **두 건 모두 제출 불가 상태**다.
    AutoEver 폼은 묻지 않았지만 여기는 묻는다. GLG가 정하면 `FAQ.md` 에 확정값으로 올린다.
  - ⚠ **같은 날 둘 다 내지 않는다.** `166870`(AI Agent) 이 1순위, `146732`(BSP) 는 2순위이고
    3~5일 뒤 또는 1순위 서류 결과를 보고 결정한다. 근거는 BSP 건 `submission.md` §제출 순서.
  - 추가질문 1(처음 알게 된 경로)·2(지원 경로)는 **두 건이 같은 값이어야 한다** — 같은 회사
    같은 ATS 라 지원서가 나란히 읽힌다.
  - 세 번째 공고 `114813 System SW` 는 **자리를 만들지 않았다** (ROM boot code·SoC 검증 축).

- **그리팅 공고 원문 뜨는 법** — WebFetch 는 **403**. 브라우저 UA 를 붙인 `curl` 은 200 이고,
  본문·폼 스키마가 전부 `<script id="__NEXT_DATA__">` 안에 있다
  (`props.pageProps.dehydratedState.queries[1].state.data.data` → `openingsInfo.detail`,
  `docsInfo`, `questionnairesInfo`, `additionalApplicantInfoConfig`).
  **필수/선택 여부와 글자수 상한까지 정확히 나온다** — 브라우저로 폼을 열기 전에 여기서 읽는다.

- **Insighter / AX Engineer** — 2026-07-28 브라우저 워크플로를 검증하면서 Easy Apply 4/5까지
  열고 임시저장했다(**제출 아님**). 이어서 내려면 공고 페이지의 「계속」에서 재개한다.
  4/5 질문 「경력 2년 이상 또는 석사 이상」은 **Yes**.
  - ⚠ **지역 기준 미달** — 근무지가 서울 마포구 DMC다. GLG 기준(성남·판교·강남권)에서
    벗어난다. 내용 적합도는 중상(`JD.md` §판단)이나 **낼지 말지는 GLG 판단이다.**
    내지 않기로 하면 이 건은 `closed`로 바꾸고 `_archive/`로 옮긴다.
