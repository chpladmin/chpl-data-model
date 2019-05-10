-- Remove the tables in correct order
DROP TABLE IF EXISTS openchpl.filter;
DROP TABLE IF EXISTS openchpl.filter_type;

-- Create the table for filter types
CREATE TABLE openchpl.filter_type (
	filter_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT filter_type_pk PRIMARY KEY (filter_type_id)
);

-- Add audit triggers to filter type table
CREATE TRIGGER filter_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.filter_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER filter_type_timestamp BEFORE UPDATE on openchpl.filter_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Add initial data to filter type table
INSERT INTO openchpl.filter_type
	(name, last_modified_user)
VALUES
	('Developer Report', -1);
	
INSERT INTO openchpl.filter_type
	(name, last_modified_user)
VALUES
	('Listing Report', -1);

-- Create the table for filters
CREATE TABLE openchpl.filter (
	filter_id bigserial not null,
	name text not null,
	user_id bigint not null,
	filter_type_id bigint not null,
	filter json not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT filter_id_pk PRIMARY KEY (filter_id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
        REFERENCES openchpl.user (user_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT filter_type_fk FOREIGN KEY (filter_type_id)
        REFERENCES openchpl.filter_type (filter_type_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Add audit triggers to filter table
CREATE TRIGGER filter_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.filter FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER filter_timestamp BEFORE UPDATE on openchpl.filter FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
