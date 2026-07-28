# AGENTS.md — resume/ (영문 이력서 · 타깃별 컷 생성기)

이 디렉터리는 **링크드인과 해외·국내 공고에 첨부하는 영문 이력서 PDF**를 만든다. NHN 제출
레인(`../nhn/`)과 목적이 다르다. 저쪽은 공고 하나에 조준한 3종 세트고, 이쪽은 **공통 프레임
하나에서 타깃별 컷을 뽑는 발사대**다. 하루에 열 곳을 내는 흐름을 전제한다.

---

## 구조 — 사실은 한 벌, 선택·순서·증거 입구는 컷마다

```
resume.org              베이스 정본 (링크드인 첨부용 공개 입구)
targets/<slug>.org      타깃 컷 — 서사 · 역량 · 공개 증거 · body 모듈 선택/순서
body.org                사실 모듈 한 벌 — 경력 · 프로젝트 · 검증 · 스택 · 학력
pipeline/preamble.org   조판 선언 (article · A4 · Pretendard/D2Coding · 색 · 표제 위계)
pipeline/latex-export.el  org → tex + CV_*_MODULES 선택/배열
run.sh                  빌드 · 검수
flake.nix / flake.lock  texlive · 활자를 빌드 입력으로 고정
build/*.pdf             산출물 (PDF 만 git 추적 — 다른 기계에서 바로 첨부하기 위해)
```

**한 벌 원칙은 사실에 적용하지, 표시 순서에 적용하지 않는다.** 경력·수치·프로젝트 설명은
`body.org` 한 곳에만 있다. 각 프로젝트 헤딩은 `CUSTOM_ID`를 가지며 타깃 정본의
`#+CV_GOQUAL_MODULES:`와 `#+CV_INDEPENDENT_MODULES:`가 export 시 선택·배열한다. 변환은 include가
풀린 임시 버퍼에서만 일어나므로 사실을 복제하지 않는다.

각 컷은 별도로 **표제, Summary 두 문단, 역량 다섯 줄, 「Public Evidence」 세 경로**를 쥔다.
공개 경로는 GitHub/가든의 실제 URL과 실행·검사 진입점을 보인다. 비공개 회사 수행 사실은
경력으로 쓰되 공개 인접 구현을 그 사실의 증거처럼 가장하지 않는다.

---

## 새 타깃 컷 만드는 법

GLG가 공고를 건네면 이 순서로 만든다. 5분이면 끝난다.

1. `targets/<slug>.org` 를 기존 컷 하나에서 복사한다.
2. `#+cv_pdf_name:` 을 바꾼다 → `KimJunghan_Resume_<Target>` (이 값이 PDF 파일명이다).
3. `#+CV_GOQUAL_MODULES:`와 `#+CV_INDEPENDENT_MODULES:`에서 **보여 줄 사실과 순서**를 고른다.
   ID의 SSOT는 `body.org` 각 헤딩의 `CUSTOM_ID`다. 없는 ID는 export가 실패한다.
4. `\cvheader{...}` 부제를 시장의 직무 언어로 바꾼다. 내부 개념어를 직무명보다 앞세우지 않는다.
5. `* Summary`를 **두 문단**으로 다시 쓴다. 첫 문단은 그 직무가 사는 층의 결과, 둘째는
   책임 경계와 인접 역량이다. 하지 않은 모델 학습·파인튜닝을 넓혀 말하지 않는다.
6. `* Core Competencies` 다섯 줄을 그 직무의 어휘로 고친다.
7. `* Public Evidence`에 공개 URL과 검사/실행 진입점 세 개를 둔다. 비공개 사실과 공개
   인접 구현의 경계를 한 줄로 밝힌다.
8. `./run.sh target <slug>` → `./run.sh verify`.

**Summary를 세 문단으로 쓰지 않는다.** 자료가 많을수록 더 넣는 대신 모듈을 고른다.

---

