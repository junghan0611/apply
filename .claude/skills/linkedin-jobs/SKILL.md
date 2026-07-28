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

```text
exa-search로 "Forward Deployed Engineer hiring Korea"를 검색하고
linkedin.com/posts 도메인을 포함한다. 실행 경로는 활성 하네스의 exa-search 스킬을 따른다.
```

`ljobs.py`는 LinkedIn의 **문서화되지 않은 공개 guest endpoint**를 읽는 best-effort 도구다.
LinkedIn과 제휴·승인된 API가 아니며 마크업 변경이나 403/999로 언제든 깨질 수 있다. 로그인
쿠키·개인정보·지원 행위는 다루지 않고, 속도 제한과 해당 서비스의 이용 조건을 지킨다.

## ljobs.py

```bash
{baseDir}/ljobs.py search <keywords> [옵션]
{baseDir}/ljobs.py enrich <병합.json> -o <상세.json> --keep-body
{baseDir}/ljobs.py detail <jobId|공고URL> ...
{baseDir}/ljobs.py rank <상세.json> --must ... --plus ... --minus ... --explain
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
| `--loc` | **클라이언트측** 지역 화이트리스트(정규식). 소프트 — 확실히 어긋난 것만 자른다 |
| `--loc-strict` | `--loc` 를 하드 컷으로. 미확인도 자른다 |
| `--loc-exclude` | 같은 축의 블랙리스트 |
| `-w, --worksite` | 본문에서 세부 근무지만 뽑는다 (본문 전문은 출력 안 함) |
| `-d, --detail` | 본문까지 같이 (공고당 1 요청 추가 — 느리다) |
| `--json` | rank 로 넘길 때 |

출력 TSV 열: `score  id  posted  company  title  location  worksite  url`.

## 지역이 첫 축이다 — 여기서 제일 많이 틀린다

**`-l/--location` 으로 좁히지 마라.** LinkedIn 서버 필터는 광역으로 번진다. 실측:

| 준 값 | 실제로 온 것 |
|---|---|
| `-l Seongnam` | 10건 중 8건이 서울 (송파·강남…) |
| `-l Pangyo` | 화성·천안·아산·송도 — 판교 0건 |
| `-l "Gyeonggi-do, South Korea"` | 화성 6 · 안산 3 · 이천 1 |

그래서 **넓게 긁고 좁게 거른다**. 검색은 `-l "South Korea"` 로 두고 `--loc` 로 자른다:

```bash
./ljobs.py search "Engineer" -l "South Korea" -n 6 --posted month \
  --loc "성남|판교|Seongnam|Pangyo|분당|Bundang"
