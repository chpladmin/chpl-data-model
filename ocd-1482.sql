------------------------------------------------------------
-- add edition reference to test standards
------------------------------------------------------------
ALTER TABLE openchpl.test_standard
DROP COLUMN IF EXISTS certification_edition_id;

ALTER TABLE openchpl.test_standard 
ADD COLUMN certification_edition_id bigint;

--fill in all certification edition ids for existing test standards
--we had to use the id in here because some names and numbers are identical across editions
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(a)' and name = 'DIRECT: Applicability Statement for Secure Health Transport, Version 1.1, July 10, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(b)' and name = 'XDR and XDM for Direct Messaging Specification, Version 1, March 9, 2011' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(c)' and name = 'Transport and Security Specification, Version 1.0, June 19, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(d)' and name = 'Implementation Guide for Direct Edge Protocols, Version 1.1, June 25, 2014' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(a)' and name = 'Web Content Accessibility Guidelines (WCAG) 2.0, December 11, 2008' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(b)' and name = 'HL7 Version 3 Standard: Context-Aware Retrieval Application (Infobutton); Release 1, July 2010' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(b)(1)' and name = 'HL7 Version 3 Implementation Guide: URL-Based Implementations of the Context-Aware Information Retrieval (Infobutton) Domain, Release 3, December 2010' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(b)(2)' and name = 'HL7 Version 3 Implementation Guide: Context-Aware Knowledge Retrieval (Infobutton) Service-Oriented Architecture Implementation Guide, Release 1, HL7 Draft Standard for Trial Use, March 2011' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(c)' and name = 'Data Element Catalog, Version 1.1 October 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(1)' and name = 'HITSP Summary Documents Using HL7 Continuity of Care Document (CCD) Component, HITSP/C32, July 8, 2009, Version 2.5' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(1)' and name = 'Health Level Seven Implementation Guide: Clinical Document Architecture (CDA) Release 2—Continuity of Care Document (CCD), April 01, 2007' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(2)' and name = 'ASTM E2369–05: Standard Specification for Continuity of Care Record (CCR), year of adoption 2005, ASTM approved July 17, 2006' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(2)' and name = 'ASTM E2369–05 (Adjunct to E2369): Standard Specification Continuity of Care Record,—Final Version 1.0 (V1.0), November 7, 2005' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(3)' and name = 'HL7 Implementation Guide for CDA® Release 2: IHE Health Story Consolidation, DSTU Release 1.1 (US Realm) Draft Standard for Trial Use July 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(b)(2)' and name = 'SCRIPT Standard, Implementation Guide, Version 10.6, October, 2008, (Approval date for ANSI: November 12, 2008)' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(d)(3)' and name = 'PHIN Messaging Guide for Syndromic Surveillance: Emergency Department and Urgent Care Data, ADT Messages A01, A03, A04, and A08, HL7 Version 2.5.1 (Version 2.3.1 Compatible), Release 1.1, August 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(d)(3)' and name = 'Conformance Clarification for EHR Certification of Electronic Syndromic Surveillance, ADT MESSAGES A01, A03, A04, and A08, HL7 Version 2.5.1, Addendum to PHIN Messaging Guide for Syndromic Surveillance: Emergency Department and Urgent Care Data (Release 1.1), August 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(d)(3)' and name = 'Health Level Seven Messaging Standard Version 2.5.1 (HL7 2.5.1), An Application Protocol for Electronic Data Exchange in Healthcare Environments, February 21, 2007' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(e)(3)' and name = 'HL7 2.5.1 Implementation Guide for Immunization Messaging, Release 1.4, August 1, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(e)(3)' and name = 'Health Level Seven Messaging Standard Version 2.5.1 (HL7 2.5.1), An Application Protocol for Electronic Data Exchange in Healthcare Environments, February 21, 2007' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(g)' and name = 'HL7 v2.5.1 IG: Electronic Laboratory Reporting to Public Health (US Realm), Release 1 Errata and Clarifications, September, 29, 2011' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(g)(3)' and name = 'ELR 2.5.1 Clarification Document for EHR Technology Certification, July 16, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(g)(3)' and name = 'Health Level Seven Messaging Standard Version 2.5.1 (HL7 2.5.1), An Application Protocol for Electronic Data Exchange in Healthcare Environments, February 21, 2007' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(g)(3)' and name = 'HL7 Version 2.5.1 Implementation Guide: Electronic Laboratory Reporting to Public Health, Release 1 (US Realm) HL7 Version 2.5.1: ORU^R01, HL7 Informative Document, February, 2010' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(h)' and name = 'HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture, DTSU Release 2 (Universal Realm), Draft Standard for Trial Use, July 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(i)' and name = 'Implementation Guide for Ambulatory Healthcare Provider Reporting to Central Cancer Registries, HL7 Clinical Document Architecture (CDA), Release 1.0, August 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(i)' and name = 'HL7 Clinical Document Architecture, Release 2.0, Normative Edition, May 2005' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(j)' and name = 'HL7 Version 2.5.1 Implementation Guide: S&I Framework Lab Results Interface, Release 1 - US Realm [HL7 Version 2.5.1: ORU^R01] Draft Standard for Trial Use, July 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(k)' and name = 'HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture—Category III, DSTU Release 1 (US Realm) Draft Standard for Trial Use, November 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(a)(3)' and name = 'International Health Terminology Standards Development Organisation (IHTSDO) Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT®) International Release July 31, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(a)(3)' and name = 'US Extension to SNOMED CT® March 2012 Release' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(2)' and name = 'CPT-4' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(2)' and name = 'HCPCS' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(3)' and name = 'CDT' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(4)' and name = 'ICD-10-PCS' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(c)(2)' and name = 'Logical Observation Identifiers Names and Codes (LOINC®) Database version 2.40,Released June 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(d)(2)' and name = 'RxNorm, August 6, 2012 Full Release Update' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(e)(2)' and name = 'IIS: HL7 Standard Code Set CVX -- Vaccines Administered, updates through July 11, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(f)' and name = 'OMB standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, Oct 30, 1997' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(g)' and name = 'ISO 639-2. Codes for the Representation of Names of Languages Part 2: Alpha-3 Code, April 8, 2011' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(i)' and name = 'ICD-10-CM' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(j)' and name = 'HL7 Version 3 Standard: Clinical Genomics; Pedigree, Release 1, Edition 2011, March 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(a)(1)' and name = 'Annex A: Approved Security Functions for FIPS PUB 140-2, Security Requirements for Cryptographic Modules, Draft, May 30, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(f)' and name = 'Annex A: Approved Security Functions for FIPS PUB 140-2, Security Requirements for Cryptographic Modules, Draft, May 30, 2012' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(g) NTP v3' and name = 'RFC 1305: Network Time Protocol (Version 3) Specification, Implementation and Analysis, March 1992' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(g) NTP v4' and name = 'RFC 5905: Network Time Protocol Version 4: Protocol and Algorithms Specification, June 2010' and test_standard_id <= 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(h)' and name = 'ASTM E2147-01 (Reapproved 2009) Standard Specification for Audit and Disclosure Logs for Use in Health Information Systems, approved September 1, 2009' and test_standard_id <= 47;


UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(3)' and name = 'CDT' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(2)' and name = 'CPT-4' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(h)' and name = 'ASTM E2147 (Reapproved 2013) ' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(f)(2)' and name = 'CDC Race and Ethnicity Code Set Version 1.0 (March 2000)' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(e)(4)' and name = 'National Drug Code Directory – Vaccine NDC Linker, updates through August 17, 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(b)(4)' and name = 'ICD-10-PCS' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(i)' and name = 'ICD-10-CM' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(r)(1)' and name = 'Crosswalk: Medicare Provider/Supplier to Healthcare Provider Taxonomy (updated April 2, 2015)' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(d)' and name = 'Record treatment, payment, and health care operations disclosures' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(n)(1)' and name = 'Birth sex must be coded in accordance with HL7 Version 3 Standard, Value Sets for AdminstrativeGender and NullFlavor attributed as follows [PDF - 59 KB]:
(1) Male. M
(2) Female. F
(3) Unknown. nullFlavor UNK 1' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(o)(1) - (2)' and name = 'HL7 Version 3 Standard, Value Sets for AdminstrativeGender and NullFlavor attributed as follows:
* Something else, please describe. nullFlavor OTH
* Don''t know. nullFlavor UNK
* Choose not to disclose. nullFlavor ASKU
* Additional gender category or other, please specify. nullFlavor OTH
* Choose not to disclose. nullFlavor ASKU' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(b)(3)' and name = 'HL7 Version 3 Standard: Context Aware Knowledge Retrieval Application. ("Infobutton"), Knowledge Request, Release 2, 2014 Release
HL7 Implementation Guide: Service-Oriented Architecture Implementations of the Context-aware Knowledge Retrieval (Infobutton) Domain, Release 1, August 9, 2013' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(b)(4)' and name = 'HL7 Version 3 Standard: Context Aware Retrieval Application ("Infobutton"), Knowledge Request, Release 2, 2014 Release
HL7 Version 3 Implementation Guide: Context-Aware Knowledge Retrieval (Infobutton), Release 4, June 13, 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(p)(1)' and name = 'IHE IT Infrastructure Technical Framework Volume 2b (ITI TF-2b) Transactions Part B – Sections 3.29 – 3.43, Revision 7.0, August 10, 2010' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(3)' and name = 'HL7 Implementation Guide for CDA® Release 2: IHE Health Story Consolidation, Release 1.1 - US Realm' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(a)(4)' and name = 'HL7 Implementation Guide for CDA®Release 2: Consolidated CDA Templates for Clinical Notes (US Realm) Draft Standard for Trial Use, Volume 1 – Introductory Material, Release 2.1, August 2015
HL7 Implementation Guide for CDA® Release 2: Consolidated CDA Templates for Clinical Notes (US Realm), Draft Standard for Trial Use, Volume 2 – Templates and Supporting Material, Release 2.1, August 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(o)(1)' and name = 'HL7 Version 3 Implementation Guide: Data Segmentation for Privacy (DS4P), Release 1, Part 1: CDA R2 and Privacy Metadata Reusable Content Profile, May 16, 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(h)(2)' and name = 'HL7 CDA® Release 2 Implementation Guide: Quality Reporting Document Architecture – Category I(QRDA I); Release 1, DTSU Release 3 (US Realm), Volume 1 – Introductory Material, June 2015
HL7 CDA ® Release 2 Implementation Guide: Quality Reporting Document Architecture – Category I (QRDA I); Release 1, DSTU Release 3 (US Realm), Volume 2 – Templates and Supporting Material, June 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(k)(1)' and name = 'Quality Reporting Document Architecture Category III, Implementation Guide for CDA Release 2' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(k)(2)' and name = 'Errata to the HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture—Category III, DSTU Release 1 (US Realm), September 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(e)(4)' and name = 'HL7 2.5.1 Implementation Guide for Immunization Messaging Release 1.5, October 1, 2014
HL7 2.5.1 Implementation Guide for Immunization Messaging, Release 1.5 - Addendum, July 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(e)(3)' and name = 'HL7 Standard Code Set CVX—Vaccines Administered, updates through August 17, 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(d)(4)' and name = 'PHIN Messaging Guide for Syndromic Surveillance: Emergency Department, Urgent Care, Inpatient and Ambulatory Care Settings, Release 2.0, April 21, 2015
Erratum to the CDC PHIN 2.0 Implementation Guide, August 2015; Erratum to the CDC PHIN 2.0 Messaging Guide, April 2015 Release for Syndromic Surveillance: Emergency Department, Urgent Care, Inpatient and Ambulatory Care Settings' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(g)' and name = 'HL7 Version 2.5.1 Implementation Guide: Electronic Laboratory Reporting to Public Health, Release 1 (US Realm)
ELR 2.5.1 Clarification Document for EHR Technology Certification V1.1' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(i)(2)' and name = 'HL7 Implementation Guide for CDA©Release 2 Implementation Guide: Reporting to Public Health Cancer Registries from Ambulatory Healthcare Providers, Release 1; DSTU Release 1.1, Volume 1 – Introductory Material, April 2015
HL7 CDA© Release 2 Implementation Guide: Reporting to Public Health Cancer Registries from Ambulatory Healthcare Providers, Release 1; DSTU Release 1.1 (US Realm), Volume 2- Templates and Supporting Material, April 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(r)(1)' and name = 'HL7 Implementation Guide for CDA®Release 2 – Level 3: Healthcare Associated Infection Reports, Release 1 - U.S. Realm, August 9, 2013' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(s)(1)' and name = 'HL7 Implementation Guide for CDA Release 2: National Health Care Surveys (NHCS), Release 1 – US Realm, HL7 Draft Standard for Trial Use, Volume 1- Introductory Material, December 2014
HL7 Implementation Guide for CDA ®Release 2: National Health Care Surveys (NHCS), Release 1 – US Realm, HL7 Draft Standard for Trial Use, Volume 2 – Templates and Supporting Material, December 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(q)(1)' and name = 'ITU-TE.123, Series E: Overall Network Operation, Telephone Service, Service Operation and Human Factors, International operation – General provisions concerning users: Notation for national and international telephone numbers, e-mail addresses and web addresses, February 2001
ITU-T E. 164, Series E: Overall Network Operation, Telephone Service, Service Operation and Human Factors, International Operation - Numbering plan of the international telephone service: The international public telecommunication numbering plan, November 2010' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(g)' and name = 'Request for Comments (RFC) 5905:Network Time Protocol Version 4: Protocol and Algorithms Specification, June 2010' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(g)(2)' and name = 'Request for Comments (RFC) 5646, "Tags for Identifying Languages," September 2009, copyright 2009' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.205(b)(2)' and name = 'SCRIPT Standard, Version 10.6, October, 2008' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(a)(2)' and name = 'Annex A: Federal Information Processing Standards (FIPS) Publication 140-2, Security Requirements for Cryptographic Modules, October 8, 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.210(c)(2)' and name = 'FIPS PUB 180-4, Secure Hash Standard, 180-4 (August 2015)' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(f)(1)' and name = 'The Office of Management and Budget Standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, as revised, October 30, 1997' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(s)(1)' and name = 'Public Health Data Standards Consortium Source of Payment Typology Code Set Version 5.0 (October 2011)' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(c)(2)' and name = 'Logical Observation Identifiers Names and Codes (LOINC®) Database version 2.40' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(c)(3)' and name = 'Logical Observation Identifiers Names and Codes (LOINC®) Database version 2.52, Released June 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(m)(1)' and name = 'The Unified Code of Units of Measure, Revision 1.9, October 23, 2013' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(a)(2)' and name = 'Applicability Statement for Secure Health Transport, Version 1.2, August 2015' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(b)' and name = 'XDR and XDM for Direct Messaging Specification, Version 1, March 9, 2011' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(d)' and name = 'Implementation Guide for Direct Edge Protocols, Version 1.1, June 25, 2014' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.202(e)(1)' and name = 'Implementation Guide for Delivery Notification in Direct, Version 1.0, June 29, 2012' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(a)(3)' and name = 'International Health Terminology Standards Development Organisation (IHTSDO) SNOMED CT® International Release July 2012 and US Extension to SNOMED CT® March 2012 Release' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(a)(4)' and name = 'International Health Terminology Standards Development Organisation (IHTSDO) Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT®), U.S. Edition, September 2015 Release' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(h)' and name = 'International Health Terminology Standards Development Organization (IHTSDO) Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT®) U.S. Edition, September 2015 Release' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.207(d)(3)' and name = 'RxNorm, a standardized nomenclature for clinical drugs produced by the United States National Library of Medicine, September 8, 2015 Release' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(a)(1)' and name = 'Web Content Accessibility Guidelines (WCAG) 2.0, Level A Conformance' and test_standard_id > 47;
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE number = '170.204(a)(2)' and name = 'Web Content Accessibility Guidelines (WCAG) 2.0, Level AA Conformance' and test_standard_id > 47;


