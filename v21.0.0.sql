-- Deployment file for version 21.0.0
--     as of 2022-09-06
-- ./changes/ocd-3940.sql
create table if not exists openchpl.change_request_certification_body_map (
    id bigserial not null,
    change_request_id bigint not null,
    certification_body_id bigint not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint change_request_certification_body_map_pk primary key (id),
	constraint change_request_fk foreign key (change_request_id)
	    references openchpl.change_request (id)
        match simple on update no action on delete restrict,
    constraint certification_body_fk foreign key (certification_body_id)
	    references openchpl.certification_body (certification_body_id)
        match simple on update no action on delete restrict
);
drop trigger if exists change_request_certification_body_map_audit on openchpl.change_request_certification_body_map;
create trigger change_request_certification_body_map_audit after insert or update or delete on openchpl.change_request_certification_body_map for each row execute procedure audit.if_modified_func();
drop trigger if exists change_request_certification_body_map_timestamp on openchpl.change_request_certification_body_map;
create trigger change_request_certification_body_map_timestamp before update on openchpl.change_request_certification_body_map for each row execute procedure openchpl.update_last_modified_date_column();

insert into openchpl.change_request_certification_body_map (change_request_id, certification_body_id, last_modified_user)
select cr.id, dcbm.certification_body_id, cr.last_modified_user
from openchpl.change_request cr
	inner join openchpl.vendor v 
		on cr.developer_id = v.vendor_id 
	inner join openchpl.developer_certification_body_map dcbm 
		on v.vendor_id = dcbm.vendor_id
where not exists (
	select *
	from openchpl.change_request_certification_body_map crcbm
	where crcbm.change_request_id = cr.id
	and crcbm.certification_body_id = dcbm.certification_body_id 
);
;
-- ./changes/ocd-4019.sql
-- Drop old deprecated api, response field, and usage tables
DROP FUNCTION IF EXISTS openchpl.deprecated_response_field_api_soft_delete() CASCADE;
DROP FUNCTION IF EXISTS openchpl.deprecated_api_soft_delete() CASCADE;

DROP TABLE IF EXISTS openchpl.deprecated_api_usage;
DROP TABLE IF EXISTS openchpl.deprecated_api;
DROP TABLE IF EXISTS openchpl.deprecated_response_field_api_usage;
DROP TABLE IF EXISTS openchpl.deprecated_response_field;
DROP TABLE IF EXISTS openchpl.deprecated_response_field_api;

-- Create new deprecated usage table
CREATE TABLE openchpl.deprecated_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	http_method varchar(10) NOT NULL,
	api_operation text NOT NULL,
	response_field text,
	removal_date date NOT NULL,
	message text NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
	notification_sent timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_usage_pk PRIMARY KEY (id),
	CONSTRAINT api_key_id_fk FOREIGN KEY (api_key_id)
      REFERENCES openchpl.api_key (api_key_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_api_usage_api_key_and_endpoint_idx UNIQUE (api_key_id, http_method, api_operation, response_field, notification_sent)
	-- add index on notifications sent
);

CREATE TRIGGER deprecated_api_usage_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api_usage FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_usage_timestamp BEFORE UPDATE ON openchpl.deprecated_api_usage FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Drop all pending tables because those endpoints are gone
DROP VIEW IF EXISTS openchpl.certified_product_summary;
ALTER TABLE openchpl.certified_product
DROP COLUMN IF EXISTS pending_certified_product_id;

DROP TABLE IF EXISTS openchpl.pending_certification_result_additional_software CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_conformance_method CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_optional_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_data CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_functionality CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_procedure CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_task CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_task_participant CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_test_tool CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result_ucd_process CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certification_result CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_accessibility_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_measure CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_measure_criteria CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_parent_listing CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_qms_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_targeted_user CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product_testing_lab_map CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certified_product CASCADE;
DROP TABLE IF EXISTS openchpl.pending_cqm_criterion CASCADE;
DROP TABLE IF EXISTS openchpl.pending_cqm_certification_criteria CASCADE;
DROP TABLE IF EXISTS openchpl.pending_test_participant CASCADE;
DROP TABLE IF EXISTS openchpl.pending_test_task CASCADE;

-- Drop the upload template tables because that endpoint is gone
DROP TABLE IF EXISTS openchpl.upload_template_version CASCADE;;
-- ./changes/ocd-4021.sql
alter table openchpl.form add column if not exists instructions text;

update openchpl.form
set instructions = 'If "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'
where description = 'Attestation Period 2022-04-01 to 2022-09-30';

update openchpl.question
set question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. **(optional - check all that apply)**'
where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)';
;
-- ./changes/ocd-4025.sql
DELETE FROM openchpl.attestation_period WHERE description = 'Second Period';
DELETE FROM openchpl.attestation_period WHERE description = 'Third Period';

INSERT INTO openchpl.attestation_period
(description, period_start, period_end, submission_start, submission_end, form_id, last_modified_user)
VALUES
('Second Period', '2022-04-01', '2022-09-30', '2022-10-01', '2022-10-31', 2, -1),
('Third Period',  '2022-10-01', '2023-03-31', '2023-04-01', '2023-04-30', null, -1);
;
-- ./changes/ocd-4035.sql
-- not needed?
--update openchpl.certification_criterion_attribute
--set svap = true where criterion_id = 170;

update openchpl.certification_criterion_attribute
set svap = true where criterion_id = 59;

update openchpl.certification_criterion_attribute
set svap = true where criterion_id = 60;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('21.0.0', '2022-09-06', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
