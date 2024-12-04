insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYzU0YzE5Y2YtMzNlZS00NDgzLTlmZTQtZjA0ZWQ0YzI4OGQ3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'DeveloperAttestations'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOGM2YzM3NzgtZjlhMS00OTFiLTkwNjQtOTViOGY0OWYxMDUwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'DeveloperAttestations'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMGI0MjM2NWUtNmU5Yi00NzI3LTllYTctNmZhMDQ4NTMwOWUzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'DeveloperAttestations' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        '',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'DeveloperAttestations' 
);
