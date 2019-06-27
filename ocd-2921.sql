-- create lookup tables for various dropdown options for surveillance

DROP TABLE IF EXISTS openchpl.surveillance_outcome;

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

DROP TABLE IF EXISTS openchpl.surveillance_process_type;

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