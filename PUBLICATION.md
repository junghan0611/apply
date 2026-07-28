# PUBLICATION.md — 나중에 공개할 때 읽는 문서

> **지금 할 일이 아니다.** 이 저장소는 전부 담는 비공개 작업면이고, 회사명 · 답변 · 제출본을
> 가리지 않는다. 여기 적힌 검열 규칙을 평소 작업에 끌어들이면 작업이 안 된다.
>
> 언젠가 GLG 가 "기록을 이렇게 했었다"를 공개하기로 **결정한 그때** 이 문서를 연다.
> 그전까지 루트 문서 · `NEXT.md` · 레인 `AGENTS.md` 는 이 문서를 참조하지 않는다.

## 결론 (그때가 오면)

Do **not** change `junghan0611/apply` from private to public in its current form.

The repository history contains real application records, company-specific answers, uploaded PDFs,
recommendation-path notes, and personally identifying fields. Deleting those paths on `main` does
not remove their blobs or earlier commits. GitHub visibility applies to the repository object
database, not only the current checkout.

The safe release is a **clean public history built from an allowlist**. If the public repository must
keep the name `apply`, first archive this remote under a new private name, then create a fresh public
repository. Never retain a “private branch” inside a public repository; public branches and old
objects are still public.

## Data classes

| Class | Examples | Public treatment |
|---|---|---|
| Public method | role contracts, search code/tests, generic pipeline design, redacted case study | allow |
| Public professional evidence | already-public GitHub/garden links and intentionally public résumé claims | explicit human review |
| Private operations | `applications/`, `NHN.md`, `nhn/`, `NEXT.md`, target/company decisions, ATS answers | deny |
| Secret / sensitive | credentials, phone, birth date, military status, raw customer data, consent choices | deny and rotate if ever committed |
| Third-party content | full scraped JDs, ATS HTML, company form schemas | do not republish without a clear right; describe the method instead |

## Initial public allowlist

The smallest useful collaboration kit is:

```text
README.md                            # 공개 독자를 상정해 쓴 문서
docs/case-study-2026-07-28.md        # 익명화된 협업 서사 — 현재 유일하게 그대로 나갈 수 있는 문서
.claude/skills/linkedin-jobs/ljobs.py
.claude/skills/linkedin-jobs/test_ljobs.py
scripts/check-public.sh
PUBLICATION.md                       # 공개 시 이 경고 블록은 걷어낸다
```

**그대로는 못 나가는 것 — 공개 시점에 다시 써야 한다:**

| 파일 | 왜 |
|---|---|
| `AGENTS.md` | 비공개 운영 문서다. 「추천 경로」 등 private 표식과 `nhn/` 레인이 그대로 있다. 공개용은 계약만 발췌해 새로 쓴다 |
| `.claude/skills/linkedin-jobs/SKILL.md` | 회사명이 예시로 박혀 있다(`DEEPX`, `Reflection AI Korea`, `딜리버리랩`). 예시를 익명화해야 한다 |
| `README.md` | `nhn/` 레인 행이 있다. 지울지 익명화할지 결정 |

`check-public.sh` 는 **회사명을 스캔하지 않는다.** 회사명 판정은 자동화하지 않았으니 §6 수동
검토에서 사람이 본다. 게이트 통과가 공개 승인이 아니라는 뜻이 여기에도 걸린다.

Possible second-stage additions after a separate fact/privacy review:

```text
resume/                              # contains personal career claims and contact routes
examples/applications/               # synthetic example only; never copy real applications/
```

`applications/`, `nhn/`, `NHN.md`, submitted PDFs, current `NEXT.md`, local settings, session JSONL,
and timeline snapshots are never part of the public export.

## Release procedure

1. **Freeze the private source.** Tagging is optional; record the private commit SHA in a private
   handoff. Do not put the SHA in a public document if commit messages disclose targets.
2. **Choose public name and license.** No license means others may read the code but have no granted
   reuse rights. This is a human decision before publication.
3. **Copy the allowlist into a new empty directory.** Do not copy `.git/`.
4. **Write a redacted case study.** Keep roles, decisions, failures, and measured outcomes; remove
   company names, application URLs, form answers, personal legal values, and full third-party JDs.
5. **Run the gate:**

   ```bash
   ./scripts/check-public.sh /path/to/public-export
   ```

6. **Manual review:**
   - `find` the entire tree;
   - read every Markdown/Org/text file;
   - inspect PDF metadata if any PDF is intentionally included;
   - search for absolute home paths, emails/phones not intended for publication, company targets,
     credentials, and copied JD prose;
   - verify all public links.
7. **Create fresh Git history** in the sanitized directory and push to a new public remote.
8. **Only after GitHub inspection** announce the repository.

## ⚠ 먼저 고쳐야 할 cross-repo 함정 — 전역 git 훅

`~/repos/gh/agent-config/git-hooks/_scan.sh` 는 **저장소 이름으로** 스캔 강도를 정한다.

```bash
case "$remote_bare" in
  *github.com[:/]junghan0611/openclaw-config|*github.com[:/]junghan0611/apply)
    echo "loose"   # 비밀만 검사. 신원 용어 차단은 끔.
```

`junghan0611/apply` 가 **PRIVATE 이라는 전제로** identity-term 차단을 꺼 둔 예외다. 그래서
지금 이 저장소는 회사명 · 연락처를 자유롭게 커밋할 수 있다 — 의도된 동작이다.

문제는 위 §결론이 권고하는 경로다. 현 remote 를 다른 private 이름으로 옮기고 **새 public
저장소를 `apply` 라는 이름으로** 만들면, 그 public 저장소가 이 `loose` 예외에 그대로 걸린다.
**공개 저장소인데 신원 용어 차단이 꺼진 채로 돌게 된다.**

따라서 공개 트랙을 열기 **전에** 순서가 있다:

1. `agent-config/git-hooks/_scan.sh` 의 `loose` 예외에서 `apply` 를 뺀다(또는 새 private
   이름으로 바꾼다).
2. `agent-config/git-hooks/README.md` 의 "Known private loose repos" 표를 같이 고친다.
3. 그다음에 public 저장소를 만든다.

이 순서를 건너뛰면 `check-public.sh` 가 통과해도 이후 커밋이 무방비다.

## Why filter-repo is not the default

`git filter-repo` can remove paths, but an allowlist is easier to reason about than a growing set of
forbidden names. This history also contains sensitive commit messages and several generations of a
private dossier, so path filtering alone is insufficient. A fresh public history makes the privacy
claim inspectable: what is not copied cannot leak through an old blob or reflog.

## Public case-study frame

The public story is not “agents applied to jobs automatically.” It is:

- one human defined the target, truth boundary, and irreversible-action gate;
- separate agents searched, wrote, operated a browser, and reviewed the system;
- shared files, not hidden shared memory, carried state between roles;
- a single fact corpus generated different role views;
- visible URLs, tests, and build commands made claims challengeable;
- the rushed run exposed real gaps: stale record closure, default-artifact contamination, ATS
  variance, location uncertainty, and ranking false positives;
- the post-run reviewer turned those gaps into tests and contracts.

That is the reusable artifact.
