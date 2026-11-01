Alias: $sct = http://snomed.info/sct
Alias: $nicip = https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP

ValueSet:       UKImagingProcedure
Id:             uk-imaging-procedure
Title:          "UK Imaging Procedure (SNOMED CT)"
Description:    """
**Proof of concept - not an authoritative source.**

Imaging procedures: members of the SNOMED CT UK Edition refset 999001111000000105
*United Kingdom diagnostic imaging procedure simple reference set*, which holds
the SNOMED CT concepts that NICIP codes are mapped to. NICIP codes can be sent
alongside as additional codings - see [NICIP](ValueSet-Interweave-NICIP.html).

tx.fhir.org has the UK Edition but cannot expand UK refset membership, so this
value set is not expanded in this guide. Expansion through the NHS England
Terminology Server is **To confirm**.
"""
* ^status = #draft
* ^experimental = true
* include codes from system http://snomed.info/sct|http://snomed.info/sct/83821000000107 where constraint = "^ 999001111000000105"

// DUPLICATION: the NICIP CodeSystem (input/resources/CodeSystem-Interweave-NICIP.json)
// is copied unchanged from the Interweave FHIR IG
// (https://fhir.interweavedigital.com/R4/CodeSystem-Interweave-NICIP.html, 2026-11-01),
// keeping its canonical URL. This value set is copied from Interweave's
// ValueSet/Interweave-NICIP under this guide's canonical.

ValueSet:       InterweaveNICIP
Id:             Interweave-NICIP
Title:          "NICIP (Interweave)"
Description:    """
**Proof of concept - not an authoritative source.**

National Interim Clinical Imaging Procedure (NICIP) codes, from the Interweave
NICIP CodeSystem (`https://fhir.interweavedigital.nhs.uk/CodeSystem/Interweave-NICIP`,
version 0.0.1, 4833 codes). Copied from the [Interweave FHIR IG](https://fhir.interweavedigital.com/R4/ValueSet-Interweave-NICIP.html).
The authoritative NICIP release is distributed by NHS England through TRUD.
"""
* ^status = #draft
* ^experimental = true
* include codes from system $nicip
