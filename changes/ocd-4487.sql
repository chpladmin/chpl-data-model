CREATE TABLE IF NOT EXISTS openchpl.complaint_type (
	id bigserial NOT NULL,
	name text NOT NULL,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	CONSTRAINT complaint_type_pk PRIMARY KEY (id)
);
	
CREATE OR replace TRIGGER complaint_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER complaint_type_timestamp BEFORE UPDATE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS complaint_type_last_modified_user_constraint ON openchpl.complaint_type;
CREATE CONSTRAINT TRIGGER complaint_type_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.complaint_type DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Criteria', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.complaint_type
    WHERE name = 'Criteria'
);

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Condition', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.complaint_type
    WHERE name = 'Condition'
);

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Other', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.complaint_type
    WHERE name = 'Other'
);

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Not Related to Certification Program Requirements', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.complaint_type
    WHERE name = 'Not Related to Certification Program Requirements'
);

CREATE TABLE IF NOT EXISTS openchpl.complaint_to_complaint_type_map (
	id bigserial NOT NULL,
	complaint_id bigint NOT NULL,
	complaint_type_id bigint NOT NULL,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	CONSTRAINT complaint_to_complaint_type_map_pk PRIMARY KEY (id)
);

CREATE OR replace TRIGGER complaint_to_complaint_type_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_to_complaint_type_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER complaint_to_complaint_type_map_timestamp BEFORE UPDATE on openchpl.complaint_to_complaint_type_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS complaint_to_complaint_type_map_last_modified_user_constraint ON openchpl.complaint_to_complaint_type_map;
CREATE CONSTRAINT TRIGGER complaint_to_complaint_type_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.complaint_to_complaint_type_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

ALTER TABLE openchpl.complaint ADD COLUMN IF NOT EXISTS complaint_type_other text;