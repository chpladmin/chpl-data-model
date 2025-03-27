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
				WHEN quarterly_report_surveillance_map_id_var IN (441,566)	
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
				WHEN quarterly_report_surveillance_map_id_var IN (279)	
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
				WHEN quarterly_report_surveillance_map_id_var IN (2,213,206,207,211,208,209,210,212,214,24,261,260,9,10,11,12,13,157,4,3,5,6,7,8,191,187,188,189,190,192,193,222,683,223,224,677,682,438,315,450,452,359,459,447,448,446,449,440,442,454,443,453,444,458,468,506,473,476,461,499,494,643,17,221)	
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
				WHEN quarterly_report_surveillance_map_id_var IN (475,486,487,465)
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
				WHEN quarterly_report_surveillance_map_id_var IN (97,96,432,62,93,94,95,434,164,88,117,86,87,98,80,82,85,77,78,79,81,84,374,427,429,433,479,425,357,411,412,413,445,405,406,400,401,407,408,409,403,404,410,415,416,428,430,485,533,578,656,658,685,686,684)
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
				WHEN quarterly_report_surveillance_map_id_var IN (200,381,384,65,36,385,386,31,89,198,215,169,170,104,105,107,118,119,383,382,219,35,184,19,70,71,73,91,318,336,348,350,338,371,426,22,30,32,34,38,37,379,471,353,380,472,302,46,40,306,303,69,72,317,373,474,378,337,41,43,44,477,488,481,45,47,48,49,480,484,482,483,50,501,532,491,469,478,470,535,51,496,52,530,555,519,53,531,54,569,492,502,500,495,498,559,616,55,553,56,617,57,646,647,648,649,653,654,655,667,668,669,58,20,103,106,59,108,109,110,60,61,63,111,112,113,114,64,115,116,120,121,122,123,67,90,92,124,125,99,100,126,127,128,129,101,102,130,135,131,132,66,133,134,136,137,138,139,142,143,144,146,147,148,149,150,151,158,159,160,161,162,163,179,181,182,183,693,23,33,74,75,76,83,68)
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
				WHEN quarterly_report_surveillance_map_id_var IN (15,195,196,197,199,25,26,27,28,29,399,387,250,252,431,272,14,679,680,389,341,573,606,254,300,301,251,298,304,299,608,316,323,365,356,388,574,537,588,515,538,521,512,539,543,509,517,540,510,541,609,589,594,598,542,544,597,545,546,511,591,547,548,564,596,599,513,611,613,614,618,549,551,550,552,516,605,561,523,508,518,601,602,615,514,520,522,524,525,526,603,619,622,625,627,628,630,632,633,634,560,629,568,576,631,570,556,604,620,623,626,592,593,595,600,610,621,624,635,636,642,644,650,659,660,661,662,664,665,663,688,670,671,672,673,687,694,558,554,557,652,674,675,690,691,692,274,343,344,345,347,563)
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
				WHEN quarterly_report_surveillance_map_id_var IN (216,226,233,217,218,174,186,375,280,424,225,340,282,141,273,305,321,377,436,392,396,397,398,402,423,462,451,584,437,439,529,528,590,583,460,466,577,565,493,503,534,562,571,572,575,581,582,586,587,612,641,640,645,166,145,180,185,227,232,234,239,281,283,308,309,313,324,333)
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
