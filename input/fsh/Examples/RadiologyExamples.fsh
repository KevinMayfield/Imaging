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
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>CT thorax, abdomen and pelvis with contrast</b> - final report, issued 29 October 2026.</p><p>Patient: MANCHESTER Sansa (NHS number 973 738 3192). Accession number RAD26110001. Imaging site: Manchester University NHS Foundation Trust (R0A). Reported by Dr Robin EXAMPLE (fictional).</p><p>Conclusion: Example conclusion for a proof-of-concept report.</p><p>Report: PDF at <code>Binary/RadiologyReportPDF</code> (presentedForm.url).</p></div>"""
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
* conclusion = "Example conclusion for a proof-of-concept report."
* presentedForm.contentType = #application/pdf
* presentedForm.language = #en-GB
* presentedForm.url = "Binary/RadiologyReportPDF"
* presentedForm.size = 1243
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
* section[imagingstudy].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">CT thorax, abdomen and pelvis with contrast, 28 October 2026, 1 series, 412 instances.</div>"
* section[imagingstudy].entry[imagingstudy] = Reference(RadiologyImagingStudyExample)
* section[order].title = "Order"
* section[order].text.status = #generated
* section[order].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">CT thorax, abdomen and pelvis with contrast. Accession number RAD26110001.</div>"
* section[order].entry = Reference(RadiologyServiceRequestExample)
* section[history].title = "History"
* section[history].text.status = #generated
* section[history].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Staging of suspected colorectal cancer.</div>"
* section[history].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[history].extension[0].valueAnnotation.text = "Staging of suspected colorectal cancer."
* section[procedure].title = "Procedure"
* section[procedure].text.status = #generated
* section[procedure].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Portal venous phase CT of the thorax, abdomen and pelvis following intravenous contrast.</div>"
* section[procedure].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[procedure].extension[0].valueAnnotation.text = "Portal venous phase CT of the thorax, abdomen and pelvis following intravenous contrast."
* section[findings].title = "Findings"
* section[findings].text.status = #generated
* section[findings].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Example findings for a proof-of-concept report. Not a real patient or a real report.</div>"
* section[findings].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[findings].extension[0].valueAnnotation.text = "Example findings for a proof-of-concept report. Not a real patient or a real report."
* section[impression].title = "Impression"
* section[impression].text.status = #generated
* section[impression].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Example conclusion for a proof-of-concept report.</div>"
* section[impression].extension[0].url = "http://hl7.org/fhir/StructureDefinition/note"
* section[impression].extension[0].valueAnnotation.text = "Example conclusion for a proof-of-concept report."

Instance:       RadiologyReportPDF
InstanceOf:     Binary
Title:          "Binary - CT thorax, abdomen and pelvis report (PDF)"
Description:    "The issued report as a PDF, referenced from DiagnosticReport.presentedForm.url. Fictional report text."
Usage:          #example
* contentType = #application/pdf
* data = "JVBERi0xLjQKMSAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4KZW5kb2JqCjMgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA1OTUgODQyXSAvQ29udGVudHMgNSAwIFIgL1Jlc291cmNlcyA8PCAvRm9udCA8PCAvRjEgNCAwIFIgPj4gPj4gPj4KZW5kb2JqCjQgMCBvYmoKPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+CmVuZG9iago1IDAgb2JqCjw8IC9MZW5ndGggNjk4ID4+CnN0cmVhbQpCVCAvRjEgMTAgVGYgNTAgNzkwIFRkIDE0IFRMCihDVCBUSE9SQVgsIEFCRE9NRU4gQU5EIFBFTFZJUyBXSVRIIENPTlRSQVNUKSBUaiBUKgooUGF0aWVudDogTUFOQ0hFU1RFUiBTYW5zYSAgTkhTIG51bWJlciA5NzMgNzM4IDMxOTIgXChOVyBHTVNBIHRlc3QgcGF0aWVudFwpKSBUaiBUKgooQWNjZXNzaW9uIG51bWJlciBSQUQyNjExMDAwMSAgTWFuY2hlc3RlciBVbml2ZXJzaXR5IE5IUyBGb3VuZGF0aW9uIFRydXN0KSBUaiBUKgooKSBUaiBUKgooQ2xpbmljYWwgaGlzdG9yeTogU3RhZ2luZyBvZiBzdXNwZWN0ZWQgY29sb3JlY3RhbCBjYW5jZXIuKSBUaiBUKgooVGVjaG5pcXVlOiBQb3J0YWwgdmVub3VzIHBoYXNlIENUIG9mIHRoZSB0aG9yYXgsIGFiZG9tZW4gYW5kIHBlbHZpcykgVGogVCoKKGZvbGxvd2luZyBpbnRyYXZlbm91cyBjb250cmFzdC4pIFRqIFQqCihGaW5kaW5nczogRXhhbXBsZSBmaW5kaW5ncyBmb3IgYSBwcm9vZi1vZi1jb25jZXB0IHJlcG9ydC4pIFRqIFQqCihOb3QgYSByZWFsIHBhdGllbnQgb3IgYSByZWFsIHJlcG9ydC4pIFRqIFQqCihDb25jbHVzaW9uOiBFeGFtcGxlIGNvbmNsdXNpb24gZm9yIGEgcHJvb2Ytb2YtY29uY2VwdCByZXBvcnQuKSBUaiBUKgooKSBUaiBUKgooUmVwb3J0ZWQgYnkgRHIgUm9iaW4gRVhBTVBMRSBcKGZpY3Rpb25hbFwpLCAyOSBPY3RvYmVyIDIwMjYpIFRqIFQqCkVUCmVuZHN0cmVhbQplbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgoxMDU5CiUlRU9GCg=="

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
