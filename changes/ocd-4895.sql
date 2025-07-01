insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Criteria Up-To-Date',
        'CriteriaUpToDate', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZDM4ZGYxNWMtYmMzNy00NGQ2LTk5ZDEtZDhkYTU1NWRhNTEyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'CriteriaUpToDate'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Criteria Up-To-Date',
        'CriteriaUpToDate', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNmRiNzc4YTMtYjE1MC00MzVmLTkzNzgtNDNiMjExZTAyOGE2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'CriteriaUpToDate' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Criteria Up-To-Date',
        'CriteriaUpToDate', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNTk0NTUyZTEtMmNiMy00YjQ2LWI0MmMtNDhlNmYxODk3ZmE1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'CriteriaUpToDate' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Criteria Up-To-Date',
        'CriteriaUpToDate', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMjRkNzhkNjctNjA0OS00YWZlLTkzNWItMjU5ZTJjM2IyNDg3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '1100px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'CriteriaUpToDate' 
);