Logical:        RadiologyReport
Id:             RadiologyReport
Title:          "Radiology Report"
Description:    """
**Proof of concept - not an authoritative source.**

The data items of a radiology report shared between RIS, PACS and reporting
networks, based on the Royal College of Radiologists'
[Radiology reporting networks: understanding the technical options](https://www.rcr.ac.uk/media/wwtp2mif/rcr-publications_radiology-reporting-networks-understanding-the-technical-options_march-2022.pdf)
(March 2022), as mapped in an earlier NHS England draft radiology IG for the
National Imaging Registry. The items have **not** been checked against the RCR
text, and cardinalities are this guide's assumption (**To confirm**).

Indicative HL7 v2 (ORU^R01), DICOM and FHIR mappings are shown on the
**Mappings** tab. The FHIR representation is [Radiology Diagnostic Report](StructureDefinition-RadiologyDiagnosticReport.html),
with the request in [Radiology Service Request](StructureDefinition-RadiologyServiceRequest.html)
and the study in [Radiology Imaging Study](StructureDefinition-RadiologyImagingStudy.html).
"""
Characteristics: #can-be-target

// Identification

* ^experimental = true
* reportIdentifier 0..1 Identifier "Report identifier" "Identifier of the report in the RIS"
* patient 1..1 Identifier "Patient" "NHS number of the patient (NHS NUMBER)"
* accessionNumber 1..1 Identifier "Accession number" "Identifies the imaging request in the issuing RIS; shared by the request, the DICOM study and the report (RADIOLOGICAL ACCESSION NUMBER)"
* visitNumber 0..1 Identifier "Visit number" "Encounter or visit the examination belongs to"

// Examination

* examination 1..* CodeableConcept "Examination" "Imaging procedure performed - NICIP code with SNOMED CT map (IMAGING CODE (NICIP))"
* diagnosticServiceSection 0..1 CodeableConcept "Diagnostic service section" "For example RAD (Radiology), from HL7 v2 table 0074"
* examinationCompleted 0..1 dateTime "Examination completed" "Date and time the radiographer completed the examination"
* imagingSite 0..1 Identifier "Imaging site" "Where the examination was performed (SITE CODE (OF IMAGING), or ODS organisation code - Open)"
* operator 0..* Identifier "Operator" "Radiographer who performed the examination - professional registration number (HCPC)"

// Report

* reportIssued 0..1 dateTime "Final report issued" "Date and time the final report was issued"
* primaryReporter 0..1 Identifier "Primary reporter" "Radiologist or reporting radiographer responsible for the report - professional registration number (GMC, HCPC)"
* secondaryReporter 0..* Identifier "Secondary reporter" "Other reporter, for example a trainee or second reader - professional registration number"
* clinicalHistory 0..1 string "Clinical history" "Narrative clinical history from the request"
* radiographerComments 0..1 string "Radiographer comments" "Comments recorded by the radiographer"
* reportText 1..1 string "Report text" "The narrative report as issued"
* conclusion 0..1 string "Conclusion" "Summary conclusion of the report. Whether the RCR data set separates it from the report text is Open"

Mapping:        RadiologyReport-HL7v2
Source:         RadiologyReport
Target:         "http://hl7.org/v2"
Id:             hl7v2
Title:          "HL7 v2 ORU^R01 (indicative)"
* reportIdentifier -> "OBR-3 Filler Order Number"
* patient -> "PID-3 Patient Identifier List"
* accessionNumber -> "ORC-3 / OBR-3 Filler Order Number"
* visitNumber -> "PV1-19 Visit Number"
* examination -> "OBR-4 Universal Service Identifier"
* diagnosticServiceSection -> "OBR-24 Diagnostic Serv Sect ID"
* examinationCompleted -> "OBR-7 Observation Date/Time, OBR-8 Observation End Date/Time"
* imagingSite -> "PV1-3 Assigned Patient Location (facility)"
* operator -> "OBR-34 Technician"
* reportIssued -> "OBR-22 Results Rpt/Status Chng - Date/Time"
* primaryReporter -> "OBR-32 Principal Result Interpreter"
* secondaryReporter -> "OBR-33 Assistant Result Interpreter"
* clinicalHistory -> "OBX-5"
* radiographerComments -> "NTE-3"
* reportText -> "OBX-5"

Mapping:        RadiologyReport-DICOM
Source:         RadiologyReport
Target:         "http://dicom.nema.org/medical/dicom/current/output/chtml/part03/"
Id:             dicom
Title:          "DICOM (indicative)"
* patient -> "(0010,0020) Patient ID"
* accessionNumber -> "(0008,0050) Accession Number, (0008,0051) Issuer of Accession Number Sequence"
* examination -> "(0008,1032) Procedure Code Sequence"
* imagingSite -> "(0008,0082) Institution Code Sequence"
* operator -> "(0008,1070) Operators' Name, (0008,1072) Operator Identification Sequence"
* primaryReporter -> "(0008,1060) Name of Physician(s) Reading Study, (0008,1062) Physician(s) Reading Study Identification Sequence"
* secondaryReporter -> "(0008,1062) Physician(s) Reading Study Identification Sequence"
* reportText -> "DICOM Structured Report"

Mapping:        RadiologyReport-FHIR
Source:         RadiologyReport
Target:         "http://hl7.org/fhir"
Id:             fhir
Title:          "FHIR (this guide's profiles)"
* reportIdentifier -> "DiagnosticReport.identifier"
* patient -> "DiagnosticReport.subject"
* accessionNumber -> "ServiceRequest.identifier:accessionNumber, DiagnosticReport.basedOn.identifier, ImagingStudy.basedOn.identifier"
* visitNumber -> "DiagnosticReport.encounter"
* examination -> "ServiceRequest.code, ImagingStudy.procedureCode, Procedure.code (DiagnosticReport.extension:procedure)"
* diagnosticServiceSection -> "DiagnosticReport.category:diagnostic-service"
* examinationCompleted -> "DiagnosticReport.effective[x]"
* imagingSite -> "DiagnosticReport.performer:organization"
* operator -> "ImagingStudy.series.performer:performer"
* reportIssued -> "DiagnosticReport.issued"
* primaryReporter -> "DiagnosticReport.resultsInterpreter"
* secondaryReporter -> "DiagnosticReport.resultsInterpreter"
* clinicalHistory -> "ServiceRequest.reasonCode / supportingInfo; DiagnosticReport.extension:patientHistory (references to the relevant resources)"
* radiographerComments -> "DiagnosticReport.extension:note"
* reportText -> "DiagnosticReport.presentedForm; Composition (DiagnosticReport.extension:composition)"
* conclusion -> "DiagnosticReport.conclusion (coded impressions: DiagnosticReport.extension:impression)"
