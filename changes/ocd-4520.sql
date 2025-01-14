insert into openchpl.report_metadata (environment, title, report_key, url, height, display_order, last_modified_user)
select 'DEV', 'Non-Conformity Counts', 'Non-conformityCounts',
    'https://app.powerbi.com/view?r=eyJrIjoiNWFjZGRjZjItZGUyMC00ODc0LWI1NTMtOGVhZjdjZTgyOGJlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
    '650px', 1, -1
where not exists (
    select *
	from openchpl.report_metadata
	where environment = 'DEV'
	and report_key = 'Non-conformityCounts');

insert into openchpl.report_metadata (environment, title, report_key, url, height, display_order, last_modified_user)
select 'QA', 'Non-Conformity Counts', 'Non-conformityCounts',
    'https://app.powerbi.com/view?r=eyJrIjoiNDI3ZjhhZTgtMzNmYi00NDI4LWEzNTgtNzY4MjY3YzZkZTRmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
    '650px', 1, -1
where not exists (
    select *
	from openchpl.report_metadata
	where environment = 'QA'
	and report_key = 'Non-conformityCounts');

insert into openchpl.report_metadata (environment, title, report_key, url, height, display_order, last_modified_user)
select 'STG', 'Non-Conformity Counts', 'Non-conformityCounts',
    'https://app.powerbi.com/view?r=eyJrIjoiOTA4YWQ1ZTAtZjdmOC00NzVlLWI3ZTEtMGFkOTdkYzViM2NmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
    '650px', 1, -1
where not exists (
    select *
	from openchpl.report_metadata
	where environment = 'STG'
	and report_key = 'Non-conformityCounts');

insert into openchpl.report_metadata (environment, title, report_key, url, height, display_order, last_modified_user)
select 'PROD', 'Non-conformity Counts', 'Non-conformityCounts',
    'https://app.powerbi.com/view?r=eyJrIjoiNTg0NzBiMDQtNjg0YS00MGE0LWI2MzMtNzY1ZDg4YzI0MWQxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
    '800px', 1, -1
where not exists (
    select *
	from openchpl.report_metadata
	where environment = 'PROD'
	and report_key = 'Non-conformityCounts');
