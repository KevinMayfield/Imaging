// DUPLICATION: copied from the NW GMSA FHIR IG (https://nw-gmsa.github.io/en/,
// source ../FHIRGenomics/input/fsh/DocumentReference.fsh, Binary.fsh and
// Termininology/ValueSet, 2026-11-01). Used for the HL7 v2 OBX type ED/RP
// convention: OBX-5 -> Binary, OBX -> DocumentReference.
// Changes from the source: the NW Encounter profile constraint on
// context.encounter and the Obligation markers are removed (not copied).
// Keep in step with the source - see notes/research.md.

Alias: $sct = http://snomed.info/sct

Profile:        DocumentReference
Parent:         http://hl7.org/fhir/StructureDefinition/DocumentReference
Id:             DocumentReference
Title:          "DocumentReference"
Description:    """
`Health Document`. Copied from the [NW GMSA FHIR IG](https://nw-gmsa.github.io/en/).
"""

* identifier 1..* MS
* identifier only CorrelationIdentifier

* type from DocumentEntryType
* category from DocumentEntryClass

* content.attachment only NWAttachment

* context.facilityType from FacilityType
* context.practiceSetting from Specialty

* context.sourcePatientInfo.identifier only MedicalRecordNumber

* context.event ^short = "The procedure or test code associated with the Accession Number (e.g. NICIP, Genomic Test Directory, etc.)"

* context.encounter 0..1 MS
* context.encounter.identifier only CorrelationIdentifier

* context.related 0..*
* context.related ^short = "Related resources. For laboratory and imaging reports, a reference to the DiagnosticReport"
* context.related ^definition = "Related resources. Accession Number, Order Identifier and Report Identifier are not carried here; they are held on the referenced DiagnosticReport (DiagnosticReport.specimen, DiagnosticReport.basedOn and DiagnosticReport.identifier)."

* context.related ^slicing.discriminator.type = #value
* context.related ^slicing.discriminator.path = "type"
* context.related ^slicing.rules = #open
* context.related ^slicing.description = "Slice based on the type"
* context.related ^slicing.ordered = false

* context.related contains
  DiagnosticReport 0..1 MS

* context.related[DiagnosticReport] only Reference(DiagnosticReport)
* context.related[DiagnosticReport] ^short = "The DiagnosticReport this document is a rendering of (laboratory or imaging report)"
* context.related[DiagnosticReport] ^definition = "Reference to the DiagnosticReport this document presents. Not mandatory, but highly recommended for the Document Access Provider when serving laboratory or imaging reports. Accession Number, Order Identifier and Report Identifier are available from the referenced DiagnosticReport."
* context.related[DiagnosticReport].type 1..1
* context.related[DiagnosticReport].type = "DiagnosticReport"
* context.related[DiagnosticReport].reference 1..1 MS

* context.sourcePatientInfo only Reference(Patient)
* context.sourcePatientInfo.identifier only MedicalRecordNumber

* context.period 0..1 MS

* subject 1..1 MS
* subject only Reference(Patient)
* subject.identifier only NHSIdentifier

* author only Reference(Organization or Practitioner or PractitionerRole)
* author.identifier only PractitionerIdentifier or OrganisationCode

* custodian only Reference(Organization)
* custodian.identifier only OrganisationCode

* date 1..1 MS

Profile:        Binary
Parent:         http://hl7.org/fhir/StructureDefinition/Binary
Id:             Binary
Title:          "Binary"
Description:    "`Health Document`. Copied from the [NW GMSA FHIR IG](https://nw-gmsa.github.io/en/)."

* contentType from DocumentEntryMimeType

// Value sets used by DocumentReference and Binary

