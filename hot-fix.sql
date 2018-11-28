-- OCD-2575

DROP TABLE IF EXISTS openchpl.file_type;

CREATE TABLE openchpl.file_type
(
    file_type_id bigserial NOT NULL,
    name text NOT NULL,
    description text,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT file_type_pk PRIMARY KEY (file_type_id)
);

CREATE TRIGGER file_type AFTER INSERT OR UPDATE OR DELETE on openchpl.file_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER file_type BEFORE UPDATE on openchpl.file_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Add the intial file_type value for API Documentation
INSERT INTO openchpl.file_type
(name, description, last_modified_user)
VALUES
('Api Documentation', 'Api Documentation', -1);


DROP TABLE IF EXISTS openchpl.files;

CREATE TABLE openchpl.files
(
    file_id bigserial NOT NULL,
	file_type_id bigint NOT NULL,
	file_name text,
	content_type text,
    file_data bytea NOT NULL,
    associated_date timestamp without time zone NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT file_pk PRIMARY KEY (file_id),
	CONSTRAINT file_type_fk FOREIGN KEY (file_type_id)
        REFERENCES openchpl.file_type (file_type_id) MATCH FULL
        ON UPDATE CASCADE
);

CREATE TRIGGER files AFTER INSERT OR UPDATE OR DELETE on openchpl.files FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER files BEFORE UPDATE on openchpl.files FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql
