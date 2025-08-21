--
-- Remove Test Results Summary url type, and all past url checks of this type.
-- It only applies to 2014 listings and we should not worry about it anymore.
--
UPDATE openchpl.url_type
SET deleted = TRUE,
last_modified_user = null,
last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE name = 'Test Results Summary';

UPDATE openchpl.url_check_result
SET deleted = true,
last_modified_user = null,
last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE url_type_id = (SELECT id FROM openchpl.url_type WHERE name = 'Test Results Summary');

--
-- Add the new report to the Dashboard
--

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'DEV', 
        'Questionable URLs',
        'QuestionableUrls', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOWVhMjg5YTctYTM5Ny00YTVhLThiZGMtNDlkZDhiNzU5MDdjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '475px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'QuestionableUrls'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'QA', 
        'Questionable URLs',
        'QuestionableUrls', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNjUwN2YwOGItOWY2YS00ZjU3LTllMDgtMTZmOWI0Yzk2ODI5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '475px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'QuestionableUrls' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'STG', 
        'Questionable URLs',
        'QuestionableUrls', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYjA3MTVkNGEtMTE3My00ODY4LTk2MzItNTU5YjViNDczZmNjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '475px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'QuestionableUrls' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'PROD', 
        'Questionable URLs',
        'QuestionableUrls', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNWI2ZWRiZmEtNzVjYi00YTMzLWFkNjUtNjViNTk2ODI5MDc0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '475px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'QuestionableUrls' 
);
