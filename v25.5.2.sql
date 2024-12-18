-- Deployment file for version 25.5.2
--     as of 2024-12-18
-- ./changes/ocd-4686.sql
delete from openchpl.report_metadata where report_key = 'ServiceBaseUrlListingReport';

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Service Base URL List Report',
        'ServiceBaseUrlListReport', 
        'dashboard', 
        'https://app.powerbi.com/reportEmbed?reportId=96b02f2f-40cc-4cd1-8c1d-36733c72c677&autoAuth=true&ctid=307d212a-fb86-4807-84dd-867769b8042a',
        '1125px',
        8,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'ServiceBaseUrlListReport'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Service Base URL List Report',
        'ServiceBaseUrlListReport', 
        'dashboard', 
        'https://app.powerbi.com/reportEmbed?reportId=7acce5ef-43fc-4093-a53d-1addadbcd0e3&autoAuth=true&ctid=307d212a-fb86-4807-84dd-867769b8042a',
        '1125px',
        8,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'ServiceBaseUrlListReport'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Service Base URL List Report',
        'ServiceBaseUrlListReport', 
        'dashboard', 
        'https://app.powerbi.com/reportEmbed?reportId=c2d5c704-622e-4ded-a4b8-2657e4b4c84a&autoAuth=true&ctid=307d212a-fb86-4807-84dd-867769b8042a',
        '1125px',
        8,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'ServiceBaseUrlListReport'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Service Base URL List Report',
        'ServiceBaseUrlListReport', 
        'dashboard', 
        'https://app.powerbi.com/reportEmbed?reportId=cf4cd6fb-803e-4c55-ac32-5355a85b3c32&autoAuth=true&ctid=307d212a-fb86-4807-84dd-867769b8042a',
        '1125px',
        8,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'ServiceBaseUrlListReport'
);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.5.2', '2024-12-18', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
