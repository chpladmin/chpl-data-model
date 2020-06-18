-- Update inheritance_errors_report table
alter table openchpl.inheritance_errors_report
add column if not exists certification_body_id integer;

do $$
begin
	if exists (select * from information_schema.columns where table_schema = 'openchpl' and table_name = 'inheritance_errors_report'and column_name = 'acb') then
		execute 'update openchpl.inheritance_errors_report ier set certification_body_id = (select certification_body_id from openchpl.certification_body cb where cb.name = ier.acb)';
	end if;
end
$$;

alter table openchpl.inheritance_errors_report
drop column if exists acb;

alter table openchpl.inheritance_errors_report
drop constraint if exists certification_body_id_fk;

alter table openchpl.inheritance_errors_report
add constraint certification_body_id_fk foreign key (certification_body_id) references openchpl.certification_body(certification_body_id);

-- Update broken_surveillance_rules
alter table openchpl.broken_surveillance_rules
add column if not exists certification_body_id integer;

do $$
begin
	if exists (select * from information_schema.columns where table_schema = 'openchpl' and table_name = 'broken_surveillance_rules'and column_name = 'acb') then
		execute 'update openchpl.broken_surveillance_rules bsr set certification_body_id = (select certification_body_id from openchpl.certification_body cb where cb.name = bsr.acb)';
	end if;
end
$$;

alter table openchpl.broken_surveillance_rules
drop column if exists acb;

alter table openchpl.broken_surveillance_rules
drop constraint if exists certification_body_id_fk;

alter table openchpl.broken_surveillance_rules
add constraint certification_body_id_fk foreign key (certification_body_id) references openchpl.certification_body(certification_body_id);
