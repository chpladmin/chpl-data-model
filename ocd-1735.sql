DROP TABLE IF EXISTS openchpl.job_message;
DROP TABLE IF EXISTS openchpl.job;
DROP TABLE IF EXISTS openchpl.job_type;
DROP TABLE IF EXISTS openchpl.job_status;
DROP TYPE IF EXISTS openchpl.job_status_type;

CREATE TYPE openchpl.job_status_type as enum('In Progress', 'Complete', 'Error');

CREATE TABLE openchpl.job_type (
	id bigserial NOT NULL,
	name varchar(500) NOT NULL,
	success_message text NOT NULL, -- what message gets sent to users with jobs of this type that have completed?
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT job_type_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.job_status (
	id bigserial NOT NULL,
	name openchpl.job_status_type NOT NULL, 
	percent_complete int,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT job_status_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.job (
	id bigserial NOT NULL,
	job_type_id bigint NOT NULL,
	contact_id bigint NOT NULL,
	job_status_id bigint,
	start_time timestamp,
	end_time timestamp,
	job_data text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT job_pk PRIMARY KEY (id),
	CONSTRAINT job_type_fk FOREIGN KEY (job_type_id)
      REFERENCES openchpl.job_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT contact_fk FOREIGN KEY (contact_id)
      REFERENCES openchpl.contact (contact_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT status_fk FOREIGN KEY (job_status_id)
      REFERENCES openchpl.job_status (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.job_message (
	id bigserial NOT NULL,
	job_id bigint NOT NULL,
	message text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT job_message_pk PRIMARY KEY (id),
	CONSTRAINT job_fk FOREIGN KEY (job_id)
      REFERENCES openchpl.job (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO openchpl.job_type (name, success_message, last_modified_user)
VALUES ('MUU Upload', 'MUU Upload is complete.', -1);

CREATE TRIGGER job_message_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_message FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_message_timestamp BEFORE UPDATE on openchpl.job_message FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_status_timestamp BEFORE UPDATE on openchpl.job_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_type_timestamp BEFORE UPDATE on openchpl.job_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_timestamp BEFORE UPDATE on openchpl.job FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql