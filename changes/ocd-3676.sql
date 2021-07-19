DROP TABLE IF EXISTS openchpl.certified_product_upload;
DROP TYPE IF EXISTS openchpl.certified_product_upload_status;
CREATE TYPE openchpl.certified_product_upload_status as enum ('Processing', 'Successful', 'Failed');

-- dropping and re-creating the table instead of just modifying a column
-- because i'm adding a unique index and in dev/qa there could already be duplicate data
-- that will cause adding of the index to fail.
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
	status openchpl.certified_product_upload_status,
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

CREATE UNIQUE INDEX certified_product_upload_unique_chpl_product_number
ON openchpl.certified_product_upload(chpl_product_number)
WHERE deleted = false;

CREATE TRIGGER certified_product_upload_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_upload FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_upload_timestamp BEFORE UPDATE on openchpl.certified_product_upload FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();