```

`--loc` 를 켜면 근무지를 알아야 하므로 **후보의 본문을 전부 받는다**(목표 건수의 4배를
긁고 자른다). 6건 얻는 데 30건 본문 요청 ≈ 40초. 지역이 기준이면 치를 값이다.

### 지역 필터는 전부 옵셔널이고, 기본은 소프트다

**근무지 확인율은 30% 남짓이다.** 나머지 70% 를 "모르니까 탈락"으로 처리하면 조건에 맞는
공고를 대량으로 놓친다. 놓치는 쪽이 섞이는 쪽보다 훨씬 비싸다 — 섞인 건 눈으로 걸러지지만
안 나온 건 존재를 모른다. 그래서:

| | 기본 동작 |
|---|---|
| 아무 것도 안 주면 | **전혀 안 거른다** |
| `--loc` | **확실히 어긋난 것만** 자른다. 근무지 미확인·카드 뭉뚱그림은 살린다 |
| `--loc-strict` | 그때만 하드 컷 (놓칠 각오로) |
| `rank --near` | 가점/감점만. **미확인은 건드리지 않는다** |
| `--penalize-unknown` | 그때만 미확인 -2 |
| `--require-worksite` | 그때만 미확인 제거 |

`--loc "판교|성남"` 실측: 부산·대구처럼 **확인된 불일치**는 자르고, `Seoul, Seoul` 처럼
판단할 수 없는 것은 남긴다. `--near` 도 마찬가지라 카드에 `Seongnam` 이 찍힌 DEEPX·42dot·
Rebellions 가 본문 미확인인 채로 상위에 남는다.

### 근무지는 카드가 아니라 본문에서 온다

카드의 `location` 은 공고 등록자가 넣은 값이라 `Seoul, Seoul, South Korea` 로 뭉개지기도
하고 `Songpa-gu, Seoul` 처럼 구까지 나오기도 한다 — **믿을 수 없다.** `-w` 를 켜면 본문에서
근무지를 건지고 근거를 함께 남긴다.

| 표기 | 뜻 |
|---|---|
| `강남역` (근거 `label`) | 「근무지」류 라벨 옆에서 확인 — 가장 믿을 만하다 |
| `강남` (근거 `body`) | 본문 어딘가의 지명 |
| `remote?` | 근무지 라벨 옆에 원격 표기 |
| `?(Seongnam)` | 본문엔 없지만 **카드가 구체적이다** — 판교권 판단에 충분 |
| `?(서울·구미상)` | 카드가 `Seoul, Seoul, South Korea` — 구를 모른다 |
| `?(원문빈칸)` | 라벨은 있는데 **원문에 값이 없다** — 파싱 실패가 아니다 |
| `?` | 단서 없음 |

`?` 를 아는 것처럼 올리지 않는다. rank 에서 미확인은 감점된다.

카드 힌트를 따로 내는 이유: 본문 근무지가 없다고 `?` 로 뭉치면 **DEEPX·42dot·Rebellions
처럼 카드에 `Seongnam, Gyeonggi` 가 찍힌 판교권 공고를 통째로 놓친다.** `--require-worksite`
는 본문 확인만 남기므로 이들을 잘라낸다 — 지역으로 좁힐 때는 `--near` 를 쓰고
`--require-worksite` 는 정말 본문 근거가 필요할 때만 쓴다(`--near` 는 카드도 본다).

**함정 둘, 둘 다 실물에서 물렸다.**

1. 라벨이 한 본문에 여러 번 나오고 **앞쪽이 비어 있을 수 있다.** Coxwave 는 첫 「근무지」가
   빈칸이고 뒤쪽 두 번째에 `서울 영등포구 여의대방로69길 23 10층` 이 있었다. 전부 순회한다.
2. 한국어 지명은 다른 낱말에 통째로 박힌다 — 무**신사**, **신사**업, **분당** 처리량,
   **고양**이, **시청**자, **일산**화탄소, **성수**기. 경계 없이 찾으면 무신사 공고의
   근무지가 "신사"가 된다. `PLACES`(조사 허용·한글 경계)와 `WEAK`(행정 접미사 필수)로
   가른다. 사전을 늘릴 때는 `ljobs.py` 의 두 목록 중 **어느 쪽인지 판단**해서 넣는다.

원격도 같은 함정이다. 복지 문단의 "remote-friendly" 를 근무지로 읽으면 Cohere 서울
공고가 원격으로 둔갑한다 — 그래서 원격은 **근무지 라벨 옆에 있을 때만** 인정한다.

### criteria

`detail` 은 LinkedIn 이 붙인 메타도 같이 낸다 — `Seniority level`, `Employment type`,
`Job function`, `Industries`. 연차 요건의 1차 신호로 쓰되, **본문의 「경력 3~7년」 같은
원문 표현이 항상 우선**이다. `Seniority level: Not Applicable` 인 공고가 흔하다.

### 한 판의 표준 흐름

본문 요청이 비용의 대부분이다. 쿼리마다 `-w/-d`를 켜면 중복 공고의 본문을 매번 다시 받는다.
따라서 **카드 수집 → ID 중복 제거 → enrich 한 번 → 본문을 포함해 rank** 순서로 간다.

```bash
cd {baseDir}
mkdir -p /tmp/ljobs
for q in "AI Engineer" "AI 엔지니어" "LLM Engineer" "Forward Deployed Engineer" \
         "Platform Engineer" "Embedded Software Engineer" "Developer Experience"; do
  ./ljobs.py search "$q" -l "South Korea" -n 20 --posted month --json \
    > "/tmp/ljobs/$(echo "$q" | tr ' ' '_').json"
done

python3 - <<'PY'
import glob, json
rows = {}
for path in glob.glob('/tmp/ljobs/*.json'):
    for row in json.load(open(path)):
        rows.setdefault(row['id'] or row['url'], row)
json.dump(list(rows.values()), open('/tmp/ljobs/cards.json', 'w'), ensure_ascii=False)
PY

