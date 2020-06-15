-- Deployment file for version 19.3.2
--     as of 2020-06-15
-- ocd-3293.sql
ALTER TABLE openchpl.pending_certification_result_additional_software ALTER COLUMN grouping TYPE text;
;
-- ocd-3117.sql
INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Complaints', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.filter_type
    WHERE name = 'Complaints' );
;
-- ocd-3360.sql
update openchpl.questionable_activity_trigger set deleted = true where id = 31;
update openchpl.questionable_activity_trigger set deleted = true where id = 33;
update openchpl.questionable_activity_trigger set deleted = true where id = 34;
update openchpl.questionable_activity_trigger set deleted = true where id = 35;
update openchpl.questionable_activity_trigger set deleted = true where id = 36;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.3.2', '2020-06-15', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
