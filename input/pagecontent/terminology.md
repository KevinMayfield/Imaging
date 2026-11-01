<div class="alert alert-danger" role="alert">
<b>Proof of concept.</b> This implementation guide is a demonstration only. It is
<b>not</b> an authoritative source, is not endorsed by NHS England, IHE or HL7, and
must not be used for implementation or clinical purposes. It is background for the
<a href="https://nw-gmsa.github.io/CancerPathologyReport/">Cancer Pathology Report</a>
proof of concept.
</div>

Code systems used for imaging. The SNOMED CT and LOINC codes below were checked
on [tx.fhir.org](https://tx.fhir.org/); the DICOM modality codes were not. Value
sets defined by this guide are listed on the [Artifacts](artifacts.html) page.

### Imaging Procedure

| Code system | Use | Notes |
|---|---|---|
| [NICIP](https://digital.nhs.uk/services/terminology-and-classifications/national-interim-clinical-imaging-procedure-nicip-code-set) | Radiology procedure (modality and body site) | National standard for imaging department systems in England; distributed through TRUD; used by the Diagnostic Imaging Dataset and COSD (CR1610). No FHIR system URI is defined - **Open** |
| SNOMED CT (`http://snomed.info/sct`) | Imaging procedure | NICIP codes are mapped to SNOMED CT (UK Diagnostic Imaging Procedure subset); COSD CR3110 |
{:.grid}

| SNOMED CT | Display | Use |
|---|---|---|
| 363679005 | Imaging | Top-level imaging procedure concept |
| 423827005 | Endoscopy | Top-level endoscopy procedure concept |
| 363680008 | Radiographic imaging procedure | Radiology procedures |
| 999001111000000105 | United Kingdom diagnostic imaging procedure simple reference set | UK Edition refset of the SNOMED CT procedures that NICIP codes map to; value set [UK Imaging Procedure](ValueSet-uk-imaging-procedure.html), bound to `ServiceRequest.code` and `ImagingStudy.procedureCode` |
{:.grid}

### Document Type

| SNOMED CT | Display | Use |
|---|---|---|
| 4201000179104 | Imaging report | Document type for imaging reports, for example `DocumentReference.type`; whether it is in the UK Core document type value set is **To confirm** |
{:.grid}

### Report Type

LOINC codes for `DiagnosticReport.code`:

| LOINC | Display | Use |
|---|---|---|
| 18748-4 | Diagnostic imaging study | Radiology / imaging report |
| 18751-8 | Endoscopy study | Endoscopy report |
| 18746-8 | Colonoscopy study | Colonoscopy report |
| 18745-0 | Cardiac catheterization study | Cardiac catheterisation report |
{:.grid}

### Report Category

`DiagnosticReport.category` uses HL7 v2 table 0074
(`http://terminology.hl7.org/CodeSystem/v2-0074`), for example `RAD` (Radiology),
`CUS` (Cardiac Ultrasound), `CTH` (Cardiac Catheterization), `OUS` (OB
Ultrasound). The table has **no endoscopy code**, so the category for endoscopy
reports is **Open** (for example SNOMED CT 423827005 Endoscopy, or a local code).

### DICOM Modality

`ImagingStudy.modality` and `ImagingStudy.series.modality` use DICOM modality
codes (`http://dicom.nema.org/resources/ontology/DCM`). Examples relevant to this
guide:

| Code | Meaning |
|---|---|
| `CT` | Computed Tomography |
| `MR` | Magnetic Resonance |
| `US` | Ultrasound |
| `MG` | Mammography |
| `CR`, `DX` | Computed / Digital Radiography |
| `NM`, `PT` | Nuclear Medicine, PET |
| `XA` | X-Ray Angiography |
| `ES` | Endoscopy |
| `OP`, `OPT` | Ophthalmic Photography, Ophthalmic Tomography |
| `XC` | External-camera Photography |
| `SM` | Slide Microscopy (whole slide imaging) |
| `ECG` | Electrocardiography |
{:.grid}
