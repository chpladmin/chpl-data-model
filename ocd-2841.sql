DROP TABLE IF EXISTS openchpl.url_check_result;
DROP TABLE IF EXISTS openchpl.url_type;

-- url type will be used to determine
-- what sort of data the url is associated with in the database (acb website, atl website, developer website, etc).
CREATE TABLE openchpl.url_type (
	id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_type_pk PRIMARY KEY (id)
);
CREATE TRIGGER url_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_type_timestamp BEFORE UPDATE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.url_type (name, last_modified_user)
VALUES ('ONC-ATL', -1),
('ONC-ACB', -1),
('Developer', -1),
('Mandatory Disclosure URL', -1), -- transparency_attestation_url
('Test Results Summary', -1), -- report_file_location
('Full Usability Report', -1), -- sed_report_file_location
('API Documentation', -1); -- api_documentation

CREATE TABLE openchpl.url_check_result (
	id bigserial NOT NULL,
	url_type_id bigint NOT NULL,
	url text NOT NULL,
	response_code int, --allow null in case something times out?
	response_message text, -- if there is some additional text about the response (error message?)
	checked_date timestamp, -- null to indicate we know about the URL in the system but haven't checked it yet
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_check_result_pk PRIMARY KEY (id),
	CONSTRAINT url_type_fk FOREIGN KEY (url_type_id)
		REFERENCES openchpl.url_type (id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER url_check_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_check_result_timestamp BEFORE UPDATE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();