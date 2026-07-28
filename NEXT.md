# NOW — 영문 이력서 발사대 (`resume/`)

- **Current**: 2026-07-28 오전, 링크드인 프리미엄 구독을 계기로 **영문 이력서 PDF 베이스**를
  세웠다. Org 정본 하나 → 타깃별 컷을 뽑는 구조다. 오늘 10곳 지원에 그대로 쓸 수 있다.
- **Built**: `resume/build/` 에 **6종 PDF, 전부 3쪽, verify 통과**.
  1. `KimJunghan_Resume.pdf` — 베이스 (타깃 중립, 링크드인 첨부용)
  2. `KimJunghan_Resume_AI_Engineer.pdf`
  3. `KimJunghan_Resume_Forward_Deployed_Engineer.pdf`
  4. `KimJunghan_Resume_Embedded_Software_Engineer.pdf`
  5. `KimJunghan_Resume_Developer_Experience_Engineer.pdf`
  6. `KimJunghan_Resume_Software_Engineer.pdf`
- **Next**: 공고를 하나 건네면 `resume/AGENTS.md` §「새 타깃 컷 만드는 법」 6단계로 컷을
  하나 더 뽑는다(5분). 기존 다섯 컷으로 덮이는 공고면 그대로 첨부한다.
- **Blocker**: none.
- **Read**: `resume/AGENTS.md` → `resume/resume.org` → `resume/body.org`.
- **Do not touch**: PDF 를 손으로 고치지 않는다. Org 를 고치고 `./run.sh` 로 다시 낸다.
  분량 계약은 3쪽이고 지금 여유가 없다 — 늘리려면 같은 분량을 먼저 덜어낸다.

## 이번 판에서 남겨 둔 것 (GLG 판단 또는 다음 세션)

- [ ] **연락처 수위** — 지금은 이메일·GitHub·가든·LinkedIn 넷뿐이다. 전화번호·주소는
      의도적으로 뺐다. 링크드인 첨부는 열람 범위가 넓을 수 있어 GLG가 결정할 자리다.
      넣기로 하면 `pipeline/preamble.org` 의 `\cvheader` 한 곳만 고치면 여섯 컷에 다 반영된다.
- [ ] **GLGMAN Universe 이미지** — `resume/images/master/` 자리를 비워 두었다. 이력서 3쪽
      계약과 충돌해서 이번 판에는 넣지 않았다. 쓴다면 이력서 본문이 아니라 **별도 1장짜리
      비주얼 포트폴리오**(`resume/visual.org`)로 여는 편이 맞다. 패턴은 `authologplay` /
      `command-glgimage`, 프롬프트 보존은 `:PROMPT:` 헤딩 규약.
- [ ] **제3자 증거 수치 재확인** — entwurf 스타 수(21)와 npm 설치 수(1,395/30d)는 2026-07-10
      측정값이다. 현재 본문은 npm 수치만 남기고 "(2026-07)"로 표기했다. 스타 수를 다시 넣으려면
      `gh` 로 재측정 후 `body.org` 의 Third-Party Validation 을 고친다.
- [ ] **국문 이력서 컷** — 국내 공고가 국문 이력서를 요구하면 같은 골격에서 `resume-ko.org`
      로 가른다. 활자·조판은 그대로 쓸 수 있다(xetexko·Pretendard 이미 배선됨).
- [ ] **공개 트랙 반영** — `junghan0611/resume/README.md` 는 2026-07-10 판이다. 이번 판에서
      다듬은 문장(Summary 세 문단, 역량 다섯 축)을 공개 리포로 되돌릴지는 별도 판단.
      비공개→공개 자동 동기화는 하지 않는다.

# RECENT

- [2026-07-28] `resume/` 신설. Org SSOT 한 벌(`body.org`) + 표제·서사만 다른 컷 6장 구조.
  조판은 `article` 기반 자체 파이프라인 — nhn 의 acmart(논문)를 재사용하지 않았다. 이력서를
  논문 판면에 얹으면 두 쪽이면 될 문서가 네 쪽이 된다.
- [2026-07-28] 조판에서 잡은 것 셋: `#+INCLUDE` 에 `:minlevel 1` 이 없어 본문 전체가 한 단
  밀려 절이 소절로 조판되던 문제, 표를 균등 X 로 늘려 설명 열이 좁아지던 문제(세 열 이상이면
  첫·끝을 자연폭으로), 넷째 쪽에 절 하나만 남아 3분의 2가 비던 문제(판면과 문장을 같이 조여
  3쪽 확정).
- [2026-07-20] NHN AX 지원 제출 완료 (`nhn/` 레인은 닫혀 있다). 연락이 오면
  `nhn/build/KimJunghan_AX_Detail.md` 의 Tech Interview anchors 로 라이브 코딩을 준비한다.

# LEDGER

- 사실·서사 SSOT: `~/repos/gh/junghan0611/apply/MATERIAL.md`
- 영문 공개키(가든): `20260318T183247` · 자기소개 서사: `20230814T142800`
  · 기업용 하네스 좌표: `20231018T221900`
- 이력서 계약: `resume/AGENTS.md` · NHN 제출 계약: `nhn/AGENTS.md`
- 패키지 탐색 계약: `nhn/AGENTS.package.md`, `nhn/README.package.md`
- 라이브 수치: `agenda.junghanacs.com/api/stats` (100 단위 내림, 측정일 명기)
- 최종 산출물은 Org 정본에서 재생성한다. `./run.sh all` → `./run.sh verify`.
