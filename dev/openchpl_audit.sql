--
-- SCHEMA for holding audit trail logs
--
CREATE schema audit;
REVOKE CREATE ON schema audit FROM public;
ALTER schema audit OWNER TO openchpl_dev;

CREATE TABLE audit.logged_actions (
    schema_name text NOT NULL,
    table_name text NOT NULL,
    user_name text,
    action_tstamp TIMESTAMP WITH TIME zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    action text NOT NULL CHECK (action IN ('I','D','U')),
    original_data json,
    new_data json,
    query text
) WITH (fillfactor=100);

-- ALTER TABLE audit.logged_actions OWNER TO openchpl;

REVOKE ALL ON audit.logged_actions FROM public;
GRANT SELECT ON audit.logged_actions TO public;

CREATE INDEX logged_actions_schema_table_idx
ON audit.logged_actions(((schema_name||'.'||table_name)::TEXT));

CREATE INDEX logged_actions_action_tstamp_idx
ON audit.logged_actions(action_tstamp);

CREATE INDEX logged_actions_action_idx
ON audit.logged_actions(action);

--
-- Function to save old/new data when triggered
--
CREATE OR REPLACE FUNCTION audit.if_modified_func() RETURNS TRIGGER AS $body$
DECLARE
    v_old_data json;
    v_new_data json;
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        v_old_data := row_to_json(OLD);
        v_new_data := row_to_json(NEW);
        INSERT INTO audit.logged_actions (schema_name, table_name, user_name, action, original_data, new_data, query)
        VALUES (TG_TABLE_SCHEMA::TEXT, TG_TABLE_NAME::TEXT, session_user::TEXT, substring(TG_OP,1,1), v_old_data, v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := row_to_json(OLD);
        INSERT INTO audit.logged_actions (schema_name, table_name, user_name, action, original_data, query)
        VALUES (TG_TABLE_SCHEMA::TEXT, TG_TABLE_NAME::TEXT, session_user::TEXT, substring(TG_OP,1,1), v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := row_to_json(NEW);
        INSERT INTO audit.logged_actions (schema_name, table_name, user_name, action, new_data, query)
        VALUES (TG_TABLE_SCHEMA::TEXT, TG_TABLE_NAME::TEXT, session_user::TEXT, substring(TG_OP,1,1), v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, audit;
-- ALTER FUNCTION audit.if_modified_func() OWNER TO openchpl;

--
-- Function for updating last_modified_date field on UPDATE
--
CREATE OR REPLACE FUNCTION openchpl.update_last_modified_date_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.last_modified_date = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
-- ALTER FUNCTION openchpl.update_last_modified_date_column() OWNER TO openchpl;

-- Adding triggers for audit & last_modified_date updates
CREATE TRIGGER acb_vendor_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.acb_vendor_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER acb_vendor_map_timestamp BEFORE UPDATE on openchpl.acb_vendor_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER accessibility_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.accessibility_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER accessibility_standard_timestamp BEFORE UPDATE on openchpl.accessibility_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER acl_class_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.acl_class FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER acl_entry_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.acl_entry FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER acl_object_identity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.acl_object_identity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER acl_sid_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.acl_sid FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER activity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.activity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER activity_concept_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.activity_concept FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER activity_concept_timestamp BEFORE UPDATE on openchpl.activity_concept FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER activity_timestamp BEFORE UPDATE on openchpl.activity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER address_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.address FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER address_timestamp BEFORE UPDATE on openchpl.address FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER announcement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.announcement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER announcement_timestamp BEFORE UPDATE on openchpl.announcement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER annual_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.annual_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER annual_report_timestamp BEFORE UPDATE on openchpl.annual_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER api_key_activity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.api_key_activity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER api_key_activity_timestamp BEFORE UPDATE on openchpl.api_key_activity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER api_key_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.api_key FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER api_key_timestamp BEFORE UPDATE on openchpl.api_key FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER broken_surveillance_rules_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.broken_surveillance_rules FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER broken_surveillance_rules_timestamp BEFORE UPDATE on openchpl.broken_surveillance_rules FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_body_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_body FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_body_timestamp BEFORE UPDATE on openchpl.certification_body FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_criterion_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_criterion FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_criterion_timestamp BEFORE UPDATE on openchpl.certification_criterion FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_edition_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_edition FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_edition_timestamp BEFORE UPDATE on openchpl.certification_edition FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_additional_software_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_additional_software FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_additional_software_timestamp BEFORE UPDATE on openchpl.certification_result_additional_software FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_functionality_tested_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_functionality FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_functionality_tested_timestamp BEFORE UPDATE on openchpl.certification_result_test_functionality FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_g1_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_g1_macra_timestamp BEFORE UPDATE on openchpl.certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_g2_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_g2_macra_timestamp BEFORE UPDATE on openchpl.certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_data_timestamp BEFORE UPDATE on openchpl.certification_result_test_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_procedure_timestamp BEFORE UPDATE on openchpl.certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_standard_timestamp BEFORE UPDATE on openchpl.certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_task_timestamp BEFORE UPDATE on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_tool_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_tool FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_tool_timestamp BEFORE UPDATE on openchpl.certification_result_test_tool FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_timestamp BEFORE UPDATE on openchpl.certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_ucd_process_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_ucd_process FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_ucd_process_timestamp BEFORE UPDATE on openchpl.certification_result_ucd_process FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_status_timestamp BEFORE UPDATE on openchpl.certification_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_status_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_status_event_timestamp BEFORE UPDATE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_accessibility_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_accessibility_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_accessibility_standard_timestamp BEFORE UPDATE on openchpl.certified_product_accessibility_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_checksum_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_checksum FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_checksum_timestamp BEFORE UPDATE on openchpl.certified_product_checksum FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_qms_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_qms_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_qms_standard_timestamp BEFORE UPDATE on openchpl.certified_product_qms_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_targeted_user_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_targeted_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_targeted_user_timestamp BEFORE UPDATE on openchpl.certified_product_targeted_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_testing_lab_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_testing_lab_map_timestamp BEFORE UPDATE on openchpl.certified_product_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certified_product_timestamp BEFORE UPDATE on openchpl.certified_product FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER change_request_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_timestamp BEFORE UPDATE on openchpl.change_request FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER change_request_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_status_timestamp BEFORE UPDATE on openchpl.change_request_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER change_request_status_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_status_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_status_type_timestamp BEFORE UPDATE on openchpl.change_request_status_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER change_request_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_type_timestamp BEFORE UPDATE on openchpl.change_request_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER change_request_website_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.change_request_website FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER change_request_website_timestamp BEFORE UPDATE on openchpl.change_request_website FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complaint_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_timestamp BEFORE UPDATE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complaint_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_criterion_map_timestamp BEFORE UPDATE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complaint_criterion_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_listing_map_timestamp BEFORE UPDATE on openchpl.complaint_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complaint_status_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_status_type_timestamp BEFORE UPDATE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complaint_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_surveillance_map_timestamp BEFORE UPDATE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER complainant_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complainant_type_timestamp BEFORE UPDATE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER contact_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.contact FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER contact_timestamp BEFORE UPDATE on openchpl.contact FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER cqm_criterion_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cqm_criterion FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cqm_criterion_timestamp BEFORE UPDATE on openchpl.cqm_criterion FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER cqm_criterion_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cqm_criterion_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cqm_criterion_type_timestamp BEFORE UPDATE on openchpl.cqm_criterion_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER cqm_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cqm_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cqm_result_criteria_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cqm_result_criteria FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cqm_result_criteria_timestamp BEFORE UPDATE on openchpl.cqm_result_criteria FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER cqm_result_timestamp BEFORE UPDATE on openchpl.cqm_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER cqm_version_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cqm_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cqm_version_timestamp BEFORE UPDATE on openchpl.cqm_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER criterion_product_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER criterion_product_statistics_timestamp BEFORE UPDATE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER data_model_version_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.data_model_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER data_model_version_timestamp BEFORE UPDATE ON openchpl.data_model_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER education_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.education_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER education_type_timestamp BEFORE UPDATE on openchpl.education_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER ehr_certification_id_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.ehr_certification_id FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ehr_certification_id_timestamp BEFORE UPDATE on openchpl.ehr_certification_id FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER ehr_certification_id_product_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.ehr_certification_id_product_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ehr_certification_id_product_map_timestamp BEFORE UPDATE on openchpl.ehr_certification_id_product_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER file_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.file_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER file_type_timestamp BEFORE UPDATE on openchpl.file_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER filter_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.filter FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER filter_timestamp BEFORE UPDATE on openchpl.filter FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER filter_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.filter_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER filter_type_timestamp BEFORE UPDATE on openchpl.filter_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER chpl_file_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.chpl_file FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER chpl_file_timestamp BEFORE UPDATE on openchpl.chpl_file FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER fuzzy_choices_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER fuzzy_choices_timestamp BEFORE UPDATE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER incumbent_developers_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.incumbent_developers_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER incumbent_developers_statistics_timestamp BEFORE UPDATE on openchpl.incumbent_developers_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER inheritance_errors_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER inheritance_errors_report_timestamp BEFORE UPDATE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER invited_user_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.invited_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER invited_user_timestamp BEFORE UPDATE on openchpl.invited_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_message_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_message FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_message_timestamp BEFORE UPDATE on openchpl.job_message FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_status_timestamp BEFORE UPDATE on openchpl.job_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_type_timestamp BEFORE UPDATE on openchpl.job_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER job_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.job FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER job_timestamp BEFORE UPDATE on openchpl.job FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER listing_count_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_count_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_count_statistics_timestamp BEFORE UPDATE on openchpl.listing_count_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER listing_to_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_to_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_to_listing_map_timestamp BEFORE UPDATE on openchpl.listing_to_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER meaningful_use_user_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.meaningful_use_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER meaningful_use_user_timestamp BEFORE UPDATE ON openchpl.meaningful_use_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER macra_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.macra_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER macra_criteria_map_timestamp BEFORE UPDATE on openchpl.macra_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER nonconformity_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_status_timestamp BEFORE UPDATE on openchpl.nonconformity_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER nonconformity_type_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_type_statistics_timestamp BEFORE UPDATE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER optional_functionality_met_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.optional_functionality_met FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER optional_functionality_met_timestamp BEFORE UPDATE on openchpl.optional_functionality_met FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER participant_age_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_age_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_age_statistics_timestamp BEFORE UPDATE on openchpl.participant_age_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER participant_education_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_education_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_education_statistics_timestamp BEFORE UPDATE on openchpl.participant_education_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER participant_experience_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_experience_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_experience_statistics_timestamp BEFORE UPDATE on openchpl.participant_experience_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER participant_gender_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_gender_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_gender_statistics_timestamp BEFORE UPDATE on openchpl.participant_gender_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_additional_software_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_additional_software FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_additional_software_timestamp BEFORE UPDATE on openchpl.pending_certification_result_additional_software FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_g1_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_g1_macra_timestamp BEFORE UPDATE on openchpl.pending_certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_g2_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_g2_macra_timestamp BEFORE UPDATE on openchpl.pending_certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_data_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_functionality_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_functionality FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_functionality_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_functionality FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_procedure_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_standard_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_task_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_task_participant_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_task_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_tool_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_tool FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_tool_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_tool FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_timestamp BEFORE UPDATE on openchpl.pending_certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_ucd_process_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_ucd_process FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_ucd_process_timestamp BEFORE UPDATE on openchpl.pending_certification_result_ucd_process FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_accessibility_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_accessibility_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_accessibility_standard_timestamp BEFORE UPDATE on openchpl.pending_certified_product_accessibility_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_parent_listing_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_parent_listing FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_parent_listing_timestamp BEFORE UPDATE on openchpl.pending_certified_product_parent_listing FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_qms_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_qms_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_qms_standard_timestamp BEFORE UPDATE on openchpl.pending_certified_product_qms_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_targeted_user_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_targeted_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_targeted_user_timestamp BEFORE UPDATE on openchpl.pending_certified_product_targeted_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_testing_lab_map_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.pending_certified_product_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_testing_lab_map_timestamp BEFORE UPDATE ON openchpl.pending_certified_product_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certified_product_timestamp BEFORE UPDATE on openchpl.pending_certified_product FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_cqm_certification_criteria_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_cqm_certification_criteria FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_cqm_certification_criteria_timestamp BEFORE UPDATE on openchpl.pending_cqm_certification_criteria FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_cqm_criterion_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_cqm_criterion FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_cqm_criterion_timestamp BEFORE UPDATE on openchpl.pending_cqm_criterion FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_timestamp BEFORE UPDATE on openchpl.pending_surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_nonconformity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_nonconformity_timestamp BEFORE UPDATE on openchpl.pending_surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_requirement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_requirement_timestamp BEFORE UPDATE on openchpl.pending_surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_surveillance_validation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_validation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_validation_timestamp BEFORE UPDATE on openchpl.pending_surveillance_validation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_test_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_test_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_test_participant_timestamp BEFORE UPDATE on openchpl.pending_test_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_test_task_timestamp BEFORE UPDATE on openchpl.pending_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER practice_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.practice_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER practice_type_timestamp BEFORE UPDATE on openchpl.practice_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER product_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_timestamp BEFORE UPDATE on openchpl.product FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER product_classification_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product_classification_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_classification_type_timestamp BEFORE UPDATE on openchpl.product_classification_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER product_owner_history_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_owner_history_map_timestamp BEFORE UPDATE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER product_version_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_version_timestamp BEFORE UPDATE on openchpl.product_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER qms_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.qms_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qms_standard_timestamp BEFORE UPDATE on openchpl.qms_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER quarter_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarter_timestamp BEFORE UPDATE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER quarterly_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_timestamp BEFORE UPDATE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER quarterly_report_excluded_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_excluded_listing_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER quarterly_report_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_surveillance_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_trigger_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_trigger FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_trigger_timestamp BEFORE UPDATE on openchpl.questionable_activity_trigger FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_version_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_version_timestamp BEFORE UPDATE on openchpl.questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_product_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_product_timestamp BEFORE UPDATE on openchpl.questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_developer_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_developer_timestamp BEFORE UPDATE on openchpl.questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_listing_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_listing_timestamp BEFORE UPDATE on openchpl.questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_certification_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_certification_result_timestamp BEFORE UPDATE on openchpl.questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER sed_participants_statistics_count_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.sed_participants_statistics_count FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER sed_participants_statistics_count_timestamp BEFORE UPDATE on openchpl.sed_participants_statistics_count FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER summary_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.summary_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER summary_statistics_timestamp BEFORE UPDATE on openchpl.summary_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_timestamp BEFORE UPDATE on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_nonconformity_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_nonconformity_timestamp BEFORE UPDATE on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_nonconformity_document_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_nonconformity_document FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_nonconformity_document_timestamp BEFORE UPDATE on openchpl.surveillance_nonconformity_document FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_requirement_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_requirement_timestamp BEFORE UPDATE on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_requirement_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_requirement_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_requirement_type_timestamp BEFORE UPDATE on openchpl.surveillance_requirement_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_result_timestamp BEFORE UPDATE on openchpl.surveillance_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_type_timestamp BEFORE UPDATE on openchpl.surveillance_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_outcome_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_outcome_timestamp BEFORE UPDATE on openchpl.surveillance_outcome FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER surveillance_process_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER surveillance_process_type_timestamp BEFORE UPDATE on openchpl.surveillance_process_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER targeted_user_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.targeted_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER targeted_user_timestamp BEFORE UPDATE on openchpl.targeted_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_timestamp BEFORE UPDATE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_data_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_criteria_map_timestamp BEFORE UPDATE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_functionality_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_functionality FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_functionality_timestamp BEFORE UPDATE on openchpl.test_functionality FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_functionality_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_functionality_criteria_map_timestamp BEFORE UPDATE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_participant_timestamp BEFORE UPDATE on openchpl.test_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_participant_age_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_participant_age FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_participant_age_timestamp BEFORE UPDATE on openchpl.test_participant_age FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_timestamp BEFORE UPDATE on openchpl.test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_procedure_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_criteria_map_timestamp BEFORE UPDATE on openchpl.test_procedure_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_standard_timestamp BEFORE UPDATE on openchpl.test_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_task_timestamp BEFORE UPDATE on openchpl.test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_task_participant_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_task_participant_map_timestamp BEFORE UPDATE on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_tool_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_tool FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_tool_timestamp BEFORE UPDATE on openchpl.test_tool FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER testing_lab_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.testing_lab FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER testing_lab_timestamp BEFORE UPDATE on openchpl.testing_lab FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER ucd_process_timestamp BEFORE UPDATE on openchpl.ucd_process FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER ucd_process_timestamp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.ucd_process FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER upload_template_version_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.upload_template_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER upload_template_version_timestamp BEFORE UPDATE on openchpl.upload_template_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER url_check_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_check_result_timestamp BEFORE UPDATE on openchpl.url_check_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER url_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER url_type_timestamp BEFORE UPDATE on openchpl.url_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_certification_body_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_certification_body_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_certification_body_map_timestamp BEFORE UPDATE on openchpl.user_certification_body_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_developer_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_developer_map_timestamp BEFORE UPDATE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_testing_lab_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_testing_lab_map_timestamp BEFORE UPDATE on openchpl.user_testing_lab_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_permission_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_permission FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_permission_timestamp BEFORE UPDATE on openchpl.user_permission FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_timestamp BEFORE UPDATE on openchpl.user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER user_reset_token_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_reset_token FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_reset_token_timestamp BEFORE UPDATE on openchpl.user_reset_token FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER vendor_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.vendor FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER vendor_timestamp BEFORE UPDATE on openchpl.vendor FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER vendor_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER vendor_status_timestamp BEFORE UPDATE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER vendor_status_history_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.vendor_status_history FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER vendor_status_history_timestamp BEFORE UPDATE on openchpl.vendor_status_history FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
