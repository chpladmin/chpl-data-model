-- drop tables

DROP TABLE IF EXISTS openchpl.surveillance_nonconformity_document;
DROP TABLE IF EXISTS openchpl.surveillance_nonconformity;
DROP TABLE IF EXISTS openchpl.surveillance_requirement;
DROP TABLE IF EXISTS openchpl.surveillance;
DROP TABLE IF EXISTS openchpl.surveillance_type;
DROP TABLE IF EXISTS openchpl.surveillance_requirement_type;
DROP TABLE IF EXISTS openchpl.surveillance_result;
DROP TABLE IF EXISTS openchpl.nonconformity_status;

-- create tables

CREATE TABLE openchpl.surveillance_type (
	id bigserial not null,
	name varchar(50) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_type_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_type_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance_requirement_type (
	id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_requirement_type_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_requirement_type_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance_result (
	id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_result_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_result_name_key UNIQUE (name)
);

CREATE TABLE openchpl.nonconformity_status (
	id bigserial not null,
	name varchar(50) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT nonconformity_status_pk PRIMARY KEY (id),
	CONSTRAINT nonconformity_status_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance (
	id bigserial not null,
	certified_product_id bigint not null,
	start_date date not null,
	end_date date,
	type_id bigint not null,
	randomized_sites_used integer, -- required if type is Randomized
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id) 
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,	
	CONSTRAINT type_fk FOREIGN KEY (type_id) 
		REFERENCES openchpl.surveillance_type (id) 
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE		
);

CREATE TABLE openchpl.surveillance_requirement (
	id bigserial not null,
	surveillance_id bigint not null,
	type_id bigint not null,
	-- either criteria or requirement text is required
	certification_criterion_id bigint,
	requirement varchar(1024),
	result_id bigint, -- required if parent surveillance has an end date
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_requirement_id PRIMARY KEY (id),
	CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id) 
		REFERENCES openchpl.surveillance (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT type_fk FOREIGN KEY (type_id) 
		REFERENCES openchpl.surveillance_requirement_type (id) 
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id) 
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,		
	CONSTRAINT result_fk FOREIGN KEY (result_id) 
		REFERENCES openchpl.surveillance_result (id) 
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE		
);

CREATE TABLE openchpl.surveillance_nonconformity (
	id bigserial not null,
	surveillance_requirement_id bigint not null,
	-- either criteria or type is required
	certification_criterion_id bigint,
	nonconformtiy_type varchar(1024), 
	nonconformity_status_id bigint not null,
	date_of_determination date not null,
	corrective_action_plan_approval_date date,
	corrective_action_start_date date,
	corrective_action_must_complete_date date,
	corrective_action_end_date date,
	summary varchar(2048) not null, -- required if nonconformity type+certification_criterion is not null
	findings text not null, -- required if nonconformity type+certification_criterion is not null
	sites_passed integer, -- only pertintent to Randomized surveillance
	total_sites integer,
	developer_explanation text,
	resolution text, -- required if status is Closed
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_nonconformity_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_requirement_fk FOREIGN KEY (surveillance_requirement_id) 
		REFERENCES openchpl.surveillance_requirement (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id) 
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT nonconformity_status_fk FOREIGN KEY (nonconformity_status_id) 
		REFERENCES openchpl.nonconformity_status (id) 
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE	
);

CREATE TABLE openchpl.surveillance_nonconformity_document (
	id bigserial not null,
	surveillance_nonconformity_id bigint not null,
	filename varchar(250) NOT NULL,
	filetype varchar(250),
	filedata bytea not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_nonconformity_document_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_nonconformity_fk FOREIGN KEY (surveillance_nonconformity_id) 
		REFERENCES openchpl.surveillance_nonconformity (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

-- permissions
GRANT ALL ON TABLE openchpl.surveillance_type TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance_requirement_type TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance_result TO openchpl;
GRANT ALL ON TABLE openchpl.nonconformity_status TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance_requirement TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance_nonconformity TO openchpl;
GRANT ALL ON TABLE openchpl.surveillance_nonconformity_document TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_type_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_requirement_type_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_result_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.nonconformity_status_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_requirement_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_nonconformity_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.surveillance_nonconformity_document_id_seq TO openchpl;

--audit

CREATE TRIGGER nonconformity_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_status_timestamp BEFORE UPDATE on openchpl.nonconformity_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_timestamp BEFORE UPDATE on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_nonconformity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_nonconformity_timestamp BEFORE UPDATE on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_nonconformity_document_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_nonconformity_document FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_nonconformity_document_timestamp BEFORE UPDATE on openchpl.surveillance_nonconformity_document FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_requirement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_requirement_timestamp BEFORE UPDATE on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_requirement_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_requirement_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_requirement_type_timestamp BEFORE UPDATE on openchpl.surveillance_requirement_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_result_timestamp BEFORE UPDATE on openchpl.surveillance_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_type_timestamp BEFORE UPDATE on openchpl.surveillance_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- preload

INSERT INTO openchpl.surveillance_type (name, last_modified_user)
values ('Reactive', -1),('Randomized', -1);

INSERT INTO openchpl.surveillance_requirement_type (name, last_modified_user)
values ('Certified Capability', -1), ('Transparency or Disclosure Requirement', -1),
('Other Requirement', -1);

INSERT INTO openchpl.surveillance_result (name, last_modified_user)
values ('Non-Conformity', -1), ('No Non-Conformity', -1);

INSERT INTO openchpl.nonconformity_status (name, last_modified_user)
values ('Open', -1), ('Closed', -1);