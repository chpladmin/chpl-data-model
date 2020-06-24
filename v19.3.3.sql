-- Deployment file for version 19.3.3
--     as of 2020-06-24
-- ocd-3380.sql
ALTER TABLE openchpl.certification_result_g1_macra DROP CONSTRAINT IF EXISTS macra_id_certification_result_id_unique CASCADE;
ALTER TABLE openchpl.certification_result_g2_macra DROP CONSTRAINT IF EXISTS macra_id_certification_result_id_unique CASCADE;
ALTER TABLE openchpl.pending_certification_result_g1_macra DROP CONSTRAINT IF EXISTS macra_id_certification_result_id_unique CASCADE;
ALTER TABLE openchpl.pending_certification_result_g2_macra DROP CONSTRAINT IF EXISTS macra_id_certification_result_id_unique CASCADE;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.3.3', '2020-06-24', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
