
--********************************************************
--Listing 10869 should have been uploaded as cures = true
--********************************************************/
		
UPDATE openchpl.cures_update_event
SET cures_update = true
WHERE id = 1655;

UPDATE openchpl.cures_update_event
SET deleted = true
WHERE id = 1660;