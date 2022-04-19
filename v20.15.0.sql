-- Deployment file for version 20.15.0
--     as of 2022-04-13
-- ./changes/ocd-3901.sql
DROP TABLE IF EXISTS openchpl.certified_product_chpl_product_number_history CASCADE;

CREATE TABLE openchpl.certified_product_chpl_product_number_history (
	id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	chpl_product_number text NOT NULL,
	end_date timestamp NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_chpl_product_number_history_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TRIGGER certified_product_chpl_product_number_history_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_chpl_product_number_history FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_chpl_product_number_history_timestamp BEFORE UPDATE on openchpl.certified_product_chpl_product_number_history FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.15.0', '2022-04-13', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
