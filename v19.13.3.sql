-- Deployment file for version 19.13.3
--     as of 2021-04-19
-- ./changes/ocd-3647.sql
update openchpl.certified_product
  set deleted = true
  where certified_product_id = 10602;
update openchpl.certified_product
  set deleted = true
  where certified_product_id = 10595;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.13.3', '2021-04-19', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
