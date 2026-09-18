# RAIL — 현재 좌표

- [x] **1. 공개 안전 계약·history 정제·새 object database 검증**
- [x] **2. 기존 지원 기록 회수와 리멤버·원티드 사후 회수**
- [x] **3. 시스템 축 판정 기준 수립과 전 후보 재분류** — `AGENTS.md` §시스템 축 (2026-09-18 GLG)
- [x] **4. 시스템 축 22건 케이스 생성 + 요건 실측** — 전부 `draft`, `check.py` ok 80건
- [~] **5. 이력서 7컷 재빌드 완료** — `platform-engineer` 신설·FDE 컷 축 정정·verify 통과.
      남은 것은 `MATERIAL.md` 사실 갱신과 ax — **GLG 입력 대기** ← CURRENT
- [ ] **6. GLG 브라우저 제출 → 원장·지문 닫기**

현재 좌표: 4 완료 → **5 절반(빌드 완료·사실 갱신 대기)** → 6 은 GLG 실행

🔴 **차단 — 공개 게이트 실패.** `./scripts/check-public.sh --repo .` 가 실패한다. 오늘 작업이
아니라 **2026-09-16 `860e2bd` 에 이미 푸시된 값** 때문이다: 이메일 blob 2개
(`applications/gint--embedded-software-engineer/JD.md` · 같은 폴더 `submit/WANTED-PROFILE-NOTE.md`)
· 커밋 메시지 이메일 · candidate UUID blob 1개(경로 미표시) · commit ident noreply 아닌 필드 6개.
**공개 저장소이고 이미 공개된 값이라 에이전트가 만지지 않는다** — history 재작성 범위는 GLG 판정이다.
그전까지 **커밋·푸시하지 않는다.**

# NOW

## 이번 배치가 무엇인가

2026-09-18 에 판정 축이 하나 늘었다. **`AGENTS.md` §시스템 축** — offense mode 안에서
FDE·AI·AX 라는 **이름**이 아니라 **무엇을 만드는 자리인가**로 가른다. 그 기준으로 원티드 34건 +
리멤버 10건을 담당업무 원문 인용으로 재분류했고(`INBOX-WANTED.md`·`INBOX-REMEMBER.md`
§시스템 축 재분류), `LEDGER.md` 대조까지 끝냈다.

**결론: 22건을 낸다.** 시스템 축 20건 + 애매 중 시스템 문장이 구체적인 2건.

## 🤖 에이전트 몫 — GLG 입력 없이 돈다

### 4-A. 22건 케이스 생성

각 건: `./new.sh` → `JD.md`(원티드·리멤버 담당업무 원문과 출처 보존) → `submission.md`(상태
`draft`) → `LEDGER.md` 행. **`ready` 로 올리지 않는다** — 첨부 컷이 5 단계에 달려 있다.

**A. 에이전트 런타임·플랫폼 6**

| 회사 | 직무 | id |
|---|---|---|
| 오토메타 | AI Agent Engineer | W 384691 |
| 다키클라우드코리아 | 시니어 엔지니어 (Agent Native Cloud) | W 371314 |
| 미리비트 | Data Engineer & Local LLM AI Agent Engineer | W 382386 |
| 위시드 | MLOps / AI 에이전트 개발자 | W 382306 |
| 심플랫폼 | AI Agent & LLM Engineer 시니어 | W 368678 |
| 애자일소다 | AI Agent Platform Engineer | W 374789 |

**B. 에이전트 아키텍처·통신 3** — 뷰티셀렉션 [AX Dept] FDE (W 378781) · 에이티씨아이
Software Engineer(AI Agent) (W 349626) · 콘센트릭스서비스코리아 LLM/Agent Engineer (W 379871)

**C. 인프라·플랫폼 6** — 링크알파 FDE (W 375859) · 위즈코어 온프레미스 K8s 플랫폼 엔지니어
(R 333230) · 마이클 Platform Engineering (R 333599) · 비상교육 Lead DevOps/AI Platform
(W 375022) · 퓨쳐스콜레 Platform Engineer Lead (W 371498) · 와탭랩스 Kubernetes 에이전트
(R 291531)

**D. 임베디드·시스템 SW 4** — 오픈엣지테크놀로지 NPU Firmware (W 365239) · 소울아트 System
Software Engineer Embedded AI (W 350980) · 카이트다이나믹스 임베디드 펌웨어·제어 (W 384224) ·
리주비놀 로봇 제어·펌웨어 (W 382219)

**E. 도메인 AI 1** — 큐픽스 머신러닝 엔지니어 공간지능 (W 373064)

**F. 애매에서 올린 2** — 비스텔리젼스 FDE (W 384457) · 멘타트 FDE (W 381184).
시스템 문장이 구체적이라 올렸다. `submission.md` 에 **서비스 쪽 문장도 함께 인용**해 둔다.

### 4-B. 각 건 제출 요건 실측

폼 문항·필수 첨부 슬롯 수·서술형 글자수 캡·마감. 원티드는 공개 API, 리멤버 3건은 GLG
로그인 세션. **「지원하기」·「간편 지원하기」 는 어느 화면에서도 클릭하지 않는다.**

### 4-C. 게이트

`applications/check.py` 통과. 공개 경계 변경이 있으면 `./scripts/check-public.sh --repo .`.

