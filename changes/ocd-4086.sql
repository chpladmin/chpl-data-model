INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Cures Update Designation Removed', 'Listing', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.questionable_activity_trigger
	WHERE name = 'Cures Update Designation Removed'
	and level = 'Listing'
);
