# dossier — archived long-form document sample

**2026-10-16 GLG decision: archive, not an active career-document source.**

The everyday editing source is [`resume/body.org`](../../../resume/body.org). The current Korean
application and systems portfolio are views under [`resume/`](../../../resume/) — see
[`resume/AGENTS.md`](../../../resume/AGENTS.md) for the build contract.

This directory preserves a different, independently authored long-form document set. It is **not**
a generated copy of the current résumé, and it is not automatically synchronized with it. Do not
update career facts here instead of updating `resume/body.org`, or attach its AX-oriented documents
to a new application without a separate content review.

## What the sample preserves

| Source | Historical purpose |
|---|---|
| `competency.org` | competency and experience statement |
| `portfolio.org` | illustrated long-form portfolio |
| `detail.org` | detailed supporting narrative |
| `references.bib`, `images/` | citations and seven individually reviewed concept images |
| `pipeline/`, `run.sh`, `flake.*`, tests | the former PDF/ODT/Markdown/package build example |

The set originated with an [NHN application](../../../applications/nhn--ax-transformation-ai-infra/)
and retained its `AX_` artifact names for continuity.
Those names, old targeting decisions and prose describe the sample's history, not today's submission
instructions. The October 15 image, bibliography and contact repairs remain preserved here.

## Preservation and old records

- Only Git-tracked sources were moved from `dossier/`; existing local `dossier/build/`, package
  output and caches were **not moved, rebuilt or deleted**. The old local directory is now ignored
  at the repository root and does not appear in a clean clone.
- Historical application records may still name `dossier/build/*.pdf`. Keep those records and
  submitted fingerprints unchanged. The legacy staging helper resolves corresponding source
  references to this sample; it does not make this the current career source.
- Original submitted bytes belong to the private preservation surface. A source checkout is not
  a promise to recreate the same bytes; `MANIFEST.sha256` is the identity commitment.
- Image publication review and hashes are in [`images/README.md`](images/README.md). Moving the
  files grants no new rights: see [`LICENSING.md`](../../../LICENSING.md).

## Optional example checks

From the repository root:

```bash
python3 docs/samples/dossier/test_contact.py
python3 docs/samples/dossier/test_figures.py
python3 docs/samples/dossier/test_bibliography.py
```

To explore the old renderer with the current contact comparison, use a temporary **source-only
copy retaining the repository layout** (`resume/` and `docs/samples/dossier/`), not the preserved
build/submit directories. Copying only this sample folder intentionally selects the historical
standalone-package email fallback, not comparison against the current résumé preamble. Its Doom Emacs, bibliography, template
and conversion dependencies are historical environment requirements, not prerequisites for editing
or generating the current résumé. Do not run it against preserved build or submission directories.
The old operating contract follows in `AGENTS.md`, explicitly marked as historical.
