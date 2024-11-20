delete from openchpl.report_metadata where report_key = 'CriteriaAttributes';

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Criteria Attributes',
        'CriteriaAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNjM1MWZmZDUtMDhmZi00NjVkLTljNDktM2E0Y2UzYjYxZTEyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '725px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'CriteriaAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Criteria Attributes',
        'CriteriaAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMzY1M2E1YWMtMDJhMC00OWUxLTliZGItYzViZDNjZDRiZTk0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '725px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'CriteriaAttributes' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Criteria Attributes',
        'CriteriaAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMzEwMDI5MWMtMTQ5My00NDIxLTgyMjUtZTM1MGIwNWRkOTlmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '725px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'CriteriaAttributes' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Criteria Attributes',
        'CriteriaAttributes', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZWY3Y2RkMzctZDdjMC00ZWJlLWEzMWUtZjAwYTUwN2RlNGQyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '725px',
        2,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'CriteriaAttributes' 
);
