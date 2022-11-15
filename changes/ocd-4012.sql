drop table if exists openchpl.surveillance_nonconformity_document;

delete from openchpl.questionable_activity_trigger where name = 'Removed Non-Conformity added to Surveillance';
delete from openchpl.questionable_activity_trigger where name = 'Removed Requirement added to Surveillance';