## 👤 GLG 몫 — 이것들이 없으면 5·6 이 안 움직인다

1. **`MATERIAL.md` 를 연다.** 프로필 repo `junghan0611/junghan0611` 의 `apply/` 에 있고 **이
   저장소에 없다.** 한 달치 새 사실과 Working Corpus 재측정이 거기부터다. → 5 단계 선행조건.
2. **「글」이 무엇인지 지목한다.** 가든 코어 글 / ax 서사 / 지원서 자기소개 문단 — 셋 중
   무엇을 갱신하는지. 셋 다면 순서만 정해 주면 된다.
3. **원장 충돌 3건을 판정한다.**
   - **모레** LLM Platform (W 375108) · NPU System SW (W 382920, 🟠 마감 09-25) — 회사가
     2026-09-09 `rejected`. 인핸스 기준 그대로면 제외. *기본값을 제외로 두고 진행 중.*
   - **OpenAI** FDE Seoul (W 370620) — DevEx 가 `ready` 로 미제출. 180일 5건 제한 재확인 필요.
     한 자리만 낸다면 FDE 가 시스템 축에 더 가깝다.
   - **마키나락스** — `submitted`(2026-08-09, **담당자 추천 경로**). 13개 req 가 열려 있다.
     새로 내는 것보다 **그 담당자에게 다른 req 를 묻는 쪽**을 권한다.
4. **terra 검수를 붙일 시점을 정한다.** 과한 워딩·뺄 것을 걷어내는 교차검수.
   `FAQ.md` §원칙 5·6 이 그 기준이다.
5. **최종 Submit 과 개인·법적 값·동의.** 6 단계 전체. 에이전트는 누르지 않는다.

## 이번 배치의 제출본 기준 — 새로 박혔다

`applications/FAQ.md` **§원칙 5 검증을 부르는 문서** · **§원칙 6 애매한 수치는 아예 넣지
않는다**(전화 면접 추궁 실측). 22건의 모든 답변·자소서가 이 둘을 통과해야 한다.

- 주장 옆에 **확인 입구**(URL·커밋 SHA·PR 번호·실행 명령·날짜)가 없으면 주장을 줄인다.
- 자가 측정 성능·작업량 수치는 문서에서도 **면접 발화에서도** 뺀다.
- 읽는 쪽이 **에이전트일 수 있다**고 가정한다 — 공개 좌표는 장식이 아니라 작동 부품이다.

## Verify

```bash
applications/check.py --deep          # 기록 변경 뒤
./scripts/check-public.sh --repo .    # 공개 경계 변경 뒤
applications/alive.py                 # 제출 직전 공고 생존
(cd resume && ./run.sh all && ./run.sh verify)   # 5 단계
```

## Read

`AGENTS.md` §시스템 축 · §후보를 판정하기 전에 원장을 먼저 본다 · §제출본은 검증을 부르는 문서다 ·
`applications/FAQ.md` §원칙 5·6 · `applications/INBOX-WANTED.md` §시스템 축 재분류 ·
`applications/INBOX-REMEMBER.md` §시스템 축 재분류

## Do not touch

raw 폼·법적 값·실제 제출 바이너리는 public repo 에 넣지 않는다. 제출 완료 건의 `submit/`
스냅샷을 재빌드·덮어쓰지 않는다. 리멤버 URL·엔드포인트 패턴을 저장소에 적지 않는다
(`docs/HISTORY-REDACTION.md` §login-gated-automation).

# RECENT

- [2026-09-16] Gmail 대조로 리멤버·원티드 6건을 사후 회수하고 2건을 `rejected` 로 닫았다 (`860e2bd`).
- [2026-09-18] **원티드 45건 생존 실측** — 34 active / 9 close / 2 draft. 9 일 기다리는 사이
  **에스투더블유(S2W) FDE(AI Platform)** 가 닫혔다. 09-09 배치에서 「GLG 축과 정면」 1번이었다.
- [2026-09-18] **`AGENTS.md` §시스템 축 신설.** offense mode 안에서 FDE·AI·AX 를 다시 가른다 —
  런타임·게이트웨이·드라이버를 만드는 자리는 내고, 고객 요청·사내 서비스를 구현하는 자리는 뺀다.
- [2026-09-18] 소넷 형제가 원티드 34 + 리멤버 10 을 **담당업무 원문 인용**으로 재분류했다.
  판정이 뒤집힌 것들 — 스켈터랩스 FDE(⭐⭐정면 → 서비스), 클리카(시스템 예상 → 서비스),
  위즈코어·마이클(제목만 확인 → 시스템). **제목으로 판정하면 반대로 고른다**는 증거다.
- [2026-09-18] **모레 AI Agent System Engineer(R 329027) 마감 확인.** 09-09 리멤버 배치 1번이었다.
  S2W 에 이어 9 일 사이 잃은 두 번째 정면 건이다.
- [2026-09-18] **원장 대조 누락을 계약으로 닫았다** — 인핸스(`rejected`)가 후보로 다시 올라온
  사고. `AGENTS.md` §후보를 판정하기 전에 원장을 먼저 본다.
- [2026-09-18] **`FAQ.md` 원칙 5·6 추가.** 검증을 부르는 문서 / 애매한 수치 전면 제외
  (전화 면접에서 토씨 하나로 추궁당한 실측이 근거).
