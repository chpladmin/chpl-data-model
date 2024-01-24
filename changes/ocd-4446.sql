alter table openchpl.certification_criterion_attribute
add column if not exists code_sets bool not null default false;

update openchpl.certification_criterion_attribute
set code_sets = true
where criterion_id in (5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167);

alter table openchpl.certification_result
add column if not exists code_sets bool;

-- Set the code_sets column to false for listings with active certificates
update openchpl.certification_result
set code_sets = false
where certification_criterion_id in 
    (select criterion_id 
	from openchpl.certification_criterion_attribute 
	where code_sets = true)
and certified_product_id in 
    (select cpd.certified_product_id 
	from openchpl.certified_product_details cpd 
	where cpd.certification_status_name in ('Active', 'Suspended by ONC-ACB', 'Suspended by ONC'));

-- Set the code_sets column to true for listings with non-active certificates
update openchpl.certification_result
set code_sets = true
where certification_criterion_id in 
    (select criterion_id 
	from openchpl.certification_criterion_attribute 
	where code_sets = true)
and certified_product_id in 
    (select cpd.certified_product_id 
	from openchpl.certified_product_details cpd 
	where cpd.certification_status_name not in ('Active', 'Suspended by ONC-ACB', 'Suspended by ONC'));

insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Code Sets changed to false', 'Certification Criteria', -1
where not exists (select * from openchpl.questionable_activity_trigger where name = 'Code Sets changed to false');


