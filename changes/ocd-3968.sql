insert into openchpl.conformance_method (name, last_modified_user)
select 'Touchstone',
       -1
where not exists (select * from openchpl.conformance_method where name = 'Touchstone');

insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user)
select (select certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(10)'),
       (select id from openchpl.conformance_method where name = 'Touchstone'),
       -1
where not exists (select * from openchpl.conformance_method_criteria_map
      where criteria_id = (select certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(10)')
      and conformance_method_id = (select id from openchpl.conformance_method where name = 'Touchstone'));
