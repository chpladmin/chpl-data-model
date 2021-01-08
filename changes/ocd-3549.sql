DROP TABLE IF EXISTS openchpl.certified_product_upload;

CREATE TABLE openchpl.certified_product_upload (
	id bigserial NOT NULL,
	chpl_product_number text NOT NULL,
	certification_body_id bigint NOT NULL,
	vendor_name text,
	product_name text,
	version_name text,
	certification_date date,
	error_count integer,
	warning_count integer,
	contents text NOT NULL,
	certified_product_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_upload_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certified_product_id_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION	  
);
CREATE TRIGGER certified_product_upload_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_upload FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_upload_timestamp BEFORE UPDATE on openchpl.certified_product_upload FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.activity_concept (concept, last_modified_user)
SELECT 'LISTING_UPLOAD', -1
WHERE
    NOT EXISTS (
        SELECT concept FROM openchpl.activity_concept WHERE concept = 'LISTING_UPLOAD'
    );