./ljobs.py enrich /tmp/ljobs/cards.json -o /tmp/ljobs/detail.json --keep-body
./ljobs.py rank /tmp/ljobs/detail.json --explain \
  --near 판교 성남 분당 강남 서초 역삼 \
  --plus agent llm rag platform infrastructure "developer experience" emacs nix embedded firmware \
  --minus intern "신입" junior "0~2년" freelance
```

`enrich -o`는 20건마다 원자적으로 중간 저장하므로 중단 후 같은 명령을 다시 실행할 수 있다.
`--keep-body`가 없으면 rank는 제목·회사·위치 위주로만 보게 된다.

### rank 의 지역 축

| 플래그 | 효과 |
|---|---|
| `--near <지명…>` | 맞으면 **+6**. **확인된** 근무지가 어긋나면 **-4**. 미확인은 무변화 |
| `--penalize-unknown` | 근무지 미확인에 -2 (기본은 감점 없음) |
| `--require-worksite` | 본문 근무지가 확인된 공고만. 카드 지명까지 잘리니 보통은 불필요 |

`--minus` 에 걸린 공고에는 **지역 가점을 주지 않는다.** 직무가 안 맞는 자리는 집 앞이어도
안 맞는다. (이 규칙이 없으면 `--near 강남` 하나로 인턴 공고가 상위로 올라온다.)

`rank`는 대충 훑는 1차 기계 판단이다. 짧은 영문 키워드는 낱말 경계로 매칭하므로 `intern`이
`internal`에 걸리지 않는다. `--explain`은 각 점수의 plus/minus/title/near 근거를 다음 줄에,
`--json`은 `score_reasons` 배열로 남긴다. 그래도 상위 후보는 반드시 `detail`과 원문으로
**연차 요건·비자·언어·근무지**를 사람이 확인한 다음 GLG에게 올린다.

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

다섯 컷 중 어느 것으로도 안 덮이면 `resume/AGENTS.md` §「새 타깃 컷 만드는 법」을 따른다.
**공고를 찾았다고 컷을 임의로 늘리지 않는다.** 사실은 한 벌이고 타깃은 모듈 선택·순서와
공개 증거 입구를 바꾼다. 분량은 2쪽 우선, 증거가 남을 때 3쪽이다.

## 넘기는 형식 (브라우저 세션이 그대로 먹을 수 있게)

근무지를 **둘째 줄에 못 박는다.** 지역이 기준의 첫 축인데 목록 어디에도 안 적히면
브라우저 축이 기준 밖 공고에 지원하게 된다.

```
1. Coxwave — [AX AgentX] 데이터 엔지니어 (RAG/LLM Pipeline)  · 07-08
   근무지: 서울 영등포구 여의대방로69길 23 10층   [본문 라벨 확인]
   https://www.linkedin.com/jobs/view/4438204315
   붙일 것: KimJunghan_Resume_AI_Engineer.pdf
   요건(원문): 경력 (3~7년) · 정규직 · 자율출근제, 주1회 재택
   주의: 자체 폼 추정 — Easy Apply 아님

2. Harper — Founding Engineer, AI Agent  · 07-27
   근무지: ?(원문 빈칸)  ← 브라우저에서 확인 필요
   ...