ValueSet: DocumentEntryType
Id: document-entry-type
Title: "DocumentEntry Type"
Description: """
- **Digital Health and Care Scotland**  [(EH4001) CLINICAL DOCUMENT INDEXING STANDARDS](https://www.digihealthcare.scot/app/uploads/2024/05/CDI-Standard-V4.5-FINAL.pdf) LA Labs
- [NHS England NRL -Record Type](https://github.com/NHSDigital/NRLF/blob/develop/resources/fhir/NRLF-RecordType-ValueSet.json)
"""
* ^experimental  = false

// * include codes from system $SCT where concept is-a "descendantOrSelfOf 4241000179101"

* $sct#4241000179101 "Laboratory report"
* $sct#721963009 "Order"
* $sct#721965002 "Laboratory order"
* http://snomed.info/sct#163221000000102 "Allergies and Adverse Reactions - Care Record Element"
* http://snomed.info/sct#927061000000101 "Gait analysis assessment record"
* http://snomed.info/sct#149671000000105 "Health status questionnaire"
* http://snomed.info/sct#734163000 "Care plan"
* http://snomed.info/sct#820161000000108 "Growth chart"
* http://snomed.info/sct#820191000000102 "Partogram"
* http://snomed.info/sct#824231000000100 "Temperature chart"
* http://snomed.info/sct#820211000000103 "Patient safety checklist"
* http://snomed.info/sct#823611000000107 "Vital signs chart"
* http://snomed.info/sct#820441000000103 "Weight chart"
* http://snomed.info/sct#820221000000109 "Inpatient medical note"
* http://snomed.info/sct#829201000000105 "Inpatient nursing note"
* http://snomed.info/sct#820451000000100 "Medical note"
* http://snomed.info/sct#820461000000102 "Multidisciplinary note"
* http://snomed.info/sct#820471000000109 "Nursing note"
* http://snomed.info/sct#823631000000104 "OOH (out of hours) note"
* http://snomed.info/sct#820481000000106 "Outpatient nursing note"
* http://snomed.info/sct#820491000000108 "Outpatient medical note"
* http://snomed.info/sct#823641000000108 "AHP (allied health professional) note"
* http://snomed.info/sct#24681000000104 "Telephone consultation"
* http://snomed.info/sct#824321000000109 "Summary record"
* http://snomed.info/sct#823651000000106 "Clinical note"
* http://snomed.info/sct#823681000000100 "Outpatient letter"
* http://snomed.info/sct#823691000000103 "Clinical letter"
* http://snomed.info/sct#823701000000103 "Discharge letter"
* http://snomed.info/sct#824331000000106 "Inpatient final discharge letter"
* http://snomed.info/sct#824341000000102 "Immediate inpatient discharge letter"
* http://snomed.info/sct#25611000000107 "Referral letter"
* http://snomed.info/sct#823721000000107 "Social Services letter"
* http://snomed.info/sct#823761000000104 "Administrative letter"
* http://snomed.info/sct#909921000000109 "DNA (did not attend) letter"
* http://snomed.info/sct#823781000000108 "MDT (multidisciplinary team) letter"
* http://snomed.info/sct#1325651000000108 "Pregnancy bereavement record"
* http://snomed.info/sct#820241000000102 "Medical photograph"
* http://snomed.info/sct#962381000000101 "Nuclear medicine images"
* http://snomed.info/sct#1219151000000104 "Ultrasound scan image"
* http://snomed.info/sct#25831000000103 "Image (document)"
* http://snomed.info/sct#416779005 "Anesthesia record"
* http://snomed.info/sct#820501000000102 "Nutritional record"
* http://snomed.info/sct#820511000000100 "Endoscopy record"
* http://snomed.info/sct#820251000000104 "Interventional radiology record"
* http://snomed.info/sct#823831000000103 "AHP (allied health professional) therapy record"
* http://snomed.info/sct#823661000000109 "Operation note"
* http://snomed.info/sct#823841000000107 "Radiotherapy record"
* http://snomed.info/sct#725869001 "Record of implantation of cardiac electronic device"
* http://snomed.info/sct#1129271000000109 "Direct current cardioversion record"
* http://snomed.info/sct#1363671000000109 "Colposcopy clinical record"
* http://snomed.info/sct#1198111000000109 "Molecular radiotherapy record"
* http://snomed.info/sct#1076911000000107 "Combined laboratory report"
* http://snomed.info/sct#4321000179101 "Hematology report"
* http://snomed.info/sct#1054291000000102 "Cellular pathology report"
* http://snomed.info/sct#1054281000000104 "Virology report"
* http://snomed.info/sct#4341000179107 "Microbiology report"
* http://snomed.info/sct#1054181000000105 "Blood transfusion report"
* http://snomed.info/sct#909871000000100 "Histocompatibility and immunogenetics"
* http://snomed.info/sct#1054161000000101 "Genetic report"
* http://snomed.info/sct#824781000000106 "Drug administration chart"
* http://snomed.info/sct#824791000000108 "Prescription and administration record"
* http://snomed.info/sct#820271000000108 "Chemotherapy record"
* http://snomed.info/sct#1099461000000101 "Medication review"
* http://snomed.info/sct#1325821000000102 "SACT (Systemic Anti-Cancer Therapy) record"
* http://snomed.info/sct#185361000000102 "Medication"
* http://snomed.info/sct#826501000000100 "Miscellaneous record"
* http://snomed.info/sct#824801000000107 "Front sheet"
* http://snomed.info/sct#24761000000103 "Scanned document"
* http://snomed.info/sct#823871000000101 "Forensic autopsy report"
* http://snomed.info/sct#229054004 "Child protection register"
* http://snomed.info/sct#824831000000101 "Consent form"
* http://snomed.info/sct#307930005 "Death certificate"
* http://snomed.info/sct#826511000000103 "Exemption form"
* http://snomed.info/sct#820291000000107 "Infectious disease notification"
* http://snomed.info/sct#826621000000105 "Legal notice"
* http://snomed.info/sct#826631000000107 "Mental Health Act notice"
* http://snomed.info/sct#826521000000109 "Refusal form"
* http://snomed.info/sct#308575004 "Employment report"
* http://snomed.info/sct#310854009 "Housing report"
* http://snomed.info/sct#308619006 "War pensions report"
* http://snomed.info/sct#270372007 "Disabled driver orange badge report"
* http://snomed.info/sct#270370004 "CLE - fit to hold driving licence"
* http://snomed.info/sct#307881004 "DSS RMO RM2 report"
* http://snomed.info/sct#270358003 "Life assurance - preliminary report"
* http://snomed.info/sct#308621001 "RM10-DHSS DMO report"
* http://snomed.info/sct#820301000000106 "Adoption report"
* http://snomed.info/sct#823951000000100 "Adult incapacity report"
* http://snomed.info/sct#826541000000102 "Power of attorney and legal guardianship record"
* http://snomed.info/sct#826651000000100 "Notification and legal document"
* http://snomed.info/sct#408403008 "Patient held record"
* http://snomed.info/sct#823881000000104 "Do not attempt cardiopulmonary resuscitation order"
* http://snomed.info/sct#827701000000106 "Living will and advance directive record"
* http://snomed.info/sct#772790007 "Organ donor card"
* http://snomed.info/sct#822761000000108 "Patient preferences record"
* http://snomed.info/sct#1054091000000108 "Research study adverse event document"
* http://snomed.info/sct#1054071000000109 "Research study withdrawal document"
* http://snomed.info/sct#827711000000108 "Electrocardiograph"
* http://snomed.info/sct#822771000000101 "Pulmonary investigation record"
* http://snomed.info/sct#822781000000104 "Vascular investigation record"
* http://snomed.info/sct#822801000000103 "Gastroenterology investigation record"
* http://snomed.info/sct#822791000000102 "Cardiac investigation record"
* http://snomed.info/sct#827721000000102 "Urodynamics record"
* http://snomed.info/sct#822811000000101 "Neurological investigation record"
* http://snomed.info/sct#824861000000106 "Ambulance service patient report form"
* http://snomed.info/sct#371527006 "Radiology report"
* http://snomed.info/sct#822821000000107 "Echography report"
* http://snomed.info/sct#822831000000109 "Audiology investigation record"
* http://snomed.info/sct#823891000000102 "AHP (allied health professional) investigation record"
* http://snomed.info/sct#962401000000101 "Visual field report"
* http://snomed.info/sct#4271000179106 "Nuclear medicine report"
* http://snomed.info/sct#983701000000101 "Non Procurator Fiscal post mortem report"
* http://snomed.info/sct#725870000 "Diagnostic coronary angiography report"
* http://snomed.info/sct#725956001 "Ambulatory blood pressure monitoring report"
* http://snomed.info/sct#770573007 "Airway endoscopy report"
* http://snomed.info/sct#770574001 "Endoscopic retrograde cholangiopancreatography report"
* http://snomed.info/sct#770572002 "Endoscopic ultrasound report"
* http://snomed.info/sct#770575000 "Endobronchial ultrasound report"
* http://snomed.info/sct#782660000 "Combined upper and lower gastrointestinal tract endoscopy report"
* http://snomed.info/sct#782659005 "Cystoscopy report"
* http://snomed.info/sct#1129261000000102 "Cardiac electrophysiology report"
* http://snomed.info/sct#1129251000000100 "Walking test report"
* http://snomed.info/sct#1129241000000103 "Tilt test report"
* http://snomed.info/sct#1129231000000107 "Bielschowsky head tilt test report"
* http://snomed.info/sct#4201000179104 "Imaging report"
* http://snomed.info/sct#1219161000000101 "Eye investigation report"
* http://snomed.info/sct#149691000000109 "Remote health monitoring report"
* http://snomed.info/sct#229059009 "Document type"
* http://snomed.info/sct#823901000000101 "Non-statutory provider document"
* http://snomed.info/sct#823931000000107 "Private provider note"
* http://snomed.info/sct#823941000000103 "Third party document"

