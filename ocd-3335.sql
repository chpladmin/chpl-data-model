DROP TRIGGER IF EXISTS complainant_type_audit on openchpl.complainant_type;
CREATE TRIGGER complainant_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS complainant_type_timestamp on openchpl.complainant_type;
CREATE TRIGGER complainant_type_timestamp BEFORE UPDATE on openchpl.complainant_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TRIGGER IF EXISTS cures_update_event_audit on openchpl.cures_update_event;
CREATE TRIGGER cures_update_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_update_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

DROP TRIGGER IF EXISTS cures_update_event_timestamp on openchpl.cures_update_event;
CREATE TRIGGER cures_update_event_timestamp AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_update_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();