```

근무지가 `?` 면 **`?` 라고 적어 올린다.** 추정으로 채우지 않는다.

### ⚠ 공고 제목을 줄이지 않는다 (2026-07-28 실물 사고)

한국 공고는 **제목 괄호 안에 결정적인 조건을 넣는다.** 연차·고용형태·부서가 거기 있다.

```
원제목  [AI Transformation Dept.] AX Governance Specialist (3년 이상 / 계약직)
줄인 것  AX Governance Specialist (3년+)          ← 「계약직」이 사라졌다
```

이 한 줄 때문에 **계약직 공고가 「티어1 · 권고 확정」 표에 정규직처럼 앉아 있었다.**
데이터는 멀쩡했다 — `search` 가 제목을 온전히 준다. 목록으로 옮겨 적으면서 날린 것이다.

- **원제목을 그대로 옮긴다.** 길다고 줄이지 않는다.
- 줄여야 하면 **괄호 안의 조건은 남긴다.**
- `rank`/`search` TSV 의 **고용형태 칸**(`⚠Contract` 등)을 목록에 같이 옮긴다.

### ⚠ 「확정」이라고 적으려면 본문을 읽었어야 한다

같은 날 `Staff Cloud Backend Engineer` 가 티어1에 올랐다. **제목은 정확했다.** 다만 본문이
`time-series · OLAP/OLTP · Cassandra/Druid/Pinot` 데이터베이스 전문직이었고, 그건 제목 어디에도
없었다. 카드만 보고 「권고 확정」으로 올린 것이다.

**제목은 직무를 말해 주지 않는다.** 「확정」 묶음에 넣기 전에 `enrich --keep-body` 또는
`detail` 로 본문을 읽는다. 안 읽었으면 **「본문 미확인」이라고 적는다** — 그것도 정직한 값이다.

## 계약

- **로그인 하지 않는다.** guest 엔드포인트만 읽는다. 쿠키·세션·`li_at` 을 이 스크립트에
  절대 넣지 않는다. 계정 리스크는 브라우저 축이 지고, 이 축은 지지 않는다.
- **연락처를 이 축에서 뿌리지 않는다.** 지원 행위는 전부 브라우저 세션 소관이다.
- `--delay`는 기본 0.7초이고 CLI가 0.2초 미만을 거부한다. 429를 맞으면 판이 끝난다.
- 빈 결과가 `없음`은 아니다. 원인은 대개 둘이다.
  1. **쿼리가 길다.** guest API 는 구를 통째로 AND 로 먹는다 —
     `"Platform Engineer developer tools"` 0건, `"Platform Engineer"` 20건. 두 낱말까지만.
  2. **키워드가 영문이다.** 한국 공고는 국문 표제가 많다 — `"AI 엔지니어"`, `"백엔드"`,
     `"플랫폼 엔지니어"` 로 한 번 더 돌린다. 그래도 없으면 exa 축을 본다.
- 공고 본문을 요약해서 GLG 에게 올릴 때 **연차·비자·근무지는 원문 표현 그대로** 옮긴다.
  여기서 의역하면 잘못 지원한다.
- **모르는 근무지를 채우지 않는다.** `?` 는 `?` 로 올린다. 지역이 기준의 첫 축이라
  여기서 추정하면 기준 밖 공고에 지원하게 된다.
- **모르는 근무지를 버리지도 않는다.** 확인율이 30% 라 미확인을 탈락시키면 놓치는 쪽이
  훨씬 크다. `?` 는 지우는 게 아니라 **`?` 라고 적어서 올리고 브라우저에서 확인**한다.
  지역으로 자르는 플래그(`--loc-strict`, `--require-worksite`, `--penalize-unknown`)는
  GLG 가 명시적으로 요구할 때만 쓴다.

## 상태와 검사

2026-07-28 검증 — search / enrich / detail / rank 4개 서브커맨드 실물 동작.

```bash
{baseDir}/test_ljobs.py      # 57 케이스, 네트워크 없이 1초
python3 -m py_compile {baseDir}/ljobs.py {baseDir}/test_ljobs.py
```

지명 경계·근무지 추출뿐 아니라 키워드 낱말 경계, 지역 가감점, 고용형태 표시, 빈 응답의 `unknown` 판정,
원자적 중간 저장을 고정한다. **`PLACES` / `WEAK` / `_SUFFIX` / `LABEL_RE` 또는 score를
건드렸으면 반드시 돌린다.** 사전을 한 줄
늘리는 것만으로 조용히 오탐이 생긴다 — 실제로 `가산`을 넣자 "가산점"이, `동작`을 넣자
"동작 방식"이 근무지가 됐다. 케이스는 전부 실물 공고에서 물린 문장이다.

막혔을 때:

- guest API 가 HTTP 403/999 를 주거나 카드 0건이면 스크립트 탓이 아니다. exa 축으로
  갈아타고 GLG 에게 보고한다.
- 마크업이 바뀌면 고칠 곳은 셋뿐이다 — `parse_cards()` 의 카드 클래스명,
  `get_detail()` 의 `show-more-less-html__markup`, `parse_criteria()` 의
  `criteria-subheader`/`criteria-text`.
- `jobs/view/<id>` 직접 요청은 authwall 이고 JSON-LD 도 없다. 시도하지 마라.
  본문은 `jobs-guest/jobs/api/jobPosting/<id>` 에서만 온다.
- typeahead GEO API 는 비공개다(HTML 껍데기 반환). geoId 를 얻을 길이 없으니
  `--geo-id` 는 이미 아는 값이 있을 때만 쓴다.
