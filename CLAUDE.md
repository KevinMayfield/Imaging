# CLAUDE.md

Proof-of-concept FHIR Implementation Guide giving background on enterprise
imaging (radiology, endoscopy and the other imaging specialties) in NHS trusts.
Published at https://nw-gmsa.github.io/Imaging/. Supports the
[Cancer Pathology Report](https://github.com/nw-gmsa/CancerPathologyReport) IG
(`../CancerPathologyReport`), whose Imaging page covers where imaging meets the
pathology report.

## Scope

- **Proof of concept only.** Every page starts with the red "Proof of concept"
  alert box (copy it from an existing page). Never present content as
  authoritative or endorsed.
- **Background, not a specification.** The guide describes systems, actors and
  standards. Its profiles are kept few and derive from HL7 Europe Imaging Report
  (`hl7.fhir.eu.imaging` 1.0.0-ballot, a dependency decided 2026-11-01). The
  radiology report logical model follows the RCR data items.
- Keep pathology content in the Cancer Pathology Report IG; link to it rather
  than repeating it.

## Layout

- Pages: `input/pagecontent/`, organised as IHE volumes - Volume 1 Analysis and
  Design (Enterprise Imaging, Radiology, Endoscopy, Other Imaging Specialties,
  Image Sharing, Imaging in the Cancer Pathway), Volume 3 Data Models (FHIR
  Resources, Terminology).
- FSH: `input/fsh/` - logical model at the top level, `Profiles/`, `Terminology/`.
- A new page must be added to both `pages:` and `menu:` in `sushi-config.yaml`.
- Research notes and open questions that should not be published:
  `notes/research.md` (outside `input/`, so the IG Publisher ignores it).

## Conventions

- Same conventions as the Cancer Pathology Report IG: Markdown pages; diagrams as
  Mermaid (`sequenceDiagram`, `erDiagram`, `flowchart`); tables end with
  `{:.grid}`; HL7 v2 mappings are "indicative".
- Check LOINC and SNOMED CT codes on tx.fhir.org (`CodeSystem/$lookup`) before
  using them.
- Cite sources with links. Mark anything unverified or undecided as **Open** or
  **To confirm** rather than guessing.
- Product names are examples of the market only; never state which system a
  trust uses without a source.

## Build and publish

- `sushi build .` after any FSH or `sushi-config.yaml` change; expect 0 errors.
- Full build: `./_genonce.sh` (HL7 IG Publisher). Mermaid diagrams are only
  rendered by the full build.
- Any push runs `.github/workflows/igPublish.yml`; pushes to `main` update the
  published site (GitHub Pages must be enabled with source "GitHub Actions").
  Commit or push only when asked.
