# History redaction record

This repository publishes its whole decision history, not a single squashed snapshot. To do that
without publishing what it has no right to publish, every commit was rewritten before the repository
became public. This file states what was removed, by what method, and how much — so the claim can be
checked instead of trusted.

It deliberately contains **no removed value and no hash of one**. Low-entropy values such as a phone
number or a birth date are not protected by hashing: a hash of one is a lookup table for anyone
holding a guess. Categories and counts are the honest unit of disclosure here.

**Not every number below is equally checkable, and it would be dishonest to imply otherwise.**
The preservation figures and the tombstone counts can be reproduced from this repository alone —
the commands are in the sections that state them, and a reader should run them rather than take
the claim. The removal figures cannot: a path removed from every commit leaves nothing here to
count, so "86 of 381" is verifiable only against the private mirror, by whoever holds it. Where a
number is reproducible, that is said; where it is not, that is said too.

## What the rewrite preserved

The point of rewriting rather than squashing was to keep the reasoning legible.

| Property | Before | After |
|---|---|---|
| Commits | 79 | 79 |
| Merge commits | 0 | 0 |
| Root commits | 1 | 1 |
| Author/committer timezones | one (`+0900`) | one (`+0900`) |
| Author name, author date, committer date, parent count | — | 79/79 rows identical |
| Commit subjects | — | 79/79 identical |

Reproduce it here:

```
git rev-list --all --count                            # 80 (79 rewritten + this contract commit)
git rev-list --all --merges --count                   # 0
git rev-list --all --max-parents=0 --count            # 1
git log --all --format='%ad' --date=format:'%z' | sort -u          # one line: +0900
git log --all --format='%ae%n%ce' | grep -vc 'users.noreply'       # 0
```

The row-by-row comparison against the pre-rewrite history is the one preservation check that needs
the private mirror, since the original commits are what it compares against.

Commit hashes necessarily changed: rewriting any byte of history changes every hash after it. The
mapping between old and new hashes is not published.

## What was removed, and how

### Whole paths, removed from every commit

- **binary-doc** — 45 paths
- **dense-pii-form** — 2 paths
- **employer-diagram** — 33 paths
- **login-gated-automation** — 1 path
- **received-assignment** — 2 paths
- **session-excerpt** — 1 path
- **third-party-raw-copy** — 1 path
- **third-party-referral** — 1 path

Total: **86 of 381 historical paths** removed; **295** paths remain.

Those first two numbers are the ones a reader cannot check here — see the note at the top. The
third can be, with one condition worth stating: 295 is the path count of the **sanitized 79 commits**,
before the publication-contract commit added the license and gate files on top. So it reproduces at
`HEAD~1`, not at `HEAD`:

```
git log HEAD~1 --name-only --pretty=format: | sed '/^$/d' | sort -u | wc -l   # 295
```

What each category means:

- `binary-doc` — generated PDF/ODT/ZIP artifacts. Text substitution cannot reach inside a binary, and
  a redacted binary is a broken file, so these are deleted rather than rewritten. The public repository
  ships no generated document binaries; each application record keeps the filename, the source, and the
  `MANIFEST.sha256` fingerprint of what was actually uploaded.
- `received-assignment` — take-home assignment material supplied by a company. Quoting a job posting
  is one thing; redistributing the dataset a company handed you is copying, and no license this
  repository grants could cure that.
- `employer-diagram` — internal architecture and product-stack diagrams. Whether these may be
  published is an employment-confidentiality question, not a personal-data question, and it is not one
  a scanner can answer. They were removed rather than left pending.
- `dense-pii-form` — completed application forms carrying legal and identity fields. Redacting these
  line by line would leave a document that is mostly holes and still re-identifiable from what remains.
- `third-party-referral` — a recommendation letter. Consent to submit it to one employer is not
  consent to publish it. What survives is the structure of claim-to-evidence, not the letter.
- `third-party-raw-copy` — a wholesale copy of another party's API documentation.
- `login-gated-automation` — code automating a service that sits behind a login, including how its
  auth header was obtained. Publishing it is a terms and security question separate from privacy.
- `session-excerpt` — a raw agent-session transcript excerpt.

### Job postings: path kept, body replaced

A job posting is where a decision starts, so deleting `JD.md` outright would empty 44 revisions
of the reasoning this repository exists to show. Instead each distinct source blob at a `*/JD.md` path
was replaced by a tombstone carrying an **opaque ordinal**.

