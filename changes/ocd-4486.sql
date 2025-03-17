--
-- create the cap status lookup table
--
CREATE TABLE IF NOT EXISTS openchpl.surveillance_cap_status (
	id bigserial NOT NULL,
	name text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT surveillance_cap_status_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'Other', 
       '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'Other'
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'CAP still open', 
       '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'CAP still open'
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'No CAP', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'No CAP'
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'Attestation Submitted', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted'
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'Testing Completed', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'Testing Completed'
);

INSERT INTO openchpl.surveillance_cap_status (name, last_modified_sso_user)
SELECT 'Required Documentation Submitted', 
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted'
);

CREATE OR replace TRIGGER surveillance_cap_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_cap_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER surveillance_cap_status_timestamp BEFORE UPDATE on openchpl.surveillance_cap_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS surveillance_cap_status_last_modified_user_constraint ON openchpl.surveillance_cap_status;
CREATE CONSTRAINT TRIGGER surveillance_cap_status_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.surveillance_cap_status DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

--
-- create the new table for the multi-value mapping between quarterly report surveillance and the verification for completed cap values
--
CREATE TABLE IF NOT EXISTS openchpl.quarterly_report_surveillance_cap_status_map (
	id bigserial NOT NULL,
	quarterly_report_surveillance_map_id bigint NOT NULL,
	surveillance_cap_status_id bigint NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT quarterly_report_surveillance_cap_status_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_surveillance_map_fk FOREIGN KEY (quarterly_report_surveillance_map_id)
			REFERENCES openchpl.quarterly_report_surveillance_map (id)
			MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_cap_status_fk FOREIGN KEY (surveillance_cap_status_id)
			REFERENCES openchpl.surveillance_cap_status (id)
			MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT			
);

CREATE OR replace TRIGGER quarterly_report_surveillance_cap_status_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_cap_status_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER quarterly_report_surveillance_cap_status_map_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_cap_status_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS quarterly_report_surveillance_cap_status_map_last_modified_user_constraint ON openchpl.quarterly_report_surveillance_cap_status_map;
CREATE CONSTRAINT TRIGGER quarterly_report_surveillance_cap_status_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.quarterly_report_surveillance_cap_status_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

--
-- add column for the new "other" field
--
ALTER TABLE openchpl.quarterly_report_surveillance_map ADD COLUMN IF NOT EXISTS surveillance_cap_status_other text;

----------
-- There are some "blank"-ish values that we can map to NULL
----------
UPDATE openchpl.quarterly_report_surveillance_map 
SET completed_cap_verification = NULL 
WHERE completed_cap_verification IN ('', 'NA', 'N/A', 'n/a', 'No non conformity was found', 'No Non-Conformities found', 'No Non-Conformities were found');

-- 
-- migrate all existing verificaiton of completed cap data to the new table/field
--

