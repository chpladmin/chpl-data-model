-- Deployment file for version 19.7.1
--     as of 2020-11-16
-- ocd-3523.sql
UPDATE openchpl.contact c
SET friendly_name = null
FROM openchpl.vendor
WHERE vendor.contact_id = c.contact_id;

UPDATE openchpl.contact c
SET friendly_name = null
FROM openchpl.product
WHERE product.contact_id = c.contact_id;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.7.1', '2020-11-16', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
