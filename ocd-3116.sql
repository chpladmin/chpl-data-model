alter table openchpl.complaint
drop column if exists complaint_status_type_id;

drop table if exists openchpl.complaint_status_type cascade;
