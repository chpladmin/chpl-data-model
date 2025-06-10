-- Deployment file for version 27.2.0
--     as of 2025-06-09
-- ./changes/ocd-4716.sql
UPDATE openchpl.report_metadata
SET height = '1100px'
WHERE title = 'SVAP Usage by SVAP';

UPDATE openchpl.report_metadata
SET height = '1100px'
WHERE title = 'SVAP Usage by Criteria';

;
-- ./changes/ocd-4749.sql
delete from openchpl.report_metadata where report_key = 'ListingAttributes';

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Listing Attributes',
        'ListingAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZDM4ZGYxNWMtYmMzNy00NGQ2LTk5ZDEtZDhkYTU1NWRhNTEyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'ListingAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Listing Attributes',
        'ListingAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNmRiNzc4YTMtYjE1MC00MzVmLTkzNzgtNDNiMjExZTAyOGE2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'ListingAttributes' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Listing Attributes',
        'ListingAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNTk0NTUyZTEtMmNiMy00YjQ2LWI0MmMtNDhlNmYxODk3ZmE1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'ListingAttributes' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Listing Attributes',
        'ListingAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMjRkNzhkNjctNjA0OS00YWZlLTkzNWItMjU5ZTJjM2IyNDg3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'ListingAttributes' 
);;
-- ./changes/ocd-4871.sql
create table if not exists openchpl.attestation_checkin_report (
	id bigserial NOT NULL,
	report_date date not null,
	developer_code text NOT null,
	developer_name text NOT null,
    developer_id bigint NOT null,
    submitted_datetime timestamp,
    published boolean not null default false,
    current_status_name text,
    last_status_change_datetime timestamp,
    relevant_acbs text,
    attestation_period text not null,
    information_blocking_response text,
    information_blocking_noncompliant_response text,
    assurances_response text,
    assurances_noncompliant_response text,
    communications_response text,
    communications_noncompliant_response text,
    rwt_response text,
    rwt_noncompliant_response text,
    api_response text,
    api_noncompliant_response text,
    signature text,
    signature_email text,
    total_surveillances bigint,
    total_surveillance_nonconformities bigint,
    open_surveillance_nonconformities bigint,
    total_direct_review_nonconformities bigint,
    open_direct_review_nonconformities bigint,
    assurances_validation text,
    real_world_testing_validation text,
    api_validation text,
    warnings text,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT attestation_checkin_report_pk PRIMARY KEY (id)
);

CREATE OR replace TRIGGER attestation_checkin_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_checkin_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER attestation_checkin_report_timestamp BEFORE UPDATE on openchpl.attestation_checkin_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS attestation_checkin_report_last_modified_user_constraint ON openchpl.attestation_checkin_report;
CREATE CONSTRAINT TRIGGER attestation_checkin_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.attestation_checkin_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
;
-- ./changes/ocd-4873.sql
CREATE TABLE IF NOT EXISTS
  openchpl.change_request_listing_url_type (
    id bigserial NOT NULL,
    name text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
    CONSTRAINT change_request_listing_url_type_pk PRIMARY KEY (id)
  );

CREATE OR replace TRIGGER change_request_listing_url_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_listing_url_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER change_request_listing_url_type_timestamp BEFORE UPDATE on openchpl.change_request_listing_url_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS change_request_listing_url_type_last_modified_user_constraint ON openchpl.change_request_listing_url_type;
CREATE CONSTRAINT TRIGGER change_request_listing_url_type_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.change_request_listing_url_type DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS
  openchpl.change_request_listing_url (
    id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	change_request_listing_url_type_id bigint NOT NULL,
	listing_id bigint NOT NULL,
	url text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
    CONSTRAINT change_request_listing_url_pk PRIMARY KEY (id),
    CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
        REFERENCES openchpl.change_request (id)
        MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT change_request_listing_url_type_fk FOREIGN KEY (change_request_listing_url_type_id)
        REFERENCES openchpl.change_request_listing_url_type (id)
        MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
  );

CREATE OR replace TRIGGER change_request_listing_url_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_listing_url FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER change_request_listing_url_timestamp BEFORE UPDATE on openchpl.change_request_listing_url FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS change_request_listing_url_last_modified_user_constraint ON openchpl.change_request_listing_url;
CREATE CONSTRAINT TRIGGER change_request_listing_url_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.change_request_listing_url DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

INSERT INTO openchpl.change_request_listing_url_type (name, last_modified_sso_user)
SELECT 'Service Base URL List', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_listing_url_type WHERE name = 'Service Base URL List');

INSERT INTO openchpl.change_request_type (name, last_modified_sso_user)
SELECT 'Listing URL Change Request', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_type WHERE name = 'Listing URL Change Request');

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('27.2.0', '2025-06-09', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
