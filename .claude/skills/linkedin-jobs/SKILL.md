---
name: linkedin-jobs
description: "링크드인 공고를 로그인 없이 검색·추리는 별동대 면. 브라우저(제출)와 분리된 탐색 축이다 — `ljobs.py` 로 LinkedIn guest API 를 직접 긁어 공고 목록·본문·랭킹을 뽑고, exa-search 로는 guest API 가 못 잡는 '사람이 올린 채용 포스트'를 잡는다. 결과는 `resume/targets/` 여섯 컷 중 어느 PDF 를 붙일지까지 결정한다. 트리거: '링크드인 공고', '지원할 곳 찾아', '채용 검색', 'job search', 'linkedin jobs', '공고 추려', '어디 낼까', 'ljobs', '오늘 지원', 'AI Engineer 공고', '리모트 공고', '공고 본문 뽑아'."
user_invocable: true
---

# linkedin-jobs — 낼 곳을 찾아 좁히는 면

제출은 브라우저가 한다. 이 스킬은 **그 앞단** — 어디에 낼지 찾고, 읽고, 순위를 매겨
`resume/build/` 의 어느 컷을 붙일지까지 정해서 넘긴다. 브라우저 세션은 목록을 스크롤할
필요가 없다. 공고 URL 과 붙일 PDF 이름만 받으면 된다.

## 두 축을 같이 쓴다 (겹치지 않는다)

| 축 | 잡는 것 | 못 잡는 것 |
|---|---|---|
| `ljobs.py` (guest API) | 정식 공고 `linkedin.com/jobs/view/<id>` — 필터·페이징·본문 전문 | 개인 피드에 올라온 채용 글 |
| `exa-search` | `linkedin.com/posts/...` 채용 포스트 — 리크루터·현업자가 직접 올린 자리 | 필터·최신순·전수 |

한국 시장은 **포스트 쪽에만 있는 자리가 많다**(예: Reflection AI Korea FDE, 딜리버리랩 AX).
그래서 한 판에 둘 다 돌린다. 하나만 돌리면 절반을 놓친다.

```bash
# 축 2 — 포스트에서 줍기 (병렬 안전)
~/.claude/skills/exa-search/search.js "Forward Deployed Engineer hiring Korea 2026" \
  -n 8 --type fast --include-domains linkedin.com
```

## ljobs.py

```bash
{baseDir}/ljobs.py search <keywords> [옵션]
{baseDir}/ljobs.py detail <jobId|공고URL> ...
{baseDir}/ljobs.py rank <search --json 결과> --must ... --plus ... --minus ...
```

의존성 0 (Python stdlib). 로그인·쿠키·API 키 없음. 공개 guest 엔드포인트만 읽는다.

### search 옵션

| 플래그 | 값 |
|---|---|
| `-l, --location` | `"South Korea"`, `"Seoul"`, `"United States"` … |
| `--geo-id` | LinkedIn geoId (location 보다 정확할 때) |
| `-n, --limit` | 기본 25. 10 단위로 페이징한다 |
| `--posted` | `24h` \| `week`(기본) \| `month` \| `any` |
| `--workplace` | `remote` `hybrid` `onsite` (복수 가능) |
| `--experience` | `entry` `associate` `mid-senior` `director` `executive` |
| `--job-type` | `full-time` `contract` `part-time` … |
| `--easy-apply` | Easy Apply 만 |
| `--sort` | `relevant`(기본) \| `recent` |
| `-d, --detail` | 본문까지 같이 (공고당 1 요청 추가 — 느리다) |
| `--json` | rank 로 넘길 때 |

출력 TSV 열: `score  id  posted  company  title  location  url`.

### 한 판의 표준 흐름

```bash
cd {baseDir}
./ljobs.py search "AI Engineer" -l "South Korea" -n 40 --posted week --json > /tmp/a.json
./ljobs.py search "Forward Deployed Engineer" -l "South Korea" -n 20 --posted month --json > /tmp/b.json
./ljobs.py search "AI Engineer" --workplace remote -n 40 --posted week --json > /tmp/c.json

python3 -c "import json,sys;
r={}; [r.setdefault(j['id'],j) for f in ['/tmp/a.json','/tmp/b.json','/tmp/c.json'] for j in json.load(open(f))];
json.dump(list(r.values()),open('/tmp/all.json','w'),ensure_ascii=False)"

./ljobs.py rank /tmp/all.json \
  --plus agent llm rag platform infrastructure "developer experience" emacs nix embedded firmware \
  --minus intern "신입" "junior" "0~2년" freelance
```

