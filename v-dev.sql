-- OCD - 2351 - nonconformity chart statistics

DROP TABLE IF EXISTS openchpl.nonconformity_type_statistics;
CREATE TABLE openchpl.nonconformity_type_statistics
(
  	id bigserial NOT NULL,
  	nonconformity_type varchar(1024),
	nonconformity_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  	CONSTRAINT nonconformity_type_statistics_pk PRIMARY KEY (id)
);
CREATE TRIGGER nonconformity_type_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_type_statistics_timestamp BEFORE UPDATE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
