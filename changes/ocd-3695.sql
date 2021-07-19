DROP TABLE IF EXISTS openchpl.deprecated_api;
DROP TABLE IF EXISTS openchpl.deprecated_api_usage;

CREATE TABLE openchpl.deprecated_api (
	id bigserial NOT NULL,
	api text NOT NULL,
	request_parameter text,
	change_description text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX deprecated_api_unique_api_and_parameter
ON openchpl.deprecated_api(api, request_parameter)
WHERE deleted = false;

CREATE TRIGGER deprecated_api_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.deprecated_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	deprecated_api_id bigint NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_usage_pk PRIMARY KEY (id),
	CONSTRAINT api_key_id_fk FOREIGN KEY (api_key_id)
      REFERENCES openchpl.api_key (api_key_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_api_id_fk FOREIGN KEY (deprecated_api_id)
      REFERENCES openchpl.deprecated_api (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE UNIQUE INDEX deprecated_api_usage_unique_api_key_and_deprecated_api
ON openchpl.deprecated_api_usage(api_key_id, deprecated_api_id)
WHERE deleted = false;

CREATE TRIGGER deprecated_api_usage_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_usage_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();