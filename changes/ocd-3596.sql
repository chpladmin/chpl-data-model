DROP TABLE IF EXISTS openchpl.api_key_request;

CREATE TABLE openchpl.api_key_request (
  id                 bigserial NOT NULL,
  name_organization  text NOT NULL,
  email              text NOT NULL,
  api_request_token  text NOT NULL,
  creation_date      timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted            bool NOT NULL DEFAULT false,
  CONSTRAINT api_key_request_id_pk PRIMARY KEY (id)
);

CREATE TRIGGER api_key_request_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.api_key_request FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER api_key_request_timestamp BEFORE UPDATE on openchpl.api_key_request FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
