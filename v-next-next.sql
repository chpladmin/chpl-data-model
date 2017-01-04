-------------------------------------------------------------------------------------
-- OCD-1039 Add indexes to improve performance
-------------------------------------------------------------------------------------
DO $$
BEGIN

IF to_regclass('openchpl.ix_certified_product') IS NULL THEN
    CREATE INDEX ix_certified_product ON openchpl.certified_product (certified_product_id, certification_edition_id, product_version_id, 
       testing_lab_id, certification_body_id, acb_certification_id, practice_type_id, product_classification_type_id, 
       certification_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_product') IS NULL THEN
    CREATE INDEX ix_product ON openchpl.product (product_id, vendor_id, deleted);
END IF;

IF to_regclass('openchpl.ix_vendor') IS NULL THEN
    CREATE INDEX ix_vendor ON openchpl.vendor (vendor_id, address_id, contact_id, vendor_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_criterion') IS NULL THEN
    CREATE INDEX ix_certification_criterion ON openchpl.certification_criterion (certification_criterion_id, certification_edition_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_event') IS NULL THEN
    CREATE INDEX ix_certification_event ON openchpl.certification_event (certification_event_id, certified_product_id, event_type_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result') IS NULL THEN
    CREATE INDEX ix_certification_result ON openchpl.certification_result (certification_result_id, certification_criterion_id, certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_additional_software') IS NULL THEN
    CREATE INDEX ix_certification_result_additional_software ON openchpl.certification_result_additional_software (certification_result_additional_software_id, certification_result_id, 
    certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_data') IS NULL THEN
    CREATE INDEX ix_certification_result_test_data ON openchpl.certification_result_test_data (certification_result_test_data_id, certification_result_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_functionality') IS NULL THEN
    CREATE INDEX ix_certification_result_test_functionality ON openchpl.certification_result_test_functionality (certification_result_test_functionality_id, certification_result_id, 
       test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_procedure') IS NULL THEN
    CREATE INDEX ix_certification_result_test_procedure ON openchpl.certification_result_test_procedure (certification_result_test_procedure_id, certification_result_id, test_procedure_id, 
    deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_standard') IS NULL THEN
    CREATE INDEX ix_certification_result_test_standard ON openchpl.certification_result_test_standard (certification_result_test_standard_id, certification_result_id, 
       test_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_task') IS NULL THEN
    CREATE INDEX ix_certification_result_test_task ON openchpl.certification_result_test_task (certification_result_test_task_id, certification_result_id, test_task_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_task_participant') IS NULL THEN
    CREATE INDEX ix_certification_result_test_task_participant ON openchpl.certification_result_test_task_participant (certification_result_test_task_participant_id, 
    certification_result_test_task_id, test_participant_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_tool') IS NULL THEN
    CREATE INDEX ix_certification_result_test_tool ON openchpl.certification_result_test_tool (certification_result_test_tool_id, certification_result_id, test_tool_id, 
 deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_ucd_process') IS NULL THEN
    CREATE INDEX ix_certification_result_ucd_process ON openchpl.certification_result_ucd_process (certification_result_ucd_process_id, certification_result_id, 
       ucd_process_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certified_product_qms_standard') IS NULL THEN
END IF;
    CREATE INDEX ix_certified_product_qms_standard ON openchpl.certified_product_qms_standard (certified_product_qms_standard_id, certified_product_id, qms_standard_id, deleted);

IF to_regclass('openchpl.ix_contact') IS NULL THEN
    CREATE INDEX ix_contact ON openchpl.contact (contact_id, deleted);
END IF;

IF to_regclass('openchpl.ix_cqm_criterion') IS NULL THEN
    CREATE INDEX ix_cqm_criterion ON openchpl.cqm_criterion (cqm_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_cqm_result') IS NULL THEN
    CREATE INDEX ix_cqm_result ON openchpl.cqm_result (cqm_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_ehr_certification_id') IS NULL THEN
    CREATE INDEX ix_ehr_certification_id ON openchpl.ehr_certification_id (ehr_certification_id_id, certification_id, practice_type_id);
END IF;

IF to_regclass('openchpl.ix_ehr_certification_id_product_map') IS NULL THEN
    CREATE INDEX ix_ehr_certification_id_product_map ON openchpl.ehr_certification_id_product_map (ehr_certification_id_product_map_id, ehr_certification_id_id, certified_product_id);
END IF;

IF to_regclass('openchpl.ix_global_user_permission_map') IS NULL THEN
    CREATE INDEX ix_global_user_permission_map ON openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, deleted, global_user_permission_id);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result') IS NULL THEN
    CREATE INDEX ix_pending_certification_result ON openchpl.pending_certification_result (pending_certification_result_id, certification_criterion_id, 
       pending_certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_additional_software') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_additional_software ON openchpl.pending_certification_result_additional_software (pending_certification_result_additional_software_id, pending_certification_result_id, certified_product_id, certified_product_chpl_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_data') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_data ON openchpl.pending_certification_result_test_data (pending_certification_result_test_data_id, pending_certification_result_id, 
       deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_functionality') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_functionality ON openchpl.pending_certification_result_test_functionality (pending_certification_result_test_functionality_id, pending_certification_result_id, test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_procedure') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_procedure ON openchpl.pending_certification_result_test_procedure (pending_certification_result_test_procedure_id, pending_certification_result_id, 
       test_procedure_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_standard') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_standard ON openchpl.pending_certification_result_test_standard (pending_certification_result_test_standard_id, pending_certification_result_id, 
       test_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_task') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_task ON openchpl.pending_certification_result_test_task (pending_certification_result_test_task_id, pending_certification_result_id, 
       pending_test_task_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_task_participant') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_task_participant ON openchpl.pending_certification_result_test_task_participant (pending_certification_result_test_task_participant_id, pending_certification_result_test_task_id, pending_test_participant_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_tool') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_tool ON openchpl.pending_certification_result_test_tool (pending_certification_result_test_tool_id, pending_certification_result_id, 
       test_tool_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_ucd_process') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_ucd_process ON openchpl.pending_certification_result_ucd_process (pending_certification_result_ucd_process_id, pending_certification_result_id, 
       ucd_process_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product') IS NULL THEN
    CREATE INDEX ix_pending_certified_product ON openchpl.pending_certified_product (pending_certified_product_id, unique_id, acb_certification_id, practice_type_id, vendor_id, vendor_address_id, vendor_contact_id, product_id, product_version_id, certification_edition_id, certification_body_id, product_classification_id, testing_lab_id, deleted, certification_status_id);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product_accessibility_standard') IS NULL THEN
    CREATE INDEX ix_pending_certified_product_accessibility_standard ON openchpl.pending_certified_product_accessibility_standard (pending_certified_product_accessibility_standard_id, pending_certified_product_id, accessibility_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product_qms_standard') IS NULL THEN
    CREATE INDEX ix_pending_certified_product_qms_standard ON openchpl.pending_certified_product_qms_standard (pending_certified_product_qms_standard_id, pending_certified_product_id, 
       qms_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_cqm_certification_criteria') IS NULL THEN
    CREATE INDEX ix_pending_cqm_certification_criteria ON openchpl.pending_cqm_certification_criteria (pending_cqm_certification_criteria_id, pending_cqm_criterion_id, 
       certification_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_cqm_criterion') IS NULL THEN
    CREATE INDEX ix_pending_cqm_criterion ON openchpl.pending_cqm_criterion (pending_cqm_criterion_id, cqm_criterion_id, pending_certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_test_participant') IS NULL THEN
    CREATE INDEX ix_pending_test_participant ON openchpl.pending_test_participant (pending_test_participant_id, test_participant_unique_id, education_type_id, deleted, 
       test_participant_age_id);
END IF;

IF to_regclass('openchpl.ix_pending_test_task') IS NULL THEN
    CREATE INDEX ix_pending_test_task ON openchpl.pending_test_task (pending_test_task_id, test_task_unique_id, deleted);
END IF;

IF to_regclass('openchpl.ix_product_version') IS NULL THEN
    CREATE INDEX ix_product_version ON openchpl.product_version (product_version_id, product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance') IS NULL THEN
    CREATE INDEX ix_surveillance ON openchpl.surveillance (id, certified_product_id, friendly_id, type_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_nonconformity') IS NULL THEN
    CREATE INDEX ix_surveillance_nonconformity ON openchpl.surveillance_nonconformity (id, surveillance_requirement_id, certification_criterion_id, nonconformity_type, nonconformity_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_requirement') IS NULL THEN
    CREATE INDEX ix_surveillance_requirement ON openchpl.surveillance_requirement (id, surveillance_id, type_id, certification_criterion_id, requirement, result_id, creation_date, last_modified_date, last_modified_user, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_requirement_type') IS NULL THEN
    CREATE INDEX ix_surveillance_requirement_type ON openchpl.surveillance_requirement_type (id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_functionality') IS NULL THEN
    CREATE INDEX ix_test_functionality ON openchpl.test_functionality (test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_participant') IS NULL THEN
    CREATE INDEX ix_test_participant ON openchpl.test_participant (test_participant_id, education_type_id, deleted, test_participant_age_id);
END IF;

IF to_regclass('openchpl.ix_test_procedure') IS NULL THEN
    CREATE INDEX ix_test_procedure ON openchpl.test_procedure (test_procedure_id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_standard') IS NULL THEN
    CREATE INDEX ix_test_standard ON openchpl.test_standard (test_standard_id, deleted);
END IF;

END$$;

-------------------------------------------------------------------------------------
-- OCD-1135 add new certification status
-------------------------------------------------------------------------------------

insert into openchpl.certification_status (certification_status, last_modified_user)
select
        'Withdrawn by Developer Under Surveillance/Review', -1
where not exists (
        select * from openchpl.certification_status where certification_status = 'Withdrawn by Developer Under Surveillance/Review'
);

