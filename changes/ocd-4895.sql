insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_sso_user)
select 'DEV', 
        'Updated Criteria Status',
        'UpdatedCriteriaStatus', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNjBlZjk5MGYtMjQ3Ni00ODdhLWE4MjAtNjNlZWViOWNmN2QzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
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
        'https://app.powerbi.com/view?r=eyJrIjoiMTA5MDM3YjUtMjI1NS00MjllLWIwOGItYTQ5MTljNjRkYmY1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
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
        'https://app.powerbi.com/view?r=eyJrIjoiNjk3MmFiZjYtZDA2Ni00MTVmLTg1MDMtMzUxYjk2YjcxZGU2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
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
        'https://app.powerbi.com/view?r=eyJrIjoiYTI1M2Y4ODItMmZmMy00NjljLThkYTgtOGZmZDg5NTAyYTljIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        2,
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'UpdatedCriteriaStatus' 
);