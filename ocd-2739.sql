-- OCD-2739: removing OBE stuff
-- corrective action plans
drop table if exists openchpl.corrective_action_plan_documentation;
drop table if exists openchpl.corrective_action_plan_certification_result;
drop table if exists openchpl.corrective_action_plan;

-- event types
drop table if exists openchpl.certification_event;
drop table if exists openchpl.event_type;

-- compliance signature
alter table openchpl.user drop column if exists compliance_signature;
