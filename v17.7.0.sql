-- Deployment file for version 17.7.0
--     as of 2019-07-22
-- ocd-2912.sql

ALTER TABLE IF EXISTS openchpl.complaint DROP CONSTRAINT IF EXISTS complaint_type_fk;
ALTER TABLE IF EXISTS openchpl.complaint DROP CONSTRAINT IF EXISTS complainant_type_fk;
DROP TABLE IF EXISTS openchpl.complaint_type;
DROP TABLE IF EXISTS openchpl.complainant_type;

CREATE TABLE openchpl.complainant_type (
	complainant_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complainant_type_pk PRIMARY KEY (complainant_type_id)
);

DO $$
BEGIN
    IF EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name = 'complaint' AND column_name = 'complaint_type_id')
    THEN
        ALTER TABLE openchpl.complaint RENAME COLUMN complaint_type_id TO complainant_type_id;
    END IF;
    IF NOT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name = 'complaint' AND column_name = 'complainant_type_other')
    THEN 
        ALTER TABLE openchpl.complaint ADD COLUMN complainant_type_other text;
    END IF;
END $$;


INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Developer', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Developer');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Provider', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Provider');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Third  Party Organization', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Third  Party Organization');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Government Entity', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Government Entity');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Patient', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Patient');
 
INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Anonymous', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Anonymous');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Other - [Please Describe]', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Other - [Please Describe]');


ALTER TABLE openchpl.complaint 
ADD CONSTRAINT complainant_type_fk FOREIGN KEY (complainant_type_id)
		REFERENCES openchpl.complainant_type (complainant_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT;

;
-- ocd-2913.sql
DROP TABLE IF EXISTS openchpl.complaint_listing_map;

CREATE TABLE openchpl.complaint_listing_map (
    complaint_listing_map_id bigserial not null,
    complaint_id bigint not null,
    listing_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_listing_map_pk PRIMARY KEY (complaint_listing_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_listing_map_timestamp BEFORE UPDATE on openchpl.complaint_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ocd-2915.sql
DROP TABLE IF EXISTS openchpl.complaint_surveillance_map;

CREATE TABLE openchpl.complaint_surveillance_map (
    complaint_surveillance_map_id bigserial not null,
    complaint_id bigint not null,
    surveillance_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_surveillance_map_pk PRIMARY KEY (complaint_surveillance_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_surveillance_map_timestamp BEFORE UPDATE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ocd-2914.sql
DROP TABLE IF EXISTS openchpl.complaint_criterion_map;

CREATE TABLE openchpl.complaint_criterion_map (
    complaint_criterion_map_id bigserial not null,
    complaint_id bigint not null,
    certification_criterion_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_criterion_map_pk PRIMARY KEY (complaint_criterion_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_criterion_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_criterion_map_timestamp BEFORE UPDATE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ocd-2917.sql
-- Remove all previously entered quarterly reports; they're not valid with the new format
DELETE FROM openchpl.quarterly_report_excluded_listing_map;
DELETE FROM openchpl.quarterly_report;

ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS annual_report_id;
ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS certification_body_id;
ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS year;

ALTER TABLE openchpl.quarterly_report ADD COLUMN certification_body_id bigint NOT NULL;
ALTER TABLE openchpl.quarterly_report ADD CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT;
ALTER TABLE openchpl.quarterly_report ADD COLUMN year integer NOT NULL;
;
-- ocd-2918.sql
INSERT INTO openchpl.job_type (name, description, success_message, last_modified_user)
SELECT 'Export Quarterly Report', 'Creating an excel file based on quarterly report data.', 'Quarterly Report generation is complete', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.job_type
	 WHERE name = 'Export Quarterly Report');

INSERT INTO openchpl.job_type (name, description, success_message, last_modified_user)
SELECT 'Export Annual Report', 'Creating an excel file based on annual report data.', 'Annual Report generation is complete.', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.job_type
	 WHERE name = 'Export Annual Report');;
-- ocd-2919.sql
DROP TABLE IF EXISTS openchpl.quarterly_report_excluded_listing_map;

CREATE TABLE openchpl.quarterly_report_excluded_listing_map (
    id bigserial not null,
    quarterly_report_id bigint not null,
    listing_id bigint not null,
	reason text not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT quarterly_report_excluded_listing_map_pk PRIMARY KEY (id),
    CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER quarterly_report_excluded_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_excluded_listing_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();;
-- ocd-2754.sql
INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Announcement Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'Announcement Report');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.7.0', '2019-07-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
