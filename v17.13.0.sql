-- Deployment file for version 17.13.0
--     as of 2019-10-21
-- ocd-2178.sql
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT '2014 Listing Edited', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = '2014 Listing Edited' );
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.13.0', '2019-10-21', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
