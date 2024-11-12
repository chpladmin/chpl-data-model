CREATE TABLE IF NOT EXISTS openchpl.report_metadata (
	id bigserial not null,
	environment text not null,
	title text not null,
	report_key text not null,
	report_group text,
	url text not null,
	height text not null,
	display_order bigint not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	CONSTRAINT report_metadata_pk PRIMARY KEY (id)
);

CREATE OR replace TRIGGER report_metadata_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.report_metadata FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER report_metadata_timestamp BEFORE UPDATE on openchpl.report_metadata FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS report_metadata_last_modified_user_constraint ON openchpl.report_metadata;
CREATE CONSTRAINT TRIGGER report_metadata_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.report_metadata DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Developer Statistics',
	'DeveloperStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMzkzNmEwODMtMDAyZC00ZDMwLWI4MjYtZDZkY2M3NDM1N2RiIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1300px',
	1,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'DeveloperStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Developer Statistics',
	'DeveloperStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNGYwZWE1MzItNzEwNy00NTMzLTkxZGUtNWJhYjAxZTBjZDFjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1300px',
	1,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'DeveloperStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG',
	'Developer Statistics',
	'DeveloperStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZjgyNDBlZGUtM2MyZS00MTBjLWE3ZjgtM2Y0ZWVmODExN2NhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1300px',
	1,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'DeveloperStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Developer Statistics',
	'DeveloperStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZWJmZWE3ZTUtZGU0My00MmUyLTgzZmMtMjQ5ZjZiYTdmMDlkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1300px',
	1,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'DeveloperStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Surveillance Statistics',
	'SurveillanceStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZjZhYzg5OTgtMzkxYy00YzIzLWE2MzItMDI0YzcwYTRiNGNkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'2500px',
	2,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'SurveillanceStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Surveillance Statistics',
	'SurveillanceStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZDk2MDM0MWUtOGFjOC00MzY5LTkzNzUtNWM3ZDljMzE4M2E1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'2500px',
	2,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'SurveillanceStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG',
	'Surveillance Statistics',
	'SurveillanceStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMGU4OGU2ZjgtOTMyNC00YzcxLWI2YTUtYTk2ZjU2ZTg0OWVjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'2500px',
	2,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'SurveillanceStatistics'
);


insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Surveillance Statistics',
	'SurveillanceStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMThmM2FmYWMtNTgyMS00MDQ0LWJmNTYtYjJiNzdhODkxZGM1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'2500px',
	2,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'SurveillanceStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Criteria Attributes',
	'CriteriaAttributes', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMGI2MGMzMzUtYjk5My00ZDRhLTllOWMtMzRhMTFlZDE3ZjIxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'500px',
	6,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'CriteriaAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Criteria Attributes',
	'CriteriaAttributes', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNjIxMjVkMGUtMDA2Zi00NzMyLThiYTQtZDAwYTMyNzkwYTE0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'500px',
	6,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'CriteriaAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
	'Criteria Attributes',
	'CriteriaAttributes', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNzIyYTUyOTItN2Y1Yi00MTViLTk0ZjgtOGRiOTY5OGRhYjliIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'500px',
	6,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'CriteriaAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Criteria Attributes',
	'CriteriaAttributes', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMDE5ZDdmOWQtZjg5Ny00MjljLTkxNTYtZTM3YTVjNDg1NzBmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'500px',
	6,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'CriteriaAttributes'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Criteria Migration - (a)(9) to (b)(11)',
	'CriteriaMigration-a9tob11', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMTVlMDlhYTktMzlmOC00NDIzLWFlZmMtZTQyY2UxZDE4YzA0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'825px',
	7,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'CriteriaMigration-a9tob11'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Criteria Migration - (a)(9) to (b)(11)',
	'CriteriaMigration-a9tob11', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNzU0MzJjNTktMDA3Mi00Mzc3LWEwMzAtYTJlZDllZWU3MTQ5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'825px',
	7,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'CriteriaMigration-a9tob11'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
	'Criteria Migration - (a)(9) to (b)(11)',
	'CriteriaMigration-a9tob11', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiOGNjMzBlMjEtMGExNy00YWY1LTljZDctOWEzYWM1ZTBiNTNjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'825px',
	7,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'CriteriaMigration-a9tob11'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Criteria Migration - (a)(9) to (b)(11)',
	'CriteriaMigration-a9tob11', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNTFiMWFiZTUtMTYxMi00MDQ2LWEyYmMtYzkyMWFhMmFmMzkzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'825px',
	7,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'CriteriaMigration-a9tob11'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Product Statistics',
	'ProductStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMzdjZDRiMjAtZjMxNy00NjZiLTgzMDMtNTY1MmU2NzllM2FmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	3,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'ProductStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Product Statistics',
	'ProductStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNGI0Yjk5MTItYzRkZi00ZWRkLTlhYjEtNjM2ZjhhZTQwZmUxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	3,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'ProductStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
	'Product Statistics',
	'ProductStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiODk0MGU3MjktMWIwMy00YzFkLWFkY2MtYWY1ODQ0ZmQ1M2FhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	3,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'ProductStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Product Statistics',
	'ProductStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZmJmMmFjZmEtMTU2Yy00NjZkLTkwMGMtNDc1MGM3MDY3YWY5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	3,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'ProductStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Listing Statistics',
	'ListingStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZGU3NjU4OTctZjczNi00MWU0LWExY2YtMWMzNWVjOGMxMGJjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	4,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'ListingStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Listing Statistics',
	'ListingStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZjRkYWRkNGUtZDE0ZS00NDFlLWEzMTAtMzVjODViMjNjZDdmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	4,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'ListingStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
	'Listing Statistics',
	'ListingStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNDg2MmViMGYtOGNhZS00NGMyLWE1YTQtNGU2ZTE4NDlhZWIwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	4,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'ListingStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Listing Statistics',
	'ListingStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiNzgzNDRhZDQtMzIzZC00MjA1LTlkZTctNjJmNTJiYzdhZmE5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'1350px',
	4,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'ListingStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
	'Direct Review Statistics',
	'DirectReviewStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiMjU5NWMzZWItMGY3ZS00ZWE4LTk3NWEtNDcwMTA5Zjg4YTAwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'750px',
	5,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'DirectReviewStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
	'Direct Review Statistics',
	'DirectReviewStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiYTYwOGE2MzgtY2I5MS00ZDVjLWEyZTktYzVkNDc3MWRhMjFhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'750px',
	5,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'DirectReviewStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
	'Direct Review Statistics',
	'DirectReviewStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZjAxOWJkYzUtNzIzNy00ZTRhLThmM2YtN2NjN2JiYjdjZmVhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'750px',
	5,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'DirectReviewStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
	'Direct Review Statistics',
	'DirectReviewStatistics', 
	'dashboard', 
	'https://app.powerbi.com/view?r=eyJrIjoiZjE4ZjdhZTctNTU3Yi00MzZkLTliZmItZGZmYWIyNGNmYjZlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'750px',
	5,
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'DirectReviewStatistics'
);

insert into openchpl.report_metadata (environment, title, report_key, url, display_order, height, last_modified_user)
select 'DEV', 
	'Unique Products',
	'UniqueProducts', 
	'https://app.powerbi.com/view?r=eyJrIjoiZDQ0MDZiYzktOGMwNy00NDkyLWJlYzctNDMwODdkMDE1NGMxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	1,
	'800px',
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'UniqueProducts'
);

insert into openchpl.report_metadata (environment, title, report_key, url, display_order, height, last_modified_user)
select 'QA', 
	'Unique Products',
	'UniqueProducts', 
	'https://app.powerbi.com/view?r=eyJrIjoiOGIxMGZmNzMtNDdkYS00NWMxLWJkMTAtYTBhNjNmZGM1ZTFiIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	1,
	'800px',
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'QA' and report_key = 'UniqueProducts'
);

insert into openchpl.report_metadata (environment, title, report_key, url, display_order, height, last_modified_user)
select 'STG', 
	'Unique Products',
	'UniqueProducts', 
	'https://app.powerbi.com/view?r=eyJrIjoiNjJlMGQ0N2YtOTliNi00OWY3LWE1YjgtNzAwM2IxNTFlMjU0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	1,
	'800px',
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'STG' and report_key = 'UniqueProducts'
);

insert into openchpl.report_metadata (environment, title, report_key, url, display_order, height, last_modified_user)
select 'PROD', 
	'Unique Products',
	'UniqueProducts', 
	'https://app.powerbi.com/view?r=eyJrIjoiZTUyYmMxZTQtZTUzYi00NGY5LTgwNmEtYjFkMGVmM2FjYmNkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	1,
	'800px',
	-1
where not exists (
	select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'UniqueProducts'
);
