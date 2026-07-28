# apply — evidence-first, human-governed application operations

`apply` is a working system for turning one verified career corpus into job-specific documents,
searching public job listings, submitting through heterogeneous ATS forms, and preserving exactly
what was sent.

The goal is not to automate judgment or mass-submit generic résumés. The goal is to make every
claim traceable, every target deliberate, every submission recoverable, and every irreversible
browser action human-owned.

> **Repository status:** this is a **private operations repository** and stays that way while the
> work is live. It deliberately keeps company names, application answers, and submitted artifacts —
> filtering them during the work would make the work impossible.
>
> This README is written as if for an eventual public reader, because the intended story is
> "here is how the record was kept." That publication is a **later, separate track**; nothing in
> day-to-day work should be shaped by it. When that day comes, read
> [`PUBLICATION.md`](PUBLICATION.md) — the current Git history is never the thing that gets published.

## The loop

```text
public job cards/posts
        │
        ▼
search + location evidence ──► ranked candidates ──► human chooses one role
                                                        │
verified fact corpus ──► role-specific résumé cut ◄─────┘
        │                         │
        └─────────────────────────┴──► ATS form + human final submit
                                           │
                                           ▼
                              immutable submitted files + ledger
```

The boundaries are as important as the arrows:

- Search does not log in or submit.
- A résumé cut may reorder and select facts, but does not invent them.
- Public adjacent work is not presented as proof of a private deployment.
- Agents may prepare a form; a human owns personal fields, consent, and the final Submit action.
- The launcher keeps changing, so each application stores a copy of the files actually uploaded.

## Repository map

| Lane | Path | Responsibility | SSOT |
|---|---|---|---|
| Discovery | `.claude/skills/linkedin-jobs/` | public guest search, detail enrichment, location evidence, explainable ranking | `SKILL.md` |
| Document launcher | `resume/` | one fact corpus → role-specific résumé cuts | `resume/body.org` |
| Submission operations | `applications/` | JD snapshot, form answers, uploaded-file snapshot, outcome ledger | `applications/LEDGER.md` |
| Dossier launcher | `dossier/` | competency statement, portfolio, and evidence package from one org corpus | `dossier/AGENTS.md` |
| Handoff | `NEXT.md` | the next concrete move, not a backlog or history archive | `NEXT.md` |

## Multi-agent collaboration

This project separates roles instead of asking one agent to search, write, browse, and judge at
once.

| Role | Owns | Must hand off |
|---|---|---|
| Explorer | candidate collection, source text, location confidence, suggested résumé cut | URL, quoted constraints, unknowns, ranking reasons |
| Document steward | factual selection, role vocabulary, public evidence routes, reproducible builds | exact artifact path and verification result |
| Browser operator | ATS observation, field preparation, upload mechanics | unresolved personal fields and the final-submit gate |
| Meta reviewer | cross-lane contracts, contradictions, public/private boundary, next-session handoff | gaps and durable fixes, not another submission lane |
| Human | target choice, truthful personal values, consent, final submission | the final decision and any private value that must not be stored |

This is role coordination, not an agent hierarchy. Parallel work succeeds only when each lane owns a
different artifact and reports checkpoints rather than silently editing another lane's SSOT.

## One morning as a systems test

On 2026-07-28 the workspace went from no general submission lane to an end-to-end operating loop:

- 418 deduplicated job cards collected across Korean/English queries;
- location evidence kept three-valued instead of treating “unknown” as “wrong”;
- six résumé cuts generated from one fact source;
- four actual applications submitted through two ATS families;
- uploaded artifacts copied into per-application snapshots;
- one potentially serious release error caught: a job-specific résumé was still configured as the
  LinkedIn default and could have leaked into unrelated applications.

The useful outcome is not the application count. It is that failures became contracts: default-file
preflight, visible evidence links, browser-only personal values, per-ATS observations, and a ledger
that can be checked against each application record.

## Verification

```bash
# Search/ranking logic — network-free regression suite
.claude/skills/linkedin-jobs/test_ljobs.py
python3 -m py_compile \
  .claude/skills/linkedin-jobs/ljobs.py \
  .claude/skills/linkedin-jobs/test_ljobs.py

# Application ledger ↔ target record ↔ uploaded snapshot
applications/check.py

# Rebuild and inspect all résumé cuts
(cd resume && ./run.sh all)

# Before any public extraction
./scripts/check-public.sh /path/to/public-export
```

`linkedin-jobs` uses an undocumented public LinkedIn guest endpoint. It is best-effort, rate-limited,
uses no login cookies, and may break when LinkedIn changes markup. See its `SKILL.md` for the exact
contract and limitations.

## Privacy and publication

The private workspace intentionally preserves company names, application answers, and submitted
artifacts. That is incompatible with making the current Git history public. A `.gitignore` change or
file deletion does not erase old commits.

The public release therefore follows three rules:

1. Export from an explicit allowlist into a clean tree.
2. Start public history from that sanitized tree; do not expose this private object database.
3. Run the publication gate and manually review the result before creating a public remote.

See [`PUBLICATION.md`](PUBLICATION.md). License selection and the final public repository name remain
human decisions.
