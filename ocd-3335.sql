-- triggers missing from existing openchpl tables
DROP TRIGGER IF EXISTS complainant_type_audit on openchpl.complainant_type;
CREATE TRIGGER complainant_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS complainant_type_timestamp on openchpl.complainant_type;
CREATE TRIGGER complainant_type_timestamp BEFORE UPDATE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS cures_update_event_audit on openchpl.cures_update_event;
CREATE TRIGGER cures_update_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_update_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS cures_update_event_timestamp on openchpl.cures_update_event;
CREATE TRIGGER cures_update_event_timestamp AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_update_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- triggers for quartz tables
DROP TRIGGER IF EXISTS qrtz_job_details_audit on quartz.QRTZ_JOB_DETAILS;
CREATE TRIGGER qrtz_job_details_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_JOB_DETAILS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_triggers_audit on quartz.QRTZ_TRIGGERS;
CREATE TRIGGER qrtz_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_simple_triggers_audit on quartz.QRTZ_SIMPLE_TRIGGERS;
CREATE TRIGGER qrtz_simple_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_SIMPLE_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_cron_triggers_audit on quartz.QRTZ_CRON_TRIGGERS;
CREATE TRIGGER qrtz_cron_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_CRON_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_simprop_triggers_audit on quartz.QRTZ_SIMPROP_TRIGGERS;
CREATE TRIGGER qrtz_simprop_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_SIMPROP_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_blob_triggers_audit on quartz.QRTZ_BLOB_TRIGGERS;
CREATE TRIGGER qrtz_blob_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_BLOB_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_calendars_audit on quartz.QRTZ_CALENDARS;
CREATE TRIGGER qrtz_calendars_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_CALENDARS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_paused_trigger_grps_audit on quartz.QRTZ_PAUSED_TRIGGER_GRPS;
CREATE TRIGGER qrtz_paused_trigger_grps_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_PAUSED_TRIGGER_GRPS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_fired_triggers_audit on quartz.QRTZ_FIRED_TRIGGERS;
CREATE TRIGGER qrtz_fired_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_FIRED_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS qrtz_locks_audit on quartz.QRTZ_LOCKS;
CREATE TRIGGER qrtz_locks_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_LOCKS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

-- triggers for ff4j tables
DROP TRIGGER IF EXISTS ff4j_audit_audit on ff4j.audit;
CREATE TRIGGER ff4j_audit_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.audit FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS ff4j_custom_properties_audit on ff4j.custom_properties;
CREATE TRIGGER ff4j_custom_properties_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.custom_properties FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS ff4j_features_audit on ff4j.features;
CREATE TRIGGER ff4j_features_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.features FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS ff4j_properties_audit on ff4j.properties;
CREATE TRIGGER ff4j_properties_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.properties FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS ff4j_roles_audit on ff4j.roles;
CREATE TRIGGER ff4j_roles_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.roles FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();