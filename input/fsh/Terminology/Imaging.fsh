Alias: $sct = http://snomed.info/sct

ValueSet:       UKImagingProcedure
Id:             uk-imaging-procedure
Title:          "UK Imaging Procedure (SNOMED CT)"
Description:    """
**Proof of concept - not an authoritative source.**

Imaging procedures: members of the SNOMED CT UK Edition refset 999001111000000105
*United Kingdom diagnostic imaging procedure simple reference set*, which holds
the SNOMED CT concepts that NICIP codes are mapped to. NICIP codes can be sent
alongside as additional codings; NICIP has no FHIR system URI (**Open**).

tx.fhir.org has the UK Edition but cannot expand UK refset membership, so this
value set is not expanded in this guide. Expansion through the NHS England
Terminology Server is **To confirm**.
"""
* ^status = #draft
* ^experimental = true
* include codes from system http://snomed.info/sct|http://snomed.info/sct/83821000000107 where constraint = "^ 999001111000000105"
