------------------------------------------------------------
-- add edition reference to test standards
------------------------------------------------------------

-- fix 2014 test standards

--fix 170.205(a)(1): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(a)(1)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(a)(1)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.205(a)(1)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(a)(1)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

--fix 170.205(a)(2): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(a)(2)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(a)(2)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.205(a)(2)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(a)(2)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

--fix 170.205(d)(3): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(d)(3)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(d)(3)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.205(d)(3)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(d)(3)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

--fix 170.205(e)(3): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(e)(3)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(e)(3)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.205(e)(3)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(e)(3)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

-- fix 170.205 (g)(3): it was never valid and needs to be removed; references to it (likely none) should point to 170.205 (g)
-- update cert results to use 170.205 (g) instead of 170.205(g)(3)
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(g)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.205(g)(3)' and test_standard_id <= 47);
--delete all test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.205(g)(3)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.205(g)(3)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

-- fix 170.205 (i): there were two 170.205(i) entries which now need to become 170.205(i)(1) and (i)(2)
UPDATE openchpl.test_standard
SET number = '170.205(i)(1)', last_modified_user = -1,
name = 'HL7 Clinical Document Architecture (CDA), Release 2.0, Normative Edition (incorporated by reference in § 170.299). Implementation specifications. Implementation Guide for Ambulatory Healthcare Provider Reporting to Central Cancer Registries, HL7 Clinical Document Architecture (CDA), Release 1.0 (incorporated by reference in § 170.299).'
WHERE number = '170.205(i)'
AND name = 'Implementation Guide for Ambulatory Healthcare Provider Reporting to Central Cancer Registries, HL7 Clinical Document Architecture (CDA), Release 1.0, August 2012'
AND test_standard_id < 47;
UPDATE openchpl.test_standard
SET number = '170.205(i)(2)', last_modified_user = -1,
name = 'HL7 Clinical Document Architecture (CDA), Release 2.0, Normative Edition (incorporated by reference in § 170.299). Implementation specifications. HL7 CDA©Release 2 Implementation Guide: Reporting to Public Health Cancer Registries from Ambulatory Healthcare Providers, Release 1; DSTU Release 1.1, Volume 1 - Introductory Material and HL7 CDA© Release 2 Implementation Guide: Reporting to Public Health Cancer Registries from Ambulatory Healthcare Providers, Release 1; DSTU Release 1.1 (US Realm), Volume 2 - Templates and Supporting Material (incorporated by reference in § 170.299).'
WHERE number = '170.205(i)'
AND name = 'HL7 Clinical Document Architecture, Release 2.0, Normative Edition, May 2005'
AND test_standard_id < 47;

--fix 170.207(a)(3): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.207(a)(3)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.207(a)(3)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.207(a)(3)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.207(a)(3)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

