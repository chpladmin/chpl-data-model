CREATE TRIGGER qrtz_job_details_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_JOB_DETAILS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_simple_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_SIMPLE_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_cron_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_CRON_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_simprop_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_SIMPROP_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_blob_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_BLOB_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_calendars_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_CALENDARS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_paused_trigger_grps_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_PAUSED_TRIGGER_GRPS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_fired_triggers_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_FIRED_TRIGGERS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER qrtz_locks_audit AFTER INSERT OR UPDATE OR DELETE on quartz.QRTZ_LOCKS FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
--not adding a trigger for quartz.QRTZ_SCHEDULER_STATE because it creates an entry every couple seconds to update the "last checkin time"
