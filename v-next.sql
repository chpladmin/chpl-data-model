-- insert missing versions
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('15.1.0', '2019-01-14', -1);
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('15.3.0', '2019-02-11', -1);

\i ocd-2633.sql
\i ocd-2697.sql

\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
