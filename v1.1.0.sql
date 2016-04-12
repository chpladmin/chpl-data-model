CREATE TRIGGER test_standard_timestamp BEFORE UPDATE on openchpl.test_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_standard_timestamp BEFORE UPDATE on openchpl.certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_task_timestamp BEFORE UPDATE on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_task_participant_timestamp BEFORE UPDATE on openchpl.certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_task_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_task_participant_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_task_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_task_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_task_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_test_participant_timestamp BEFORE UPDATE on openchpl.pending_test_participant FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_test_participant_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_test_participant FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_test_task_timestamp BEFORE UPDATE on openchpl.pending_test_task FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_test_task_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_test_task FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
update openchpl.pending_certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = 'N/A');
update openchpl.certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = 'N/A');
update openchpl.test_tool set deleted = true where name = 'N/A';

update openchpl.pending_certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = '');
update openchpl.certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = '');
update openchpl.test_tool set deleted = true where name = '';alter table openchpl.test_tool drop column version;

alter table openchpl.certification_result_test_tool add column version varchar(100);update openchpl.certified_product set chpl_product_number = null where chpl_product_number not like 'CHP-%';