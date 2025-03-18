-- Deployment file for version 26.1.0
--     as of 2025-03-17
-- ./changes/ocd-4717.sql
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
;
-- ./changes/ocd-4800.sql
ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS ics_surveillance_summary text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS developer_complaints_log_review text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS post_certification_performance_of_certified_capabilities text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS appropriate_use_of_mark text;

ALTER TABLE openchpl.quarterly_report_surveillance_map
ADD COLUMN IF NOT EXISTS surveillance_findings text;
;
-- ./changes/ocd-4834.sql
update openchpl.certification_criterion_attribute
set svap = true
where criterion_id = 210;
;
-- ./changes/ocd-4843.sql
CREATE TABLE IF NOT EXISTS
  openchpl.criterion_product_statistics (
    id bigserial NOT NULL,
    product_count bigint NOT NULL,
    certification_criterion_id bigint NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT criterion_product_statistics_pk PRIMARY KEY (id),
    CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
  );

CREATE OR replace TRIGGER criterion_product_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER criterion_product_statistics_timestamp BEFORE UPDATE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS criterion_product_statistics_last_modified_user_constraint ON openchpl.criterion_product_statistics;
CREATE CONSTRAINT TRIGGER criterion_product_statistics_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.criterion_product_statistics DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();


;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('26.1.0', '2025-03-17', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