`rank` 는 대충 훑는 1차 체이지 판단이 아니다. 상위 후보는 반드시 `detail` 로 본문을 읽고
**연차 요건·비자·언어·근무지**를 눈으로 확인한 다음 GLG 에게 올린다.

## 컷 배정 — 찾았으면 여기까지 정해서 넘긴다

`resume/build/` 여섯 장. 공고 하나당 하나를 지목한다.

| 공고 성격 | 붙일 PDF |
|---|---|
| LLM/에이전트/RAG 제품 | `KimJunghan_Resume_AI_Engineer.pdf` |
| 고객사 투입·솔루션 딜리버리·FDE | `..._Forward_Deployed_Engineer.pdf` |
| 펌웨어·IoT·디바이스 | `..._Embedded_Software_Engineer.pdf` |
| 사내 도구·플랫폼·DX·툴체인 | `..._Developer_Experience_Engineer.pdf` |
| 일반 백엔드/풀스택 | `..._Software_Engineer.pdf` |
| 애매하거나 첫 접촉 | `KimJunghan_Resume.pdf` (베이스) |

다섯 컷 중 어느 것으로도 안 덮이면 새 컷을 뽑는다 — `resume/AGENTS.md` §「새 타깃 컷
만드는 법」6단계, 5분. **공고를 찾았다고 컷을 임의로 늘리지 않는다.** 분량 계약은 3쪽이다.

## 넘기는 형식 (브라우저 세션이 그대로 먹을 수 있게)

```
1. Reflection AI — Forward Deployed Engineer (Seoul, 07-16)
   https://www.linkedin.com/jobs/view/4432478961
   붙일 것: KimJunghan_Resume_Forward_Deployed_Engineer.pdf
   근거: 고객 투입형·초기 팀·글로벌 협업. 연차 요건 없음, 한국어/영어.
   주의: Easy Apply 아님 — 자체 폼. 커버레터 칸 있음.
```

## 계약

- **로그인 하지 않는다.** guest 엔드포인트만 읽는다. 쿠키·세션·`li_at` 을 이 스크립트에
  절대 넣지 않는다. 계정 리스크는 브라우저 축이 지고, 이 축은 지지 않는다.
- **연락처를 이 축에서 뿌리지 않는다.** 지원 행위는 전부 브라우저 세션 소관이다.
- `--delay` 를 0 으로 내리지 않는다(기본 0.7s). 429 를 맞으면 판이 끝난다.
- 빈 결과가 `없음`은 아니다. 원인은 대개 둘이다.
  1. **쿼리가 길다.** guest API 는 구를 통째로 AND 로 먹는다 —
     `"Platform Engineer developer tools"` 0건, `"Platform Engineer"` 20건. 두 낱말까지만.
  2. **키워드가 영문이다.** 한국 공고는 국문 표제가 많다 — `"AI 엔지니어"`, `"백엔드"`,
     `"플랫폼 엔지니어"` 로 한 번 더 돌린다. 그래도 없으면 exa 축을 본다.
- 공고 본문을 요약해서 GLG 에게 올릴 때 **연차·비자·근무지는 원문 표현 그대로** 옮긴다.
  여기서 의역하면 잘못 지원한다.

## 상태

`ljobs.py` 는 2026-07-28 기준 동작 확인 — search / detail / rank 3 개 서브커맨드 전부.
guest API 가 막히면(HTTP 403/999, 카드 0건) 스크립트 탓이 아니다. exa 축으로 갈아타고
GLG 에게 보고한다. LinkedIn 이 마크업을 바꾸면 `parse_cards()` 의 클래스명
(`base-search-card__title` / `__subtitle` / `job-search-card__location`)만 고치면 된다.
