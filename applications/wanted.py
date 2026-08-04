#!/usr/bin/env python3
"""wanted.py — 원티드(wanted.co.kr) 공고를 손 안 대고 훑는다.

리멤버는 브라우저를 열고 체크박스를 눌러야 하지만, **원티드는 공개 JSON API 가 열려 있다.**
로그인·쿠키·브라우저 없이 목록과 본문이 다 나온다. 그래서 이 채널의 수집은 사람 손이 필요 없고,
스크립트 한 번이 곧 재현 가능한 스캔이다.

    ./wanted.py scan                      기본 직무 카테고리 전체를 긁는다 → JSON
    ./wanted.py scan --tags 1634,658      카테고리 지정 (id 는 `tags` 로 본다)
    ./wanted.py scan --query "AI Agent"   자유 검색어 (⚠ 아래 §검색어는 필터가 아니다)
    ./wanted.py tags                      직무 카테고리 id·이름·공고수 목록
    ./wanted.py detail 368678 375404      담당업무·자격요건 본문을 찍는다
    ./wanted.py pick scan.json            수집본에서 AI·에이전트 축만 거른다

`scan` 은 파일을 쓰기만 하고 판정하지 않는다. **판정은 사람이 담당업무를 읽고 한다**
(`AGENTS.md` §어떤 자리에 내는가). 결과를 옮겨 적는 곳은 `INBOX-WANTED.md` 다.

## API 지도 (2026-08-04 실측)

    GET /api/v4/jobs?country=kr&locations=all&years=-1&limit=100&offset=<n>
        &job_sort=job.latest_order&tag_type_ids=<직무id>&query=<검색어>
    GET /api/v4/jobs/<id>        → job.detail.{main_tasks,requirements,preferred_points}

- `limit=100` 까지 받는다. `links.next` 가 null 이 될 때까지 `offset` 을 민다.
- `tag_type_ids` 는 **여러 번 쓰면 OR** 다. `query` 와 같이 쓰면 교집합이다.
  ⚠ **한 요청에 5개까지다. 6개부터 422** 를 준다 — 그래서 `scan` 이 5개씩 잘라 여러 번 돈다.
- 직무 카테고리 id·이름은 어느 API 에도 없다. `wdlist` **HTML 안의 JSON 배열**에서 긁는다
  (`tags` 서브커맨드가 그것이다).
- `due_time` 은 대개 null 이다. **마감일이 없다는 뜻이지 상시 채용이라는 보장이 아니다.**

## 검색어는 필터가 아니다 (2026-08-04)

`query=AI Agent` 로 「네오사피엔스 Product Manager」가 나온다. 원티드 검색은 제목 일치가 아니라
**회사·태그·본문을 섞은 느슨한 매칭**이다. 리멤버에서 「검색창 자유텍스트가 필터로 안 먹힌다」는
것과 원인은 다르지만 결론은 같다 — **믿을 축은 직무 카테고리(`tag_type_ids`)이고, 검색어는
카테고리가 못 잡는 것을 줍는 보조축이다.** 그래서 `scan` 의 기본값은 카테고리다.

## 원티드는 뒤쪽 채널이다

`AGENTS.md` §탐색 채널 위계에서 원티드는 **회사 공식 보드·원본 ATS 뒤**다. 여기서 나온 것은
후보 흔적이고, 낼 때는 회사 채용홈에서 열림 여부와 JD 원문을 다시 확인한다. 원티드 자체 지원
(합격보상금 경로)과 「홈페이지 지원」 중 어느 쪽으로 낼지도 건별로 정한다.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.parse
import urllib.request

BASE = "https://www.wanted.co.kr"
UA = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"}

# 개발 축에서 GLG 가 설 수 있는 직무 카테고리. `./wanted.py tags` 로 확인·갱신한다.
DEFAULT_TAGS = [
    1634,   # 머신러닝 엔지니어
    10110,  # 소프트웨어 엔지니어
    872,    # 서버 개발자
    899,    # 파이썬 개발자
    655,    # 데이터 엔지니어
    1024,   # 데이터 사이언티스트
    674,    # DevOps / 시스템 관리자
    658,    # 임베디드 개발자
    900,    # C,C++ 개발자
]

# 축에 걸리는 말. 제목만으로 판정하지 않는다 — 1차 거름망일 뿐이다.
# ⚠ 짧은 약어는 반드시 경계를 준다. 경계 없는 `AX` 는 「AXI Bus 설계」를 물어 온다(2026-08-04).
AXIS = re.compile(
    r"(\bAI\b|\bLLM\w*|\bVLM\b|\bML\b|\bMLOps\b|\bLLMOps\b|\bRAG\b|에이전트|\bAgent\w*"
    r"|생성형|\bGenAI\b|인공지능|Forward Deployed|\bFDE\b|\bAX\b|\bMCP\b)",
    re.I,
)
# 같은 말이 붙어도 보직이 아닌 것.
NOT_AXIS = re.compile(
    r"(마케|영업|디자이너|기획자|PM\b|PO\b|인사|회계|세일즈|Sales|Recruit|강사|편집|크리에이터"
    r"|컨설턴트|매니저|Manager|Product Manager)",
    re.I,
)


def get(url: str, tries: int = 3):
    for n in range(tries):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=25) as r:
                return json.load(r)
        except Exception as e:  # 네트워크는 흔들린다. 조용히 죽지 않는다.
            if n == tries - 1:
                print(f"  ! {e} — {url}", file=sys.stderr)
                return None
            time.sleep(1.5 * (n + 1))


TAGS_PER_CALL = 5  # 6개부터 422. 실측값이다.


def scan(tags: list[int], query: str | None, cap: int) -> dict[int, dict]:
    found: dict[int, dict] = {}
    chunks = [tags[i:i + TAGS_PER_CALL] for i in range(0, len(tags), TAGS_PER_CALL)] or [[]]
    for chunk in chunks:
        print(f"  · 카테고리 {chunk}", file=sys.stderr)
        _scan_one(chunk, query, cap, found)
    return found


def _scan_one(tags: list[int], query: str | None, cap: int, found: dict[int, dict]) -> None:
    params = [("country", "kr"), ("locations", "all"), ("years", "-1"),
              ("job_sort", "job.latest_order"), ("limit", "100")]
    params += [("tag_type_ids", str(t)) for t in tags]
    if query:
        params.append(("query", query))
    offset = 0
    while offset < cap:
        url = f"{BASE}/api/v4/jobs?" + urllib.parse.urlencode(params + [("offset", str(offset))])
        d = get(url)
        if not d or not d.get("data"):
            break
        for j in d["data"]:
            addr = j.get("address") or {}
            found[j["id"]] = {
                "id": j["id"],
                "company": j["company"]["name"],
                "position": j["position"],
                "annual": f"{j.get('annual_from')}-{j.get('annual_to')}",
                "location": f"{addr.get('location', '')} {addr.get('district', '')}".strip(),
                "due": j.get("due_time"),
                "url": f"{BASE}/wd/{j['id']}",
            }
        print(f"  offset {offset:>4} → 누적 {len(found)}", file=sys.stderr)
        if not (d.get("links") or {}).get("next"):
            break
        offset += 100
        time.sleep(0.3)


def tags_map() -> dict[int, tuple[str, int]]:
    """직무 카테고리 id·이름·공고수. wdlist HTML 안의 JSON 배열에서 긁는다."""
    req = urllib.request.Request(f"{BASE}/wdlist/518", headers={"User-Agent": UA["User-Agent"]})
    with urllib.request.urlopen(req, timeout=25) as r:
        html = r.read().decode("utf-8", "replace")
    pat = re.compile(r'\{"id":(\d+),"image":"[^"]*","title":"([^"]+)","counts":\{"job":(\d+),')
    return {int(i): (t, int(c)) for i, t, c in pat.findall(html)}


def detail(job_id: int) -> dict | None:
    d = get(f"{BASE}/api/v4/jobs/{job_id}")
    if not d:
        return None
    j = d["job"]
    de = j.get("detail") or {}
    return {
        "id": job_id,
        "company": j["company"]["name"],
        "position": j.get("position") or de.get("position"),
        "main_tasks": de.get("main_tasks", ""),
        "requirements": de.get("requirements", ""),
        "preferred": de.get("preferred_points", ""),
        "due": j.get("due_time"),
        "url": f"{BASE}/wd/{job_id}",
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("scan", help="목록 수집 → JSON")
    s.add_argument("--tags", default=",".join(str(t) for t in DEFAULT_TAGS))
    s.add_argument("--query", default=None)
    s.add_argument("--cap", type=int, default=1000, help="offset 상한 (기본 1000)")
    s.add_argument("--out", default="wanted-scan.json")

    sub.add_parser("tags", help="직무 카테고리 id·이름·공고수")

    d = sub.add_parser("detail", help="담당업무·자격요건 본문")
    d.add_argument("ids", nargs="+", type=int)

    p = sub.add_parser("pick", help="수집본에서 AI·에이전트 축만 거른다 (1차 거름망)")
    p.add_argument("path")
    p.add_argument("--min-annual", type=int, default=0, help="경력 상한이 이 값 미만인 건은 뺀다")

    a = ap.parse_args()

    if a.cmd == "tags":
        for i, (t, c) in sorted(tags_map().items(), key=lambda x: -x[1][1])[:60]:
            print(f"{i:>6}  {t:<24} {c:>5}건")
        return 0

    if a.cmd == "scan":
        tags = [int(t) for t in a.tags.split(",") if t.strip()]
        print(f"카테고리 {tags}" + (f" · 검색어 {a.query!r}" if a.query else ""), file=sys.stderr)
        found = scan(tags, a.query, a.cap)
        with open(a.out, "w", encoding="utf-8") as f:
            json.dump(sorted(found.values(), key=lambda x: x["id"]), f, ensure_ascii=False, indent=1)
        print(f"{len(found)}건 → {a.out}")
        return 0

    if a.cmd == "detail":
        for i in a.ids:
            v = detail(i)
            if not v:
                continue
            print("=" * 76)
            print(f"{v['id']}  {v['company']} | {v['position']} | 마감 {v['due']}")
            print(v["url"])
            print("\n[담당업무]\n" + v["main_tasks"])
            print("\n[자격요건]\n" + v["requirements"])
        return 0

    if a.cmd == "pick":
        rows = json.load(open(a.path, encoding="utf-8"))
        hits = []
        for r in rows:
            t = r["position"]
            if not AXIS.search(t) or NOT_AXIS.search(t):
                continue
            try:
                top = int(r["annual"].split("-")[1])
            except (ValueError, IndexError):
                top = 0
            if top < a.min_annual:
                continue
            hits.append(r)
        hits.sort(key=lambda x: (x["company"], x["position"]))
        for r in hits:
            print(f"{r['id']}\t{r['company']}\t{r['position']}\t{r['annual']}\t{r['location']}")
        print(f"\n{len(hits)} / {len(rows)}건 — ⚠ 제목 거름망이다. 담당업무는 `detail` 로 읽는다.",
              file=sys.stderr)
        return 0

    return 1


if __name__ == "__main__":
    raise SystemExit(main())