ValueSet: DocumentEntryClass
Id: document-entry-class
Title: "DocumentEntry Class"
Description: """
- [Switzerland DocumentEntry.classCode](https://fhir.ch/ig/ch-term/3.0.0/ValueSet-DocumentEntry.classCode.html)
- [NHS England NRL - Record Category](https://github.com/NHSDigital/NRLF/blob/develop/resources/fhir/NRLF-RecordCategory-ValueSet.json)
"""
* ^experimental  = false

* $sct#721981007 "Diagnostic studies report"
* $sct#721963009 "Order"
* $sct#734163000 "Care plan"
* $sct#371525003 "Clinical procedure report"
* $sct#422735006 "Summary clinical document"
* $sct#371537001 "Consent report"
* $sct#419891008 "Record artifact"

ValueSet: FacilityType
Id: facility-type
Title: "Facility Type"
Description: """
`NHS Data Model and Dictionary` [ACTIVITY LOCATION TYPE CODE](https://www.datadictionary.nhs.uk/data_elements/activity_location_type_code.html)
"""
* ^experimental  = false

ValueSet: Specialty
Id: specialty
Title: "Specialty"
Description: """
`NHS Data Model and Dictionary` [MAIN SPECIALTY CODE](https://www.datadictionary.nhs.uk/attributes/main_specialty_code.html)

- [UKCorePracticeSettingCode](https://simplifier.net/hl7fhirukcorer4/valueset-ukcore-practicesettingcode)
  - OID 2.16.840.1.113883.2.1.6.8
- [HL7 Practice Setting Code Value Set](https://hl7.org/fhir/R4/valueset-c80-practice-codes.html)
"""

* ^experimental  = false

* include codes from system https://fhir.hl7.org.uk/CodeSystem/UKCore-PracticeSettingCode
* include codes from valueset http://hl7.org/fhir/ValueSet/c80-practice-codes

