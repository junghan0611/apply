# Notices and reserved material

Copyright 2026 Junghan Kim.

The repository contains software, reusable method documentation, personal career records, and
third-party quotations. The root license does not apply to every file indiscriminately; consult
[`LICENSING.md`](LICENSING.md).

## Personal records — no license granted

Personal résumé claims, application answers, cover letters, autobiographical passages, and actual
submission records are published for transparency and review, not for reuse as another person's
career material. Unless a file explicitly says otherwise, these materials are all rights reserved
and identified by the local SPDX reference `LicenseRef-Personal-Record`.

Publication permits reading, linking, quotation where applicable law allows it, and independent
analysis. It does not grant permission to copy the material into another person's résumé,
application, profile, or endorsement.

## Third-party material

Repository licenses cover only material authored or controlled by Junghan Kim. They do not
relicense job-posting quotations, company form wording, API documentation excerpts, company names,
product names, trademarks, received assignments, or linked material. Those remain under their
original terms.

- `dossier/pipeline/templates/ieee.csl` identifies the Zotero IEEE CSL style and declares
  [CC-BY-SA-3.0](LICENSES/CC-BY-SA-3.0.txt) in its own `<rights>` metadata. That license governs the
  file; preserve its contributor metadata.
- `dossier/pipeline/templates/reference.odt` is **absent from this repository.** It is an ODT style
  master that the build uses to carry fonts and paragraph styles, and it went out with the other
  document binaries at publication. Its own tooling
  (`dossier/pipeline/strip_reference_odt.py`) records that it was produced by saving one of the
  author's own documents from LibreOffice, so it is the author's file rather than third-party
  material; it is named here so that a reader who meets the reference in the build scripts knows
  why it is missing and does not go looking for a license that never applied.
- Raw received assignments and unnecessary full third-party copies are not made licensable by this
  notice. They are removal targets in the publication rewrite.
- External Nix, Python, JavaScript, Emacs Lisp, LaTeX, and other dependencies retain their own
  licenses. Lockfiles and references do not change those terms.

## Emacs Lisp provenance

`dossier/pipeline/latex-export.el` records in its own header that the class wiring came from the same
author's `ax` build script, and the lineage continues through `memex-kb/scripts/paper_build.el` and
`jacobian-lens/survey/build.el`. All three sources were inspected locally on 2026-08-27:
`ax/build.el` is tracked as `apply/ax/build.el` in the author's `junghan0611` GitHub profile repository;
`memex-kb/scripts/paper_build.el` has one author and no repository license; and
`jacobian-lens/survey/build.el` has one author under the repository's Apache-2.0 `LICENSE`.
`dossier/pipeline/proposal-export.el` likewise records that its Doom loading pattern came from the
same author's `doomemacs-config/bin/denote-export.el`; that source was inspected and its history also
has only the same author.

A copyright holder may release their own work under different terms, so licensing this repository's
copies under MIT is the owner's choice to make. Two conditions bound it, and both are stated so a
reader can check them rather than take them on trust:

- If any of the upstream files carries contributions from someone other than the owner, those
  contributions stay under their original Apache-2.0 terms and cannot be relicensed here.
- MIT applies because this code was authored here, not copied from GNU Emacs or Org mode. It calls
  the public Org export API; that is use, not derivation. If a copied fragment from a GPL source is
  ever identified in one of these files, that file becomes `GPL-3.0-or-later` and this notice is
  corrected.

## Rights not granted

The licenses do not grant privacy, publicity, personality, employment-confidentiality, trademark,
or database rights. A name or factual record appearing publicly is not permission to use it for
profiling, contact, endorsement, or impersonation.
