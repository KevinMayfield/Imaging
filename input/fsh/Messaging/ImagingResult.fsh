// FHIR Messaging for the IHE RAD Results Distribution HL7 v2.5.1 result message
// (ORU^R01) - Send Imaging Result [RAD-128]. Same pattern as ImagingOrder.fsh; the
// report PDF follows the NW GMSA OBX type ED convention (DocumentReference + Binary).

Alias: $v2-0003 = http://terminology.hl7.org/CodeSystem/v2-0003
Alias: $ods-code = https://fhir.nhs.uk/Id/ods-organization-code

// Message definition

Instance: imaging-result
InstanceOf: MessageDefinition
Title: "Message Definition - Imaging Result (R01)"
Description: "FHIR Message equivalent of the IHE RAD Results Distribution HL7 v2.5.1 `ORU^R01^ORU_R01` result message - Send Imaging Result [RAD-128]. The focus is the Radiology Diagnostic Report."
Usage: #definition
* url = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/imaging-result"
* name = "ImagingResult"
* title = "Imaging Result (R01)"
* status = #draft
* experimental = true
* date = "2026-11-01"
* eventCoding = $v2-0003#R01 "ORU/ACK - Unsolicited transmission of an observation message"
* category = #consequence
* description = """
FHIR Message equivalent of the IHE RAD Results Distribution HL7 v2.5.1
`ORU^R01^ORU_R01` message, sent by the Report Creator / Report Manager (RIS reporting)
to the Report Consumer (EPR) for [Send Imaging Result [RAD-128]](RAD-128.html).

The ORC / OBR become the
[Radiology Diagnostic Report](StructureDefinition-RadiologyDiagnosticReport.html) - see
the [Radiology Report](StructureDefinition-RadiologyReport.html) logical model mappings.
A report PDF in an OBX of type `ED` (PDF Option) becomes a
[DocumentReference](StructureDefinition-DocumentReference.html) and a
[Binary](StructureDefinition-Binary.html), carried in the message; the DiagnosticReport
points to the Binary through `presentedForm.url` (NW GMSA convention).

The HL7 v2 acknowledgement `ACK^R01` is a FHIR response message
(`MessageHeader.response`).
"""
* focus[+]
  * code = #DiagnosticReport
  * profile = "https://fhir.nwgenomics.nhs.uk/Imaging/StructureDefinition/RadiologyDiagnosticReport"
  * min = 1
  * max = "1"
* responseRequired = #always

// Example: RAD-128 send imaging result

Instance: ImagingResultMessage
InstanceOf: BundleMessage
Title: "Bundle Message - Imaging Result (R01) [RAD-128]"
Description: "FHIR Message equivalent of an HL7 v2.5.1 ORU^R01 from RIS reporting to the EPR: the staging CT report for Sansa MANCHESTER, with the report PDF as DocumentReference + Binary."
Usage: #example
* identifier.system = "https://ris.example.nhs.uk/Id/message"
* identifier.value = "RIS-MSG-0005790"
* type = #message
* timestamp = "2026-10-29T09:10:00Z"
* entry[message].fullUrl = "https://fhir.example.nhs.uk/R4/MessageHeader/ImagingResultMessageHeader"
* entry[message].resource = ImagingResultMessageHeader
* entry[1].fullUrl = "https://fhir.example.nhs.uk/R4/DiagnosticReport/RadiologyDiagnosticReportExample"
* entry[1].resource = RadiologyDiagnosticReportExample
* entry[2].fullUrl = "https://fhir.example.nhs.uk/R4/Composition/RadiologyCompositionExample"
* entry[2].resource = RadiologyCompositionExample
* entry[3].fullUrl = "https://fhir.example.nhs.uk/R4/DocumentReference/RadiologyReportDocumentReference"
* entry[3].resource = RadiologyReportDocumentReference
* entry[4].fullUrl = "https://fhir.example.nhs.uk/R4/Binary/RadiologyReportPDF"
* entry[4].resource = RadiologyReportPDF
* entry[5].fullUrl = "https://fhir.example.nhs.uk/R4/Patient/PatientManchester"
* entry[5].resource = PatientManchester
* entry[6].fullUrl = "https://fhir.example.nhs.uk/R4/Practitioner/PractitionerRadiologist"
* entry[6].resource = PractitionerRadiologist
* entry[7].fullUrl = "https://fhir.example.nhs.uk/R4/Organization/OrganizationMFT"
* entry[7].resource = OrganizationMFT

Instance: ImagingResultMessageHeader
InstanceOf: MessageHeader
Usage: #inline
* id = "ImagingResultMessageHeader"
* meta.lastUpdated = "2026-10-29T09:10:00Z"
* eventCoding = $v2-0003#R01 "ORU/ACK - Unsolicited transmission of an observation message"
* destination.endpoint = "https://epr.example.nhs.uk/R4/$process-message"
* destination.receiver.identifier.system = $ods-code
* destination.receiver.identifier.value = "R0A"
* sender.identifier.system = $ods-code
* sender.identifier.value = "R0A"
* source.endpoint = "https://ris.example.nhs.uk/R4"
* focus = Reference(DiagnosticReport/RadiologyDiagnosticReportExample)
* definition = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/imaging-result"
