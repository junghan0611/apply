# Case study — four roles, one fact corpus, a human-owned submit gate

## Starting point

The morning began with a polished dossier for one earlier target, but no general application
operating system. There was no reusable job-discovery tool, no ledger, no target-specific English
résumé launcher, and no durable record of what a browser had uploaded.

The constraint was roughly ninety minutes before work. Four agent sessions and one human worked in
parallel.

## Role split

- **Explorer:** queried public LinkedIn guest endpoints in Korean and English, deduplicated cards,
  recovered detail pages, and kept location evidence separate from guesses.
- **Document steward:** converted one verified fact corpus into role-specific résumé views and put
  inspectable public evidence near the top of every document.
- **Browser operator:** opened real ATS forms, discovered required fields and upload mechanics, and
  stopped at personal values and irreversible actions.
- **Application writer:** created company/role-specific supporting documents when the ATS required
  more than a résumé.
- **Human:** chose targets, filled personal/legal fields, consented, uploaded files where native file
  dialogs defeated automation, and pressed Submit.
- **Meta reviewer:** entered after the run to compare claims against records, inspect failure
  patterns, and turn gaps into tests and repository contracts.

No agent was the coordinator by status or model. Coordination lived in file ownership, explicit
handoffs, and the human's final authority.

## What the system produced

- 418 deduplicated job cards across multiple query families;
- three-valued location evidence: confirmed, card hint, or unknown;
- six role views from one résumé fact source;
- an application ledger and per-target directory scaffold;
- immutable copies of the PDFs actually uploaded;
- four submitted applications across two ATS families;
- a next-session queue with role cut, location confidence, and application route.

The count is not a throughput claim. Most collected cards were never candidates. The useful
measurement is that a candidate could move from source evidence to a recoverable submission without
copying career facts into another uncontrolled document.

## Failures that changed the design

### 1. The default artifact was target-specific

A document built for an earlier company was still configured as the LinkedIn default résumé. Had the
team trusted the saved default, unrelated applications could have received it.

**Contract added:** the browser operator verifies the visible filename at the final review step;
LinkedIn's saved default holds only the neutral base résumé.

### 2. “Unknown location” was being treated as “wrong location”

Only a minority of Korean job descriptions contained a reliable worksite. A strict filter would
silently delete valid candidates.

**Contract added:** unknown remains unknown. Confirmed mismatch may be filtered; card hints may rank;
strict removal requires an explicit flag.

### 3. Korean place names collide with ordinary words

Strings meaning place names also occur inside words such as “internal operation,” “per minute,” or
brand names. Adding a place to a flat dictionary created quiet false positives.

**Contract added:** strong and weak place classes, Korean boundaries, administrative suffix rules,
and network-free regression cases from real failures.

### 4. Keyword ranking used unsafe substring matching

A negative keyword such as `intern` also matched `internal`. The location mismatch branch was nested
under the match branch and therefore failed to apply as documented.

**Contract added:** ASCII token boundaries, score reasons, explicit known/unknown location handling,
and score regression tests.

### 5. The ledger closed, but target records stayed open

The summary and central ledger said four applications were submitted while three per-target records
still said `ready` or `not submitted`. The human outcome had been recorded in one SSOT but not
propagated to each immutable case record.

**Contract added:** record closure is a two-file transaction. `LEDGER.md` and the target's
`submission.md` must agree before a run is called closed. Personal values may remain browser-only;
the record stores that the human completed them, not their contents.

### 6. One-company/one-role was a default, not a law

The initial policy discouraged simultaneous applications to very different roles at one company.
The human deliberately overrode it after reading both evidence packages.

**Contract added:** agent recommendations are defaults. A human may make an explicit exception; the
record stores the reason rather than rewriting the earlier recommendation as if it never existed.

## Why the documents were not generic AI prose

Every role cut had a section whose visible text included public repository URLs, runnable commands,
or third-party pull requests. Private employer work was labeled as experience and was not “proved”
by an adjacent public repository. The AI-focused cut explicitly did not claim foundation-model
training or fine-tuning expertise.

The objective was not to ask a reviewer to believe a distinctive voice. It was to make the claims
cheap to challenge.

## Reusable lessons

1. Keep facts single-sourced; let targets own selection and order.
2. Separate discovery from logged-in submission.
3. Represent uncertainty instead of deleting it.
4. Preserve the exact submitted artifact, not a link to a mutable launcher.
5. Keep irreversible actions and personal/legal values human-owned.
6. Record agent recommendations and human overrides as different events.
7. Close the run only when central and per-target records agree.
8. Review the collaboration after the deadline; rushed gaps are test cases, not shame.
