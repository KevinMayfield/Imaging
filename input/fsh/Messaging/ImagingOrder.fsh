// FHIR Messaging for the IHE SWF.b HL7 v2.5.1 order messages (OMG^O19) - Placer Order
// Management [RAD-2] and Filler Order Management [RAD-3]. Follows the Patient Care
// Coordination IG (https://github.com/KevinMayfield/PatientCareCoordination), where a
// REF_I12 is converted to the same O19 FHIR Message: one FHIR order message whatever the
// HL7 v2 source.

Alias: $v2-0003 = http://terminology.hl7.org/CodeSystem/v2-0003
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $ods-code = https://fhir.nhs.uk/Id/ods-organization-code
Alias: $sct = http://snomed.info/sct
Alias: $nicip = https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP

// Message definition

Instance: imaging-order
InstanceOf: MessageDefinition
Title: "Message Definition - Imaging Order (O19)"
Description: "FHIR Message equivalent of the IHE SWF.b HL7 v2.5.1 `OMG^O19^OMG_O19` order message - Placer Order Management [RAD-2] and Filler Order Management [RAD-3]. The focus is the Radiology Service Request."
Usage: #definition
* url = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/imaging-order"
* name = "ImagingOrder"
* title = "Imaging Order (O19)"
* status = #draft
* experimental = true
* date = "2026-11-01"
* eventCoding = $v2-0003#O19 "OMG - General clinical order"
* category = #consequence
* description = """
FHIR Message equivalent of the IHE SWF.b HL7 v2.5.1 `OMG^O19^OMG_O19` order message,
sent by the Order Placer for [Placer Order Management [RAD-2]](RAD-2.html) and by the
Order Filler for [Filler Order Management [RAD-3]](RAD-3.html). The order control
(ORC-1) and order status (ORC-5) are carried by the
[Radiology Service Request](StructureDefinition-RadiologyServiceRequest.html):

| Transaction | ORC-1 | ServiceRequest |
|---|---|---|
| RAD-2 new order | NW | `status` active, placer order number |
| RAD-2 change order | XO | updated ServiceRequest |
| RAD-2 cancel order | CA | `status` revoked |
| RAD-3 new filler order | SN | `status` active, filler order number and accession number |
| RAD-3 change order | XX | updated ServiceRequest |
| RAD-3 status change | SC | `status` from ORC-5 |
| RAD-3 cancel | OC | `status` revoked |

The code-by-code ORC-1 / ORC-5 mapping to `ServiceRequest.status` is **Open**.

The HL7 v2 acknowledgement `ORG^O20^ORG_O20` is a FHIR response message
(`MessageHeader.response`) - from the Order Filler for RAD-2, returning the
ServiceRequest with the filler order number; from the Order Placer for RAD-3, returning
the placer order number.
"""
* focus[+]
  * code = #ServiceRequest
  * profile = "https://fhir.nwgenomics.nhs.uk/Imaging/StructureDefinition/RadiologyServiceRequest"
  * min = 1
  * max = "1"
* responseRequired = #always

// Example: RAD-2 new order

Instance: RadiologyServiceRequestNewOrder
InstanceOf: RadiologyServiceRequest
Title: "Radiology Service Request - CT thorax, abdomen and pelvis, new order"
Description: "The staging CT request as placed by the Order Placer [RAD-2], before the RIS has assigned an accession number."
Usage: #example
* identifier[0].type = $v2-0203#PLAC
* identifier[0].value = "ORD-26-0001234"
* identifier[0].assigner.identifier.system = $ods-code
* identifier[0].assigner.identifier.value = "R0A"
* status = #active
* intent = #order
* code.coding[nicip] = $nicip#CCHAPC "CT Thorax abdomen pelvis with contrast"
* code.coding[snomedCT] = $sct#433761009 "CT of thorax, abdomen and pelvis with contrast"
* subject = Reference(PatientManchester)
* authoredOn = "2026-10-26T10:15:00Z"
* reasonCode.text = "Staging of suspected colorectal cancer"