Be precise about what that does and does not preserve:

- **Preserved:** that the path existed, and that a new revision of it landed in a particular commit.
- **Not preserved:** the original diff. A tombstone is not the posting. The ordinal does not encode
  the posting's content, its length, or anything about the company; it is a counter assigned in the
  order distinct revisions first appear, which the commit history already shows on its own. It cannot
  be reversed into text.

44 distinct source blobs across 33 posting paths were replaced this way. None of those blobs was shared
with a non-posting path, so no other file was affected.

**One thing this does not accomplish, stated plainly.** Removing the raw `JD.md` blobs does not mean
the postings are gone from the repository. The application records quote them — requirements,
preferred qualifications, sometimes a recruiter's own words — because that is what the reasoning was
built on, and a record of "why I judged this role a fit" is unreadable without the requirement it
was judged against. In a few cases those quotes are extensive enough that removing the source file
is a distinction without much difference. So the honest claim is narrow: **the wholesale copies were
removed, and what remains is quotation inside the records that reasoned about it.** Whether a given
quote stays within quotation and away from redistribution is a judgment made per record, not a
guarantee this rewrite can offer.

### Values replaced in surviving text

12 distinct email addresses, 1 phone number, 13 candidate-specific UUIDs, 1 local home-directory
path, and 2 third-party personal names were replaced with category markers such as
`[email removed]`. The same expressions were applied to commit messages.

4 email addresses were **kept**: the upstream contributor credits inside
`dossier/pipeline/templates/ieee.csl`. That file is CC-BY-SA-3.0, and stripping its attribution to
satisfy a privacy scan would trade one violation for another. Any scanner run against this repository
should expect those and allowlist them with this reason recorded.

### Commit identity

Every author and committer identity was rewritten to the owner's GitHub noreply address via a mailmap.
The verification standard is not "the old address appears zero times" but "every identity in the
repository is the noreply one" — 158 of 158 identity fields across 79 commits (two per commit).

## What was kept on purpose

Company names, role titles, application dates, the answers given, interview outcomes, rejections, and
the judgment errors and their corrections. Removing those would leave a case study that only shows the
parts that went well, which is the opposite of the point.

Four further categories were kept by an explicit decision on 2026-08-27, not by oversight. They had
been left open as per-item opt-ins while the rest of the rewrite ran, and the owner closed them at the
level they are published:

- **Contextual personal detail about the owner** — the city of residence, the stated reason for a
  career gap, nationality and work eligibility, and the "not applicable" answers to disability and
  veteran-status questions. Each is already findable on the owner's public profiles, and the
  "not applicable" answers disclose that a required field was filled rather than a condition. What
  they buy is specific: a gap that is not hidden, a commute radius, and the conclusion that no
  sponsorship is needed.
- **Graduate affiliation** — a named lab and a named visiting lab with their date ranges. No third
  party is named, but the combination is enough for someone with domain knowledge to identify the
  academic advisor. A graduate affiliation is ordinary résumé content and the advisor is already
  identifiable from published work, so the marginal disclosure was judged small and accepted.
- **Quotation from job postings** — kept at the level described in the tombstone section above.
- **Prose about current employment** — cluster, delivery, and internal-tool descriptions, minus the
  diagrams, binaries, evidence archives, customer identifiers, and internal endpoints that were
  removed. This is the evidence the repository is published to show.

Stating this here matters more than the decision itself: a reader who finds these categories should
know they survived a review and a choice, not that the scan missed them. **The opt-in closed one open
row; it reopened none.** Phone number, date of birth, street address, personal email, military-service
detail, GPA, consent values, third-party personal data, and the submitted binaries remain removed.

## Tools

`git-filter-repo` (Nix, version `a40bce548d2c`), run in two passes over a disposable clone taken from a
private mirror — never over a working checkout. `--prune-empty never --prune-degenerate never` were
set explicitly so that no commit could disappear as a side effect. Scanning and verification used
`ripgrep`, `gitleaks`, and `trufflehog`; the tool versions and the full verification output are part of
the private release receipt.

The rewrite inputs — the exact path list, the replacement expressions, and the verification value
inventory — necessarily contain the removed values. They are kept in a private location at
restrictive permissions and are not part of this repository, now or in any earlier commit.
