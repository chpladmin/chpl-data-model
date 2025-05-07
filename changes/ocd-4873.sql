CREATE TABLE IF NOT EXISTS
  openchpl.change_request_listing_url_type (
    id bigserial NOT NULL,
    name text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
    CONSTRAINT change_request_listing_url_type_pk PRIMARY KEY (id)
  );

CREATE OR replace TRIGGER change_request_listing_url_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_listing_url_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER change_request_listing_url_type_timestamp BEFORE UPDATE on openchpl.change_request_listing_url_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS change_request_listing_url_type_last_modified_user_constraint ON openchpl.change_request_listing_url_type;
CREATE CONSTRAINT TRIGGER change_request_listing_url_type_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.change_request_listing_url_type DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS
  openchpl.change_request_listing_url (
    id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	change_request_listing_url_type_id bigint NOT NULL,
	listing_id bigint NOT NULL,
	url text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
    CONSTRAINT change_request_listing_url_pk PRIMARY KEY (id),
    CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
        REFERENCES openchpl.change_request (id)
        MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT change_request_listing_url_type_fk FOREIGN KEY (change_request_listing_url_type_id)
        REFERENCES openchpl.change_request_listing_url_type (id)
        MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
  );

CREATE OR replace TRIGGER change_request_listing_url_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_listing_url FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER change_request_listing_url_timestamp BEFORE UPDATE on openchpl.change_request_listing_url FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS change_request_listing_url_last_modified_user_constraint ON openchpl.change_request_listing_url;
CREATE CONSTRAINT TRIGGER change_request_listing_url_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.change_request_listing_url DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

INSERT INTO openchpl.change_request_listing_url_type (name, last_modified_sso_user)
SELECT 'Service Base URL List', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_listing_url_type WHERE name = 'Service Base URL List');

--This is needed because we updated the name of the CR Type after it was created
--It should have no effect in envs after DEV
UPDATE openchpl.change_request_type
SET name = 'Listing URL Change Request'
WHERE name = 'Listing Service Base URL List Change Request';

INSERT INTO openchpl.change_request_type (name, last_modified_sso_user)
SELECT 'Listing URL Change Request', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_type WHERE name = 'Listing URL Change Request');

