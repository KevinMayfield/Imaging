# Research Notes

Working notes for the Enterprise Imaging IG. **Not published** - this folder is
outside `input/`. Findings that belong in the guide go on the IG pages; this
file keeps supporting evidence, local service detail and open questions.

Dates are when the source was checked.

## Open Questions

| # | Question | Who could answer | Status |
|---|---|---|---|
| 1 | Take a dependency on `hl7.fhir.eu.imaging` 1.0.0-ballot? It depends on `hl7.fhir.eu.base` 2.0.0-ballot, `ihe.iti.mhd`, `fhir.dicom` and the R5 cross-version package; Cancer Pathology Report uses eu.base 2.0.1 | IG authors | Decided 2026-11-01: depend on 1.0.0-ballot |
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
| 13 | DiagnosticReportEuImaging requires a Composition (FHIR document). Can NHS RIS reports (HL7 v2 ORU, text) meet this, or is a lighter report profile needed? | IG authors | Open |
| 14 | How to distinguish primary and secondary reporters in DiagnosticReport.resultsInterpreter | IG authors | Open |
| 16 | Create an NW core package for shared identifier conventions, replacing the copies in this guide (see Duplication below) | NW GMSA IG authors | Open |
| 17 | NW GMSA links DiagnosticReport to DocumentReference with the R5 DiagnosticReport.supportingInfo extension pinned to version 1.0.2 (retired); the current version (xver 0.1.0) only allows Procedure, Observation, DiagnosticReport or Citation targets. Alternative link for both IGs? | NW GMSA IG authors | Open |
| 18 | ORC-1 / ORC-5 to ServiceRequest.status mapping for RAD-2 / RAD-3; whether NHS RIS use the accession number as the filler order number (ORC-3) | IG authors / RIS suppliers | Open |
| 15 | tx.fhir.org has the SNOMED CT UK Edition (2023-04-12) but cannot expand refset 999001111000000105, so the UK Imaging Procedure value set and its bindings are not validated. Use the NHS England Terminology Server? | IG authors | Open |

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

## Duplication: NHS Identifier Conventions (2026-11-01)

To clear the validator's "No definition could be found for URL" warnings and to
follow NW GMSA identifier conventions, this guide **copies** artefacts rather than
depending on another IG:

