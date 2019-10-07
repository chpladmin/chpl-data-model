-- Deployment file for version 17.12.0
--     as of 2019-10-07
-- ocd-2841.sql
DROP TABLE IF EXISTS openchpl.url_check_result;
DROP TABLE IF EXISTS openchpl.url_type;

-- url type will be used to determine
-- what sort of data the url is associated with in the database (acb website, atl website, developer website, etc).
CREATE TABLE openchpl.url_type (
	id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_type_pk PRIMARY KEY (id)
);
CREATE TRIGGER url_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_type_timestamp BEFORE UPDATE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.url_type (name, last_modified_user)
VALUES ('ONC-ATL', -1),
('ONC-ACB', -1),
('Developer', -1),
('Mandatory Disclosure URL', -1), -- transparency_attestation_url
('Test Results Summary', -1), -- report_file_location
('Full Usability Report', -1), -- sed_report_file_location
('API Documentation', -1); -- api_documentation

CREATE TABLE openchpl.url_check_result (
	id bigserial NOT NULL,
	url_type_id bigint NOT NULL,
	url text NOT NULL,
	response_code int, --allow null in case something times out?
	response_message text, -- if there is some additional text about the response (error message?)
	checked_date timestamp, -- null to indicate we know about the URL in the system but haven't checked it yet
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_check_result_pk PRIMARY KEY (id),
	CONSTRAINT url_type_fk FOREIGN KEY (url_type_id)
		REFERENCES openchpl.url_type (id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER url_check_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_check_result_timestamp BEFORE UPDATE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();;
-- ocd-2699.sql
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'RT13 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'RT14 EC', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'RT14 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT15 EC', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT15 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'RT15 EC', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'RT15 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'RT13 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'RT14 EC', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'RT14 EC');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.12.0', '2019-10-07', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