CREATE OR REPLACE FUNCTION openchpl.migrate_surveillance_cap_status() RETURNS void AS $$
	DECLARE
	quarterly_report_surveillance_map_id_var bigint;
    existing_verification text;
	BEGIN
		FOR quarterly_report_surveillance_map_id_var IN 
			SELECT id FROM openchpl.quarterly_report_surveillance_map
			WHERE completed_cap_verification IS NOT NULL
		LOOP
			RAISE NOTICE 'Migrating verification of completed cap from row %', quarterly_report_surveillance_map_id_var;
			
			SELECT completed_cap_verification 
				FROM openchpl.quarterly_report_surveillance_map
				WHERE id = quarterly_report_surveillance_map_id_var
			INTO existing_verification;
		
			CASE 
				-- all the different options we enumerated in the mapping
				WHEN existing_verification IN (
					'The developer submitted supporting documentation in the form of screenshots displaying the availability of the ''sync with OBERD'' button, the syncing process once the button is selected, and then the outcome. They also provided an attestation that they have made this functionality available.',
					'The developer worked with its ONC-ACB to provide its Conditions and Maintenance of Certification requirements attestations and update to Mandatory Disclosures in a timeframe that allowed for appropriate review and submission.')	
				THEN
					RAISE NOTICE 'Migrating "%" as Required Documentation Submitted and Attestation Submitted', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted')
						);
						INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted')
						);
				WHEN existing_verification IN (
					'Quarterly report was received. Website was reviewed and confirmed to be compliant.')	
				THEN
					RAISE NOTICE 'Migrating "%" as Required Documentation Submitted and Other', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted')
						);
						
						UPDATE openchpl.quarterly_report_surveillance_map
						SET surveillance_cap_status_other = existing_verification
						WHERE id = quarterly_report_surveillance_map_id_var;
					
						INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Other'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Other')
						);						
				WHEN existing_verification IN (
					'API documentation Link was reviewed.',
					'Product code was updated to improve audit log report query performance and to display messaging to guide users on the need to narrow search scope when necessary. Fix was made in the TheraDoc 4.9.1 release and supporting documentation was submitted to the ACB confirming the changes.',
					'CAP and quarterly report were submitted',
					'Quarterly Report and CAP were received and approved.',
					'The developer worked with its ONC-ACB to submit its Real World Testing results in a timeframe that allowed for appropriate review and publication.',
					'Quarterly report received. Developer POCs updated.',
					'Documentation was received along with CAP',
					'Once the Real World Testing plan is submitted and made available publicly this can be completed.',
					'The developer worked with its ONC-ACB to submit its Real World Testing plans in a timeframe that allowed for appropriate review and publication.',
					'CAP and quarterly report were submitted.',
					'Quarterly report received.',
					'CAP issued and completed.  RWTP submitted.',
					'We validated the updates via the submission of supporting documentation, including screenshots and XML files.',
					'Disculosures URL was received and reviewed',
					'Review of the Corrective Action Plan and the developer''s 2025 Real World Test Plan; confirmation that the RWT plan was posted on the developer RWT website')	
				THEN
					RAISE NOTICE 'Migrating "%" as Required Documentation Submitted', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Required Documentation Submitted')
						);
				WHEN existing_verification IN (
					'Developer certified to revised 170.315(b)(1), (b)(2), (d)(2), (d)(3), (e)(1), (g)(6), and (g)(9) via attestation after internal coding and testing was completed.',
					'Developer attestation was received stating compliance with the 170.315(c)(3) cures update requirements and successful conformance testing was done with the Cypress testing tool.',
					'Developer certified to revised 170.315(b)(3) via attestation and review of test tool validation reports.',
					'Developer certified to revised 170.315(b)(1), (b)(2), (b)(3), (c)(3), (d)(2), (d)(3), (d)(12), (d)(13), (e)(1), (g)(6), and (g)(9) via attestation and review of (b)(3) test tool validation reports.')
				THEN
					RAISE NOTICE 'Migrating "%" as Attestation Submitted AND Testing Completed', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted')
						);
						INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Testing Completed'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Testing Completed')
						);
				WHEN existing_verification IN (
					'All attestations submitted.  CAP closed.',
					'Attestations submitted.',
					'Completed CAP - The developer worked with its ONC-ACB to provide its Conditions and Maintenance of Certification requirements attestations in a timeframe that allowed for appropriate review and submission',
					'Completed CAP - The developer worked with its ONC-ACB to provide its Conditions and Maintenance of Certification requirements attestations in a timeframe that allowed for appropriate review and submission.',
					'Developer certified via attestation to the revised version of 170.315(b)(1), (b)(2), (d)(2), (d)(3), (d)(12), (d)(13), and (g)(6).',
					'Developer certified to revised 170.315(d)(2), (d)(3), (d)(12), and (d)(13) via attestation.',
					'Developer completed their attestation to update 170.315(b)(1), (b)(2), (e)(1), and (g)(6) to adhere to the Cures requirements.',
					'Attestation submitted',
					'Attestations were submitted.',
					'Attestations were submitted.',
					'Attestations submitted.',
					'Attestations submitted',
					'Attestation Submitted',
					'Developer certified to revised 170.315(c)(3), (d)(2), and (d)(3) via attestation.',
					'SLI reviewed the developer''s attestation and completed corrective action documentation',
					'Quarterly Attestations were submitted, CAP completed and closed.',
					'The developer worked with its ONC-ACB to provide its Conditions and Maintenance of Certification requirements attestations in a timeframe that allowed for appropriate review and submission.',
					'Submitted quarterly attestation.',
					'Quarterly Attestations were submitted.',
					'Developer attested the necessary infrastructure was deployed to customer production environments.')
				THEN
					RAISE NOTICE 'Migrating "%" as Attestation Submitted', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Attestation Submitted')
						);
				WHEN existing_verification IN (
					'Not yet completed.',
					'CAP Ongoing.',
					'Corrective Action Plan Issued',
					'The CAP has not yet been completed',
					'CAP is not completed.',
					'Corrective Action Plan is ongoing.',
					'Corrective Action Plan Issued.',
					'Corrective Action Plan issued',
					'CAP is still open',
					'Corrective Action Ongoing',
					'Corrective Action ongoing',
					'CAP has not been completed',
					'NA. The CA Plan is in progress. The developer completed the fix and are waiting for their API developers to complete development in order to fully test and close out the issue.')
				THEN
					RAISE NOTICE 'Migrating "%" as CAP still open', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'CAP still open'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'CAP still open')
						);
				WHEN existing_verification IN (
					'No corrective action plan issued',
					'No CAP was issued',
					'No Corrective Action Plan was issued',
					'Not Applicable (No CAP was necessary).',
					'No Corrective Action Plan Issued',
					'No Corrective Action Plan issued.',
					'No Corrective Action Plan issued',
					'No Corrective Action Plan issued.  Bug was fixed when it was reported',
					'No Corrective Action Plan was issued.',
					'No corrective action plan was issued, as the issue was already fixed.',
					'No corrective action issuesd',
					'No CAP issued',
					'No CAP issued.',
					'No CAP was issued.',
					'No CAP requested or provided. The developer submitted the Q3 quarterly attestation on 11/28/2024.',
					'NA. SLI hasn''t accepted the developer''s Corrective Action Plans because they were not relevant.')
				THEN
					RAISE NOTICE 'Migrating "%" as No CAP', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'No CAP'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'No CAP')
						);
				WHEN existing_verification IN (
					'Drummond tested all non conformity''s.  Resolved through corrective action.',
					'Corrective Action Plan completed.  All issues were resolved and tested by Drummond',
					'Corrective Action Plan Completed and fix tested by Drummond',
					'Drummond tested all non conformity''s.  Corrective Action Closed',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(b)(1) and 170.315(g)(6) have been resolved.',
					'Drummond test all non conformity''s.  Resloved through corrective action.',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(f)(4), 170.315(f)(5), and 170.315(f)(7) have been resolved.',
					'SLI verified with the developer that they completed all steps in the resolution, tested it and pushed it out to affected users.',
					'Drummond tested the non conformity.  Resolved',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(b)(1), (b)(2), (e)(1), (g)(6) and (g)(9) have been resolved.',
					'Issue has been resolved and tested by Drummond',
					'CAP will be completed pending successful live testing of (b)(3) Medication History',
					'Drummond tested all non conformity''s.  Resolved through Corrective Action.',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(b)(1), (b)(2), (e)(1), (f)(4), (f)(5), (f)(7), (g)(6) and (g)(9) have been resolved.',
					'Drummond tested all non conformity''s',
					'CAP open until testing can be done to confirm fix.',
					'Drummond conducted a surveillance test of both criterion to confirm compliance.',
					'Corrective Action Plan Completed and tested to confirm resolution.',
					'Drummond tested all non conformity''s.  Corrective Action Resolved.',
					'Surveillance testing was conducted to confirm the non-conformity to 170.315(f)(7) has been resolved.',
					'Developer did change the functionality but is deciding whether or not to appeal further. Demonstrated on July 14, 2021.  CAP Completed.',
					'Developer did change the functionality but is deciding whether or not to appeal further. Demonstrated on July 14, 2021.  Corrective Action Closed',
					'Surveillance testing was conducted to confirm the non-conformity to 170.315(f)(1) has been resolved.',
					'Corrective Action Plan Completed and tested to confirm compliance.',
					'Corrective Action Plan was issued.  Issues have been resolved and tested by Drummond',
					'Corrective Action Plan was issued.  Issues have been resolved by developer and they are scheduling a test date with Drummond.  CAP completed',
					'Drummond tested all non conformity''s.  Resolved through correction action',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(b)(1), 170.315(b)(2), 170.315(e)(1), 170.315(g)(6), and 170.315(g)(9) have been resolved.',
					'Surveillance testing was conducted to confirm the non-conformities to 170.315(b)(1), (b)(2), (e)(1), and (g)(9) have been resolved.',
					'CAP is not completed, Drummond is requiring the functionality be re-tested.',
					'Corrective Action Plan Completed and reported issues were tested and confirmed compliant.',
					'Internal testing was conducted and documentation review was performed to confirm expected calculation.',
					'Issue resolved and tested by Drummond.  CAP Closed',
					'Issue resolved and tested by Drummond.  CAP Closed.',
					'Drummond tested the ability to run a QRDA file without intervention from the developer.',
					'DRummond test the non conformity.',
					'Corrective Action Completed, all reported issues were tested and confirmed compliant.',
					'CAP will be completed pending successful live testing of (b)(3) to ensure support for RxNorm Codes',
					'Surveillance testing was conducted to confirm the non-conformity to 170.315(g)(10) has been resolved.',
					'This CAP was retro-actively issued and then Drummond used the closed date as the day the product was withdrawn by the developer and Drummond issued a new CHPL Listing.  Drummond tested with the developer on the active product and closed that non-compliance on January 21, 2021.',
					'Live testing was successfully conducted in a newer Version 22 of the product (15.04.04.2880.prac.22.04.1.220621). All customers have been migrated from this Version 20 to Version 22.',
					'Drummond tested all non conformity''s.',
					'Live testing of (b)(3) was conducted on 1/18/23. This included utilizing the Electronic Prescribing test tool and Test Case Validation reports were also provided and reviewed to confirm the support for RxNorm.',
					'Drummond tested with the developer and closed the non compliance on January 21, 2021',
					'Live testing was successfully conducted in a newer Version 22 of the product (15.04.04.2880.flow.22.05.1.220621). All customers have been migrated from this Version 20 to Version 22.',
					'Drummond tested all criteria to ensure compliance.  CAP closed',
					'Surveillance testing was conducted to confirm the non-conformity to 170.315(b)(1) has been resolved.',
					'Validation testing was conducted to confirm the non-conformities to 170.315(f)(5) have been resolved.',
					'Drummond tested the non conformity.',
					'Successful live testing of (b)(3) was conducted with the developer to validate Medication History capabilities.')
				  THEN
					RAISE NOTICE 'Migrating "%" as Testing Completed', existing_verification;
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
						(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
						SELECT quarterly_report_surveillance_map_id_var, 
								(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Testing Completed'),
								'6498c4f8-b0f1-70b5-55de-d84faae73402',
								(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
						WHERE NOT EXISTS (
								SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
								WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
								AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Testing Completed')
						);											
				-- other
				ELSE
					RAISE NOTICE 'Migrating "%" as Other', existing_verification;
					
					UPDATE openchpl.quarterly_report_surveillance_map
					SET surveillance_cap_status_other = existing_verification
					WHERE id = quarterly_report_surveillance_map_id_var;
				
					INSERT INTO openchpl.quarterly_report_surveillance_cap_status_map 
					(quarterly_report_surveillance_map_id, surveillance_cap_status_id, last_modified_sso_user, deleted)
					SELECT quarterly_report_surveillance_map_id_var, 
							(SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Other'),
							'6498c4f8-b0f1-70b5-55de-d84faae73402',
							(SELECT deleted FROM openchpl.quarterly_report_surveillance_map WHERE id = quarterly_report_surveillance_map_id_var)
					WHERE NOT EXISTS (
							SELECT * FROM openchpl.quarterly_report_surveillance_cap_status_map tbl
							WHERE tbl.quarterly_report_surveillance_map_id = quarterly_report_surveillance_map_id_var
							AND surveillance_cap_status_id = (SELECT id FROM openchpl.surveillance_cap_status WHERE name = 'Other')
					);
			END CASE;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT openchpl.migrate_surveillance_cap_status();
DROP FUNCTION IF EXISTS openchpl.migrate_surveillance_cap_status;
