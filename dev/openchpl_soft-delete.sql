CREATE OR REPLACE FUNCTION openchpl.developer_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE openchpl.vendor_status_history as src SET deleted = NEW.deleted WHERE src.vendor_id = NEW.vendor_id;
	UPDATE openchpl.user_developer_map as src SET deleted = NEW.deleted WHERE src.developer_id = NEW.vendor_id;

	UPDATE openchpl.change_request as src SET deleted = NEW.deleted WHERE src.developer_id = NEW.vendor_id;
	UPDATE openchpl.change_request_status as src SET deleted = NEW.deleted
	WHERE change_request_id IN (
		SELECT id
		FROM openchpl.change_request
		WHERE developer_id = NEW.vendor_id);

	UPDATE openchpl.change_request_developer_details as src SET deleted = NEW.deleted
	WHERE change_request_id IN (
		SELECT id
		FROM openchpl.change_request
		WHERE developer_id = NEW.vendor_id);

	UPDATE openchpl.change_request_website as src SET deleted = NEW.deleted
	WHERE change_request_id IN (
		SELECT id
		FROM openchpl.change_request
		WHERE developer_id = NEW.vendor_id);

	UPDATE openchpl.change_request_attestation_submission as src SET deleted = NEW.deleted
	WHERE change_request_id IN (
		SELECT id
		FROM openchpl.change_request
		WHERE developer_id = NEW.vendor_id);

	UPDATE openchpl.change_request_attestation_response as src SET deleted = NEW.deleted
	WHERE change_request_attestation_submission_id IN (
		SELECT id
		FROM openchpl.change_request_attestation_submission
		WHERE change_request_id IN (
			SELECT id
			FROM openchpl.change_request
			WHERE developer_id = NEW.vendor_id));

	UPDATE openchpl.developer_attestation_submission as src SET deleted = NEW.deleted WHERE src.developer_id = NEW.vendor_id;
	UPDATE openchpl.developer_attestation_response as src SET deleted = NEW.deleted
	WHERE developer_attestation_submission_id IN (
		SELECT id
		FROM openchpl.developer_attestation_submission
		WHERE developer_id = NEW.vendor_id);

	UPDATE openchpl.attestation_period_developer_exception as src SET deleted = NEW.deleted WHERE src.developer_id = NEW.vendor_id;

    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS developer_soft_delete on openchpl.vendor;
CREATE TRIGGER developer_soft_delete AFTER UPDATE of deleted on openchpl.vendor FOR EACH ROW EXECUTE PROCEDURE openchpl.developer_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.product_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE openchpl.product_owner_history_map as src SET deleted = NEW.deleted WHERE src.product_id = NEW.product_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS product_soft_delete on openchpl.product;
CREATE TRIGGER product_soft_delete AFTER UPDATE of deleted on openchpl.product FOR EACH ROW EXECUTE PROCEDURE openchpl.product_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certified_product_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE openchpl.certification_status_event as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.cures_update_event as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certification_result as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.certification_result_additional_software as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.certified_product_chpl_product_number_history as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_accessibility_standard as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_qms_standard as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_targeted_user as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.certified_product_testing_lab_map as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.cqm_result as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.ehr_certification_id_product_map as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.pending_certification_result_additional_software as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.surveillance as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.pending_surveillance as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.listing_to_listing_map as src SET deleted = NEW.deleted WHERE src.parent_listing_id = NEW.certified_product_id;
    UPDATE openchpl.listing_to_listing_map as src SET deleted = NEW.deleted WHERE src.child_listing_id = NEW.certified_product_id;
	UPDATE openchpl.quarterly_report_excluded_listing_map as src SET deleted = NEW.deleted WHERE src.listing_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_measure as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.promoting_interoperability_user as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
	UPDATE openchpl.questionable_activity_listing as src SET deleted = NEW.deleted WHERE src.listing_id = NEW.certified_product_id;
	UPDATE openchpl.complaint_listing_map as src SET deleted = NEW.deleted WHERE src.listing_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_upload as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.listing_validation_report as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certified_product_soft_delete on openchpl.certified_product;
CREATE TRIGGER certified_product_soft_delete AFTER UPDATE of deleted on openchpl.certified_product FOR EACH ROW EXECUTE PROCEDURE openchpl.certified_product_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certified_product_measure_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.certified_product_measure_criteria as src SET deleted = NEW.deleted WHERE src.certified_product_measure_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certified_product_measure_soft_delete on openchpl.certified_product_measure;
CREATE TRIGGER certified_product_measure_soft_delete AFTER UPDATE of deleted on openchpl.certified_product_measure FOR EACH ROW EXECUTE PROCEDURE openchpl.certified_product_measure_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certification_result_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.certification_result_additional_software as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_conformance_method as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_optional_standard as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_svap as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_data as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_functionality as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_procedure as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_standard as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_task as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_tool as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_ucd_process as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.optional_functionality_met as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
	UPDATE openchpl.questionable_activity_certification_result as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certification_result_soft_delete on openchpl.certification_result;
CREATE TRIGGER certification_result_soft_delete AFTER UPDATE of deleted on openchpl.certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.certification_result_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.cqm_result_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.cqm_result_criteria as src SET deleted = NEW.deleted WHERE src.cqm_result_id = NEW.cqm_result_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS cqm_result_soft_delete on openchpl.cqm_result;
CREATE TRIGGER cqm_result_soft_delete AFTER UPDATE of deleted on openchpl.cqm_result FOR EACH ROW EXECUTE PROCEDURE openchpl.cqm_result_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_requirement as src SET deleted = NEW.deleted WHERE src.surveillance_id = NEW.id;
    UPDATE openchpl.complaint_surveillance_map as src SET deleted = NEW.deleted WHERE src.surveillance_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_soft_delete on openchpl.surveillance;
