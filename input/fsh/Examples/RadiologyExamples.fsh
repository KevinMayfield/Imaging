// Example: staging CT of the thorax, abdomen and pelvis at Manchester University
// NHS Foundation Trust (R0A). Patient MANCHESTER Sansa is an NW GMSA test patient
// (https://github.com/nw-gmsa/Testing/blob/main/MRN-Mapping.md). Practitioners,
// identifiers and report text are fictional.

Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v2-0074 = http://terminology.hl7.org/CodeSystem/v2-0074
Alias: $dcm = http://dicom.nema.org/resources/ontology/DCM
Alias: $ods = https://fhir.nhs.uk/Id/ods-organization-code
Alias: $accession = http://example.org/R0A/accession-number

RuleSet: AccessionNumberExample
* system = $accession
* value = "RAD26110001"
* assigner.identifier.value = "R0A"

// Participants

Instance:       PatientManchester
InstanceOf:     Patient
Title:          "Patient - MANCHESTER Sansa"
Description:    "NW GMSA test patient (NHS number 973 738 3192, MFT MRN R0A4990415)."
Usage:          #example
* identifier[nhsNumber].system = "https://fhir.nhs.uk/Id/nhs-number"
* identifier[nhsNumber].value = "9737383192"
* identifier[MedicalRecordNumber].value = "R0A4990415"
* identifier[MedicalRecordNumber].assigner.identifier.value = "R0A"
* name.family = "MANCHESTER"
* name.given = "Sansa"
* gender = #female
* birthDate = "1972-09-21"
* address.line = "Oxford Rd"
* address.city = "MANCHESTER"
* address.postalCode = "M13 9PL"
* generalPractitioner.identifier.system = $ods
* generalPractitioner.identifier.value = "P84673"

Instance:       OrganizationMFT
InstanceOf:     http://hl7.eu/fhir/base/StructureDefinition/organization-eu-core
Title:          "Organization - Manchester University NHS Foundation Trust"
Description:    "Manchester University NHS Foundation Trust (ODS R0A), the imaging site."
Usage:          #example
* identifier.system = $ods
* identifier.value = "R0A"
* active = true
* name = "Manchester University NHS Foundation Trust"

Instance:       PractitionerRadiologist
InstanceOf:     http://hl7.eu/fhir/base/StructureDefinition/practitioner-eu-core
Title:          "Practitioner - reporting radiologist (fictional)"
Description:    "Fictional consultant radiologist who reported the examination."
Usage:          #example
* identifier.system = "https://fhir.hl7.org.uk/Id/gmc-number"
* identifier.value = "C1234567"
* name.family = "EXAMPLE"
* name.given = "Robin"
* name.prefix = "Dr"

Instance:       PractitionerRadiographer
InstanceOf:     http://hl7.eu/fhir/base/StructureDefinition/practitioner-eu-core
Title:          "Practitioner - radiographer (fictional)"
Description:    "Fictional diagnostic radiographer who performed the examination."
Usage:          #example
* identifier.system = "https://fhir.hl7.org.uk/Id/hcpc-number"
* identifier.value = "RA123456"
* name.family = "SAMPLE"
* name.given = "Jordan"

Instance:       PractitionerRoleRadiographer
InstanceOf:     http://hl7.eu/fhir/base/StructureDefinition/practitionerRole-eu-core
Title:          "PractitionerRole - radiographer at MFT (fictional)"
Description:    "The radiographer working at MFT - the operator in ImagingStudy.series.performer."
Usage:          #example
* practitioner = Reference(PractitionerRadiographer)
* organization = Reference(OrganizationMFT)
* code = $sct#159017007 "Diagnostic radiographer"

// Request

Instance:       RadiologyServiceRequestExample
InstanceOf:     RadiologyServiceRequest
Title:          "Radiology Service Request - CT thorax, abdomen and pelvis"
Description:    "Request for a staging CT, after the RIS has accepted it and assigned an accession number."
Usage:          #example
* identifier[0].type = $v2-0203#PLAC
* identifier[0].value = "ORD-26-0001234"
* identifier[0].assigner.identifier.system = $ods
* identifier[0].assigner.identifier.value = "R0A"
* identifier[accessionNumber] insert AccessionNumberExample
* status = #completed
* intent = #order
* code.coding[nicip] = https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP#CCHAPC "CT Thorax abdomen pelvis with contrast"
* code.coding[snomedCT] = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
* subject = Reference(PatientManchester)
* authoredOn = "2026-10-26T10:15:00Z"
* reasonCode.text = "Staging of suspected colorectal cancer"

