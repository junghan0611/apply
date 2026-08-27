# Licensing map

Copyright 2026 Junghan Kim.

This repository uses different terms for software, reusable method documentation, personal records,
and third-party material. A narrower path rule or an inline notice overrides a broader rule.

## Software — MIT

SPDX identifier: `MIT`  
Full text: [`LICENSE`](LICENSE)

The MIT license applies to original software source, scripts, tests, build definitions,
configuration, and executable examples, including:

- `.claude/skills/linkedin-jobs/` code and tests (not prose-only documentation);
- `scripts/`;
- executable `.py`, `.js`, `.sh`, and `.el` files under `applications/`, `resume/`, and `dossier/`;
- `flake.nix`, `flake.lock`, LaTeX/build configuration, and repository configuration authored here.

The Emacs Lisp provenance note and compatibility boundary are recorded in [`NOTICE.md`](NOTICE.md).

Two carve-outs apply to that list:

- **Emacs Lisp.** MIT covers these files only because they were authored here and no code was copied
  from GNU Emacs or Org mode sources. If a copied fragment is later identified in a specific file,
  that file — and only that file — is `GPL-3.0-or-later`, and this map is corrected rather than
  argued with.
- **Code that automates a login-gated service.** Such a file is not covered by the MIT grant above
  even if it sits under one of those directories. The question it raises is a terms-of-service and
  security question, not a licensing one, and a license cannot settle it. The one file of this kind
  that this repository used to contain was removed from history before publication rather than
  licensed (see [`docs/HISTORY-REDACTION.md`](docs/HISTORY-REDACTION.md)); if another is ever written,
  it stays out of the public repository until a human decides otherwise.

## Reusable method documentation — CC-BY-4.0

SPDX identifier: `CC-BY-4.0`  
Full text: [`LICENSES/CC-BY-4.0.txt`](LICENSES/CC-BY-4.0.txt)

CC-BY-4.0 applies to original prose explaining the reusable method and operating contracts,
including the public-safe versions of:

- `README.md`, `PUBLICATION.md`, and `docs/`;
- the operating contracts: the root `AGENTS.md` and every lane `AGENTS.md`
  (`applications/`, `resume/`, `dossier/`), along with `dossier/README.md`,
  `dossier/PORTFOLIO-PLAN.md`, and the `*.package.md` files;
- prose-only skill and pipeline documentation.

These are covered by the paths named above, not by an inline marker; no `SPDX-License-Identifier`
header is required in them. A document elsewhere in the tree may opt in by carrying that header.

Attribution: **Junghan Kim**, with a link to this repository when practical; retain the license
notice and indicate changes. `NC`, `ND`, and `SA` restrictions are deliberately not added: quoting,
translation, adaptation, and organizational case-study use are part of the publication's purpose.

## Personal career and application records — no license granted

Local SPDX reference: `LicenseRef-Personal-Record`  
Notice: [`NOTICE.md`](NOTICE.md)

Unless a file explicitly opts into CC-BY-4.0, no reuse license is granted for:

- résumé facts and wording in `resume/body.org`, `resume/resume.org`, and `resume/targets/`;
- cover letters, self-introductions, application answers, interview narratives, and submitted-form
  records under `applications/`;
- personal career claims and application-facing prose in `dossier/*.org`;
- operational handoffs containing personal decisions, including `NEXT.md`.

These records are public so the process can be inspected, not so another person can reuse the
applicant's words as their own.

## Third-party material — original terms or no repository grant

- `dossier/pipeline/templates/ieee.csl`: `CC-BY-SA-3.0`; see
  [`LICENSES/CC-BY-SA-3.0.txt`](LICENSES/CC-BY-SA-3.0.txt) and the file's inline `<rights>` metadata.
- `dossier/pipeline/templates/reference.odt` is **not in this repository.** It is an ODT style
  master, and it was removed with the other document binaries at publication; see
  [`NOTICE.md`](NOTICE.md). It is the author's own file, not third-party material — it is listed
  here only because the build scripts still name it.
- Job-posting and company-form quotations, API excerpts, trademarks, linked sources, and received
  material remain under their respective owners' terms. This repository grants no license to them.
- Raw assignments and unnecessary full copies are publication-removal targets; a repository license
  cannot cure a missing redistribution right.

See [`NOTICE.md`](NOTICE.md) for attribution, exclusions, and rights not granted.

## Unclassified files

A file that is not clearly covered above and has no inline SPDX identifier is **not licensed by
implication**. Treat it as all rights reserved until it is classified. Before public release, the
publication gate must reject newly added unclassified authored files or require a recorded review.

SPDX headers and the final path inventory are added to the sanitized tree after history rewrite so
the public tip states the license without pretending that older private commits carried it.
