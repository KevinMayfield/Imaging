<div class="alert alert-danger" role="alert">
<b>Proof of concept.</b> This implementation guide is a demonstration only. It is
<b>not</b> an authoritative source, is not endorsed by NHS England, IHE or HL7, and
must not be used for implementation or clinical purposes. It is background for the
<a href="https://kevinmayfield.github.io/CancerPathologyReport/">Cancer Pathology Report</a>
proof of concept.
</div>

### Aim

This guide gives **background on imaging** in NHS trusts for the
[Cancer Pathology Report](https://kevinmayfield.github.io/CancerPathologyReport/) IG.
That IG covers the pathology report; imaging has its own systems, workflows and
reports, and it meets pathology at several points on the cancer pathway - see
[Imaging in the Cancer Pathway](CancerPathway.html).

The guide uses the term **enterprise imaging**: all clinical imaging across an
organisation, not only radiology. Radiology is the largest imaging service, but
endoscopy, cardiology, ophthalmology, medical photography and digital pathology
also produce images and reports, usually in their own specialist systems. See
[Enterprise Imaging](EnterpriseImaging.html).

This guide **describes** systems, actors and standards. Its first FHIR
profiles, for the radiology request, study and report, are derived from
[HL7 Europe Imaging Report](https://hl7.eu/fhir/imaging/) - see
[FHIR Resources](DataModel.html).

### Content

**Analysis and Design (Volume 1)**

- [Enterprise Imaging](EnterpriseImaging.html) - what the term covers, the
  typical system landscape (RIS, PACS, VNA, viewer, specialist reporting systems)
  and how it relates to the EPR
- [Radiology Scheduled Workflow (SWF.b)](SWF.html) - RIS and PACS, IHE Radiology Scheduled Workflow,
  NICIP and SNOMED CT procedure codes, the Diagnostic Imaging Dataset
- [Endoscopy](Endoscopy.html) - endoscopy reporting systems, the National
  Endoscopy Database, IHE Endoscopy profiles, and endoscopy as a specimen
  collection point for pathology
- [Other Imaging Specialties](OtherImaging.html) - cardiology, ophthalmology,
  medical photography, point-of-care ultrasound and digital pathology
- [Image Sharing](ImageSharing.html) - sharing images and reports between
  organisations, including the NHS England National Imaging Registry
- [Imaging in the Cancer Pathway](CancerPathway.html) - detection, image-guided
  biopsy, staging, the MDT and COSD Imaging

**Data Models (Volume 3)**

- [FHIR Resources](DataModel.html) - FHIR resources for imaging orders, studies
  and reports, and this guide's radiology profiles based on HL7 Europe Imaging
  Report
- [Radiology Report](StructureDefinition-RadiologyReport.html) - logical model of
  the radiology report data items
- [Terminology](terminology.html) - code systems used for imaging procedures,
  modalities and report types

### Sources

| Source | Version | Used for |
|---|---|---|
| [A Foundation for Enterprise Imaging: HIMSS-SIIM Collaborative White Paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5023525/) | 2016 | Definition and scope of enterprise imaging |
| [HL7 Europe Imaging Report](https://hl7.eu/fhir/imaging/) | 1.0.0-ballot | FHIR model of the imaging report |
| [IHE Radiology (RAD) profiles](https://profiles.ihe.net/RAD/) | - | Scheduled Workflow (SWF.b), XDS-I.b, MADO, IMR |
| [IHE Endoscopy (ENDO) profiles](https://profiles.ihe.net/ENDO/index.html) | Trial implementation (2018) | Endoscopy ordering, image archiving, report and pathology order |
| [IHE Pathology and Laboratory Medicine (PaLM)](https://profiles.ihe.net/PaLM/index.html) | - | Digital pathology image acquisition (DPIA) |
| [NICIP code set](https://digital.nhs.uk/services/terminology-and-classifications/national-interim-clinical-imaging-procedure-nicip-code-set) - NHS England | - | Imaging procedure codes, mapped to SNOMED CT |
| [Diagnostic Imaging Dataset (DID)](https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/diagnostic-imaging-data-set) - NHS England | - | National radiology activity data |
| [COSD v10 Core - Imaging](https://digital.nhs.uk/ndrs/data/data-sets/cosd/cosd-user-guide-v10/core---imaging) - NDRS | v10 | Imaging items in the cancer dataset |
| [National Imaging Registry](https://digital.nhs.uk/services/national-imaging-registry) - NHS England | - | Finding a patient's imaging held by other organisations |
{:.grid}

### Related

- [Cancer Pathology Report](https://kevinmayfield.github.io/CancerPathologyReport/) -
  the IG this guide supports; its
  [Imaging and Radiology](https://kevinmayfield.github.io/CancerPathologyReport/Imaging.html)
  page covers where imaging meets the pathology report
- [NHS North West Genomics FHIR IG](https://nw-gmsa.github.io/en/)
