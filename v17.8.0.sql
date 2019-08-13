-- Deployment file for version 17.8.0
--     as of 2019-08-12
-- ocd-3016.sql
do $$
	declare row_cnt int;
begin
	row_cnt := count(*) from openchpl.activity_concept;
	perform setval('openchpl.activity_concept_activity_concept_id_seq', row_cnt);

	insert into openchpl.activity_concept (concept, last_modified_user)
	select 'COMPLAINT', -1
	where not exists
	        (select *
	        from openchpl.activity_concept
	        where concept = 'COMPLAINT');
end $$;;
-- ocd-2920.sql
DROP TABLE IF EXISTS openchpl.quarterly_report_surveillance_map CASCADE;
DROP TABLE IF EXISTS openchpl.surveillance_outcome CASCADE;
DROP TABLE IF EXISTS openchpl.surveillance_process_type CASCADE;

-- create lookup tables for various dropdown options for surveillance
CREATE TABLE openchpl.surveillance_outcome (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_outcome_pk PRIMARY KEY (id)
);

CREATE TRIGGER surveillance_outcome_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_outcome_timestamp BEFORE UPDATE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.surveillance_outcome (name, last_modified_user)
VALUES ('No non-conformity', -1), ('Non-conformity substantiated - Resolved through corrective action', -1),
('Non-conformity substantiated - Unresolved - Corrective action ongoing', -1), ('Non-conformity substantiated - Unresolved - Certification suspended', -1),
('Non-conformity substantiated - Unresolved - Certification withdrawn', -1), ('Non-conformity substantiated - Unresolved - Surveillance in process', -1),
('Non-conformity substantiated - Unresolved - Under investigation/review', -1), ('Non-conformity substantiated - Unresolved - Other - [Please describe]', -1);

CREATE TABLE openchpl.surveillance_process_type (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_process_type_pk PRIMARY KEY (id)
);

CREATE TRIGGER surveillance_process_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_process_type_timestamp BEFORE UPDATE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.surveillance_process_type (name, last_modified_user)
VALUES ('In-the-Field', -1), ('Controlled/Test Environment', -1),
('Correspondence with Complainant/Developer', -1), ('Review of Websites/Written Documentation', -1),
('Other - [Please describe]', -1);


CREATE TABLE openchpl.quarterly_report_surveillance_map (
	id bigserial not null,
	quarterly_report_id bigint not null,
	surveillance_id bigint not null,
	k1_reviewed boolean,
	surveillance_outcome_id bigint,
	surveillance_outcome_other text,
	surveillance_process_type_id bigint,
	surveillance_process_type_other text,
	grounds_for_initiating text,
	nonconformity_causes text,
	nonconformity_nature text,
	steps_to_surveil text,
	steps_to_engage text,
	additional_costs_evaluation text,
	limitations_evaluation text,
	nondisclosure_evaluation text,
	direction_developer_resolution text,
	completed_cap_verification text,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT quarterly_report_surveillance_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_outcome_fk FOREIGN KEY (surveillance_outcome_id)
		REFERENCES openchpl.surveillance_outcome (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_process_type_fk FOREIGN KEY (surveillance_process_type_id)
		REFERENCES openchpl.surveillance_process_type (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER quarterly_report_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_surveillance_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ocd-3015.sql
insert into openchpl.activity_concept (concept, last_modified_user)
select 'QUARTERLY_REPORT', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'QUARTERLY_REPORT');

insert into openchpl.activity_concept (concept, last_modified_user)
select 'QUARTERLY_REPORT_LISTING', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'QUARTERLY_REPORT_LISTING');

insert into openchpl.activity_concept (concept, last_modified_user)
select 'ANNUAL_REPORT', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'ANNUAL_REPORT');;
-- ocd-3080.sql
update openchpl.certified_product set deleted = true where certified_product_id = 10063;
update openchpl.certified_product set deleted = true where certified_product_id = 10064;
update openchpl.certified_product set deleted = true where certified_product_id = 10065;
update openchpl.certified_product set deleted = true where certified_product_id = 10066;
;
update openchpl.data_model_version set version = '17.7.1' where version = '17.8.0';

insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.8.0', '2019-08-12', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
