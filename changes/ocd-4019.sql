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
ALTER TABLE openchpl.certified_product
DROP COLUMN IF EXISTS pending_certified_product_id bigint;

DROP TABLE IF EXISTS openchpl.pending_certification_result CASCADE;
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
DROP TABLE IF EXISTS openchpl.pending_certifed_product CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_accessibility_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_measure CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_measure_criteria CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_parent_listing CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_qms_standard CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_targeted_user CASCADE;
DROP TABLE IF EXISTS openchpl.pending_certifed_product_testing_lab_map CASCADE;
DROP TABLE IF EXISTS openchpl.pending_cqm_certfication_criteria CASCADE;
DROP TABLE IF EXISTS openchpl.pending_cqm_criterion CASCADE;
DROP TABLE IF EXISTS openchpl.pending_test_participant CASCADE;
DROP TABLE IF EXISTS openchpl.pending_test_task CASCADE;

-- Drop the upload template tables because that endpoint is gone
DROP TABLE IF EXISTS openchpl.upload_template_version CASCADE;