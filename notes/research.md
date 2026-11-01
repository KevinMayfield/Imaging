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
| 9 | Is RCR "Radiology reporting networks: understanding the technical options" (March 2022) withdrawn or moved? The PDF URL and publication page return 404 | RCR | Open |
| 10 | Check the imaging report data items on the FHIR Resources page against the RCR text (the table came from the NHS England draft IG, not the RCR original) | IG authors | Open |
| 11 | Accession number `Identifier.system` convention for sharing between organisations | IG authors / NIR | Open |
| 12 | Imaging site in DiagnosticReport.performer: SITE CODE (OF IMAGING) or ODS organisation code? | IG authors | Open |

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

## NHS England Draft Radiology IG Review (2026-11-01)

Local copy: `~/github/NHSEngland/radiology` (NHS England draft for the National
Imaging Registry alphas; marked "not an official guide").

Incorporated:

- RCR imaging report data items mapped to DiagnosticReport / HL7 v2 ORU / DICOM
  (from the draft's ImagingReport intro) -> FHIR Resources page. Corrected two
  DICOM tags in the draft: modality is (0008,0060) not (0008,0024); operator is
  (0008,1070)/(0008,1072), not (0008,1049) (Physician(s) of Record).
- DICOM General Study module -> ImagingStudy mapping; accession number
  identifier (v2-0203 ACSN, CX.5/CX.6, DICOM 0008,0050/0051).
- EU eHealth Network definitions of imaging study and imaging report.
- WADO-RS [RAD-107] and KOS as retrieval options -> Image Sharing page.
- SNOMED CT 999001111000000105 (UK diagnostic imaging procedure refset, UK
  Edition), 363680008, 4201000179104 checked on tx.fhir.org.

Not incorporated:

- IHE XDS DocumentEntry / MHD DocumentReference mapping and NRL profile:
  already covered by the NW GMSA DocumentReference profile
  (https://nw-gmsa.github.io/en/StructureDefinition-DocumentReference.html).
- NIR alpha architectures (NRL central index vs federated XCA/MHD).
- Draft's problem statement figure of about GBP 4 million a year on re-imaging
  caused by Image Exchange Portal delays: no source given. To confirm before use.
- Detailed DICOM KOS module tables (draft was incomplete, with open "CHECK"
  notes).
