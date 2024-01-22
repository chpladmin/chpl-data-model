alter table openchpl.certification_criterion_attribute
add column if not exists code_set bool not null default false;

update openchpl.certification_criterion_attribute
set code_set = true
where criterion_id in (5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167);

alter table openchpl.certification_result
add column if not exists code_set bool;

update openchpl.certification_result
set code_set = false
where certification_criterion_id in (select criterion_id from openchpl.certification_criterion_attribute where code_set = true)
and certified_product_id in (select cpd.certified_product_id from openchpl.certified_product_details cpd where cpd.certification_status_name in ('Active', 'Withdrawn by ONC-ACB', 'Withdrawn by Developer'));
