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
);

CREATE TRIGGER deprecated_api_usage_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api_usage FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_usage_timestamp BEFORE UPDATE ON openchpl.deprecated_api_usage FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Do we still need access to the pending listing ACTIVITY? I don't think we have ever called it.. but I need to keep certain objects around if we want it.

-- Do we want to drop all the old pending* tables? Any reason to keep them around for audit purposes?

-- Can I drop the upload template tables?
	-- We never deprecated /data/upload_template_versions... can I please delete it anyway?
	-- Add a note somewhere to delete upload template cache from ehcache.xml files