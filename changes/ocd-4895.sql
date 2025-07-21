insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'DEV', 
        'Updated Criteria Status',
        'UpdatedCriteriaStatus', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNjBlZjk5MGYtMjQ3Ni00ODdhLWE4MjAtNjNlZWViOWNmN2QzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '775px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'UpdatedCriteriaStatus'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'QA', 
        'Updated Criteria Status',
        'UpdatedCriteriaStatus', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiY2ZjYTU2ZDMtY2YzOC00ZWYwLThkM2MtYTUxZTljOTFjYmFhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '775px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'UpdatedCriteriaStatus' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'STG', 
        'Updated Criteria Status',
        'UpdatedCriteriaStatus', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNTUyNTcxZDQtNmRlOS00YmQ3LTk0NDctZTMxOTU3ZDQ5Nzk2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '775px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'UpdatedCriteriaStatus' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'PROD', 
        'Updated Criteria Status',
        'UpdatedCriteriaStatus', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMzdjOGJkOGUtNjM3ZC00YWQxLTg0ZTItZmRiYmM5ZTk3OWFkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '775px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'UpdatedCriteriaStatus' 
);