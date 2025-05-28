CREATE TABLE IF NOT EXISTS openchpl.listing_not_up_to_date_reason (
	id bigserial NOT NULL,
	name text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT listing_not_up_to_date_reason_pk PRIMARY KEY (id)
);

CREATE OR replace TRIGGER listing_not_up_to_date_reason_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_not_up_to_date_reason FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER listing_not_up_to_date_reason_timestamp BEFORE UPDATE on openchpl.listing_not_up_to_date_reason FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS listing_not_up_to_date_reason_last_modified_user_constraint ON openchpl.listing_not_up_to_date_reason;
CREATE CONSTRAINT TRIGGER listing_not_up_to_date_reason_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.listing_not_up_to_date_reason DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Standard Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Standard Attested');

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Standard Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Required Standard Not Attested');

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Functionality Tested Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Functionality Tested Attested');

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Functionality Tested Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Required Functionality Tested Not Attested');

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Code Set Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Code Set Attested');

INSERT INTO openchpl.listing_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Code Set Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.listing_not_up_to_date_reason WHERE name = 'Required Code Set Not Attested');

-- we think the existing data is invalid so we can actually just get rid of it all... 
TRUNCATE TABLE openchpl.updated_listing_status_report;

-- we don't care about days updated early anymore, and this is really hard to calculate correctly, so drop it
ALTER TABLE openchpl.updated_listing_status_report DROP COLUMN IF EXISTS days_updated_early;

-- add new columns that we are going to calculate to the report
ALTER TABLE openchpl.updated_listing_status_report ADD COLUMN IF NOT EXISTS certification_result_id bigint NOT NULL;
ALTER TABLE openchpl.updated_listing_status_report ADD COLUMN IF NOT EXISTS listing_not_up_to_date_reason_id bigint NOT NULL;
ALTER TABLE openchpl.updated_listing_status_report ADD COLUMN IF NOT EXISTS standard_id bigint;
ALTER TABLE openchpl.updated_listing_status_report ADD COLUMN IF NOT EXISTS functionality_tested_id bigint;
ALTER TABLE openchpl.updated_listing_status_report ADD COLUMN IF NOT EXISTS code_set_id bigint;

-- add new foreign keys for the new columns
ALTER TABLE openchpl.updated_listing_status_report DROP CONSTRAINT IF EXISTS certification_result_fk;
ALTER TABLE openchpl.updated_listing_status_report ADD CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE openchpl.updated_listing_status_report DROP CONSTRAINT IF EXISTS listing_not_up_to_date_reason_fk;
ALTER TABLE openchpl.updated_listing_status_report ADD CONSTRAINT listing_not_up_to_date_reason_fk FOREIGN KEY (listing_not_up_to_date_reason_id)
      REFERENCES openchpl.listing_not_up_to_date_reason (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE openchpl.updated_listing_status_report DROP CONSTRAINT IF EXISTS standard_fk;
ALTER TABLE openchpl.updated_listing_status_report ADD CONSTRAINT standard_fk FOREIGN KEY (standard_id)
      REFERENCES openchpl.standard (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE openchpl.updated_listing_status_report DROP CONSTRAINT IF EXISTS functionality_tested_fk;
ALTER TABLE openchpl.updated_listing_status_report ADD CONSTRAINT functionality_tested_fk FOREIGN KEY (functionality_tested_id)
      REFERENCES openchpl.functionality_tested (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE openchpl.updated_listing_status_report DROP CONSTRAINT IF EXISTS code_set_fk;
ALTER TABLE openchpl.updated_listing_status_report ADD CONSTRAINT code_set_fk FOREIGN KEY (code_set_id)
      REFERENCES openchpl.code_set (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- clear out the criteria status report data, which is also not correct for all the attributes
TRUNCATE openchpl.updated_criteria_status_report;

-- TODO any other changes we need to make to the calculations in this table??
