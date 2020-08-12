-- Deployment file for version 19.5.0
--     as of 2020-08-10
-- ocd-3441.sql
alter table openchpl.certified_product
add column if not exists rwt_eligibility_year integer null;
;
-- ocd-2944.sql
-- Update inheritance_errors_report table
alter table openchpl.inheritance_errors_report
add column if not exists certification_body_id bigint;

do $$
begin
	if exists (select * from information_schema.columns where table_schema = 'openchpl' and table_name = 'inheritance_errors_report'and column_name = 'acb') then
		execute 'update openchpl.inheritance_errors_report ier set certification_body_id = (select certification_body_id from openchpl.certification_body cb where cb.name = ier.acb)';
	end if;
end
$$;

alter table openchpl.inheritance_errors_report
alter column certification_body_id set not null;

alter table openchpl.inheritance_errors_report
drop column if exists acb;

alter table openchpl.inheritance_errors_report
drop constraint if exists certification_body_id_fk;

alter table openchpl.inheritance_errors_report
add constraint certification_body_id_fk foreign key (certification_body_id) references openchpl.certification_body(certification_body_id);

-- Update broken_surveillance_rules
alter table openchpl.broken_surveillance_rules
add column if not exists certification_body_id bigint;

do $$
begin
	if exists (select * from information_schema.columns where table_schema = 'openchpl' and table_name = 'broken_surveillance_rules'and column_name = 'acb') then
		execute 'update openchpl.broken_surveillance_rules bsr set certification_body_id = (select certification_body_id from openchpl.certification_body cb where cb.name = bsr.acb)';
	end if;
end
$$;

alter table openchpl.broken_surveillance_report
alter column certification_body_id set not null;

alter table openchpl.broken_surveillance_rules
drop column if exists acb;

alter table openchpl.broken_surveillance_rules
drop constraint if exists certification_body_id_fk;

alter table openchpl.broken_surveillance_rules
add constraint certification_body_id_fk foreign key (certification_body_id) references openchpl.certification_body(certification_body_id);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.5.0', '2020-08-10', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