Instance: ImagingOrderMessage
InstanceOf: BundleMessage
Title: "Bundle Message - Imaging Order (O19), new order [RAD-2]"
Description: "FHIR Message equivalent of an HL7 v2.5.1 OMG^O19 (ORC-1 NW) from the Order Placer (order communications) to the Order Filler (RIS): a staging CT for Sansa MANCHESTER."
Usage: #example
* identifier.system = "https://fhir.mft.nhs.uk/Id/message"
* identifier.value = "OC-MSG-0001234"
* type = #message
* timestamp = "2026-10-26T10:15:00Z"
* entry[message].fullUrl = "https://fhir.example.nhs.uk/R4/MessageHeader/ImagingOrderMessageHeader"
* entry[message].resource = ImagingOrderMessageHeader
* entry[1].fullUrl = "https://fhir.example.nhs.uk/R4/ServiceRequest/RadiologyServiceRequestNewOrder"
* entry[1].resource = RadiologyServiceRequestNewOrder
* entry[2].fullUrl = "https://fhir.example.nhs.uk/R4/Patient/PatientManchester"
* entry[2].resource = PatientManchester

Instance: ImagingOrderMessageHeader
InstanceOf: MessageHeader
Usage: #inline
* id = "ImagingOrderMessageHeader"
* meta.lastUpdated = "2026-10-26T10:15:00Z"
* eventCoding = $v2-0003#O19 "OMG - General clinical order"
* destination.endpoint = "https://ris.example.nhs.uk/R4/$process-message"
* destination.receiver.identifier.system = $ods-code
* destination.receiver.identifier.value = "R0A"
* sender.identifier.system = $ods-code
* sender.identifier.value = "R0A"
* source.endpoint = "https://ordercomms.example.nhs.uk/R4"
* focus = Reference(ServiceRequest/RadiologyServiceRequestNewOrder)
* definition = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/imaging-order"

// Example: RAD-3 status change (completed)

Instance: ImagingOrderStatusMessage
InstanceOf: BundleMessage
Title: "Bundle Message - Imaging Order (O19), status change [RAD-3]"
Description: "FHIR Message equivalent of an HL7 v2.5.1 OMG^O19 (ORC-1 SC, ORC-5 CM) from the Order Filler (RIS) to the Order Placer: the staging CT is complete, with the accession number assigned by the RIS."
Usage: #example
* identifier.system = "https://ris.example.nhs.uk/Id/message"
* identifier.value = "RIS-MSG-0005678"
* type = #message
* timestamp = "2026-10-28T14:40:00Z"
* entry[message].fullUrl = "https://fhir.example.nhs.uk/R4/MessageHeader/ImagingOrderStatusMessageHeader"
* entry[message].resource = ImagingOrderStatusMessageHeader
* entry[1].fullUrl = "https://fhir.example.nhs.uk/R4/ServiceRequest/RadiologyServiceRequestExample"
* entry[1].resource = RadiologyServiceRequestExample
* entry[2].fullUrl = "https://fhir.example.nhs.uk/R4/Patient/PatientManchester"
* entry[2].resource = PatientManchester

Instance: ImagingOrderStatusMessageHeader
InstanceOf: MessageHeader
Usage: #inline
* id = "ImagingOrderStatusMessageHeader"
* meta.lastUpdated = "2026-10-28T14:40:00Z"
* eventCoding = $v2-0003#O19 "OMG - General clinical order"
* destination.endpoint = "https://ordercomms.example.nhs.uk/R4/$process-message"
* destination.receiver.identifier.system = $ods-code
* destination.receiver.identifier.value = "R0A"
* sender.identifier.system = $ods-code
* sender.identifier.value = "R0A"
* source.endpoint = "https://ris.example.nhs.uk/R4"
* focus = Reference(ServiceRequest/RadiologyServiceRequestExample)
* definition = "https://fhir.nwgenomics.nhs.uk/Imaging/MessageDefinition/imaging-order"
