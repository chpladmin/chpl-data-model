delete from openchpl.report_metadata where report_key = 'SVAPUsage';

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'SVAP Usage by Criteria',
        'SVAPUsageByCriteria', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNmUxMzE0ZGMtZDRkYi00ODI4LWEyZmMtNTRlMDJiNjA4N2VjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        10,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'SVAPUsageByCriteria'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'SVAP Usage by Criteria',
        'SVAPUsageByCriteria', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiM2Y3MzQ1NjUtNDQ0YS00NWVhLWI5MDUtMTZlMzE0YzQ0NGFkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        10,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'SVAPUsageByCriteria'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'SVAP Usage by Criteria',
        'SVAPUsageByCriteria', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZjZkYzhhZDItYzg4MC00MmQxLWE2ZjQtNjE1ODc5YTgxZjc5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        10,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'SVAPUsageByCriteria' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'SVAP Usage by Criteria',
        'SVAPUsageByCriteria', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZjRkNmVhOGYtN2JhNC00ODgzLWFmOGEtYTVkYjIyZTcyOWQ4IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        10,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'SVAPUsageByCriteria' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'SVAP Usage by SVAP',
        'SVAPUsageBySVAP', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOTc0YmEwNjQtY2FlYi00ZWI4LTg3NDktYWFiNzE5ZWYxYmY0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        11,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'SVAPUsageBySVAP'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'SVAP Usage by SVAP',
        'SVAPUsageBySVAP', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNGFjMTllMTgtZDNjNi00Njk1LWFjMzctMjE3ZGYwZjBlYTE5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        11,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'SVAPUsageBySVAP'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'SVAP Usage by SVAP',
        'SVAPUsageBySVAP', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiODZkNzFkZjAtYWJlNi00YjYxLTkwZGYtZWVlNzE3NmQzNjIyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        11,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'SVAPUsageBySVAP' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'SVAP Usage by SVAP',
        'SVAPUsageBySVAP', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNTgyOTk4YTgtZWE1YS00YWVhLTg5YWMtZDlmOTk2NzYwYjBlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '925px',
        11,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'SVAPUsageBySVAP' 
);
