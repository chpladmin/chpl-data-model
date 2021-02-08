-- Deployment file for version 19.11.0
--     as of 2021-02-08
-- ./changes/ocd-3549.sql
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
    );;
-- ./changes/ocd-3582.sql
INSERT INTO openchpl.allowed_measure_criteria (certification_criterion_id, measure_id, last_modified_user) VALUES
	 (165, 72, -1),
	 (165, 76, -1),
	 (165, 70, -1),
	 (165, 75, -1),
	 (165, 74, -1),
	 (165, 69, -1),
	 (166, 84, -1),
	 (166, 82, -1),
	 (166, 79, -1),
	 (166, 80, -1),
	 (167, 32, -1),
	 (167, 1, -1),
	 (167, 31, -1),
	 (167, 2, -1),
	 (167, 3, -1),
	 (178, 38, -1),
	 (178, 52, -1),
	 (178, 39, -1),
	 (178, 50, -1),
	 (178, 41, -1),
	 (178, 53, -1),
	 (178, 43, -1),
	 (178, 57, -1),
	 (178, 55, -1),
	 (181, 57, -1),
	 (181, 38, -1),
	 (181, 39, -1),
	 (181, 41, -1),
	 (181, 43, -1),
	 (181, 51, -1),
	 (181, 52, -1),
	 (181, 53, -1),
	 (181, 55, -1);

;
-- ./changes/ocd-3604.sql
-- load changes to the soft delete triggers before attempting to delete the listing
\i dev/openchpl_soft-delete.sql

-- delete the listing
UPDATE openchpl.certified_product
SET deleted = true
WHERE certified_product_id = 10439;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.11.0', '2021-02-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