SELECT count(*)||' test standards is/are left without certification_edition_id after fixing preloaded values.'
FROM openchpl.test_standard
WHERE certification_edition_id IS NULL;

--only ones left without an edition should be user-entered
CREATE OR REPLACE FUNCTION openchpl.fillUserEnteredTestStandardEditions() RETURNS VOID AS $$
DECLARE
    userEnteredTestStandard RECORD;
    testStdId bigint;
	
    BEGIN

		FOR userEnteredTestStandard IN 
		(SELECT * FROM openchpl.test_standard WHERE certification_edition_id IS NULL)
		LOOP
			--look up editions of listings that use this standard
			
				-- look up test std id for listing edition and same test std number
				SELECT INTO testStdId result
				FROM
				(SELECT test_standard_id as result
				FROM openchpl.test_standard
				WHERE number = mismatch.test_std_number
				AND certification_edition_id = mismatch.listing_edition) innerQuery;
				
				--update certification_result_test_standard to point to correct test std id
				UPDATE openchpl.certification_result_test_standard
				SET test_standard_id = testStdId
				WHERE certification_result_test_standard_id = mismatch.certification_result_test_standard_id;
				
		END LOOP;
		
		SELECT INTO mismatchCount result
		FROM
		(SELECT count(*) as result
		FROM openchpl.certification_result_test_standard crts
		JOIN openchpl.test_standard ts ON crts.test_standard_id = ts.test_standard_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crts.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != ts.certification_edition_id) innerQuery;
		
		raise notice '# criteria with test standard certification edition mismatches AFTER update: %', mismatchCount;
	END;
