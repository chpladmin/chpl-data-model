--
-- Add "No Standard From Group" reason
--
INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'No Standard From Group Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
    SELECT 1
    FROM openchpl.criterion_not_up_to_date_reason
    WHERE name = 'No Standard From Group Attested'
);

--
-- Add column to store standard group name
--
ALTER TABLE openchpl.updated_criterion_status_report ADD COLUMN IF NOT EXISTS standard_group_name text;
