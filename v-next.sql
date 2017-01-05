-------------------------------------------------------------------------------------
-- Some of the below will affect the details view. 
-- Dropping it now and will add back at the end
-------------------------------------------------------------------------------------

DROP VIEW IF EXISTS openchpl.certified_product_details;

-------------------------------------------------------------------------------------
-- OCD-999 create surveillance tables
-------------------------------------------------------------------------------------

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
	friendly_id varchar(10) NOT NULL, -- is filled in with a trigger
	start_date date not null,
	end_date date,
	type_id bigint not null,
	randomized_sites_used integer, -- required if type is Randomized
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_pk PRIMARY KEY (id),
	CONSTRAINT friendly_id_cp_unique_key UNIQUE (certified_product_id, friendly_id),
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
	nonconformity_type varchar(1024), 
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

-- friendly id trigger/function

CREATE OR REPLACE FUNCTION openchpl.friendly_surveillance_id_func()
RETURNS TRIGGER AS $$
DECLARE
	v_num_survs text;
BEGIN
	SELECT cast (count(*)+1 as text) INTO v_num_survs from openchpl.surveillance where certified_product_id = NEW.certified_product_id;
	NEW.friendly_id = 'SURV' || lpad(v_num_survs, 2, '0');
	RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER surveillance_friendly_id BEFORE INSERT on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.friendly_surveillance_id_func();

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
GRANT ALL ON FUNCTION openchpl.friendly_surveillance_id_func() TO openchpl;

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


-------------------------------------------------------------------------------------
-- OCD-1000 create pending surveillance tables
-------------------------------------------------------------------------------------

-- drop tables

DROP TABLE IF EXISTS openchpl.pending_surveillance_nonconformity;
DROP TABLE IF EXISTS openchpl.pending_surveillance_requirement;
DROP TABLE IF EXISTS openchpl.pending_surveillance;

-- create tables

