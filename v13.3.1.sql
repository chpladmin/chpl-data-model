update openchpl.questionable_activity_trigger set name = 'Current Certification Status Edited' where name = 'Certification Status Edited';
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user) select 'Current Certification Date Edited', 'Listing', -1 where not exists (select * from openchpl.questionable_activity_trigger where name = 'Current Certification Date Edited');
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user) select 'Historical Certification Status Edited', 'Listing', -1 where not exists (select * from openchpl.questionable_activity_trigger where name = 'Historical Certification Status Edited');

--
-- OCD-1989
--
update openchpl.upload_template_version set deleted = true where name = '2015 CHPL Upload Template v11';
