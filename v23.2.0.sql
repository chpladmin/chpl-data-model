-- Deployment file for version 23.2.0
--     as of 2023-02-21
-- ./changes/ocd-4107.sql
-- Delete all data. Choosing DELETE over TRUNCATE so we don't start over with the ID sequence
DELETE FROM openchpl.inheritance_errors_report;

-- remove audit columns and trigger for last_modified_date
DROP TRIGGER IF EXISTS inheritance_errors_report_timestamp ON openchpl.inheritance_errors_report;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS last_modified_date;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS last_modified_user;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS deleted;

-- dropping "derived" columns
ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS url;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS chpl_product_number;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS developer;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS product;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS version;

-- add new certified_product_id column
ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS certified_product_id;

ALTER TABLE openchpl.inheritance_errors_report
ADD COLUMN certified_product_id bigint NOT NULL; 

ALTER TABLE openchpl.inheritance_errors_report 
ADD CONSTRAINT certified_product_fk 
	FOREIGN KEY (certified_product_id) 
	REFERENCES openchpl.certified_product (certified_product_id) 
	MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;
;
-- ./changes/ocd-4118.sql
CREATE INDEX IF NOT EXISTS test_task_id_idx ON openchpl.test_task_participant_map (test_task_id);
CREATE INDEX IF NOT EXISTS test_task_participant_id_idx ON openchpl.test_task_participant_map (test_participant_id);
CREATE INDEX IF NOT EXISTS test_task_participant_id_and_deleted_idx ON openchpl.test_task_participant_map (test_participant_id, deleted);

DROP TRIGGER IF EXISTS test_task_participant_map_soft_delete on openchpl.test_task_participant_map;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.2.0', '2023-02-21', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