CREATE TABLE openchpl.pending_surveillance (
	id bigserial not null,
	surveillance_id_to_replace varchar(10),
	certified_product_id bigint, 
	certified_product_unique_id varchar(100),
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
	nonconformity_type varchar(1024), 
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

-- permission
GRANT ALL ON TABLE openchpl.pending_surveillance TO openchpl;
GRANT ALL ON TABLE openchpl.pending_surveillance_requirement TO openchpl;
GRANT ALL ON TABLE openchpl.pending_surveillance_nonconformity TO openchpl;
GRANT ALL ON SEQUENCE openchpl.pending_surveillance_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.pending_surveillance_requirement_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.pending_surveillance_nonconformity_id_seq TO openchpl;

--audit
CREATE TRIGGER pending_surveillance_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_timestamp BEFORE UPDATE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_nonconformity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_nonconformity_timestamp BEFORE UPDATE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_requirement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_requirement_timestamp BEFORE UPDATE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-------------------------------------------------------------------------------------
-- OCD-1001 migrate corrective action plans to surveillance
-------------------------------------------------------------------------------------

-- Clear all receiving tables. Note: cascade on surveillance also impacts surveillance_requirement, surveillance_nonconformity, and surveillance_nonconformity_document
TRUNCATE openchpl.surveillance CASCADE;

-- Build temp staging tables for each destination table
DROP TABLE IF EXISTS surveillance_temp;
CREATE TEMP TABLE surveillance_temp AS
	SELECT C.corrective_action_plan_id AS id, 
	C.certified_product_id, 
	C.surveillance_start AS start_date, 
	C.surveillance_end AS end_date, 
	CASE WHEN CR.num_sites_total IS NOT NULL THEN 2 ELSE 1 END AS type_id, 
	CR.num_sites_total AS randomized_sites_used,
	C.creation_date, 
	C.last_modified_date, 
	C.last_modified_user, 
	C.deleted
	FROM openchpl.corrective_action_plan C
	LEFT JOIN (SELECT DISTINCT corrective_action_plan_id, MAX(num_sites_total) AS num_sites_total 
	FROM openchpl.corrective_action_plan_certification_result GROUP BY corrective_action_plan_id) CR 
	ON C.corrective_action_plan_id = CR.corrective_action_plan_id;

DROP TABLE IF EXISTS surveillance_requirement_temp;
CREATE TEMP TABLE surveillance_requirement_temp AS
	SELECT ROW_NUMBER() OVER() AS surveillance_requirement_id, 
	s.id AS surveillance_id, 
	CASE WHEN CR.certification_criterion_id IS NOT NULL THEN 1 WHEN CR.certification_criterion_id IS NULL THEN 2 ELSE s.type_id END AS type_id,
	CR.certification_criterion_id, 
	CASE WHEN CR.certification_criterion_id IS NULL THEN '170.523(k)(2)' ELSE NULL END AS requirement,
	CASE WHEN s.end_date IS NULL THEN 1 ELSE 2 END AS result_id, 
	CASE WHEN CR.creation_date IS NOT NULL THEN CR.creation_date ELSE now() END AS creation_date, 
	CASE WHEN CR.last_modified_date IS NOT NULL THEN CR.last_modified_date ELSE now() END AS last_modified_date, 
	CASE WHEN CR.last_modified_user IS NOT NULL THEN CR.last_modified_user ELSE -2 END AS last_modified_user, 
	CASE WHEN CR.deleted IS NOT NULL THEN CR.deleted ELSE false END AS deleted
	FROM surveillance_temp s
	LEFT JOIN (SELECT corrective_action_plan_id, certification_criterion_id, creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.corrective_action_plan_certification_result) CR ON CR.corrective_action_plan_id = s.id;

DROP TABLE IF EXISTS surveillance_nonconformity_temp;
CREATE TEMP TABLE surveillance_nonconformity_temp AS
	SELECT 
	ROW_NUMBER() OVER() AS surveillance_nonconformity_id, 
	r.surveillance_requirement_id, 
	cr.certification_criterion_id, 
	CASE WHEN r.type_id = 1 AND CC.number IS NOT NULL THEN CC.number WHEN r.type_id = 2 THEN '170.523 (k)(2)' ELSE '170.523 (k)(2)' END AS nonconformity_type, 
	CASE WHEN c.surveillance_end IS NULL THEN 1 ELSE 2 END AS nonconformity_status_id, 
	c.noncompliance_determination_date AS date_of_determination, 
	c.approval_date AS corrective_action_plan_approval_date, 
	c.surveillance_start AS corrective_action_start_date, 
	c.completion_date_required AS corrective_action_must_complete_date, 
	c.completion_date_actual AS corrective_action_end_date, 
	CASE WHEN cr.summary IS NULL THEN 'Not available' ELSE cr.summary END AS summary, 
	'N/A' AS findings, 
	cr.num_sites_passed AS sites_passed, 
	cr.num_sites_total AS total_sites, 
	cr.developer_explanation, 
	cr.resolution, 
	r.creation_date, 
	r.last_modified_date, 
	r.last_modified_user, 
	r.deleted, 
	r.surveillance_id
	FROM surveillance_requirement_temp r
	LEFT JOIN openchpl.corrective_action_plan_certification_result CR 
	ON cr.corrective_action_plan_id = r.surveillance_id AND (cr.certification_criterion_id IS NOT NULL AND cr.certification_criterion_id = r.certification_criterion_id)
	LEFT JOIN openchpl.corrective_action_plan c ON c.corrective_action_plan_id= r.surveillance_id
	LEFT JOIN openchpl.certification_criterion CC ON cr.certification_criterion_id = CC.certification_criterion_id;

DROP TABLE IF EXISTS surveillance_nonconformity_document_temp;
CREATE TEMP TABLE surveillance_nonconformity_document_temp AS
	SELECT ROW_NUMBER() OVER() AS id, 
	SN.surveillance_nonconformity_id, 
	D.filename, 
	D.filetype, 
	D.filedata, 
	D.creation_date, 
	D.last_modified_date, 
	D.last_modified_user, 
	D.deleted
	FROM openchpl.corrective_action_plan_documentation D
	LEFT JOIN surveillance_nonconformity_temp SN ON D.corrective_action_plan_id = SN.surveillance_id;

-- Disable triggers
ALTER TABLE openchpl.surveillance DISABLE TRIGGER surveillance_audit;
ALTER TABLE openchpl.surveillance DISABLE TRIGGER surveillance_timestamp;
ALTER TABLE openchpl.surveillance_nonconformity DISABLE TRIGGER surveillance_nonconformity_audit;
ALTER TABLE openchpl.surveillance_nonconformity DISABLE TRIGGER surveillance_nonconformity_timestamp;
ALTER TABLE openchpl.surveillance_requirement DISABLE TRIGGER surveillance_requirement_audit;
ALTER TABLE openchpl.surveillance_requirement DISABLE TRIGGER surveillance_requirement_timestamp;
ALTER TABLE openchpl.surveillance_nonconformity_document DISABLE TRIGGER surveillance_nonconformity_document_audit;
ALTER TABLE openchpl.surveillance_nonconformity_document DISABLE TRIGGER surveillance_nonconformity_document_timestamp;

-- Insert from each temp staging table into the destination table
INSERT INTO openchpl.surveillance 
	(id, certified_product_id, start_date, end_date, type_id, randomized_sites_used, 
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT id, certified_product_id, start_date, end_date, type_id, randomized_sites_used, 
	creation_date, last_modified_date, last_modified_user, deleted
	FROM surveillance_temp;

INSERT INTO openchpl.surveillance_requirement
	(id, surveillance_id, type_id, certification_criterion_id, requirement, 
	result_id, creation_date, last_modified_date, last_modified_user, 
	deleted)
	SELECT 
	surveillance_requirement_id, surveillance_id, type_id, certification_criterion_id, 
	requirement, result_id, creation_date, last_modified_date, last_modified_user, 
	deleted
	FROM surveillance_requirement_temp;

INSERT INTO openchpl.surveillance_nonconformity 
	(id, surveillance_requirement_id, certification_criterion_id, 
	nonconformity_type, nonconformity_status_id, date_of_determination, 
	corrective_action_plan_approval_date, corrective_action_start_date, 
	corrective_action_must_complete_date, corrective_action_end_date, 
	summary, findings, sites_passed, total_sites, developer_explanation, 
	resolution, creation_date, last_modified_date, last_modified_user, 
	deleted)
	SELECT
	surveillance_nonconformity_id, surveillance_requirement_id, certification_criterion_id, 
	nonconformity_type, nonconformity_status_id, date_of_determination, 
	corrective_action_plan_approval_date, corrective_action_start_date, 
	corrective_action_must_complete_date, corrective_action_end_date, 
	summary, findings, sites_passed, total_sites, developer_explanation, 
	resolution, creation_date, last_modified_date, last_modified_user,
	deleted
	FROM surveillance_nonconformity_temp;

INSERT INTO openchpl.surveillance_nonconformity_document 
	(id, surveillance_nonconformity_id, filename, filetype, filedata, 
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT
	id, surveillance_nonconformity_id, filename, filetype, filedata, 
	creation_date, last_modified_date, last_modified_user, deleted
	FROM surveillance_nonconformity_document_temp;

-- Enable triggers
ALTER TABLE openchpl.surveillance ENABLE TRIGGER surveillance_audit;
ALTER TABLE openchpl.surveillance ENABLE TRIGGER surveillance_timestamp;
ALTER TABLE openchpl.surveillance_nonconformity ENABLE TRIGGER surveillance_nonconformity_audit;
ALTER TABLE openchpl.surveillance_nonconformity ENABLE TRIGGER surveillance_nonconformity_timestamp;
ALTER TABLE openchpl.surveillance_requirement ENABLE TRIGGER surveillance_requirement_audit;
ALTER TABLE openchpl.surveillance_requirement ENABLE TRIGGER surveillance_requirement_timestamp;
ALTER TABLE openchpl.surveillance_nonconformity_document ENABLE TRIGGER surveillance_nonconformity_document_audit;
ALTER TABLE openchpl.surveillance_nonconformity_document ENABLE TRIGGER surveillance_nonconformity_document_timestamp;

-- Drop temp tables
DROP TABLE IF EXISTS surveillance_temp;
DROP TABLE IF EXISTS surveillance_requirement_temp;
DROP TABLE IF EXISTS surveillance_nonconformity_temp;
DROP TABLE IF EXISTS surveillance_nonconformity_document_temp;

-- Update sequence numbers
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance', 'id'), (SELECT MAX(id) FROM openchpl.surveillance)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_requirement', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_requirement)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_nonconformity', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_nonconformity)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_nonconformity_document', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_nonconformity_document)+1);

