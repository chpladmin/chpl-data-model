DROP TABLE IF EXISTS openchpl.complaint;
DROP TABLE IF EXISTS openchpl.complaint_type;
DROP TABLE IF EXISTS openchpl.complaint_status_type;

CREATE TABLE openchpl.complaint_type (
	complaint_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_type_pk PRIMARY KEY (complaint_type_id)
);

CREATE TRIGGER complaint_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_type_timestamp BEFORE UPDATE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.complaint_status_type (
	complaint_status_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_status_type_pk PRIMARY KEY (complaint_status_type_id)
);

CREATE TRIGGER complaint_status_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_status_type_timestamp BEFORE UPDATE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.complaint (
	complaint_id bigserial not null,
    certification_body_id bigint not null,
    complaint_type_id bigint not null,
    complaint_status_type_id bigint not null,
    onc_complaint_id text,
    acb_complaint_id text,
    received_date date not null,
    summary text not null,
    actions text,
    complainant_contacted boolean not null DEFAULT false,
    developer_contacted boolean not null DEFAULT false,
    onc_atl_contacted boolean not null DEFAULT false,
    flag_for_onc_review boolean not null DEFAULT false,
    closed_date date,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_pk PRIMARY KEY (complaint_id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT complaint_type_fk FOREIGN KEY (complaint_type_id)
		REFERENCES openchpl.complaint_type (complaint_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT complaint_status_type_fk FOREIGN KEY (complaint_status_type_id)
		REFERENCES openchpl.complaint_status_type (complaint_status_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_timestamp BEFORE UPDATE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Developer', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Developer');
     
INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Provider', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Provider');
     
INSERT INTO openchpl.complaint_status_type (name, last_modified_user)
SELECT 'Open', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_status_type
	 WHERE name = 'Open');
     
INSERT INTO openchpl.complaint_status_type (name, last_modified_user)
SELECT 'Closed', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_status_type
	 WHERE name = 'Closed');