// Study

Instance:       RadiologyImagingStudyExample
InstanceOf:     RadiologyImagingStudy
Title:          "Radiology Imaging Study - CT thorax, abdomen and pelvis"
Usage:          #example
* identifier[studyInstanceUid].system = "urn:dicom:uid"
* identifier[studyInstanceUid].value = "urn:oid:2.25.170157840389855822130589223217853734980"
* status = #available
* modality = $dcm#CT "Computed Tomography"
* subject = Reference(PatientManchester)
* basedOn[ServiceRequestOrderEuImagingaccession] = Reference(RadiologyServiceRequestExample)
* basedOn[ServiceRequestOrderEuImagingaccession].identifier insert AccessionNumberExample
* started = "2026-10-28T14:02:00Z"
* procedureCode = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
* description = "CT thorax, abdomen and pelvis with contrast"
* endpoint = Reference(EndpointWADORS)
* numberOfSeries = 1
* numberOfInstances = 412
* series[0].uid = "2.25.307274614326340063188103739735467162017"
* series[0].number = 1
* series[0].modality = $dcm#CT "Computed Tomography"
* series[0].description = "Portal venous phase"
* series[0].numberOfInstances = 412
* series[0].performer[performer].actor = Reference(PractitionerRoleRadiographer)

Instance:       EndpointWADORS
InstanceOf:     Endpoint
Title:          "Endpoint - DICOMweb WADO-RS (example address)"
Description:    "DICOMweb WADO-RS endpoint from which the images can be retrieved. Example address."
Usage:          #example
* status = #active
* connectionType = http://terminology.hl7.org/CodeSystem/endpoint-connection-type#dicom-wado-rs
* managingOrganization = Reference(OrganizationMFT)
* payloadType = http://terminology.hl7.org/CodeSystem/endpoint-payload-type#any
* payloadMimeType = #application/dicom
* address = "https://pacs.example.org/dicomweb"

// Report

Instance:       RadiologyDiagnosticReportExample
InstanceOf:     RadiologyDiagnosticReport
Title:          "Radiology Diagnostic Report - CT thorax, abdomen and pelvis"
Description:    "Final report for the staging CT, with the full text in presentedForm and the FHIR document in the composition extension."
Usage:          #example
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>CT thorax, abdomen and pelvis with contrast</b> - final report, issued 29 October 2026.</p><p>Patient: MANCHESTER Sansa (NHS number 973 738 3192). Accession number RAD26110001. Imaging site: Manchester University NHS Foundation Trust (R0A). Reported by Dr Robin EXAMPLE (fictional).</p><p>Conclusion: Caecal tumour extending beyond the bowel wall, with two suspicious pericolic lymph nodes. No evidence of distant metastases. Radiological stage T3 N1 M0.</p><p>Report: PDF at <code>Binary/RadiologyReportPDF</code> (presentedForm.url).</p></div>"""
* extension[composition].valueReference = Reference(RadiologyCompositionExample)
* identifier.type = $v2-0203#FILL
* identifier.system = "http://example.org/R0A/report-identifier"
* identifier.value = "RPT-26-0005678"
* identifier.assigner.identifier.system = $ods
* identifier.assigner.identifier.value = "R0A"
* basedOn[ServiceRequestOrderEuImagingaccession] = Reference(RadiologyServiceRequestExample)
* basedOn[ServiceRequestOrderEuImagingaccession].identifier insert AccessionNumberExample
* status = #final
* category[diagnostic-service] = $v2-0074#RAD "Radiology"
* code.coding[nicip] = https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP#CCHAPC "CT Thorax abdomen pelvis with contrast"
* code.coding[loinc] = $loinc#18748-4 "Diagnostic imaging study"
* subject = Reference(PatientManchester)
* effectiveDateTime = "2026-10-28T14:20:00Z"
* issued = "2026-10-29T09:45:00Z"
* performer[organization] = Reference(OrganizationMFT)
* resultsInterpreter[author] = Reference(PractitionerRadiologist)
* imagingStudy = Reference(RadiologyImagingStudyExample)
* conclusion = "Caecal tumour extending beyond the bowel wall, with two suspicious pericolic lymph nodes. No evidence of distant metastases. Radiological stage T3 N1 M0."
* presentedForm.contentType = #application/pdf
* presentedForm.language = #en-GB
* presentedForm.url = "Binary/RadiologyReportPDF"
* presentedForm.size = 3597
* presentedForm.title = "CT thorax, abdomen and pelvis with contrast"
* presentedForm.creation = "2026-10-29T09:45:00Z"

Instance:       RadiologyCompositionExample
InstanceOf:     http://hl7.eu/fhir/imaging/StructureDefinition/CompositionEuImaging
Title:          "Composition - CT thorax, abdomen and pelvis report"
Description:    "The report as a FHIR document, required by HL7 Europe Imaging DiagnosticReportEuImaging."
Usage:          #example
* extension[diagnosticreport-reference].valueReference = Reference(RadiologyDiagnosticReportExample)
* identifier.type = $v2-0203#FILL
* identifier.system = "http://example.org/R0A/report-identifier"
* identifier.value = "RPT-26-0005678"
* identifier.assigner.identifier.system = $ods
* identifier.assigner.identifier.value = "R0A"
* status = #final
* type = $loinc#18748-4 "Diagnostic imaging study"
* category[imaging-report] = $loinc#85430-7
* category[imaging] = http://hl7.eu/fhir/health-data-api/CodeSystem/eehrxf-document-priority-category-cs#Medical-Imaging
* subject = Reference(PatientManchester)
* date = "2026-10-29T09:45:00Z"
* author[0] = Reference(PractitionerRadiologist)
* author[1] = Reference(OrganizationMFT)
* title = "CT thorax, abdomen and pelvis with contrast"
* section[imagingstudy].title = "Imaging Study"
* section[imagingstudy].text.status = #generated
* section[imagingstudy].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Examination.</b> CT thorax, abdomen and pelvis with contrast (NICIP CCHAPC). 1 series, 412 images.</p></div>"
* section[imagingstudy].entry[imagingstudy] = Reference(RadiologyImagingStudyExample)
* section[order].title = "Order"
* section[order].text.status = #generated
* section[order].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>CT thorax, abdomen and pelvis with contrast. Accession number RAD26110001. Requested by Colorectal Surgery.</p></div>"
* section[order].entry = Reference(RadiologyServiceRequestExample)
* section[history].title = "History"
* section[history].text.status = #generated
* section[history].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Clinical history.</b> Caecal mass found at colonoscopy; biopsy awaited. Staging of suspected colorectal cancer.</p></div>"
* section[history].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[history].extension[0].valueAnnotation.text = "Caecal mass found at colonoscopy; biopsy awaited. Staging of suspected colorectal cancer."
* section[procedure].title = "Procedure"
* section[procedure].text.status = #generated
* section[procedure].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Technique.</b> Portal venous phase CT of the thorax, abdomen and pelvis following 100 ml intravenous contrast. No immediate adverse reaction. DLP 820 mGy·cm.</p></div>"
* section[procedure].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[procedure].extension[0].valueAnnotation.text = "Portal venous phase CT of the thorax, abdomen and pelvis following 100 ml intravenous contrast. No immediate adverse reaction. DLP 820 mGy·cm."
* section[comparison].title = "Comparison"
* section[comparison].text.status = #generated
* section[comparison].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Comparison.</b> No previous cross-sectional imaging available.</p></div>"
* section[comparison].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[comparison].extension[0].valueAnnotation.text = "No previous cross-sectional imaging available."
* section[findings].title = "Findings"
* section[findings].text.status = #generated
* section[findings].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Findings.</b></p><p><i>Thorax:</i> No pulmonary nodules or masses. No mediastinal or hilar lymphadenopathy. No pleural effusion.</p><p><i>Abdomen and pelvis:</i> Irregular circumferential wall thickening of the caecum over 45 mm, with stranding of the adjacent pericolic fat, in keeping with the known tumour. Two pericolic lymph nodes, the largest 8 mm short axis. The liver is normal, with no focal lesion. No ascites or peritoneal deposits. The remaining bowel, kidneys, adrenals, pancreas and spleen are unremarkable. No suspicious bone lesion.</p></div>"
* section[findings].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[findings].extension[0].valueAnnotation.text = "Thorax: No pulmonary nodules or masses. No mediastinal or hilar lymphadenopathy. No pleural effusion. Abdomen and pelvis: Irregular circumferential wall thickening of the caecum over 45 mm, with stranding of the adjacent pericolic fat, in keeping with the known tumour. Two pericolic lymph nodes, the largest 8 mm short axis. The liver is normal, with no focal lesion. No ascites or peritoneal deposits. The remaining bowel, kidneys, adrenals, pancreas and spleen are unremarkable. No suspicious bone lesion."
* section[impression].title = "Impression"
* section[impression].text.status = #generated
* section[impression].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Conclusion.</b> Caecal tumour extending beyond the bowel wall, with two suspicious pericolic lymph nodes. No evidence of distant metastases. Radiological stage T3 N1 M0.</p></div>"
* section[impression].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[impression].extension[0].valueAnnotation.text = "Caecal tumour extending beyond the bowel wall, with two suspicious pericolic lymph nodes. No evidence of distant metastases. Radiological stage T3 N1 M0."
* section[recommendation].title = "Recommendation"
* section[recommendation].text.status = #generated
* section[recommendation].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Recommendation.</b> Discuss at the colorectal cancer MDT.</p></div>"
* section[recommendation].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[recommendation].extension[0].valueAnnotation.text = "Discuss at the colorectal cancer MDT."
* section[communication].title = "Communication"
* section[communication].text.status = #generated
* section[communication].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Communication.</b> Not an urgent unexpected finding. Report added to the colorectal MDT list on 29-Oct-2026.</p></div>"
* section[communication].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[communication].extension[0].valueAnnotation.text = "Not an urgent unexpected finding. Report added to the colorectal MDT list on 29-Oct-2026."

Instance:       RadiologyReportPDF
InstanceOf:     Binary
Title:          "Binary - CT thorax, abdomen and pelvis report (PDF)"
Description:    "The issued report as a PDF, referenced from DiagnosticReport.presentedForm.url. Fictional report text."
Usage:          #example
* contentType = #application/pdf
* data = "JVBERi0xLjQKMSAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4KZW5kb2JqCjMgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA1OTUgODQyXSAvQ29udGVudHMgNiAwIFIgL1Jlc291cmNlcyA8PCAvRm9udCA8PCAvRjEgNCAwIFIgL0YyIDUgMCBSID4+ID4+ID4+CmVuZG9iago0IDAgb2JqCjw8IC9UeXBlIC9Gb250IC9TdWJ0eXBlIC9UeXBlMSAvQmFzZUZvbnQgL0hlbHZldGljYSA+PgplbmRvYmoKNSAwIG9iago8PCAvVHlwZSAvRm9udCAvU3VidHlwZSAvVHlwZTEgL0Jhc2VGb250IC9IZWx2ZXRpY2EtQm9sZCA+PgplbmRvYmoKNiAwIG9iago8PCAvTGVuZ3RoIDI5NDYgPj4Kc3RyZWFtCkJUCjUwIDgwMCBUZAovRjIgMTYgVGYgMCAtMjAgVGQgKFJhZGlvbG9neSBSZXBvcnQpIFRqCi9GMiAxMiBUZiAwIC0xNiBUZCAoQ1QgVGhvcmF4IGFiZG9tZW4gcGVsdmlzIHdpdGggY29udHJhc3QpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoTWFuY2hlc3RlciBVbml2ZXJzaXR5IE5IUyBGb3VuZGF0aW9uIFRydXN0IFwoT0RTIFIwQVwpKSBUagovRjIgMTAgVGYgMCAtMTQgVGQgKEZJQ1RJVElPVVMgRVhBTVBMRSAtIG5vdCBhIHJlYWwgcGF0aWVudCBvciBhIHJlYWwgcmVwb3J0KSBUagowIC04IFRkCi9GMSAxMCBUZiAwIC0xNCBUZCAoUGF0aWVudDogTUFOQ0hFU1RFUiwgU2Fuc2EgICAgICBOSFMgTnVtYmVyOiA5NzMgNzM4IDMxOTIgXChOVyBHTVNBIHRlc3QgcGF0aWVudFwpKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKERhdGUgb2YgYmlydGg6IDIxLVNlcC0xOTcyICAgICAgTVJOOiBSMEE0OTkwNDE1KSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKEFjY2Vzc2lvbiBudW1iZXI6IFJBRDI2MTEwMDAxICAgUmVwb3J0IG51bWJlcjogUlBULTI2LTAwMDU2NzgpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoUmVxdWVzdGVkIGJ5OiBDb2xvcmVjdGFsIFN1cmdlcnkgICBSZXBvcnQgc3RhdHVzOiBGaW5hbCkgVGoKL0YxIDEwIFRmIDAgLTE0IFRkIChFeGFtaW5hdGlvbjogMjgtT2N0LTIwMjYgMTQ6MDIgICBSZXBvcnRlZDogMjktT2N0LTIwMjYgMDk6NDUpIFRqCjAgLTggVGQKL0YyIDExIFRmIDAgLTE1IFRkIChFeGFtaW5hdGlvbikgVGoKL0YxIDEwIFRmIDAgLTE0IFRkIChDVCB0aG9yYXgsIGFiZG9tZW4gYW5kIHBlbHZpcyB3aXRoIGNvbnRyYXN0IFwoTklDSVAgQ0NIQVBDXCkuIDEgc2VyaWVzLCA0MTIgaW1hZ2VzLikgVGoKMCAtOCBUZAovRjIgMTEgVGYgMCAtMTUgVGQgKENsaW5pY2FsIGhpc3RvcnkpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoQ2FlY2FsIG1hc3MgZm91bmQgYXQgY29sb25vc2NvcHk7IGJpb3BzeSBhd2FpdGVkLiBTdGFnaW5nIG9mIHN1c3BlY3RlZCBjb2xvcmVjdGFsIGNhbmNlci4pIFRqCjAgLTggVGQKL0YyIDExIFRmIDAgLTE1IFRkIChUZWNobmlxdWUpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoUG9ydGFsIHZlbm91cyBwaGFzZSBDVCBvZiB0aGUgdGhvcmF4LCBhYmRvbWVuIGFuZCBwZWx2aXMgZm9sbG93aW5nIDEwMCBtbCBpbnRyYXZlbm91cyBjb250cmFzdC4pIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoTm8gaW1tZWRpYXRlIGFkdmVyc2UgcmVhY3Rpb24uIERMUCA4MjAgbUd5LmNtLikgVGoKMCAtOCBUZAovRjIgMTEgVGYgMCAtMTUgVGQgKENvbXBhcmlzb24pIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoTm8gcHJldmlvdXMgY3Jvc3Mtc2VjdGlvbmFsIGltYWdpbmcgYXZhaWxhYmxlLikgVGoKMCAtOCBUZAovRjIgMTEgVGYgMCAtMTUgVGQgKEZpbmRpbmdzKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKFRob3JheDogTm8gcHVsbW9uYXJ5IG5vZHVsZXMgb3IgbWFzc2VzLiBObyBtZWRpYXN0aW5hbCBvciBoaWxhciBseW1waGFkZW5vcGF0aHkuIE5vIHBsZXVyYWwpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAoZWZmdXNpb24uKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKEFiZG9tZW4gYW5kIHBlbHZpczogSXJyZWd1bGFyIGNpcmN1bWZlcmVudGlhbCB3YWxsIHRoaWNrZW5pbmcgb2YgdGhlIGNhZWN1bSBvdmVyIDQ1IG1tLCB3aXRoKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKHN0cmFuZGluZyBvZiB0aGUgYWRqYWNlbnQgcGVyaWNvbGljIGZhdCwgaW4ga2VlcGluZyB3aXRoIHRoZSBrbm93biB0dW1vdXIuIFR3byBwZXJpY29saWMgbHltcGgpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAobm9kZXMsIHRoZSBsYXJnZXN0IDggbW0gc2hvcnQgYXhpcy4gVGhlIGxpdmVyIGlzIG5vcm1hbCwgd2l0aCBubyBmb2NhbCBsZXNpb24uIE5vIGFzY2l0ZXMgb3IpIFRqCi9GMSAxMCBUZiAwIC0xNCBUZCAocGVyaXRvbmVhbCBkZXBvc2l0cy4gVGhlIHJlbWFpbmluZyBib3dlbCwga2lkbmV5cywgYWRyZW5hbHMsIHBhbmNyZWFzIGFuZCBzcGxlZW4gYXJlKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKHVucmVtYXJrYWJsZS4gTm8gc3VzcGljaW91cyBib25lIGxlc2lvbi4pIFRqCjAgLTggVGQKL0YyIDExIFRmIDAgLTE1IFRkIChDb25jbHVzaW9uKSBUagovRjIgMTAgVGYgMCAtMTQgVGQgKENhZWNhbCB0dW1vdXIgZXh0ZW5kaW5nIGJleW9uZCB0aGUgYm93ZWwgd2FsbCwgd2l0aCB0d28gc3VzcGljaW91cyBwZXJpY29saWMgbHltcGggbm9kZXMuIE5vKSBUagovRjIgMTAgVGYgMCAtMTQgVGQgKGV2aWRlbmNlIG9mIGRpc3RhbnQgbWV0YXN0YXNlcy4gUmFkaW9sb2dpY2FsIHN0YWdlIFQzIE4xIE0wLikgVGoKMCAtOCBUZAovRjIgMTEgVGYgMCAtMTUgVGQgKFJlY29tbWVuZGF0aW9uKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKERpc2N1c3MgYXQgdGhlIGNvbG9yZWN0YWwgY2FuY2VyIE1EVC4pIFRqCjAgLTggVGQKL0YyIDExIFRmIDAgLTE1IFRkIChDb21tdW5pY2F0aW9uKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKE5vdCBhbiB1cmdlbnQgdW5leHBlY3RlZCBmaW5kaW5nLiBSZXBvcnQgYWRkZWQgdG8gdGhlIGNvbG9yZWN0YWwgTURUIGxpc3Qgb24gMjktT2N0LTIwMjYuKSBUagowIC04IFRkCi9GMSAxMCBUZiAwIC0xNCBUZCAoUmVwb3J0ZWQgYnk6IERyIFJvYmluIEVYQU1QTEUsIENvbnN1bHRhbnQgUmFkaW9sb2dpc3QgXChHTUMgQzEyMzQ1NjdcKSBcKGZpY3Rpb25hbFwpKSBUagovRjEgMTAgVGYgMCAtMTQgVGQgKEV4YW1pbmF0aW9uIHBlcmZvcm1lZCBieTogSm9yZGFuIFNBTVBMRSwgRGlhZ25vc3RpYyBSYWRpb2dyYXBoZXIgXChIQ1BDIFJBMTIzNDU2XCkgXChmaWN0aW9uYWxcKSkgVGoKL0YxIDEwIFRmIDAgLTE0IFRkIChWZXJpZmllZDogMjktT2N0LTIwMjYgMDk6NDUgLSBNYW5jaGVzdGVyIFVuaXZlcnNpdHkgTkhTIEZvdW5kYXRpb24gVHJ1c3QpIFRqCkVUCmVuZHN0cmVhbQplbmRvYmoKeHJlZgowIDcKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjUxIDAwMDAwIG4gCjAwMDAwMDAzMjEgMDAwMDAgbiAKMDAwMDAwMDM5NiAwMDAwMCBuIAp0cmFpbGVyCjw8IC9TaXplIDcgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjMzOTMKJSVFT0YK"

// HL7 v2 ORU^R01 OBX type ED (embedded PDF), converted following the NW GMSA
// convention: OBX-5 -> Binary (RadiologyReportPDF), OBX -> DocumentReference

Instance:       RadiologyReportDocumentReference
InstanceOf:     DocumentReference
Title:          "DocumentReference - CT thorax, abdomen and pelvis report (PDF)"
Description:    "The report PDF, converted from an HL7 v2 ORU^R01 OBX of type ED: OBX-5 becomes the Binary and the OBX becomes this DocumentReference, which points to the DiagnosticReport."
Usage:          #example
* identifier.system = "http://example.org/R0A/report-identifier"
* identifier.value = "RPT-26-0005678-PDF"
* identifier.assigner.identifier.value = "R0A"
* status = #current
* type = $sct#4201000179104 "Imaging report"
* category = $sct#721981007 "Diagnostic studies report"
* subject = Reference(PatientManchester)
* date = "2026-10-29T09:45:00Z"
* author[0] = Reference(PractitionerRadiologist)
* author[1] = Reference(OrganizationMFT)
* custodian = Reference(OrganizationMFT)
* content.attachment.contentType = #application/pdf
* content.attachment.language = #en-GB
* content.attachment.url = "Binary/RadiologyReportPDF"
* content.attachment.title = "CT thorax, abdomen and pelvis with contrast"
* content.attachment.creation = "2026-10-29T09:45:00Z"
* context.period.start = "2026-10-28T14:02:00Z"
* context.related[DiagnosticReport] = Reference(RadiologyDiagnosticReportExample)
