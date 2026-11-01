Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

// Identifiers

Profile:        RadiologicalAccessionNumber
Parent:         http://hl7.eu/fhir/imaging/StructureDefinition/AccessionNumberIdentifierEuImaging
Id:             RadiologicalAccessionNumber
Title:          "Radiological Accession Number"
Description:    """
**Proof of concept - not an authoritative source.**

The accession number issued by a RIS for an imaging request - NHS Data
Dictionary [RADIOLOGICAL ACCESSION NUMBER](https://www.datadictionary.nhs.uk/data_elements/radiological_accession_number.html).
Based on HL7 Europe Imaging `AccessionNumberIdentifierEuImaging` (type `ACSN`).
DICOM (0008,0050) Accession Number, with the issuer in (0008,0051); HL7 v2 CX
with CX.5 `ACSN` and CX.6 the assigning facility.

Accession numbers are unique only within the issuing RIS, so `system` must
identify the issuer. A convention for the `system` URI is **Open**.
"""
* ^experimental = true
* type = $v2-0203#ACSN
* system MS
* system ^short = "Identifies the issuing RIS / organisation - convention Open"
* value MS
* value ^short = "Accession number (DICOM 0008,0050; HL7 v2 CX.1)"
* assigner MS
* assigner ^short = "Issuing organisation (HL7 v2 CX.6; DICOM 0008,0051)"
* assigner.identifier.system = "https://fhir.nhs.uk/Id/ods-organization-code"
* assigner.identifier ^short = "ODS code of the issuing organisation"

// Request

Profile:        RadiologyServiceRequest
Parent:         http://hl7.eu/fhir/imaging/StructureDefinition/ServiceRequestOrderEuImaging
Id:             RadiologyServiceRequest
Title:          "Radiology Service Request"
Description:    """
**Proof of concept - not an authoritative source.**

An imaging request from the Order Placer (EPR or order communications) to the
Order Filler (RIS), in IHE Radiology Scheduled Workflow. Based on HL7 Europe
Imaging `ServiceRequestOrderEuImaging`, with the NICIP / SNOMED CT procedure and
the radiological accession number.
"""
* ^experimental = true
* identifier MS
* identifier ^short = "Placer order number, and the accession number once the RIS has accepted the request"
* identifier[accessionNumber] only RadiologicalAccessionNumber
* identifier[accessionNumber] MS
* code MS
* code ^short = "Imaging procedure requested - NICIP code and its SNOMED CT map"
* code from UKImagingProcedure (preferred)
* subject MS
* reasonCode MS
* reasonCode ^short = "Clinical question / reason for the request"
* supportingInfo MS
* supportingInfo ^short = "Clinical history and other information supporting the request"

// Study

Profile:        RadiologyImagingStudy
Parent:         http://hl7.eu/fhir/imaging/StructureDefinition/ImagingStudyEuImaging
Id:             RadiologyImagingStudy
Title:          "Radiology Imaging Study"
Description:    """
**Proof of concept - not an authoritative source.**

Metadata of a DICOM imaging study - not the pixel data. Based on HL7 Europe
Imaging `ImagingStudyEuImaging`. Elements map to the DICOM General Study and
General Series modules - see [FHIR Resources](DataModel.html#imaging-study-data-items).
"""
* ^experimental = true
* identifier MS
* identifier ^short = "Study Instance UID (0020,000D)"
* basedOn MS
* basedOn[ServiceRequestOrderEuImagingaccession] only Reference(RadiologyServiceRequest)
* basedOn[ServiceRequestOrderEuImagingaccession].identifier only RadiologicalAccessionNumber
* basedOn[ServiceRequestOrderEuImagingaccession] ^short = "The request, identified by its accession number (0008,0050)"
* started MS
* started ^short = "Study Date (0008,0020) and Study Time (0008,0030)"
* procedureCode MS
* procedureCode ^short = "Procedure Code Sequence (0008,1032) - NICIP code and its SNOMED CT map"
* procedureCode from UKImagingProcedure (extensible)
* description MS
* description ^short = "Study Description (0008,1030)"
* referrer MS
* referrer ^short = "Referring Physician's Name (0008,0090)"
* interpreter MS
* interpreter ^short = "Name of Physician(s) Reading Study (0008,1060)"
* series MS
* series.modality MS
* series.modality ^short = "Modality (0008,0060)"
* series.performer[performer] MS
* series.performer[performer] ^short = "Operator - the radiographer who performed the examination (0008,1070, 0008,1072)"
* endpoint MS
* endpoint ^short = "Where the images can be retrieved, for example DICOMweb WADO-RS"

// Report

Profile:        RadiologyDiagnosticReport
Parent:         http://hl7.eu/fhir/imaging/StructureDefinition/DiagnosticReportEuImaging
Id:             RadiologyDiagnosticReport
Title:          "Radiology Diagnostic Report"
Description:    """
**Proof of concept - not an authoritative source.**

A radiology report. Based on HL7 Europe Imaging `DiagnosticReportEuImaging`, so
the report is also a FHIR document (`CompositionEuImaging`, via the
`composition` extension). Element descriptions show the
[Radiology Report](StructureDefinition-RadiologyReport.html) data items, which
follow the Royal College of Radiologists' report data for reporting networks.

The examination (NICIP / SNOMED CT) is carried on the request
([Radiology Service Request](StructureDefinition-RadiologyServiceRequest.html)
`code`) and the study ([Radiology Imaging Study](StructureDefinition-RadiologyImagingStudy.html)
`procedureCode`). `DiagnosticReport.code` is the report type, as in HL7 Europe
Imaging.
"""
* ^experimental = true
* identifier MS
* identifier only ReportIdentifier
* identifier ^short = "Report identifier (HL7 v2 OBR-3)"
* basedOn MS
* basedOn[ServiceRequestOrderEuImagingaccession] only Reference(RadiologyServiceRequest)
* basedOn[ServiceRequestOrderEuImagingaccession].identifier only RadiologicalAccessionNumber
* basedOn[ServiceRequestOrderEuImagingaccession] ^short = "The request, identified by its accession number"
* status MS
* category MS
* category[diagnostic-service] MS
* category[diagnostic-service] ^short = "Diagnostic service section, for example RAD (HL7 v2 OBR-24)"
* code MS
* code ^short = "Report type, for example LOINC 18748-4 Diagnostic imaging study"
* subject MS
* subject ^short = "Patient, identified by NHS number"
* encounter MS
* encounter ^short = "Visit number (HL7 v2 PV1-19)"
* effective[x] MS
* effective[x] ^short = "Examination completed (HL7 v2 OBR-7 / OBR-8)"
* issued MS
* issued ^short = "Final report issued (HL7 v2 OBR-22)"
* performer MS
* performer[organization] MS
* performer[organization] ^short = "Imaging site (SITE CODE (OF IMAGING) or ODS organisation code - Open)"
* resultsInterpreter MS
* resultsInterpreter ^short = "Primary reporter (OBR-32) and secondary reporters (OBR-33)"
* resultsInterpreter ^comment = "Radiologists or reporting radiographers, identified by professional registration number (GMC, HCPC). How to distinguish the primary from secondary reporters is Open - the NHS England draft used the performerFunction extension with v3 ParticipationType PPRF / SPRF."
* imagingStudy MS
* imagingStudy only Reference(RadiologyImagingStudy)
* conclusion MS
* conclusion ^short = "Conclusion of the report"
* presentedForm MS
* presentedForm ^short = "The report as issued (HL7 v2 OBX-5), for example PDF or text"
