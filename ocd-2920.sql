DROP TABLE IF EXISTS openchpl.quarterly_report_surveillance_map CASCADE;
DROP TABLE IF EXISTS openchpl.surveillance_outcome CASCADE;
DROP TABLE IF EXISTS openchpl.surveillance_process_type CASCADE;

-- create lookup tables for various dropdown options for surveillance
CREATE TABLE openchpl.surveillance_outcome (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_outcome_pk PRIMARY KEY (id)
);

CREATE TRIGGER surveillance_outcome_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_outcome_timestamp BEFORE UPDATE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.surveillance_outcome (name, last_modified_user)
VALUES ('No non-conformity', -1), ('Non-conformity substantiated - Resolved through corrective action', -1),
('Non-conformity substantiated - Unresolved - Corrective action ongoing', -1), ('Non-conformity substantiated - Unresolved - Certification suspended', -1),
('Non-conformity substantiated - Unresolved - Certification withdrawn', -1), ('Non-conformity substantiated - Unresolved - Surveillance in process', -1),
('Non-conformity substantiated - Unresolved - Under investigation/review', -1), ('Non-conformity substantiated - Unresolved - Other - [Please describe]', -1);

CREATE TABLE openchpl.surveillance_process_type (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_process_type_pk PRIMARY KEY (id)
);

CREATE TRIGGER surveillance_process_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_process_type_timestamp BEFORE UPDATE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.surveillance_process_type (name, last_modified_user)
VALUES ('In-the-Field', -1), ('Controlled/Test Environment', -1),
('Correspondence with Complainant/Developer', -1), ('Review of Websites/Written Documentation', -1),
('Other - [Please describe]', -1);


CREATE TABLE openchpl.quarterly_report_surveillance_map (
	id bigserial not null,
	quarterly_report_id bigint not null,
	surveillance_id bigint not null,
	k1_reviewed boolean,
	surveillance_outcome_id bigint,
	surveillance_outcome_other text,
	surveillance_process_type_id bigint,
	surveillance_process_type_other text,
	grounds_for_initiating text,
	nonconformity_causes text,
	nonconformity_nature text,
	steps_to_surveil text,
	steps_to_engage text,
	additional_costs_evaluation text,
	limitations_evaluation text,
	nondisclosure_evaluation text,
	direction_developer_resolution text,
	completed_cap_verification text,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT quarterly_report_surveillance_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_outcome_fk FOREIGN KEY (surveillance_outcome_id)
		REFERENCES openchpl.surveillance_outcome (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_process_type_fk FOREIGN KEY (surveillance_process_type_id)
		REFERENCES openchpl.surveillance_process_type (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER quarterly_report_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_surveillance_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
