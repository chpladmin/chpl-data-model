UPDATE openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiZTQzYzU0OTQtNTQ0Zi00MGZiLWEyYTEtYzEwNzFjMzIwYTc3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'DEV'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiOTY4MzI1YTUtOTYzOC00YmNhLWFhMjgtMjg2NTU2MWM4MDVlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'QA'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiYmNiNDVmMTQtNTQ1Yy00MTczLWI5MDMtNGJlNzYwOGQyMTZjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'STG'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiNDBiZTllZTAtMzMzYi00ZjFkLTlhZGQtNGEyYzRiZTdjZDgzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'PROD'
AND report_key = 'UpdatedCriteriaStatus';
