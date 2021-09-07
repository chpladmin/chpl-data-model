-- Deployment file for version 20.7.0
--     as of 2021-09-07
-- ./changes/ocd-3704.sql
alter table openchpl.quarterly_report rename reactive_summary to reactive_surveillance_summary;
alter table openchpl.quarterly_report rename transparency_disclosure_summary to disclosure_requirements_summary;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.7.0', '2021-09-07', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