-- Add function to allow printing text to screen
CREATE OR REPLACE FUNCTION openchpl.print_notice(msg text) 
  RETURNS INTEGER AS 
$$ 
DECLARE 
BEGIN 
    RAISE NOTICE USING MESSAGE = msg;
    RETURN null;
END; 
$$ 
LANGUAGE 'plpgsql' IMMUTABLE; 

-- Output certified Product ID for any CAP that is defined as "general " so Jennifer can look at them
-- Note: "general" would be whenever a CAP does not have an associated certification_criterion; 
-- in other words, "general" is whenever there is no corrective_action_plan_id in the corrective_action_plan_certification_result table.
SELECT openchpl.print_notice('Please send the following "general" Certified Product IDs to Jennifer for review:');

DROP FUNCTION IF EXISTS openchpl.print_notice(text);

SELECT DISTINCT C.certified_product_id
FROM openchpl.corrective_action_plan C
LEFT JOIN openchpl.corrective_action_plan_certification_result CR ON C.corrective_action_plan_id = CR.corrective_action_plan_id
WHERE C.corrective_action_plan_id IS NOT NULL AND CR.corrective_action_plan_id IS NULL;


-------------------------------------------------------------------------------------
-- OCD-1030 add two new certification statuses
-------------------------------------------------------------------------------------

