--
-- create the grounds for initiating lookup table
--
CREATE TABLE IF NOT EXISTS openchpl.grounds_for_initiating (
	id bigserial NOT NULL,
	name text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT grounds_for_initiating_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'Other', 
       '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'Other'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'ICS', 
       '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'ICS'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'Complaints', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'Complaints'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'Developer-Reported', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'Developer-Reported'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'RWT Self-Reported Non-conformance', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'RWT Self-Reported Non-conformance'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'Missed Requirement Deadline', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'Missed Requirement Deadline'
);

INSERT INTO openchpl.grounds_for_initiating (name, last_modified_sso_user)
SELECT 'Randomized', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.grounds_for_initiating WHERE name = 'Randomized'
);

CREATE OR replace TRIGGER grounds_for_initiating_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.grounds_for_initiating FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER grounds_for_initiating_timestamp BEFORE UPDATE on openchpl.grounds_for_initiating FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS grounds_for_initiating_last_modified_user_constraint ON openchpl.grounds_for_initiating;
CREATE CONSTRAINT TRIGGER grounds_for_initiating_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.grounds_for_initiating DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

--
-- create the new table for the multi-value mapping between quarterly report surveillance and the grounds for initiating values
--
CREATE TABLE IF NOT EXISTS openchpl.quarterly_report_surveillance_grounds_for_initiating_map (
	id bigserial NOT NULL,
	quarterly_report_surveillance_map_id bigint NOT NULL,
	grounds_for_initiating_id bigint NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT quarterly_report_surveillance_grounds_for_initiating_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_surveillance_map_fk FOREIGN KEY (quarterly_report_surveillance_map_id)
			REFERENCES openchpl.quarterly_report_surveillance_map (id)
			MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER quarterly_report_surveillance_grounds_for_initiating_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_grounds_for_initiating_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER quarterly_report_surveillance_grounds_for_initiating_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_grounds_for_initiating_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS quarterly_report_surveillance_grounds_for_initiating_map_last_modified_user_constraint ON openchpl.quarterly_report_surveillance_grounds_for_initiating_map;
CREATE CONSTRAINT TRIGGER quarterly_report_surveillance_grounds_for_initiating_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.quarterly_report_surveillance_grounds_for_initiating_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

--
-- this column stopped being used some time ago but was left around
--
ALTER TABLE openchpl.quarterly_report_surveillance_map DROP COLUMN IF EXISTS surveillance_process_type_id;

--
-- add column for the new "other" field
--
ALTER TABLE openchpl.quarterly_report_surveillance_map ADD COLUMN IF NOT EXISTS grounds_for_initiating_other text;

-- 
-- migrate all existing grounds for surveillance data to the new table/field
--

CREATE OR REPLACE FUNCTION openchpl.migrate_grounds_for_initiating() RETURNS void AS $$
	DECLARE
	quarterly_report_surveillance_map_id_var bigint;
    existing_grounds text;
	BEGIN
		FOR quarterly_report_surveillance_map_id_var IN 
			SELECT id FROM openchpl.quarterly_report_surveillance_map
		LOOP
			RAISE NOTICE 'Migrating grounds for initiating surveillance from row %', quarterly_report_surveillance_map_id_var;
			
			SELECT grounds_for_initiating 
				FROM openchpl.quarterly_report_surveillance_map
				WHERE id = quarterly_report_surveillance_map_id_var
			INTO existing_grounds;
		
			CASE 
				-- all the different options we enumerated in the mapping
				WHEN existing_grounds IN (
					'Complaint came in and was closed on 9/15/19.  Developer contacted the provider on multiple occasions attempting to educate the provider on how to use the product correctly.  Complainant continued to complain so Drummond requested to demonstrate the listed criteria.',
					'An anonymous complainant stated that the developer advertised that their certified product could be used for MIPS and also that the product lacked sufficient certified criteria to quality for MIPS use.',
					'Complaint submitted via user. Stated CQM report exclusions always reporting 0.',
					'After receiving a complaint from an end user that has already written the developer''s API,  Drummond was attempting to register to test the eCW API using the Interoperability Hub, the registration link was broken.',
					'Complaint related to NewCropRx',
					'Drummond received a complaint that the Meditech product was not able to provide patient information requested.',
					'SLI received a complaint both through the ONC and directly from the complainant.',
					'Third Party Organization reported the the MOSAIQ product could not bulk export.  Drummond conducted a test of the product and confirmed bulk export is compliant.',
					'Patient reported they could not login to the patient portal.',
					'Complaint from user that product was not able to calculate CQMs.',
					'Complaint (NewCropRx)',
					'Anonymous complainant contacted Drummond and indicated that they had to take a hardship because they were unable to report.  Once the developer investigated they found that many of the CQMs were not calculating correctly.',
					'SLI received a complaint that originated from the developer''s customer and was reported to the developer, who reported it to SLI in the developer''s quarterly report.')	
				THEN
					RAISE NOTICE 'Migrating "%" as Complaints', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Complaints'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Complaints')
						);
				WHEN existing_grounds IN (
					'Surveillance testing conducted due to Inherited Certified Status (ICS) request for the third time for this product.',
					'Surveillance testing conducted due to the number of Inherited Certified Status (ICS) requests for this product.')
				THEN
					RAISE NOTICE 'Migrating "%" as ICS', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'ICS'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'ICS')
						);
				WHEN existing_grounds IN (
					'Routine proactive surveillance of developer''s website')
				THEN
					RAISE NOTICE 'Migrating "%" as Randomized', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Randomized'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Randomized')
						);
				WHEN existing_grounds IN (
					'The Leidos ONC-ACB initiated reactive surveillance on the grounds of a non-conformity self-disclosure by the developer during the course of their RWT.')
				THEN
					RAISE NOTICE 'Migrating "%" as RWT Self-Reported Non-conformance', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'RWT Self-Reported Non-conformance'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'RWT Self-Reported Non-conformance')
						);	
				WHEN existing_grounds IN (
					'Health IT Module was not updated to the applicable revised version of 170.315(c)(3) by the regulatory deadline.', 
					'Developer failed to provide 2024 Real World Test Plan by the ACB deadline',
					'Developer failed to submit their Q4 2021, Q1 and Q2 2022 Quarterly Attestations.',
					'Q4 2018 and Q1 2019 Quarterly Attestations have not been submitted for ACB Review.',
					'Failure to submit a quarterly report of adaptations and updates',
					'Developer failed to submit their Q2 Quarterly Attestation by the due date.',
					'Failed to submit a quarterly report of adaptations/updates.',
					'RWT plan not submitted',
					'Developer failed to submit their Q2 2022 Quarterly Attestation by the due date',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (d)(2), (d)(3), (e)(1), (g)(6), and (g)(9) by the regulatory deadline.',
					'Health IT Module was not updated to the revised version of 170.315(c)(3), (d)(2), and (d)(3) by the regulatory deadline.',
					'The health IT developer failed to provide its Conditions and Maintenance of Certification requirements attestations to its ONC-ACB within the attestation window.',
					'Developer missed window of Attestation submission for the the Conditions and Maintenance of Certification Requirement.',
					'Developer failed to provide quarterly report for 2023-Q3 in a timely manner',
					'Developer missed 170.523 (m)(1) and (2) quarterly reporting deadline for Q3',
					'Failed to submit  a quarterly report of adaptations/updates. (170.523.m)',
					'Health IT Module was not updated to the revised version of 170.315(b)(3) by the regulatory deadline.',
					'Developer failed to submit quarterly attestations for 2021',
					'Developer failed to submit their Q4 2021, Q1 2022 and Q2 2022 Quarterly Attestations',
					'Developer failed to submit their Q1 and Q2 Quarterly Attestations.',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (d)(2), (d)(3), (d)(12), (d)(13), (g)(6), and (g)(9) by the regulatory deadline.',
					'The health IT developer failed to provide its Conditions and Maintenance of Certification requirements attestations to its ONC-ACB within the attestation window. Also, their Mandatory Disclosures did not include required information.',
					'Failure to update to the Cures Update criteria by the compliance deadline.',
					'Q2 2019 Qaurterly Attestation Delinquent',
					'Missed deadline for required 170.523 (m)(1) and (m)(2) quarterly reporting',
					'Developer failed to submit their Q1 and Q2 2022 Quarterly Attestations.',
					'A Real World Testing plan was not submitted to the ONC-ACB by the ONC-ACB''s determined deadline for completeness review.',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (e)(1), and (g)(6) by the regulatory deadline.',
					'Health IT Module was not updated to the revised version of b.3, c.3, d.2, d.3 by the regulatory deadline.',
					'Health IT Module was not updated to the revised version of 170.315(d)(2), (d)(3), (d)(12), and (d)(13) by the regulatory deadline.',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (b)(3), (c)(3), (d)(2), (d)(3), (d)(12), (d)(13), (e)(1), (g)(6), and (g)(9) by the regulatory deadline.',
					'Developer has not submitted a quarterly attestation since 2018. Mandatory disclosure still reflects 2014 Edition.',
					'A Real World Testing Plan was not submitted to the ONC-ACB by the ONC-ACB''s determined deadline for completeness review.',
					'Developer failed to submit their Q1 and Q2 2022 Quarterly Attestations',
					'Failed to submit a quarterly report of adaptations and updates',
					'Missed deadline to provide hyperlink to disclosures required in 170.523 (k)(1)',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (d)(2), (d)(3), (d)(12), (d)(13), and (g)(6) by the regulatory deadline.',
					'Developer had 3 delinquent quarterly reports',
					'Failed to submit a quarterly report of adaptations/updates',
					'Developer was notified 4/26/2020 and again May 2021 of delinquent attestations and incorrect Mandatory disclosure statement.',
					'Real World Testing results report was not submitted to the ONC-ACB by the ONC-ACB''s determined deadline for completeness review.',
					'Health IT Module was not updated to the revised version of 170.315(b)(1), (b)(2), (c)(3), (d)(2), (d)(3), (d)(12), (d)(13), (e)(1), (g)(6), and (g)(9) by the regulatory deadline.',
					'Developer failed to submit a quarterly report per 170.523.m',
					'Developer failed to submit quarterly attestations for 2021.')
				  THEN
					RAISE NOTICE 'Migrating "%" as Missed Requirement Deadline', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Missed Requirement Deadline'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Missed Requirement Deadline')
						);						
				WHEN existing_grounds IN (
					'Developer self-reported an issue which may impact 170.315(g)(6). The issue was reported and resolved within 30 days.',
					'Developer reported that they shut down their patient portal due to a data breach',
					'Developer reported in their quarterly attestation that they discovered they were unable to receive health records sent from Patient Portal via Direct Address Summary.  Issue was fixed when reported.',
					'Reported by Developer Intergy users are unable to open certain documents/encounter notes in rich text format. When trying to open the document, the user receives the following error message “document is corrupt.” ErrorUnique: 1803108852.  Providers are unable to view the patient’s encounter note.  And unsigned notes cannot be opened for completion.',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(d)(3) audit issue under specific circumstances.',
					'Developer self-reported an issue which may impact 170.315(f)(6) reporting. The issue was reported and resolved within 30 days.',
					'Developer reported they found an issued with Drug Interaction Checking.',
					'Developer self-reported an issue that was found and fixed where specific allergy codes within the database weren’t populating the C-CDA',
					'Developer self-reported that a system configuration issue was discovered where the FHIR server infrastructure required for 170.315(g)(10) capabilities was not configured/deployed to customer production environments as intended.',
					'The developer self-reported an issue relating to their audit log, whereas it was always capturing data, it was not able to be accessed for greater than 30 days worth of events without developer assistance.',
					'Developer reported to Drummond in their quarterly attestation that they had a new CCDA generation model.  Drummond requested to test 170.315(b)(1) and found required data missing from the Common Clinical Data Set.',
					'Developer self-reported an issue that was found where the CCDA was missing granular CDC ethnicities for the OMB rollup of “Hispanic or Latino”.',
					'Developer self reported an issue with their validation logic.',
					'Developer reported to Drummond that the reporting product did not support auditable events and audit reports.',
					'Developer reported through their "reportable event process" multiple issues found with their eClinicalWorks v11 product',
					'Developer reported that the automatic time out function was not working correctly.',
					'Developer reported in their Q2 attestation that they conducted an audit of their product and found multiple issues that were not compliant with their certification',
					'Developer self-reported an issue that could potentially impact 170.315(b)(1), 170.315(b)(2), 170.315(e)(1), 170.315(g)(6), and 170.315(g)(9) where the time element for the author section is not present for the Medications, Health Concerns and Goals section in the C-CDA document when the medications and goals are recorded using Templates. This issue may also occur when the medications are recorded using order sets.',
					'Developer reported that the unit of measure was not in the QRDAI file for the BMI measure',
					'Developer self-reported an issue that was found where the CCDA is missing granular CDC ethnicities for the OMB rollup of “Hispanic or Latino”.',
					'Developer reported that the Frailty outpatient visit code visit with embedded advanced illness code is causing the QRDA 1 file to fail.',
					'Developer reported and issue with the audit log that they had fixed',
					'Developer self-reported an issue that may arise under certain circumstances where auditing relating to 170.315(d)(3) may not function for a period of time while a client is being migrated.',
					'Developer reported that they found issues with the automatic time out functionality.',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(a)(1) and 170.315(b)(3) issue.',
					'Developer reported to Drummond after conducting an internal audit:  There is a defect with a second request for a patient''s immunization history and forecast, also missing audit log records when adding or printing lab/imaging orders, and When logged into the portal as a patient and trying to send a new secure message, sending fails.   The issue does not happen for new sites and is only happening for sites that change configuration settings after the upgrade to 4.6.',
					'Developer reported that they found that Lab results entered manually were not being captured on the audit log.',
					'Developer self-reported an issue that was found and already fixed for a potential issue impacting 170.315(g)(10) where a patientâ€™s previous address may not be included with an API request.',
					'Developer reported issues with sending to Immunization Registries',
					'Developer self-reported an issue for Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired. New requirements with the USCDI v1 standard allow for a larger range of SNOMED CT codes for Smoking Status that should be available and codified.',
					'Developer reported through their "reportable event letter" required under their CIA.  Several of the reported events, Drummond required a test to ensure compliance.',
					'Developer reporting during the course of Real World testing, a potential issue impacting 170.315(f)(5).',
					'Developer self-reported an issue for 170.315(g)(10) where the Inferno Test 7/Multi-Patient API is failing.',
					'Reported by Developer: When prescribing medications during discharge, MEDHOST Enterprise 2017 R2 & 2018 R1 queries Medispan drug database for RxNorm codes. The RxNorm codes are used during the e-prescribing workflow for retrieving DEA schedules for controlled substances as appropriate. The RxNorm codes are not populated into the NCPDP V10.6 message sent to the third-party vendor’s e-prescription network.',					
					'Developer self-reported an issue that was found and already fixed impacting 170.315(b)(1) where deployments to new customers did not include an additional code fix necessary to display new C-CDA 2.1 sections within the UI.',
					'Developer self-reported an issue that was found and already fixed for a potential issue impacting 170.315(b)(1), 170.315(b)(2), 170.315(e)(1), 170.315(g)(6), and 170.315(g)(9) relating to Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired.',
					'Developer self-reported some validation errors that were found and already fixed impacting 170.315(g)(10). These were discovered in the course of conducting their Real World Testing.',
					'Developer reported that their IRO conducted a Negative Test of (d)(1) and found: The tester verifies that the unique identifier cannot access health information or perform actions for which it does not have permission.  The test failed as the user was able to delete the vital signs when they should not have had the access control.',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(d)(2) audit issue under specific circumstances.',
					'Developer self-reported an issue that was found and already fixed for a potential issue impacting 170.315(b)(1), 170.315(b)(2), 170.315(e)(1), 170.315(f)(5), 170.315(g)(6), and 170.315(g)(9) relating to Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired.',
					'Reported by the developer in a "Reportable Event Letter" that they found and fixed issues with Implantable Devices and View Download and Transmit',
					'Given the number of reported non-conformities reported by the developer, Drummond felt it was prudent to test all certification criteria for compliance.',
					'Developer reported that the RxNorm codes displaying in the record and exported as part of the CCD are inaccurate (brand vs. generic, incorrect codes, retired codes etc.)',
					'Developer self-reported an issue that was found for a potential issue impacting 170.315(b)(1) and 170.315(g)(6) relating to Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired.',
					'Developer reported to Drummond the following: 1. Patient Security Access Control (PSAC) enabled patient in the eClinicalTouch application, the corresponding entry is not present in the Break the Glass Logs. 2. username associated with the “Modified” action for the Social History section in the Progress Notes Access Logs displays as blank when a specific workflow is followed',
					'Developer reported through their reportable event requirements that their product was not transmitting the required codes.',
					'Developer self-reported an issue that was found relating to 170.315(f)(1) where in certain situations the HL7 immunization message is not created.',
					'Developer reported a change was introduced to the CareLogic production system. Reported a connectivity issue involving the systems Audit Log functionality.',
					'Developer reported in their quarterly attestations that they found some issues and made changes to 170.315(a)(4), (a)(9) and (d)(6)',
					'Developer reported that they inadvertently removed a URL from their API and fixed it',
					'Developer self-reported an issue that was found and fixed where granular ethnicity codes were not available.',
					'Developer reported that the athenaclinical for Hospitals product can generate a CCD as part of a different certified functionality (b)(6), and also via an engine which is enabled as part of an “internal page” not accessible to clinicians (i.e., end users)',
					'Developer requested that Drummond conduct a test of 170.315(d)(6).  Customer reported to Drummond that as a condition of their settlement with the Office Of The Inspector General they were required to conduct a test of "Data Export".',
					'The developer self-reported an identified calculation issue related to 170.315(c)(2).',
					'Developer discovered a bug that prevented bulk CCDA exporting.  Bug was fixed and tested by Drummond',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(e)(1) issue.',
					'Developer discovered during internal testing relating to Cures, their users do not have Medication History enabled.',
					'Developer Self-Reported issue.',
					'Developer reported while going through their 2017071 test with Surescripts they were not transmitting the RxNorm Code.',
					'Developer reported that their Template pre-selected medications still show on face sheet & CCD''s even when they are unselected.',
					'Developer reported: When logged into the portal as a patient and trying to send a new secure message, sending fails.   The issue does not happen for new sites and is only happening for sites that change configuration settings after the upgrade to 4.6. and Prime Suite does provide a separate means to record for birth sex.  The administrative gender collected in patient registration is currently also output in the CCDA as the birth sex.',
					'Developer found and reported that the implanted device UDI is failing to parse.',
					'Developer discovered during testing that they do not support submission, receiving, and storing of RxNorm Codes.',
					'Developer reported that while Solution Series v9 contain RxNorm codes for the majority of prescription medications and some medication allergies, the system does not contain RxNorm codes for every single prescription medication and medication allergy, including those that represent a non-dispensable medication. When a CCD is generated for a transition of care, the XML contains an RxNorm code for the medication or medication allergy if such code is present in the system. When, however, the medication or medication allergy is not mapped to an RxNorm code or is otherwise a non-dispensable medication, an RxNorm code is not included; instead, a null value is populated in the RxNorm field in the XML',
					'Developer self-reported an issue that was found for a potential issue impacting 170.315(f)(4), 170.315(f)(5), and 170.315(f)(7) relating to Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired.',
					'Developer reported to Drummond that they found and fixed and issue with 170.315(b)(2)',
					'Developer reported that On the OBChart, when resulting the HCG test as positive, a diagnosis is automatically created indicating the patient is pregnant. The SNOMED value associated with the pregnancy diagnosis is 289908002, which is not in the correct value set and results in the CCDA failing validation.',
					'Reported by the developer, the athenaclinicals product can generate a CCD as part of a different certified functionality (b.6), and also via an engine which is only enabled as part of an “internal page” not accessible to end users. CCDA cannot be transmitted.',
					'Developer reported to Drummond:  GPP was not displaying the patient’s pulse oximetry reading (LOINC 59408-5) as recorded in the Common Clinical Data (CCDA) in Prime Suite v18.00.02.00.  GPP was not displaying the patients birth sex (LOINC 76689-9) as recorded in the CCDA in Social History. The administrative gender collected is properly displayed in GPP as recorded in Prime Suite.  GPP supports .xml download of both an ambulatory summary and visit summary. The ambulatory summary download is created using the CCD template id as specified in §170.205(a)(4). However, the .xml download for the visit summary is built with a referral note template note ID not the required CCD template id and therefore does not meet the requirement outlined for the criteria.',
					'Developer reported through the reportable events that they had created a new tool that would audit what they were capturing in their audit log.  While deploying that tool they discovered many issues with the audit log.',
					'Developer recently discovered that the feature associated with the (b)(9) criterion does not utilize the official "Care Plan" template',
					'Developer reported in their Q2 2019 attestation that they made changes to their product and requested the product to be inherited.  This was the third consecutive inheritance request, therefore Drummond initiated Surveillance.',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(f)(6) issue.',
					'Developer reported during the course of Real World Testing that there may be a user workflow that does not generate a HL7 V2.5.1 compliant Immunization Message. Instead, an older version of the message was being created with a specific workflow.',
					'Developer reported  that when a user updates patient demographics, specifically address or date of birth, through the claim edits modal, the date of birth and/or address changes are updating information on other patients.  Developer fixed prior to reporting.',
					'Developer reported their Independent Review Organization identified several issues while conducting an audit.  Developer''s Quality Committee reviewed and determined the issues reported were not compliant with certification criteria.',
					'Reported by the Developer:  DTR170.314(g)(1)/(2) – 17: Medication Reconciliation A client just reported to us an error, which lead us to find a fault with the logic of this report, requiring that we change the SQL query to accommodate the instance presented by the client.  This change in our code may also result in changes in the results on this measure as reported by clients to CMS. Of course, we will  advise all our clients that an upgrade  to the M 17 query will be made asap to rectify the error and that they rerun the report for the 2018 year.  Developer had the issue fixed at the time it was reported.',
					'An email from the developer confirmed the certified product did not meet the automated token revocation requirement in 170.315(g)(10)',
					'Developer found and reported that the implanted device UDI is failing to parse,  diagnosis is missing on a CancelRx or RxChange, and that antigen is in a separate ORC/RCA node.',
					'Developer report that an audit record is not created when viewing/accessing the care plan.  Issue was fixed when reported',
					'Developer reported they found and fixed: This issue was discovered internally by Greenway. • Allergies in a Consolidated Clinical Document Architecture (CCDA) document can be imported into Intergy as discreet data. • When utilizing this function, the allergies section of Intergy fails to display the allergies, including any allergies previously documented in the patient’s chart. • An error message: “An error occurred while loading” is received. • A user can continue working but is unable to resolve the error. • Allergy checking continues to function even though the allergies can’t be viewed in the allergy list. • If, previously entered allergies were listed in a prior note, they would be visible there. • Found in version 12.50.00.02',
					'Developer self-reported an issue that was found for a potential issue impacting 170.315(f)(7) relating to Smoking Status where the system is still utilizing the previously valid eight-code value set standard from 107.207(h) which has been retired.',
					'The developer reported a non-conformity that affects 2 of the certified criteria.',
					'Reported by Developer: A user that has no security rights to access confidential patient records, can still access records from practice management patient flow tracking when the patient information modeless window is already open. And Audit records created for batch export(b6) incorrectly indicate a view action was taken for each CCD, not a create action. No view action takes place.',
					'The developer self-reported an issue relating to their audit log where when using a mobile modality, certain audit log actions werenâ€™t being logged as expected.',
					'Developer reported Consolidated Clinical Architecture Document (CCDA) missing required information.',
					'Developer reported in their Q2 attestation Costs and Limitations that the Infobutton is disabled by default and they had issues with notifications to immunization registries',
					'Developer reporting during the course of Real World testing, a potential issue impacting 170.315(b)(1) and 170.315(b)(6). Both items were reported within 30 days and resolved.',
					'Developer reported through their Reportable Event Process that they had corrected issues found with their Drug-Drug, Drug-allergy functionality, ePrescribing functionality, Application Access-data, and Application Acces-All',
					'Developer reported two issues identified internally (see incident reports in box): Reconciliation Encounters not including C-CDAs were included in the following measures resulting in an inflation of the numbers: 2018 Medicaid PI Objective 7: Health Information Exchange Measures 2 and 3 and 2018 MIPS PI Base Measure: Send a Summary of Care and Performance Measure: Clinical Information Reconciliation. And Undeliverable Direct Messages included in the following 2018 measures: 2018 MIPS Promoting Interoperability - Send a Summary of Care and 2018 Medicaid Promoting Interoperability - Health Information Exchange â€“ Objective 7, Measure 1',
					'Developer reported to Drummond they found and fixed an issue with 170.315(b)(2)',
					'Developer self-reported an issue encountered during the course of Real World testing a potential issue impacting 170.315(b)(1).',
					'Developer found and reported Quick registered patients by default do not have a patient ID, resulting in audit records without a unique patient identifier. Unique ID is also not present in the batch export.',
					'Developer reported that When editing the patient or person’s sex field on the registration page, the gender identity is also being updated in the database and CCDA’s fail to create when orthostatic vitals are captured via a connected device.',
					'Developer self-reported an issue that was found and fixed for a potential 170.315(g)(2) calculation issue specific to RT7.',
					'Developer reported that they found an issue On the OBChart, when resulting the HCG test as positive, a diagnosis is automatically created indicating the patient is pregnant. The SNOMED value associated with the pregnancy diagnosis is 289908002, which is not in the correct value set and results in the CCDA failing validation.')	
				THEN
					RAISE NOTICE 'Migrating "%" as Developer-Reported', existing_grounds;
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Developer-Reported'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Developer-Reported')
						);						
				-- other
				ELSE
					RAISE NOTICE 'Migrating "%" as Other', existing_grounds;
					
					UPDATE openchpl.quarterly_report_surveillance_map
					SET grounds_for_initiating_other = existing_grounds
					WHERE id = quarterly_report_surveillance_map_id_var;
					
					INSERT INTO openchpl.quarterly_report_surveillance_grounds_for_initiating_map 
						(quarterly_report_surveillance_map_id, grounds_for_initiating_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Other'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_grounds_for_initiating_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND grounds_for_initiating_id = (SELECT id FROM openchpl.grounds_for_initiating WHERE name = 'Other')
						); 
			END CASE;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT openchpl.migrate_grounds_for_initiating();