$$ LANGUAGE plpgsql;

--SELECT openchpl.fillUserEnteredTestStandardEditions();
DROP FUNCTION openchpl.fillUserEnteredTestStandardEditions();

--only run this once all of the standards have an edition
CREATE OR REPLACE FUNCTION openchpl.fixTestStandards() RETURNS VOID AS $$
DECLARE
	mismatchCount integer;
    mismatch RECORD;
    testStdId bigint;
	
    BEGIN
	
		--get the records where listing edition does not match test func edition
		SELECT INTO mismatchCount result
		FROM
		(SELECT count(*) as result
		FROM openchpl.certification_result_test_standard crts
		JOIN openchpl.test_standard ts ON crts.test_standard_id = ts.test_standard_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crts.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != ts.certification_edition_id) innerQuery;
		
		raise notice '# criteria with test standards certification edition mismatches BEFORE update: %', mismatchCount;
	
		FOR mismatch IN 
		(SELECT distinct cp.certified_product_id, cr.certification_result_id, crts.certification_result_test_standard_id, 
			ts.number as test_std_number, 
			cp.certification_edition_id as listing_edition, 
			ts.certification_edition_id as criteria_edition
		FROM openchpl.certification_result_test_standard crts
		JOIN openchpl.test_standard ts ON crts.test_standard_id = ts.test_standard_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crts.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != ts.certification_edition_id)
		LOOP
				-- look up test std id for listing edition and same test std number
				SELECT INTO testStdId result
				FROM
				(SELECT test_standard_id as result
				FROM openchpl.test_standard
				WHERE number = mismatch.test_std_number
				AND certification_edition_id = mismatch.listing_edition) innerQuery;
				
				--update certification_result_test_standard to point to correct test std id
				UPDATE openchpl.certification_result_test_standard
				SET test_standard_id = testStdId
				WHERE certification_result_test_standard_id = mismatch.certification_result_test_standard_id;
				
		END LOOP;
		
		SELECT INTO mismatchCount result
		FROM
		(SELECT count(*) as result
		FROM openchpl.certification_result_test_standard crts
		JOIN openchpl.test_standard ts ON crts.test_standard_id = ts.test_standard_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crts.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != ts.certification_edition_id) innerQuery;
		
		raise notice '# criteria with test standard certification edition mismatches AFTER update: %', mismatchCount;
	END;
$$ LANGUAGE plpgsql;

--SELECT openchpl.fixTestStandards();

DROP FUNCTION openchpl.fixTestStandards();

-- set column to not allow null
--ALTER TABLE openchpl.test_standard 
--ALTER COLUMN certification_edition_id SET NOT NULL;