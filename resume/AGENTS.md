# AGENTS.md — resume/ (영문 이력서 · 타깃별 컷 생성기)

이 디렉터리는 **링크드인과 해외·국내 공고에 첨부하는 영문 이력서 PDF**를 만든다. NHN 제출
레인(`../nhn/`)과 목적이 다르다. 저쪽은 공고 하나에 조준한 3종 세트고, 이쪽은 **공통 프레임
하나에서 타깃별 컷을 뽑는 발사대**다. 하루에 열 곳을 내는 흐름을 전제한다.

---

## 구조 — 사실은 한 벌, 표제와 서사는 컷마다

```
resume.org              베이스 정본 (타깃 중립, 링크드인 첨부용 기본판)
targets/<slug>.org      타깃 컷 — 표제 부제 · Summary · Core Competencies 만 자기 것
body.org                공통 본문 — 경력 · 제3자 증거 · 오픈소스 · 스택 · 학력 · 코퍼스
pipeline/preamble.org   조판 선언 (article · A4 · Pretendard/D2Coding · 색 · 표제 위계)
pipeline/latex-export.el  org → tex 변환기 (클래스 등록 + 표 폭 정책)
run.sh                  빌드 · 검수
flake.nix / flake.lock  texlive · 활자를 빌드 입력으로 고정
build/*.pdf             산출물 (PDF 만 git 추적 — 다른 기계에서 바로 첨부하기 위해)
```

**한 벌 원칙.** 경력·수치·증거는 `body.org` 한 곳에만 있다. 컷이 여섯 개든 열 개든 사실이
어긋날 자리를 만들지 않기 위해서다. 컷이 바꾸는 것은 **표제 부제 한 줄, Summary 두 문단,
역량 다섯 줄**뿐이다.

---

## 새 타깃 컷 만드는 법

GLG가 공고를 건네면 이 순서로 만든다. 5분이면 끝난다.

1. `targets/<slug>.org` 를 기존 컷 하나에서 복사한다.
2. `#+cv_pdf_name:` 을 바꾼다 → `KimJunghan_Resume_<Target>` (이 값이 PDF 파일명이다).
3. `\cvheader{...}` 부제를 그 직무의 언어로 바꾼다.
4. `* Summary` 를 **두 문단**으로 다시 쓴다. 첫 문단은 그 직무가 사는 층의 증거,
   둘째 문단은 왜 그 층만 아는 사람이 아닌지.
5. `* Core Competencies` 다섯 줄의 **순서를 바꾸고** 그 직무의 어휘로 라벨을 고친다.
6. `./run.sh target <slug>` → `./run.sh verify`.

**Summary 를 세 문단으로 쓰지 않는다.** 두 문단이 3쪽 계약이다 (아래 참조).

---

## 분량 계약 — 3쪽

- 이력서는 훑는 문서다. `run.sh verify` 가 4쪽을 경고, 5쪽을 실패로 센다.
- 지금 여섯 컷 전부 정확히 3쪽이고, 셋째 쪽이 거의 꽉 찬다. **여유가 없다.**
  Summary 를 한 문단 늘리거나 경력 항목을 서너 줄 더하면 바로 넷째 쪽이 열리고,
  그 쪽의 대부분이 빈다 — 읽는 사람에게는 "네 쪽짜리 이력서" 로 보인다.
- 늘려야 한다면 먼저 `body.org` 에서 같은 분량을 덜어낸다. 판면(`preamble.org` 의
  `geometry`·`linespread`)은 이미 조여 놓았으므로 거기서 더 짜내지 않는다.

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
  경계(not used)를 섞지 않는다.
- 파생물(PDF)을 손으로 고치지 않는다. Org 를 고치고 다시 빌드한다.

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
