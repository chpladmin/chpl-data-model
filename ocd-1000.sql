-- drop tables

DROP TABLE IF EXISTS openchpl.pending_surveillance_nonconformity;
DROP TABLE IF EXISTS openchpl.pending_surveillance_requirement;
DROP TABLE IF EXISTS openchpl.pending_surveillance;

-- create tables

CREATE TABLE openchpl.pending_surveillance (
	id bigserial not null,
	certified_product_unique_id varchar(30),
	start_date date,
	end_date date,
	type_value varchar(30),
	randomized_sites_used integer, 
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_pk PRIMARY KEY (id)	
);

CREATE TABLE openchpl.pending_surveillance_requirement (
	id bigserial not null,
	pending_surveillance_id bigint not null,
	type_value varchar(50),
	requirement varchar(1024),
	result_value varchar(30),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_requirement_id PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_fk FOREIGN KEY (pending_surveillance_id) 
		REFERENCES openchpl.pending_surveillance (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE openchpl.pending_surveillance_nonconformity (
	id bigserial not null,
	pending_surveillance_requirement_id bigint not null,
	nonconformtiy_type varchar(1024), 
	nonconformity_status varchar(15),
	date_of_determination date,
	corrective_action_plan_approval_date date,
	corrective_action_start_date date,
	corrective_action_must_complete_date date,
	corrective_action_end_date date,
	summary varchar(2048), 
	findings text, 
	sites_passed integer, 
	total_sites integer,
	developer_explanation text,
	resolution text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_nonconformity_pk PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_requirement_fk FOREIGN KEY (pending_surveillance_requirement_id) 
		REFERENCES openchpl.pending_surveillance_requirement (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

--audit

CREATE TRIGGER pending_surveillance_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_timestamp BEFORE UPDATE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_nonconformity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_nonconformity_timestamp BEFORE UPDATE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_requirement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_requirement_timestamp BEFORE UPDATE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();