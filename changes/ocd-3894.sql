DROP TABLE IF EXISTS openchpl.change_request_website;
DROP TABLE IF EXISTS openchpl.change_request_developer_details;
DROP TABLE IF EXISTS openchpl.change_request_developer_demographic;

CREATE TABLE IF NOT EXISTS openchpl.change_request_developer_demographics (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	self_developer boolean,
 	website text,
	street_line_1 varchar(250),
	street_line_2 varchar(250),
	city varchar(250),
	state varchar(250),
	zipcode varchar(25),
	country varchar(250),
	full_name varchar(500),
	email varchar(250),
	phone_number varchar(100),
	title varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_developer_demographics_pk PRIMARY KEY (id),
	CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
	    REFERENCES openchpl.change_request (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER change_request_developer_demographics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_developer_demographics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_developer_demographics_timestamp BEFORE UPDATE on openchpl.change_request_developer_demographics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DELETE openchpl.change_request_type
WHERE name = 'Website Change Request';

UPDATE openchpl.change_request_type
SET name = 'Developer Demographics Change Request'
WHERE name = 'Developer Details Change Request';