SELECT certification_status from openchpl.certification_status;

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Suspended by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Suspended by ONC'
        );

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Terminated by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Terminated by ONC'
        );

SELECT certification_status from openchpl.certification_status;

CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS
SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.vendor v
    LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

    GRANT ALL ON TABLE openchpl.developer_certification_statuses TO openchpl;

CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS
SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.product p
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

    GRANT ALL ON TABLE openchpl.product_certification_statuses TO openchpl;


-------------------------------------------------------------------------------------
-- OCD-1087 change 1-1 certification status to 1-many certification status events
-------------------------------------------------------------------------------------

--
-- Certification Status Event table and trigger setup
--
DROP TABLE IF EXISTS openchpl.certification_status_event;
CREATE TABLE openchpl.certification_status_event (
	certification_status_event_id  bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	certification_status_id bigint NOT NULL,
	event_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_status_event_pk PRIMARY KEY (certification_status_event_id),
	CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id) REFERENCES openchpl.certification_status (certification_status_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);
GRANT ALL ON TABLE openchpl.certification_status_event TO openchpl;
GRANT ALL ON SEQUENCE openchpl.certification_status_event_certification_status_event_id_seq TO openchpl;

CREATE TRIGGER certification_status_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_status_event_timestamp BEFORE UPDATE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--
-- Certification Event Migration
--

--insert all the original certification status events to get certified date
INSERT INTO openchpl.certification_status_event 
	(certified_product_id, certification_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certified_product_id, 1, event_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certification_event
	WHERE event_type_id = 1;


-- now look for certified products that aren't Active and insert a certification status event 
-- to track the current certification status. Use cp last modified date for lack of anything more accurate
INSERT INTO openchpl.certification_status_event 
	(certified_product_id, certification_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certified_product_id, certification_status_id, last_modified_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certified_product
	WHERE certification_status_id != 1;


-------------------------------------------------------------------------------------
-- Add meaningful use users column
-------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION openchpl.add_column(schema_name TEXT, table_name TEXT, 
column_name TEXT, data_type TEXT)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
  _tmp text;
BEGIN

  EXECUTE format('SELECT COLUMN_NAME FROM information_schema.columns WHERE 
    table_schema=%L
    AND table_name=%L
    AND column_name=%L', schema_name, table_name, column_name)
  INTO _tmp;

  IF _tmp IS NOT NULL THEN
    RAISE NOTICE 'Column % already exists in %.%', column_name, schema_name, table_name;
    RETURN FALSE;
  END IF;

  EXECUTE format('ALTER TABLE %I.%I ADD COLUMN %I %s;', schema_name, table_name, column_name, data_type);

  RAISE NOTICE 'Column % added to %.%', column_name, schema_name, table_name;

  RETURN TRUE;
END;
$BODY$
LANGUAGE 'plpgsql';

SELECT openchpl.add_column('openchpl', 'certified_product', 'meaningful_use_users', 'BIGINT');

DROP FUNCTION IF EXISTS openchpl.add_column(text, text, text, text);


-------------------------------------------------------------------------------------
-- VIEW CHANGES dependent on all above
-------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW openchpl.certified_product_details AS

SELECT
    a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.testing_lab_id,
    a.certification_body_id,
    a.chpl_product_number,
    a.report_file_location,
    a.sed_report_file_location,
    a.sed_intended_user_description,
    a.sed_testing_end,
    a.acb_certification_id,
    a.practice_type_id,
    a.product_classification_type_id,
    a.other_acb,
	a.creation_date,
    a.deleted,
    a.product_code,
    a.version_code,
    a.ics_code,
    a.additional_software_code,
    a.certified_date_code,
    a.transparency_attestation_url,
    a.ics,
    a.sed,
    a.qms,
    a.accessibility_certified,
    a.product_additional_software,
    a.last_modified_date,
    a.meaningful_use_users,	
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_deleted,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
	v.vendor_status_id,
	v.vendor_status_name,
    t.address_id,
    t.street_line_1,
    t.street_line_2,
    t.city,
    t.state,
    t.zipcode,
    t.country,
    u.contact_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.title,
    i.certification_date,
	decert.decertification_date,
    COALESCE(k.count_certifications, 0) as "count_certifications",
    COALESCE(m.count_cqms, 0) as "count_cqms",
	COALESCE(surv.count_surveillance_activities, 0) as "count_surveillance_activities",
    COALESCE(surv_open.count_open_surveillance_activities, 0) as "count_open_surveillance_activities",
	COALESCE(surv_closed.count_closed_surveillance_activities, 0) as "count_closed_surveillance_activities",
    COALESCE(nc_open.count_open_nonconformities, 0) as "count_open_nonconformities",
	COALESCE(nc_closed.count_closed_nonconformities, 0) as "count_closed_nonconformities",
	r.certification_status_id,
	r.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code

FROM openchpl.certified_product a
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
				cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) r
		ON r.certified_product_id = a.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) n on r.certification_status_id = n.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_classification_type_id, name as "product_classification_name" FROM openchpl.product_classification_type) d on a.product_classification_type_id = d.product_classification_type_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" from openchpl.practice_type) e on a.practice_type_id = e.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
    LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and a.certification_body_id = p.certification_body_id
    LEFT JOIN (SELECT address_id, street_line_1, street_line_2, city, state, zipcode, country from openchpl.address) t on h.vendor_address = t.address_id
    LEFT JOIN (SELECT contact_id, first_name, last_name, email, phone_number, title from openchpl.contact) u on h.vendor_contact = u.contact_id
	LEFT JOIN (SELECT vendor_status_id, name as "vendor_status_name" from openchpl.vendor_status) v on h.vendor_status_id = v.vendor_status_id
	LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) i on a.certified_product_id = i.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on a.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_certifications" FROM (SELECT * FROM openchpl.certification_result WHERE success = true AND deleted <> true) j GROUP BY certified_product_id) k ON a.certified_product_id = k.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_cqms" FROM (SELECT DISTINCT ON (cqm_id, certified_product_id) * FROM openchpl.cqm_result_details WHERE success = true AND deleted <> true) l GROUP BY certified_product_id ORDER BY certified_product_id) m ON a.certified_product_id = m.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" FROM (SELECT * FROM openchpl.surveillance WHERE deleted <> true) n GROUP BY certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND (end_date IS NULL OR end_date >= NOW())) n GROUP BY certified_product_id) surv_open
    ON a.certified_product_id = surv_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND end_date IS NOT NULL 
		 AND end_date <= NOW()) n GROUP BY certified_product_id) surv_closed
    ON a.certified_product_id = surv_closed.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Open') n GROUP BY certified_product_id) nc_open
    ON a.certified_product_id = nc_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Closed') n GROUP BY certified_product_id) nc_closed
    ON a.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) q on a.testing_lab_id = q.testing_lab_id
    ;

GRANT ALL ON TABLE openchpl.certified_product_details TO openchpl;
-------------------------------------------------------------------------------------
-- OCD-1098 Re-retire "Transport Test[ing] Tool"
-------------------------------------------------------------------------------------
UPDATE openchpl.test_tool
SET retired = TRUE
WHERE name IN ('Transport Testing Tool', 'Transport Test Tool');
