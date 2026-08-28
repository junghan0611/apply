# apply — evidence-first, human-governed application operations

`apply` is a working system for turning one verified career corpus into job-specific documents,
searching public job listings, submitting through heterogeneous ATS forms, and preserving exactly
what was sent.

The goal is not to automate judgment or mass-submit generic résumés. The goal is to make every
claim traceable, every target deliberate, every submission recoverable, and every irreversible
browser action human-owned.

> **Repository status:** public. This began as a private operations repository and ran that way
> through every application it records. In August 2026 its whole history — every commit, not a
> squashed snapshot — was rewritten to remove what could not be published, and the result is what
> you are reading.
>
> So the record is real but not complete, and the gap is deliberate. Personal data, third-party
> personal data, received assignments, internal diagrams, and the submitted binaries are gone;
> the companies, the answers, the rejections, and the judgment errors are not.
> [`docs/HISTORY-REDACTION.md`](docs/HISTORY-REDACTION.md) states what was removed and by what
> method, and [`PUBLICATION.md`](PUBLICATION.md) is the contract that governs it.

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

The narrative documents — this file, `PUBLICATION.md`, `docs/`, the license files — are in English.
The operating contracts the agents actually follow, the root `AGENTS.md` and one per lane, are in
Korean, because that is the language the work was done in. Translating them would mean maintaining
two versions of a contract, and a contract that drifts is worse than one you have to translate.

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

# Publication gate — this repository's own history, not an export tree
./scripts/check-public.sh --repo .

# Application ledger plus the public-contract invariant
applications/check.py --public
```

`linkedin-jobs` uses an undocumented public LinkedIn guest endpoint. It is best-effort, rate-limited,
uses no login cookies, and may break when LinkedIn changes markup. See its `SKILL.md` for the exact
contract and limitations.

## Privacy and publication

The private workspace intentionally preserves company names, application answers, and submitted
artifacts. That is incompatible with publishing this object database as it stands. A `.gitignore`
change or a file deletion does not erase old commits.

The published record is therefore the **whole decision history, sanitized** — not a single-commit
allowlist export. This repository **is** that sanitized result, not a plan for one. Four rules produced it:

1. Rewrite every reachable commit, blob, path, and identity field with `git-filter-repo`, keeping
   commit count, topology, timestamps, and messages intact. Preservation is verified, not assumed.
2. Remove what cannot be published — personal data, third-party personal data, compensation figures,
   received assignments, raw third-party copies, submitted binaries — and record the *categories and
   method* of every removal, never the values.
3. Push the sanitized history into a **new, private** object database and re-verify it from a clean
   clone; never flip this private repository's own object database to public.
4. Run the publication gate and read every file manually before the visibility change.

See [`PUBLICATION.md`](PUBLICATION.md). The final visibility change remains a human decision, and it
is effectively irreversible: once public, third-party archives and caches hold independent copies.

## Licensing

- Software, scripts, tests, build definitions, and configuration: **MIT** — [`LICENSE`](LICENSE).
- Reusable method documentation and public-safe operating contracts: **CC-BY-4.0** —
  [`LICENSES/CC-BY-4.0.txt`](LICENSES/CC-BY-4.0.txt).
- Personal résumé wording, application answers, and actual career records: **no reuse license**
  (`LicenseRef-Personal-Record`).
- Exact path mapping: [`LICENSING.md`](LICENSING.md); reserved and third-party material:
  [`NOTICE.md`](NOTICE.md).

The licenses do not grant privacy, publicity, trademark, or employment-confidentiality rights, and
do not relicense third-party job postings, received assignments, or quoted company material.

## Author

This project is maintained by **Junghan Kim (김정한, GLG)**.

- [Digital garden](https://notes.junghanacs.com/)
- [Homepage](https://junghanacs.com/)
- [GitHub profile](https://github.com/junghan0611)
- [LinkedIn](https://www.linkedin.com/in/junghan-kim-1489a4306)
