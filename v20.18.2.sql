-- Deployment file for version 20.18.2
--     as of 2022-07-06
-- ./changes/ocd-3960.sql
-- make (g)(10) macra measure 'RT2a EH/CAH Medicare PI' point to the correct mips measure
UPDATE openchpl.allowed_measure_criteria
SET deleted = true
WHERE id = 198;

update openchpl.allowed_measure_criteria_legacy_map
set allowed_criteria_measure_id = 197
where id = 267;

-- remove the incorrect (g)(10) measure; nothing maps to this
UPDATE openchpl.measure
SET deleted = true
where id = 88;
;
-- ./changes/ocd-3991.sql
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
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.18.2', '2022-07-06', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
