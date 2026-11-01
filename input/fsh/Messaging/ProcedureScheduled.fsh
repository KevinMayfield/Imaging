// FHIR Messaging for the IHE SWF.b HL7 v2.5.1 imaging order message (OMI^O23) -
// Procedure Scheduled [RAD-4] and Procedure Update [RAD-13]. Same pattern as
// ImagingOrder.fsh.

Alias: $v2-0003 = http://terminology.hl7.org/CodeSystem/v2-0003
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $ods-code = https://fhir.nhs.uk/Id/ods-organization-code
Alias: $sct = http://snomed.info/sct
Alias: $nicip = https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP
Alias: $dcm = http://dicom.nema.org/resources/ontology/DCM

// Message definition

Instance: procedure-scheduled
InstanceOf: MessageDefinition
Title: "Message Definition - Procedure Scheduled (O23)"
Description: "FHIR Message equivalent of the IHE SWF.b HL7 v2.5.1 `OMI^O23^OMI_O23` imaging order message - Procedure Scheduled [RAD-4] and Procedure Update [RAD-13]. The focus is the Radiology Service Request and the scheduled Radiology Imaging Study."
Usage: #definition
* url = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/procedure-scheduled"
* name = "ProcedureScheduled"
* title = "Procedure Scheduled (O23)"
* status = #draft
* experimental = true
* date = "2026-11-01"
* eventCoding = $v2-0003#O23 "OMI - Imaging order"
* category = #consequence
* description = """
FHIR Message equivalent of the IHE SWF.b HL7 v2.5.1 `OMI^O23^OMI_O23` message, sent by
the Order Filler (RIS) to the Image Manager / Image Archive (PACS) for
[Procedure Scheduled [RAD-4]](RAD-4.html) and Procedure Update [RAD-13].

Each ORC-TQ1-OBR-IPC group (one per Requested Procedure) becomes a
[Radiology Service Request](StructureDefinition-RadiologyServiceRequest.html) and a
[Radiology Imaging Study](StructureDefinition-RadiologyImagingStudy.html) with
`status` registered - the study before any images are acquired:

| IPC field | FHIR |
|---|---|
| IPC-1 Accession Identifier | `ServiceRequest.identifier:accessionNumber`, `ImagingStudy.basedOn.identifier` |
| IPC-2 Requested Procedure ID | `ServiceRequest.identifier` |
| IPC-3 Study Instance UID | `ImagingStudy.identifier:studyInstanceUid` |
| IPC-4 Scheduled Procedure Step ID | - |
| IPC-5 Modality | `ImagingStudy.modality` |

For RAD-13 the message carries the updated ServiceRequest and ImagingStudy; a
cancellation sets `ServiceRequest.status` revoked and `ImagingStudy.status` cancelled.
The ORC-1 codes used by RAD-13 are **To confirm** against IHE RAD TF-2 section 4.13.

The HL7 v2 acknowledgement `ORI^O24^ORI_O24` is a FHIR response message
(`MessageHeader.response`).
"""
* focus[+]
  * code = #ServiceRequest
  * profile = "https://fhir.nwgenomics.nhs.uk/Imaging/StructureDefinition/RadiologyServiceRequest"
  * min = 1
  * max = "*"
* focus[+]
  * code = #ImagingStudy
  * profile = "https://fhir.nwgenomics.nhs.uk/Imaging/StructureDefinition/RadiologyImagingStudy"
  * min = 1
  * max = "*"
* responseRequired = #always

// Example: RAD-4 procedure scheduled

Instance: RadiologyServiceRequestScheduled
InstanceOf: RadiologyServiceRequest
Title: "Radiology Service Request - CT thorax, abdomen and pelvis, scheduled"
Description: "The staging CT request after the RIS has accepted and scheduled it and assigned an accession number [RAD-4]."
Usage: #example
* identifier[0].type = $v2-0203#PLAC
* identifier[0].value = "ORD-26-0001234"
* identifier[0].assigner.identifier.system = $ods-code
* identifier[0].assigner.identifier.value = "R0A"
* identifier[accessionNumber] insert AccessionNumberExample
* status = #active
* intent = #order
* code.coding[nicip] = $nicip#CCHAPC "CT Thorax abdomen pelvis with contrast"
* code.coding[snomedCT] = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
* subject = Reference(PatientManchester)
* authoredOn = "2026-10-26T10:15:00Z"
* occurrenceDateTime = "2026-10-28T14:00:00Z"
* reasonCode.text = "Staging of suspected colorectal cancer"

Instance: RadiologyImagingStudyScheduled
InstanceOf: RadiologyImagingStudy
Title: "Radiology Imaging Study - CT thorax, abdomen and pelvis, scheduled"
Description: "The scheduled study sent to PACS in Procedure Scheduled [RAD-4]: the Study Instance UID (IPC-3) and modality (IPC-5), before any images are acquired."
Usage: #example
* identifier[studyInstanceUid].system = "urn:dicom:uid"
* identifier[studyInstanceUid].value = "urn:oid:2.25.170157840389855822130589223217853734980"
* status = #registered
* modality = $dcm#CT "Computed Tomography"
* subject = Reference(PatientManchester)
* basedOn[ServiceRequestOrderEuImagingaccession] = Reference(RadiologyServiceRequestScheduled)
* basedOn[ServiceRequestOrderEuImagingaccession].identifier insert AccessionNumberExample
* procedureCode = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
* description = "CT thorax, abdomen and pelvis with contrast"

Instance: ProcedureScheduledMessage
InstanceOf: BundleMessage
Title: "Bundle Message - Procedure Scheduled (O23) [RAD-4]"
Description: "FHIR Message equivalent of an HL7 v2.5.1 OMI^O23 from the Order Filler (RIS) to the Image Manager (PACS): the staging CT for Sansa MANCHESTER has been scheduled."
Usage: #example
* identifier.system = "https://ris.example.nhs.uk/Id/message"
* identifier.value = "RIS-MSG-0005601"
* type = #message
* timestamp = "2026-10-27T09:00:00Z"
* entry[message].fullUrl = "https://fhir.example.nhs.uk/R4/MessageHeader/ProcedureScheduledMessageHeader"
* entry[message].resource = ProcedureScheduledMessageHeader
* entry[1].fullUrl = "https://fhir.example.nhs.uk/R4/ServiceRequest/RadiologyServiceRequestScheduled"
* entry[1].resource = RadiologyServiceRequestScheduled
* entry[2].fullUrl = "https://fhir.example.nhs.uk/R4/ImagingStudy/RadiologyImagingStudyScheduled"
* entry[2].resource = RadiologyImagingStudyScheduled
* entry[3].fullUrl = "https://fhir.example.nhs.uk/R4/Patient/PatientManchester"
* entry[3].resource = PatientManchester

Instance: ProcedureScheduledMessageHeader
InstanceOf: MessageHeader
Usage: #inline
* id = "ProcedureScheduledMessageHeader"
* meta.lastUpdated = "2026-10-27T09:00:00Z"
* eventCoding = $v2-0003#O23 "OMI - Imaging order"
* destination.endpoint = "https://pacs.example.nhs.uk/R4/$process-message"
* destination.receiver.identifier.system = $ods-code
* destination.receiver.identifier.value = "R0A"
* sender.identifier.system = $ods-code
* sender.identifier.value = "R0A"
* source.endpoint = "https://ris.example.nhs.uk/R4"
* focus[0] = Reference(ServiceRequest/RadiologyServiceRequestScheduled)
* focus[1] = Reference(ImagingStudy/RadiologyImagingStudyScheduled)
* definition = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/procedure-scheduled"
