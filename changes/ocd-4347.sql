create index if not exists certification_result_additional_software_cert_res_id_idx on openchpl.certification_result_additional_software (certification_result_id);
create index if not exists certification_result_conformance_method_cert_res_id_idx on openchpl.certification_result_conformance_method (certification_result_id);
create index if not exists certification_result_functionality_tested_cert_res_id_idx on openchpl.certification_result_functionality_tested (certification_result_id);
create index if not exists certification_result_optional_standard_cert_res_id_idx on openchpl.certification_result_optional_standard (certification_result_id);
create index if not exists certification_result_svap_cert_res_id_idx on openchpl.certification_result_svap (certification_result_id);
create index if not exists certification_result_test_data_cert_res_id_idx on openchpl.certification_result_test_data (certification_result_id);
create index if not exists certification_result_test_procedure_cert_res_id_idx on openchpl.certification_result_test_procedure (certification_result_id);
create index if not exists certification_result_test_standard_cert_res_id_idx on openchpl.certification_result_test_standard (certification_result_id);
create index if not exists certification_result_test_task_cert_res_id_idx on openchpl.certification_result_test_task (certification_result_id);
create index if not exists certification_result_ucd_process_cert_res_id_idx on openchpl.certification_result_ucd_process (certification_result_id);
create index if not exists optional_functionality_met_cert_res_id_idx on openchpl.optional_functionality_met (certification_result_id);
create index if not exists questionable_activity_certification_result_cert_res_id_idx on openchpl.questionable_activity_certification_result (certification_result_id);

delete from openchpl.certification_result_conformance_method child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_functionality_tested child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_optional_standard child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_svap child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_test_data child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_test_procedure child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_test_standard child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_test_task child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_ucd_process child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.optional_functionality_met child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.questionable_activity_certification_result child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));
delete from openchpl.certification_result_additional_software child where exists (select * from openchpl.certification_result where certification_result_id = child.certification_result_id and (success = false or deleted = true));

delete from openchpl.certification_result cr 
where (success = false and g1_success = false and g2_success = false)
or deleted = true;
