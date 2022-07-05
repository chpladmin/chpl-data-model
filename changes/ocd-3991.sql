delete from openchpl.conformance_method_criteria_map
where conformance_method_id = 6;

delete from openchpl.conformance_method
where name = 'Drummond G10+ FHIR API powered by Touchstone';

insert into openchpl.test_data (name, last_modified_user)
select 'Drummond G10+ FHIR API powered by Touchstone', -1
where not exists (select * from openchpl.test_data where name = 'Drummond G10+ FHIR API powered by Touchstone');

insert into openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_user)
select 182, (select id from openchpl.test_data where name = 'Drummond G10+ FHIR API powered by Touchstone'), -1
where not exists (select * from openchpl.test_data_criteria_map where criteria_id = 182 and test_data_id = (select id from openchpl.test_data where name = 'Drummond G10+ FHIR API powered by Touchstone'));

insert into openchpl.test_tool (name, last_modified_user)
select 'Drummond G10+ FHIR API powered by Touchstone', -1
where not exists (select * from openchpl.test_tool where name = 'Drummond G10+ FHIR API powered by Touchstone');

insert into openchpl.test_tool_criteria_map (certification_criterion_id, test_tool_id, last_modified_user)
select 182, (select test_tool_id from openchpl.test_tool where name = 'Drummond G10+ FHIR API powered by Touchstone'), -1
where not exists (select * from openchpl.test_tool_criteria_map where certification_criterion_id = 182 and test_tool_id = (select test_tool_id from openchpl.test_tool where name = 'Drummond G10+ FHIR API powered by Touchstone'));