| Copied | From | Into |
|---|---|---|
| NamingSystems: NHS number, ODS organisation code, ODS site code, GMC number, GMP number | NW GMSA `../FHIRGenomics/input/resources/*.json` - themselves copies of HL7 UK Core NamingSystems (publisher "HL7 UK") | `input/resources/` (unchanged) |
| Patient profile (NW core Patient, on patient-eu-core) | NW GMSA `../FHIRGenomics/input/fsh/Patient.fsh` | `input/fsh/Core/Patient.fsh` (UK Core EthnicCategory extension removed) |
| NICIP CodeSystem (4833 codes, canonical kept) and NICIP value set; procedure code slicing pattern | Interweave FHIR IG `CodeSystem-Interweave-NICIP` / `ValueSet-Interweave-NICIP` / `Interweave-DiagnosticReport` (fhir.interweavedigital.com/R4, CodeSystem v0.0.1, 2024-07-15) | `input/resources/CodeSystem-Interweave-NICIP.json` (unchanged; allowed via `special-url`), `input/fsh/Terminology/Imaging.fsh` |
| DocumentReference and Binary profiles; DocumentEntryType, DocumentEntryClass, FacilityType, Specialty value sets (for the OBX type ED convention) | NW GMSA `../FHIRGenomics/input/fsh/DocumentReference.fsh`, `Binary.fsh`, `Termininology/ValueSet` | `input/fsh/Core/DocumentReference.fsh` (NW Encounter profile constraint and Obligation markers removed) |
| Expansion parameters (SNOMED CT UK Edition) | NW GMSA `input/fsh/Parameters/exp-params.fsh` and `path-expansion-params` | `input/fsh/Parameters/exp-params.fsh`, `sushi-config.yaml` |
| NWAttachment data type (report referenced by `url`, not embedded in `data`) and the DocumentEntryMimeType value set | NW GMSA `../FHIRGenomics/input/fsh/DataTypes/Attachment.fsh`, `Termininology/ValueSet/DocumentEntry.mimeType.fsh` | `input/fsh/DataTypes/NWDataTypes.fsh` (unchanged) |
| FHIR Messaging: MessageHeader and BundleMessage profiles; the O19 MessageDefinition pattern (one FHIR order message whatever the HL7 v2 source - REF_I12 or OMG^O19) | NW GMSA `../FHIRGenomics/input/fsh/MessageHeader.fsh`, `BundleMessage.fsh`, via Patient Care Coordination `../Referral360/input/fsh/Messaging/` (KevinMayfield/PatientCareCoordination) | `input/fsh/Messaging/Messaging.fsh` (as Patient Care Coordination: v2-0003 binding not pinned to 3.0.0); `input/fsh/Messaging/ImagingOrder.fsh` (Imaging Order (O19), focus Radiology Service Request) |
| Identifier data types: CorrelationIdentifier, NHSIdentifier, MedicalRecordNumber, PatientIdentifier, OrganisationCode, OrganisationSiteIdentifier, PractitionerIdentifier, ReportIdentifier, OrderIdentifier, VisitNumber, and the NWIdentifierType, UKNationalHealthIdentifiers, PractitionerIdentifiers value sets and their code systems | NW GMSA `../FHIRGenomics/input/fsh/DataTypes` and `Termininology` | `input/fsh/DataTypes/NWDataTypes.fsh` (UK Core NHS number verification extension and NW GMSA ZCID code removed; CodeSystem retitled "UK National Health Identifier Systems" because its title duplicated the value set's - an IG Publisher error, so the NW GMSA source likely has the same error) |
{:.grid}

The same definitions now exist in HL7 UK Core, NW GMSA and this guide (and the
Cancer Pathology Report IG has none). Copies drift, and canonical URLs differ
between IGs, so profiles in one IG cannot reuse another's identifier types. This
is the case for a small **NW core** package (NamingSystems, identifier data
types, NW identifier value sets, aliases), with no genomics or UK Core
pre-release dependencies and published to a registry the CI can resolve, that
the NW GMSA, Cancer Pathology Report and Imaging IGs all depend on.

Why not depend on NW GMSA now: it depends on `hl7.fhir.eu.base` 2.0.1 (EU
Imaging ballot uses 2.0.0-ballot), pulls in UK Core pre-release, genomics
reporting, SDC and BALP, and is published only at
https://nw-gmsa.github.io/package.tgz, not packages.fhir.org.

Still missing from all copies: an HCPC number NamingSystem
(`https://fhir.hl7.org.uk/Id/hcpc-number`), needed for radiographers.

## IHE SWF.b and HL7 v2.5.1 (2026-11-01)

- IHE RAD SWF.b supplement Rev. 1.7 Trial Implementation (2019-08-09) makes HL7
  v2.5.1 mandatory for the HL7 transactions.
- IHE RAD TF-2 Rev. 23.0 Final Text (2025-08-08): RAD-2 and RAD-3 use
  OMG^O19^OMG_O19 / ORG^O20^ORG_O20 (RAD-2 ORC-1 NW, XO, CA, optional PA/CH;
  RAD-3 ORC-1 SN, XX, SC, OC, ORG NA); RAD-4 and RAD-13 use OMI^O23^OMI_O23 with
  the IPC segment (IPC-1 accession identifier with assigning authority, max 16
  characters; IPC-2 requested procedure ID; IPC-3 Study Instance UID; IPC-4
  scheduled procedure step ID; IPC-5 modality).
- Report delivery is not in SWF.b. IHE RAD Results Distribution (RD) supplement
  Rev. 1.2 Trial Implementation (2019-08-09) defines Send Imaging Result
  [RAD-128]: HL7 v2.5.1 ORU^R01^ORU_R01, actors Report Creator, Report Manager,
  Report Consumer; payload OBX-2 TX (text), ED (Base64 PDF, PDF Option) or ED
  (CDA, CDA Option). The older RAD-28 Structured Report Export (SINR) is ORU in
  HL7 v2.3.1 with ASCII text. The guide uses RAD-128.
