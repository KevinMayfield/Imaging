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
InstanceOf:     http://hl7.eu/fhir/base/StructureDefinition/patient-eu-core
Title:          "Patient - MANCHESTER Sansa"
Description:    "NW GMSA test patient (NHS number 973 738 3192, MFT MRN R0A4990415)."
Usage:          #example
* identifier[0].system = "https://fhir.nhs.uk/Id/nhs-number"
* identifier[0].value = "9737383192"
* identifier[1].type = $v2-0203#MR
* identifier[1].value = "R0A4990415"
* identifier[1].assigner.identifier.system = $ods
* identifier[1].assigner.identifier.value = "R0A"
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
* code = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
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
* code = $loinc#18748-4 "Diagnostic imaging study"
* subject = Reference(PatientManchester)
* effectiveDateTime = "2026-10-28T14:20:00Z"
* issued = "2026-10-29T09:45:00Z"
* performer[organization] = Reference(OrganizationMFT)
* resultsInterpreter[author] = Reference(PractitionerRadiologist)
* imagingStudy = Reference(RadiologyImagingStudyExample)
* conclusion = "Example conclusion for a proof-of-concept report."
* presentedForm.contentType = #text/plain
* presentedForm.language = #en-GB
* presentedForm.title = "CT thorax, abdomen and pelvis with contrast"
* presentedForm.data = "Q1QgVEhPUkFYLCBBQkRPTUVOIEFORCBQRUxWSVMgV0lUSCBDT05UUkFTVAoKQ2xpbmljYWwgaGlzdG9yeTogU3RhZ2luZyBvZiBzdXNwZWN0ZWQgY29sb3JlY3RhbCBjYW5jZXIuCgpUZWNobmlxdWU6IFBvcnRhbCB2ZW5vdXMgcGhhc2UgQ1Qgb2YgdGhlIHRob3JheCwgYWJkb21lbiBhbmQgcGVsdmlzIGZvbGxvd2luZyBpbnRyYXZlbm91cyBjb250cmFzdC4KCkZpbmRpbmdzOiBFeGFtcGxlIGZpbmRpbmdzIGZvciBhIHByb29mLW9mLWNvbmNlcHQgcmVwb3J0LiBOb3QgYSByZWFsIHBhdGllbnQgb3IgYSByZWFsIHJlcG9ydC4KCkNvbmNsdXNpb246IEV4YW1wbGUgY29uY2x1c2lvbiBmb3IgYSBwcm9vZi1vZi1jb25jZXB0IHJlcG9ydC4K"

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
