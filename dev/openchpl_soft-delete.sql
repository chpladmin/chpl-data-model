CREATE OR REPLACE FUNCTION openchpl.certified_product_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.certification_event as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certification_result as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_accessibility_standard as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_qms_standard as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.certified_product_targeted_user as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.corrective_action_plan as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.cqm_result as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.ehr_certification_id_product_map as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.pending_certification_result_additional_software as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.surveillance as src SET deleted = NEW.deleted WHERE src.certified_product_id = NEW.certified_product_id;
    UPDATE openchpl.listing_to_listing_map as src SET deleted = NEW.deleted WHERE src.parent_listing_id = NEW.certified_product_id;
    UPDATE openchpl.listing_to_listing_map as src SET deleted = NEW.deleted WHERE src.child_listing_id = NEW.certified_product_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certified_product_soft_delete on openchpl.certified_product;
CREATE TRIGGER certified_product_soft_delete AFTER UPDATE on openchpl.certified_product FOR EACH ROW EXECUTE PROCEDURE openchpl.certified_product_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certification_result_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.certification_result_additional_software as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_g1_macra as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_g2_macra as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_data as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_functionality as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_procedure as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_standard as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_task as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_test_tool as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.certification_result_ucd_process as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    UPDATE openchpl.optional_functionality_met as src SET deleted = NEW.deleted WHERE src.certification_result_id = NEW.certification_result_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certification_result_soft_delete on openchpl.certification_result;
CREATE TRIGGER certification_result_soft_delete AFTER UPDATE on openchpl.certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.certification_result_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.corrective_action_plan_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.corrective_action_plan_certification_result as src SET deleted = NEW.deleted WHERE src.corrective_action_plan_id = NEW.corrective_action_plan_id;
    UPDATE openchpl.corrective_action_plan_documentation as src SET deleted = NEW.deleted WHERE src.corrective_action_plan_id = NEW.corrective_action_plan_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS corrective_action_plan_soft_delete on openchpl.corrective_action_plan;
CREATE TRIGGER corrective_action_plan_soft_delete AFTER UPDATE on openchpl.corrective_action_plan FOR EACH ROW EXECUTE PROCEDURE openchpl.corrective_action_plan_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.cqm_result_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.cqm_result_criteria as src SET deleted = NEW.deleted WHERE src.cqm_result_id = NEW.cqm_result_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS cqm_result_soft_delete on openchpl.cqm_result;
CREATE TRIGGER cqm_result_soft_delete AFTER UPDATE on openchpl.cqm_result FOR EACH ROW EXECUTE PROCEDURE openchpl.cqm_result_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_requirement as src SET deleted = NEW.deleted WHERE src.surveillance_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_soft_delete on openchpl.surveillance;
CREATE TRIGGER surveillance_soft_delete AFTER UPDATE on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_requirement_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_nonconformity as src SET deleted = NEW.deleted WHERE src.surveillance_requirement_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_requirement_soft_delete on openchpl.surveillance_requirement;
CREATE TRIGGER surveillance_requirement_soft_delete AFTER UPDATE on openchpl.surveillance_requirement FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_requirement_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.surveillance_nonconformity_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.surveillance_nonconformity_document as src SET deleted = NEW.deleted WHERE src.surveillance_nonconformity_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS surveillance_nonconformity_soft_delete on openchpl.surveillance_nonconformity;
CREATE TRIGGER surveillance_nonconformity_soft_delete AFTER UPDATE on openchpl.surveillance_nonconformity FOR EACH ROW EXECUTE PROCEDURE openchpl.surveillance_nonconformity_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.certification_result_test_task_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.test_task as src SET deleted = NEW.deleted WHERE src.test_task_id = NEW.test_task_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS certification_result_test_task_soft_delete on openchpl.certification_result_test_task;
CREATE TRIGGER certification_result_test_task_soft_delete AFTER UPDATE on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.certification_result_test_task_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.test_task_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.test_task_participant_map as src SET deleted = NEW.deleted WHERE src.test_task_id = NEW.test_task_id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS test_task_soft_delete on openchpl.test_task;
CREATE TRIGGER test_task_soft_delete AFTER UPDATE on openchpl.test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.test_task_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.test_task_participant_map_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.test_participant as src SET deleted = NEW.deleted WHERE
        src.test_participant_id IN
        (SELECT src.test_participant_id
        FROM openchpl.test_participant AS src
            LEFT JOIN (SELECT ttpm.test_participant_id, ttpm.test_task_id FROM openchpl.test_task_participant_map AS ttpm WHERE ttpm.deleted = FALSE)
            AS ttpm
            ON (src.test_participant_id = ttpm.test_participant_id)
        GROUP BY
            src.test_participant_id
        HAVING count(ttpm.test_participant_id) = 0
    );
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS test_task_participant_map_soft_delete on openchpl.test_task_participant_map;
CREATE TRIGGER test_task_participant_map_soft_delete AFTER UPDATE on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE openchpl.test_task_participant_map_soft_delete();
