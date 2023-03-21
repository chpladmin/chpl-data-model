-- Add activity ID columns to all questionable activity tables

ALTER TABLE openchpl.questionable_activity_certification_result
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_certification_result
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_certification_result 
ADD CONSTRAINT activity_to_questionable_activity_certification_result_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_developer
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_developer
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_developer 
ADD CONSTRAINT activity_to_questionable_activity_developer_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_listing
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_listing
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_listing 
ADD CONSTRAINT activity_to_questionable_activity_listing_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_product
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_product
ADD COLUMN activity_id bigint; 

ALTER TABLE openchpl.questionable_activity_product 
ADD CONSTRAINT activity_to_questionable_activity_product_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_version
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_version
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_version 
ADD CONSTRAINT activity_to_questionable_activity_version_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

-- Rename trigger to be more specific and correct.
-- It is detecting when the date associated with the current certification status changes.
-- This may not be the Certification Date (if the current certification status it not 'Active')
-- but the current "name" reads as though it is the Certification Date that is being changed.
UPDATE openchpl.questionable_activity_trigger
SET name = 'Current Certification Status Date Edited'
WHERE name = 'Current Certification Date Edited'; 

UPDATE openchpl.questionable_activity_trigger
SET name = 'Current Certification Status Date Edited'
WHERE name = 'Current Certification Date Edited'; 

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
	SELECT 'Certification Date Edited', 'Listing', -1
	WHERE NOT EXISTS 
		(SELECT * FROM openchpl.questionable_activity_trigger 
		WHERE name = 'Certification Date Edited' 
		AND level = 'Listing');
		
-- Add reason column to activity table 
ALTER TABLE openchpl.activity
DROP COLUMN IF EXISTS reason;

ALTER TABLE openchpl.activity
ADD COLUMN reason text;