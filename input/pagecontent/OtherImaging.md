<div class="alert alert-danger" role="alert">
<b>Proof of concept.</b> This implementation guide is a demonstration only. It is
<b>not</b> an authoritative source, is not endorsed by NHS England, IHE or HL7, and
must not be used for implementation or clinical purposes. It is background for the
<a href="https://nw-gmsa.github.io/CancerPathologyReport/">Cancer Pathology Report</a>
proof of concept.
</div>

Apart from radiology and endoscopy, several specialties produce clinical images.
They usually have their own departmental systems and store images in the
enterprise archive (VNA) where the trust has one. This page is a short overview;
local systems are **To confirm** for each trust.

### Summary

| Specialty | Images | DICOM modality | Notes |
|---|---|---|---|
| Cardiology | Echocardiography, cardiac catheterisation, ECG waveforms | `US`, `XA`, `ECG` | Often a cardiovascular PACS or cardiology information system, separate from radiology PACS |
| Ophthalmology | Retinal photography, optical coherence tomography (OCT) | `OP`, `OPT` | Often held in an ophthalmology EPR or device-vendor image management system |
| Medical photography | Clinical photographs, for example dermatology, wounds, plastic surgery | `XC` (external camera) | Captured by medical illustration services or mobile apps; often non-DICOM |
| Obstetric and point-of-care ultrasound | Ultrasound outside radiology | `US` | Obstetric ultrasound is often reported in the maternity system |
| Digital pathology | Whole slide images, gross specimen photographs | `SM` (slide microscopy), `XC` | See below |
{:.grid}

### Digital Pathology

**Digital pathology** scans glass slides into **whole slide images (WSI)** so
that pathologists can report on screen. It is pathology imaging, not radiology:
it changes how slides are viewed, not the content of the pathology report.

- [IHE PaLM Digital Pathology Workflow - Image Acquisition (DPIA)](https://www.ihe.net/uploadedFiles/Documents/PaLM/IHE_PaLM_Suppl_DPIA.pdf)
  (trial implementation) defines how an **Acquisition Manager** (usually the LIMS)
  tells an **Acquisition Modality** (the slide scanner) which slides to scan.
- [IHE PaLM Digital Pathology Ordering & Workflow (DPOW)](https://build.fhir.org/ig/IHE/PaLM.DPOW/)
  builds on DPIA.
- Images are stored as **DICOM WSI** (modality `SM`) where the scanner and archive
  support it, and can share the trust's VNA.

In the [Cancer Pathology Report](https://nw-gmsa.github.io/CancerPathologyReport/)
IG the slides and blocks are derived specimens; the report itself does not
change with digital pathology.
