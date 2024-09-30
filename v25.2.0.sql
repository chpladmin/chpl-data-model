-- Deployment file for version 25.2.0
--     as of 2024-09-30
-- ./changes/ocd-4636.sql
ALTER TABLE openchpl.test_task
ADD COLUMN IF NOT EXISTS friendly_id text;

ALTER TABLE openchpl.test_participant
ADD COLUMN IF NOT EXISTS friendly_id text;

-- In the course of testing this, I found that we have some bad data in the system.
-- There are test tasks that are soft-deleted and also referenced by a non-deleted and attested certification result.
-- These test tasks should NOT be soft-deleted.
-- In at least the one case I investigated, the erroneous soft-delete occurred when a listing changed from b3-original to b3-cures
-- on Dec 30, 2022 and moved the test task from one criterion to the other.
-- This SQL correctly sets the test tasks back to non-deleted.
-- There were 198 test tasks in this state. 
update openchpl.test_task tt
set deleted = false
from  openchpl.certification_result_test_task crtt 
join openchpl.certification_result cr on cr.certification_result_id = crtt.certification_result_id
where crtt.test_task_id = tt.test_task_id
and tt.deleted = true
and crtt.deleted = false
and cr.success = true
;
-- ./changes/ocd-4653.sql
-- view changes 
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.2.0', '2024-09-30', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
