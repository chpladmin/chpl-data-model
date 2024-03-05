-- Deployment file for version 24.7.0
--     as of 2024-03-05
-- ./changes/ocd-4452.sql
DROP VIEW IF EXISTS openchpl.product_certification_statuses;
DROP VIEW IF EXISTS openchpl.developer_certification_statuses;
DROP VIEW IF EXISTS openchpl.certified_product_search_result;

-- this index is needed for the function that calculates current status event for a listing
CREATE INDEX IF NOT EXISTS cse_certified_product_id_idx ON openchpl.certification_status_event (certified_product_id);

-- we will trigger questionable activity if the certification status is set far into the future
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Future Certification Status', 'Listing', -1
WHERE NOT EXISTS (
	SELECT id from openchpl.questionable_activity_trigger where name = 'Future Certification Status'
); 
;
-- ./changes/ocd-4482.sql
create table if not exists openchpl.code_set (
    id bigserial not null,
    required_day date not null,
	start_day date not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint code_set_pk primary key (id)
);
CREATE or replace TRIGGER code_set_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.code_set FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER code_set_timestamp BEFORE UPDATE on openchpl.code_set FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS code_set_last_modified_user_constraint ON openchpl.code_set;
CREATE CONSTRAINT TRIGGER code_set_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.code_set DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();


create table if not exists openchpl.code_set_criteria_map (
    id bigserial not null,
    code_set_id int not null,
    certification_criterion_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint code_set_criteria_map_pk primary key (id),
    constraint code_set_fk foreign key (code_set_id)
        references openchpl.code_set (id)
        match simple on update no action on delete restrict,
    constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
	match simple on update no action on delete restrict
);
CREATE or replace TRIGGER code_set_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.code_set_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER code_set_criteria_map_timestamp BEFORE UPDATE on openchpl.code_set_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS code_set_criteria_map_last_modified_user_constraint ON openchpl.code_set_criteria_map;
CREATE CONSTRAINT TRIGGER code_set_criteria_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.code_set_criteria_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

create table if not exists openchpl.certification_result_code_set (
    id bigserial not null,
    code_set_id int not null,
    certification_result_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint certification_result_code_set_pk primary key (id),
    constraint code_set_fk foreign key (code_set_id)
        references openchpl.code_set (id)
        match simple on update no action on delete restrict,
    constraint certification_result_fk foreign key (certification_result_id)
        references openchpl.certification_result (certification_result_id)
        match simple on update no action on delete restrict
);
CREATE or replace TRIGGER certification_result_code_set_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_code_set FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER certification_result_code_set_timestamp BEFORE UPDATE on openchpl.certification_result_code_set FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS certification_result_code_set_last_modified_user_constraint ON openchpl.certification_result_code_set;
CREATE CONSTRAINT TRIGGER certification_result_code_set_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.certification_result_code_set DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

alter table openchpl.certification_criterion_attribute add column if not exists code_set boolean default false;

update openchpl.certification_criterion_attribute cca
set code_set = true
where criterion_id in (5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167);

insert into openchpl.code_set (required_day, start_day, last_modified_user)
select '2025-12-31', '2024-03-11', -1
where not exists (select * from openchpl.code_set where required_day = '2025-12-31');

insert into openchpl.code_set_criteria_map (certification_criterion_id, code_set_id, last_modified_user)
select crit_id,
	(select id from openchpl.code_set where required_day = '2025-12-31'),
	-1
from unnest('{5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167}'::int[]) crit_id
where not exists (
	select * 
	from openchpl.code_set_criteria_map 
	where certification_criterion_id = crit_id
	and code_set_id = (select id from openchpl.code_set where required_day = '2025-12-31')
);
;
-- ./changes/ocd-4506.sql
delete from openchpl.certification_result_standard
where standard_id in (
	select id
	from openchpl.standard
	where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)'));

delete from openchpl.standard_criteria_map
where standard_id in (
	select id
	from openchpl.standard
	where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)'));

delete from openchpl.standard
where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)');

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.7.0', '2024-03-05', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