CREATE TRIGGER surveillance_soft_delete AFTER UPDATE of deleted on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_requirement_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_nonconformity as src SET deleted = NEW.deleted WHERE src.surveillance_requirement_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_requirement_soft_delete on openchpl.surveillance_requirement;
CREATE TRIGGER surveillance_requirement_soft_delete AFTER UPDATE of deleted on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_requirement_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_nonconformity_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_nonconformity_document as src SET deleted = NEW.deleted WHERE src.surveillance_nonconformity_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_nonconformity_soft_delete on openchpl.surveillance_nonconformity;
CREATE TRIGGER surveillance_nonconformity_soft_delete AFTER UPDATE of deleted on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_nonconformity_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certification_result_test_task_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.test_task as src SET deleted = NEW.deleted WHERE src.test_task_id = NEW.test_task_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certification_result_test_task_soft_delete on openchpl.certification_result_test_task;
CREATE TRIGGER certification_result_test_task_soft_delete AFTER UPDATE of deleted on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.certification_result_test_task_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.test_task_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.test_task_participant_map as src 
	SET deleted = NEW.deleted 
	WHERE NOT EXISTS (
		SELECT 1 
		FROM openchpl.certification_result_test_task crtt
		WHERE crtt.deleted = false 
		AND crtt.test_task_id != NEW.test_task_id
	)
	AND src.test_task_id = NEW.test_task_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS test_task_soft_delete on openchpl.test_task;
CREATE TRIGGER test_task_soft_delete AFTER UPDATE of deleted on openchpl.test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.test_task_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.test_task_participant_map_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
   	UPDATE openchpl.test_participant 
	SET deleted = NEW.deleted 
	WHERE test_participant_id IN ( 
		SELECT DISTINCT tp.test_participant_id 
		FROM openchpl.test_participant tp 
		WHERE NOT EXISTS ( 
			SELECT 1 
			FROM openchpl.test_task_participant_map ttpm 
			WHERE tp.test_participant_id = ttpm.test_participant_id 
			AND ttpm.deleted = false 
		) 
	);
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS test_task_participant_map_soft_delete on openchpl.test_task_participant_map;
CREATE TRIGGER test_task_participant_map_soft_delete AFTER UPDATE of deleted on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE openchpl.test_task_participant_map_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.user_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE openchpl.user_certification_body_map as src SET deleted = NEW.deleted WHERE src.user_id = NEW.user_id;
    UPDATE openchpl.user_testing_lab_map as src SET deleted = NEW.deleted WHERE src.user_id = NEW.user_id;
	UPDATE openchpl.user_developer_map as src SET deleted = NEW.deleted WHERE src.user_id = NEW.user_id;
    UPDATE openchpl.user_reset_token as src SET deleted = NEW.deleted WHERE src.user_id = NEW.user_id;
	UPDATE openchpl.contact as src SET deleted = NEW.deleted WHERE src.contact_id = NEW.contact_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS user_soft_delete on openchpl.user;
CREATE TRIGGER user_soft_delete AFTER UPDATE of deleted on openchpl.user FOR EACH ROW EXECUTE PROCEDURE openchpl.user_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.complaint_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.complaint_listing_map as src SET deleted = NEW.deleted WHERE src.complaint_id = NEW.complaint_id;
    UPDATE openchpl.complaint_surveillance_map as src SET deleted = NEW.deleted WHERE src.complaint_id = NEW.complaint_id;
    UPDATE openchpl.complaint_criterion_map as src SET deleted = NEW.deleted WHERE src.complaint_id = NEW.complaint_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS complaint_soft_delete on openchpl.complaint;
CREATE TRIGGER complaint_soft_delete AFTER UPDATE of deleted on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE openchpl.complaint_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.quarterly_report_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.quarterly_report_excluded_listing_map as src SET deleted = NEW.deleted WHERE src.quarterly_report_id = NEW.id;
	UPDATE openchpl.quarterly_report_surveillance_map as src SET deleted = NEW.deleted WHERE src.quarterly_report_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS quarterly_report_soft_delete on openchpl.quarterly_report;
CREATE TRIGGER quarterly_report_soft_delete AFTER UPDATE of deleted on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE openchpl.quarterly_report_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.deprecated_api_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.deprecated_api_usage as src SET deleted = NEW.deleted WHERE src.deprecated_api_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS deprecated_api_soft_delete on openchpl.deprecated_api;
CREATE TRIGGER deprecated_api_soft_delete AFTER UPDATE of deleted on openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.deprecated_api_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.deprecated_response_field_api_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.deprecated_response_field as src SET deleted = NEW.deleted WHERE src.deprecated_api_id = NEW.id;
	UPDATE openchpl.deprecated_response_field_api_usage as src SET deleted = NEW.deleted WHERE src.deprecated_response_field_api_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS deprecated_response_field_api_soft_delete on openchpl.deprecated_response_field_api;
CREATE TRIGGER deprecated_response_field_api_soft_delete AFTER UPDATE of deleted on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE openchpl.deprecated_response_field_api_soft_delete();
