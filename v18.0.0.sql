-- Deployment file for version 18.0.0
--     as of 2020-01-02
-- ocd-3116.sql
alter table openchpl.complaint
drop column if exists complaint_status_type_id;

drop table if exists openchpl.complaint_status_type cascade;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('18.0.0', '2020-01-02', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
