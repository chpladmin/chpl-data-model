DROP TABLE IF EXISTS openchpl.change_request_website;
DROP TABLE IF EXISTS openchpl.change_request_status;
DROP TABLE IF EXISTS openchpl.change_request;

CREATE TABLE openchpl.change_request (
    id bigserial NOT NULL,
    change_request_type_id bigint NOT NULL,
    developer_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_pk PRIMARY KEY (id),
    CONSTRAINT change_request_type_fk FOREIGN KEY (change_request_type_id)
	    REFERENCES openchpl.change_request_type (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT developer_fk FOREIGN KEY (developer_id)
        REFERENCES openchpl.vendor (vendor_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER change_request_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_timestamp BEFORE UPDATE on openchpl.change_request FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.change_request_status (
    id bigserial NOT NULL,
    change_request_id bigint NOT NULL,
    change_request_status_type_id bigint NOT NULL,
    status_change_date timestamp NOT NULL,
    comment text,
    user_permission_id bigint NOT NULL,
    certification_body_id bigint,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_status_pk PRIMARY KEY (id),
    CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
	    REFERENCES openchpl.change_request (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT change_request_status_type_fk FOREIGN KEY (change_request_status_type_id)
	    REFERENCES openchpl.change_request_status_type (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
	    REFERENCES openchpl.user_permission (user_permission_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
	    REFERENCES openchpl.certification_body (certification_body_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER change_request_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_status_timestamp BEFORE UPDATE on openchpl.change_request_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.change_request_website (
    id bigserial NOT NULL,
    change_request_id bigint NOT NULL,
    website text,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_website_pk PRIMARY KEY (id),
    CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
	    REFERENCES openchpl.change_request (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER change_request_website_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_website FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_website_timestamp BEFORE UPDATE on openchpl.change_request_website FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