--fix 170.207(b)(2): it had a duplicate and needs to be resolved to be a single entry
-- update cert results to use one standard
UPDATE openchpl.certification_result_test_standard 
SET test_standard_id = 
	(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.207(b)(2)' and test_standard_id <= 47)
WHERE test_standard_id IN (SELECT test_standard_id FROM openchpl.test_standard WHERE number = '170.207(b)(2)' and test_standard_id <= 47);
--delete any other test standards with this number
UPDATE openchpl.test_standard 
SET deleted = true, last_modified_user = -1
WHERE number = '170.207(b)(2)' 
AND test_standard_id > (SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = '170.207(b)(2)' and test_standard_id <= 47) 
AND test_standard_id <= 47;

-- update all existing test standard names to the correct values based on new spreadsheet
UPDATE openchpl.test_standard 
SET name = 'DIRECT: Applicability Statement for Secure Health Transport, Version 1.1, July 10, 2012', last_modified_user = -1 
WHERE number = '170.202(a)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'XDR and XDM for Direct Messaging Specification, Version 1, March 9, 2011', last_modified_user = -1 
WHERE number = '170.202(b)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Transport and Security Specification, Version 1.0, June 19, 2012', last_modified_user = -1 
WHERE number = '170.202(c)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Implementation Guide for Direct Edge Protocols, Version 1.1, June 25, 2014', last_modified_user = -1 
WHERE number = '170.202(d)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Web Content Accessibility Guidelines (WCAG) 2.0, December 11, 2008', last_modified_user = -1 
WHERE number = '170.204(a)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Version 3 Standard: Context-Aware Retrieval Application (Infobutton); Release 1, July 2010', last_modified_user = -1 
WHERE number = '170.204(b)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Version 3 Implementation Guide: URL-Based Implementations of the Context-Aware Information Retrieval (Infobutton) Domain, Release 3, December 2010', last_modified_user = -1 
WHERE number = '170.204(b)(1)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Version 3 Implementation Guide: Context-Aware Knowledge Retrieval (Infobutton) Service-Oriented Architecture Implementation Guide, Release 1, HL7 Draft Standard for Trial Use, March 2011', last_modified_user = -1 
WHERE number = '170.204(b)(2)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Data Element Catalog, Version 1.1 October 2012', last_modified_user = -1 
WHERE number = '170.204(c)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Health Level Seven Clinical Document Architecture (CDA) Release 2, Continuity of Care Document (CCD) (incorporated by reference in § 170.299). Implementation specifications. The Healthcare Information Technology Standards Panel (HITSP) Summary Documents Using HL7 CCD Component HITSP/C32 (incorporated by reference in § 170.299).' 
WHERE number = '170.205(a)(1)' and test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'ASTM E2369 Standard Specification for Continuity of Care Record and Adjunct to ASTM E2369 (incorporated by reference in § 170.299).' 
WHERE number = '170.205(a)(2)' and test_standard_id <= 47;

UPDATE openchpl.test_standard
SET name = 'HL7 Implementation Guide for CDA® Release 2: IHE Health Story Consolidation, DSTU Release 1.1 (US Realm) Draft Standard for Trial Use July 2012', last_modified_user = -1
WHERE number = '170.205(a)(3)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'SCRIPT Standard, Implementation Guide, Version 10.6, October, 2008, (Approval date for ANSI: November 12, 2008)', last_modified_user = -1 
WHERE number = '170.205(b)(2)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 2.5.1 (incorporated by reference in § 170.299). Implementation specifications. PHIN Messaging Guide for Syndromic Surveillance (incorporated by reference in § 170.299) and Conformance Clarification for EHR Certification of Electronic Syndromic Surveillance, Addendum to PHIN Messaging Guide for Syndromic Surveillance (incorporated by reference in § 170.299).' 
WHERE number = '170.205(d)(3)' and test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 2.5.1 (incorporated by reference in § 170.299). Implementation specifications. HL7 2.5.1 Implementation Guide for Immunization Messaging, Release 1.4, (incorporated by reference in § 170.299).' 
WHERE number = '170.205(e)(3)' and test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 2.5.1 (incorporated by reference in § 170.299). Implementation specifications. HL7 Version 2.5.1 Implementation Guide: Electronic Laboratory Reporting to Public Health, Release 1 (US Realm) (incorporated by reference in § 170.299) with Errata and Clarifications, (incorporated by reference in § 170.299) and ELR 2.5.1 Clarification Document for EHR Technology Certification, (incorporated by reference in § 170.299).', last_modified_user = -1 
WHERE number = '170.205(g)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture, DTSU Release 2 (Universal Realm), Draft Standard for Trial Use, July 2012', last_modified_user = -1 
WHERE number = '170.205(h)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Version 2.5.1 Implementation Guide: S&I Framework Lab Results Interface, Release 1 - US Realm [HL7 Version 2.5.1: ORU^R01] Draft Standard for Trial Use, July 2012', last_modified_user = -1 
WHERE number = '170.205(j)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture—Category III, DSTU Release 1 (US Realm) Draft Standard for Trial Use, November 2012', last_modified_user = -1 
WHERE number = '170.205(k)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'IHTSDO SNOMED CT® International Release July 2012 (incorporated by reference in § 170.299) and US Extension to SNOMED CT® March 2012 Release (incorporated by reference in § 170.299).' 
WHERE number = '170.207(a)(3)' and test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'The combination of Health Care Financing Administration Common Procedure Coding System (HCPCS), as maintained and distributed by HHS, and Current Procedural Terminology, Fourth Edition (CPT-4), asmaintained and distributed by the American Medical Association, for physician services and other health care services.' 
WHERE number = '170.207(b)(2)' and test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'CDT', last_modified_user = -1 
WHERE number = '170.207(b)(3)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'ICD-10-PCS', last_modified_user = -1 
WHERE number = '170.207(b)(4)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Logical Observation Identifiers Names and Codes (LOINC®) Database version 2.40,Released June 2012', last_modified_user = -1 
WHERE number = '170.207(c)(2)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'RxNorm, August 6, 2012 Full Release Update', last_modified_user = -1 
WHERE number = '170.207(d)(2)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'IIS: HL7 Standard Code Set CVX -- Vaccines Administered, updates through July 11, 2012', last_modified_user = -1 
WHERE number = '170.207(e)(2)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'OMB standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, Oct 30, 1997', last_modified_user = -1
WHERE number = '170.207(f)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'ISO 639-2. Codes for the Representation of Names of Languages Part 2: Alpha-3 Code, April 8, 2011', last_modified_user = -1 
WHERE number = '170.207(g)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'ICD-10-CM', last_modified_user = -1 
WHERE number = '170.207(i)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'HL7 Version 3 Standard: Clinical Genomics; Pedigree, Release 1, Edition 2011, March 2012', last_modified_user = -1 
WHERE number = '170.207(j)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Annex A: Approved Security Functions for FIPS PUB 140-2, Security Requirements for Cryptographic Modules, Draft, May 30, 2012', last_modified_user = -1 
WHERE number = '170.210(a)(1)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'Annex A: Approved Security Functions for FIPS PUB 140-2, Security Requirements for Cryptographic Modules, Draft, May 30, 2012', last_modified_user = -1 
WHERE number = '170.210(f)' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'RFC 1305: Network Time Protocol (Version 3) Specification, Implementation and Analysis, March 1992', last_modified_user = -1 
WHERE number = '170.210(g) NTP v3' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'RFC 5905: Network Time Protocol Version 4: Protocol and Algorithms Specification, June 2010', last_modified_user = -1 
WHERE number = '170.210(g) NTP v4' AND test_standard_id <= 47;

UPDATE openchpl.test_standard 
SET name = 'ASTM E2147-01 (Reapproved 2009) Standard Specification for Audit and Disclosure Logs for Use in Health Information Systems, approved September 1, 2009', last_modified_user = -1 
WHERE number = '170.210(h)' AND test_standard_id <= 47;

-- no changes needed to 2015 test standards

-- add certification edition column
ALTER TABLE openchpl.test_standard
DROP COLUMN IF EXISTS certification_edition_id;

ALTER TABLE openchpl.test_standard 
ADD COLUMN certification_edition_id bigint;

--make first 47 test standards be 2014 edition
UPDATE openchpl.test_standard SET certification_edition_id = 2 WHERE test_standard_id <= 47;

--make next 48 test standards be 2015 edition
UPDATE openchpl.test_standard SET certification_edition_id = 3 WHERE test_standard_id >= 48 AND test_standard_id <= 95;

--only ones left without an edition should be user-entered
CREATE OR REPLACE FUNCTION openchpl.fillUserEnteredTestStandardEditions() RETURNS VOID AS $$
DECLARE
	userEnteredTestStandardCount int;
    userEnteredTestStandard RECORD;
	duplicateTestStandard RECORD;
	numDuplicateTestStandards int;
    testStdId bigint;
	referencedByEditionsCount int;
	referencedByEdition int;
	mismatchTestStandardId bigint;
	
	mismatchCount int;
	mismatch RECORD;
	
    BEGIN

		SELECT INTO userEnteredTestStandardCount result
		FROM
			(SELECT count(*) as result
			FROM openchpl.test_standard
			WHERE certification_edition_id IS NULL) innerQuery;
		raise notice '% user-entered test standards is/are left without certification_edition_id before fixing them.', userEnteredTestStandardCount;

		-- try to match user-entered test standards (these aren't in the preload file) with the proper edition to fill in certification_edition_id field
		FOR userEnteredTestStandard IN 
		(SELECT * FROM openchpl.test_standard WHERE certification_edition_id IS NULL)
		LOOP
			--look up editions of listings that use this standard. 
			--each standard could be referenced by 0, 1, or 2 editions.
			SELECT INTO referencedByEditionsCount result
			FROM 
			(SELECT COUNT(DISTINCT cp.certification_edition_id) as result
			FROM openchpl.certified_product cp
			JOIN openchpl.certification_result cert ON cp.certified_product_id = cert.certified_product_id
			JOIN openchpl.certification_result_test_standard certTestStd ON cert.certification_result_id = certTestStd.certification_result_id
			JOIN openchpl.test_standard testStd on certTestStd.test_standard_id = testStd.test_standard_id
			WHERE testStd.test_standard_id = userEnteredTestStandard.test_standard_id) innerQuery;
			
			CASE referencedByEditionsCount
				WHEN 0 THEN
					raise notice 'No listings use user-entered test standard %', userEnteredTestStandard.number;

					-- test std is not referenced anywhere, delete it
					-- and fill in cert edition so we can make the column not null later
					UPDATE openchpl.test_standard
					SET deleted = true, last_modified_user = -1, certification_edition_id = 1
					WHERE test_standard_id = userEnteredTestStandard.test_standard_id;
				WHEN 1 THEN
					
					-- look up which edition it was
					SELECT INTO referencedByEdition result
					FROM 
					(SELECT DISTINCT cp.certification_edition_id as result
					FROM openchpl.certified_product cp
					JOIN openchpl.certification_result cert ON cp.certified_product_id = cert.certified_product_id
					JOIN openchpl.certification_result_test_standard certTestStd ON cert.certification_result_id = certTestStd.certification_result_id
					JOIN openchpl.test_standard testStd on certTestStd.test_standard_id = testStd.test_standard_id
					WHERE testStd.test_standard_id = userEnteredTestStandard.test_standard_id) innerQuery;
					
					raise notice 'Only listings for edition id % use user-entered test standard %', referencedByEdition, userEnteredTestStandard.number;
			
					-- set this test standard to this edition
					UPDATE openchpl.test_standard
					SET certification_edition_id = referencedByEdition, last_modified_user = -1
					WHERE test_standard_id = userEnteredTestStandard.test_standard_id;
				WHEN 2 THEN
					raise notice 'Listings with both 2014 and 2015 use user-entered test standard %', userEnteredTestStandard.number;

					-- set the existing test standard to 2014
					UPDATE openchpl.test_standard
					SET certification_edition_id = 2, last_modified_user = -1
					WHERE test_standard_id = userEnteredTestStandard.test_standard_id;
					
					-- create a new duplicate test standard for 2015
					INSERT INTO openchpl.test_standard(number, name, certification_edition_id, last_modified_user) VALUES
					(userEnteredTestStandard.number, userEnteredTestStandard.name, 3, -1);
					
					-- find 2015 listings now pointing to the 2014 standard and make them point to the new 2015 standard
					FOR mismatchTestStandardId IN 
					(SELECT certTestStd.certification_result_test_standard_id as result
					FROM openchpl.certified_product cp
					JOIN openchpl.certification_result cert ON cp.certified_product_id = cert.certified_product_id
					JOIN openchpl.certification_result_test_standard certTestStd ON cert.certification_result_id = certTestStd.certification_result_id
					JOIN openchpl.test_standard testStd on certTestStd.test_standard_id = testStd.test_standard_id
					WHERE testStd.test_standard_id = userEnteredTestStandard.test_standard_id
					AND cp.certification_edition_id = 3)
					LOOP
						UPDATE openchpl.certification_result_test_standard
						SET test_standard_id = 
							(SELECT test_standard_id 
							FROM openchpl.test_standard 
							WHERE number = userEnteredTestStandard.number AND certification_edition_id = 3)
						WHERE certification_result_test_standard_id = mismatchTestStandardId;
					END LOOP;
				ELSE
					raise notice 'Test Standard % (id %) was not referenced by any criteria and has been marked deleted.', userEnteredTestStandard.number, userEnteredTestStandard.test_standard_id;
			END CASE;
		END LOOP;
		
		SELECT INTO userEnteredTestStandardCount result
		FROM
			(SELECT count(*) as result
			FROM openchpl.test_standard
			WHERE certification_edition_id IS NULL) innerQuery;
		raise notice '% user-entered test standards is/are left without certification_edition_id after fixing them.', userEnteredTestStandardCount;
		
		-- remove duplicates in the test standards (users have entered some that already existed from the preload, or users have entered some that other users already entered)
		SELECT INTO numDuplicateTestStandards result
		FROM
			(SELECT count(*) as result 
			FROM
				(SELECT number, certification_edition_id, deleted, count(*) as num_count
				FROM openchpl.test_standard
				WHERE deleted = false
				GROUP BY number, certification_edition_id, deleted
				HAVING count(*) > 1) dups) innerQuery;
				
		raise notice '# Duplicate test standards before de-duping %', numDuplicateTestStandards;
		FOR duplicateTestStandard IN 
		(SELECT number, certification_edition_id, deleted, count(*) as num_count
		FROM openchpl.test_standard
		WHERE deleted = false
		GROUP BY number, certification_edition_id, deleted
		HAVING count(*) > 1)
		LOOP
			UPDATE openchpl.certification_result_test_standard 
			SET test_standard_id = 
				(SELECT MIN(test_standard_id) FROM openchpl.test_standard WHERE number = duplicateTestStandard.number AND certification_edition_id = duplicateTestStandard.certification_edition_id)
			WHERE test_standard_id IN 
				(SELECT test_standard_id FROM openchpl.test_standard WHERE number = duplicateTestStandard.number AND certification_edition_id = duplicateTestStandard.certification_edition_id);
			--delete any other test standards with this number
			UPDATE openchpl.test_standard 
			SET deleted = true, last_modified_user = -1
			WHERE number = duplicateTestStandard.number 
			AND certification_edition_id = duplicateTestStandard.certification_edition_id
			AND test_standard_id > 
				(SELECT MIN(test_standard_id) 
				FROM openchpl.test_standard
				WHERE number = duplicateTestStandard.number 
				AND certification_edition_id = duplicateTestStandard.certification_edition_id);
		END LOOP;
		
		SELECT INTO numDuplicateTestStandards result
		FROM
			(SELECT count(*) as result 
			FROM
				(SELECT number, certification_edition_id, deleted, count(*) as num_count
				FROM openchpl.test_standard
				WHERE deleted = false
				GROUP BY number, certification_edition_id, deleted
				HAVING count(*) > 1) dups) innerQuery;
				
		raise notice '# Duplicate test standards after de-duping %', numDuplicateTestStandards;
	END;
$$ LANGUAGE plpgsql;

SELECT openchpl.fillUserEnteredTestStandardEditions();
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

SELECT openchpl.fixTestStandards();
DROP FUNCTION openchpl.fixTestStandards();

-- set column to not allow null
ALTER TABLE openchpl.test_standard 
ALTER COLUMN certification_edition_id SET NOT NULL;