# Research Notes

Working notes for the Enterprise Imaging IG. **Not published** - this folder is
outside `input/`. Findings that belong in the guide go on the IG pages; this
file keeps supporting evidence, local service detail and open questions.

Dates are when the source was checked.

## Open Questions

| # | Question | Who could answer | Status |
|---|---|---|---|
| 1 | Take a dependency on `hl7.fhir.eu.imaging` 1.0.0-ballot? It depends on `hl7.fhir.eu.base` 2.0.0-ballot, `ihe.iti.mhd`, `fhir.dicom` and the R5 cross-version package; Cancer Pathology Report uses eu.base 2.0.1 | IG authors | Open |
| 2 | Has NHS England withdrawn NICIP in favour of SNOMED CT only? Data dictionary shows IMAGING CODE (NICIP) being replaced by CODED PROCEDURE (NICIP) (July 2026 release) | NHS England terminology / DID team | Open |
| 3 | Full COSD v10 Core - Imaging item list and formats (only CR1610, CR3110, CR0340, retired CR0350 confirmed) | COSD v10 user guide | Open |
| 4 | DiagnosticReport.category for endoscopy reports (v2-0074 has no endoscopy code) | IG authors | Open |
| 5 | Which systems MFT and other NW trusts use for RIS, PACS/VNA, ERS, cardiology, and how they integrate with the EPR | Trust imaging / digital teams | Open |
| 6 | NW imaging network(s): shared PACS/VNA, image exchange arrangements, NIR adoption | NW imaging networks | Open |
| 7 | Is the histopathology request for endoscopic biopsies placed from the ERS or the EPR at MFT? | MFT endoscopy / pathology | Open |
| 8 | Does HL7 Europe Imaging Report fit the endoscopy report? | IG authors | Open |

## Sources Checked (2026-11-01)

- IHE ENDO domain lists EWF, EIA and ERPO as trial implementation (2018-11-28);
  Technical Framework "not yet developed". https://profiles.ihe.net/ENDO/index.html
- IHE PaLM DPIA Rev 1.4 trial implementation, 2026-03-06.
- IHE RAD index lists SWF.b, IMR (2024-06-25), MADO (2026-03-16), XDS-I.b.
  https://profiles.ihe.net/RAD/
- `hl7.fhir.eu.imaging` on packages.fhir.org: only 1.0.0-ballot, FHIR 4.0.1.
- NED: SOAP web service called by ERS suppliers (2016 abstract); JAG reports
  over 15 million procedures since 2015, over 530 sites.
- LOINC 18748-4, 18751-8, 18746-8, 18745-0 and SNOMED CT 363679005, 423827005
  checked on tx.fhir.org.