## 분량 계약 — 2쪽 우선, 증거가 남으면 3쪽

- 이력서는 훑는 문서다. `run.sh verify`는 4쪽을 경고, 5쪽을 실패로 센다.
- 현재 Embedded 컷은 2쪽, 나머지는 3쪽이다. 세 번째 쪽은 공개 검증·기술·학력까지 남길
  가치가 있을 때만 쓴다. 공고가 좁으면 모듈을 덜어 2쪽으로 만든다.
- 늘려야 한다면 먼저 타깃의 모듈 선택에서 같은 분량을 덜어낸다. 사실원 `body.org`를 한
  공고 때문에 삭제하거나 판면(`geometry`·`linespread`)을 더 짜내지 않는다.
- `Selected Open Source`와 `Working Corpus`는 베이스용 카탈로그다. 타깃 컷은
  `#+EXCLUDE_TAGS: catalog corpus`로 빼고, 대신 그 직무에 직접 닿는 공개 증거 세 개를 둔다.

---

## 사실의 출처 (지어내지 않는다)

| 무엇 | 어디 |
|---|---|
| 검증된 사실·수치·계보 | `~/repos/gh/junghan0611/apply/MATERIAL.md` |
| 공개 이력서 SSOT (영문) | 가든 `20260318T183247` — §junghan0611 깃허브 프로파일 이력서 |
| 자기소개 서사 | 가든 `20230814T142800` |
| 기업용 하네스 좌표 (FDE 컷의 논지) | 가든 `20231018T221900` |
| 라이브 수치 | `agenda.junghanacs.com/api/stats` (100 단위 내림, 측정일 명기) |
| 공개 리포 판 | `~/repos/gh/junghan0611/resume/README.md` |

수치를 갱신하면 **측정일도 같이 갱신한다.** `body.org` 의 Working Corpus 문단 한 곳이다.

---

## 경계

- **연락처는 이메일·GitHub·가든·LinkedIn 넷뿐이다.** 전화번호와 주소는 넣지 않았다.
  넣을지는 GLG가 결정한다 (링크드인 첨부는 채용담당자 외에도 열람 범위가 넓을 수 있다).
- 추천인 실명, 지원 경로, 회사 내부 식별자, 고객 식별자, 자격증명은 넣지 않는다.
- 회사 실명(GoQual)은 공개 이력서에 이미 있으므로 그대로 쓴다.
- **직접 쓰지 않은 기술을 썼다고 쓰지 않는다.** 능력(self-owned)과 수용(third-party)과
  경계(not used)를 섞지 않는다. 특히 AI 컷은 모델 학습 전문가를 주장하지 않는다.
- 공개 저장소가 비공개 양산·고객 배포를 증명한다고 쓰지 않는다. 공개 인접 구현은 무엇을
  검증하고 무엇을 검증하지 않는지 명시한다.
- "검증 가능"은 수사가 아니다. 보이는 URL, 실행 명령, 테스트·doctor·gate, 제3자 PR/merge
  중 하나로 이어져야 한다.
- 파생물(PDF)을 손으로 고치지 않는다. Org를 고치고 다시 빌드한다.

---

## 빌드

```bash
./run.sh check                 # 도구·활자 점검
./run.sh base                  # 베이스 이력서
./run.sh target ai-engineer    # 타깃 컷 하나
./run.sh all                   # 전부 + 검수
./run.sh verify                # A4 · 활자누락 · 판면초과 · 분량 · 연락처 · 별표누출
./run.sh clean                 # 중간산물 정리 (PDF 는 유지)
```

조판은 언제나 flake devshell 을 경유한다(`nix develop 'path:.'`). 호스트 texlive 와 활자가
다르면 같은 소스에서 다른 문서가 나오기 때문이다. **처음 도는 기계에서는 devshell 을
세우는 데 몇 분이 걸린다** — 그래서 `build/*.pdf` 를 git 으로 추적한다.
