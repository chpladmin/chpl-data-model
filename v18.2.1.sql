-- Deployment file for version 18.2.1
--     as of 2020-02-20
-- ocd-3238.sql
INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Export Documentation', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Export Documentation');

INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Documentation URL', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Documentation URL');

INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Use Cases', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Use Cases');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('18.2.1', '2020-02-20', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
