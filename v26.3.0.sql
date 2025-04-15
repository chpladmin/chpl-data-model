-- Deployment file for version 26.3.0
--     as of 2025-04-14
-- ./changes/ocd-4839.sql
update openchpl.report_metadata
set url = 'https://app.powerbi.com/view?r=eyJrIjoiNjhmM2U1OWQtYTZmNi00N2M1LWE4MGQtMTc5NjFiMGE5ODgwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
where report_key = 'ServiceBaseUrlListReport'
and environment = 'DEV';

update openchpl.report_metadata
set url = 'https://app.powerbi.com/view?r=eyJrIjoiOTBkMDU5ZjUtYmYzZS00OWUzLThhOTAtZDU5YzQ2YzUzNDE4IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
where report_key = 'ServiceBaseUrlListReport'
and environment = 'QA';

update openchpl.report_metadata
set url = 'https://app.powerbi.com/view?r=eyJrIjoiZjNkMjhhZTItNjk1ZC00YmE3LThmMTEtNGQ5ZDBlMjliMzIzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
where report_key = 'ServiceBaseUrlListReport'
and environment = 'STG';

update openchpl.report_metadata
set url = 'https://app.powerbi.com/view?r=eyJrIjoiYTgzYjczMjktYjY1Yi00OWU3LTg0NDMtNzZlNDQ1NWRjMjcxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
where report_key = 'ServiceBaseUrlListReport'
and environment = 'PROD';

update openchpl.report_metadata
set url = 'https://app.powerbi.com/view?r=eyJrIjoiYzEwOWE0M2QtZjJiMS00Y2IwLWExMWQtNTI1MWJiMWIxMjMxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
where report_key = 'DeveloperAttestations'
and environment = 'PROD';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('26.3.0', '2025-04-14', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
