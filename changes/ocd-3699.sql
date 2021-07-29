DROP TABLE openchpl.change_request_attestation;

CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation (
  id bigserial NOT NULL,
  change_request_id bigint NOT NULL,
  attestation text not null,
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL DEFAULT false,
  CONSTRAINT change_request_attestation_pk primary key (id),
  CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
    REFERENCES openchpl.change_request (id)
    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER change_request_attestation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_attestation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_attestation_timestamp BEFORE UPDATE on openchpl.change_request_attestation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.change_request_type (name, last_modified_user)
SELECT 'Developer Attestation Change Request', -1
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_type WHERE name = 'Developer Attestation Change Request');

DELETE FROM openchpl.change_request_status
WHERE change_request_id IN 
	(SELECT id 
	FROM openchpl.change_request
	WHERE change_request_type_id = (
		SELECT id
		FROM openchpl.change_request_type
		WHERE name = 'Developer Attestation Change Request'));

DELETE FROM openchpl.change_request
WHERE change_request_type_id = 
	(SELECT id 
	FROM openchpl.change_request_type
	WHERE name = 'Developer Attestation Change Request');


