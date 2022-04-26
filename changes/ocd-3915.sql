
--********************************************************
-- Listing 10850 had an update that removed it's Cures Update designation. 
-- The update should have left cures update = true.
--********************************************************/
DELETE FROM openchpl.cures_update_event
WHERE id = 1645;

DELETE FROM openchpl.cures_update_event
WHERE id = 1658;
		
--********************************************************
--Listing 10861 should have been uploaded as cures = true
--********************************************************/
		
UPDATE openchpl.cures_update_event
SET cures_update = true
WHERE id = 1646;

DELETE FROM openchpl.cures_update_event
WHERE id = 1659;

--********************************************************
--Listing 10869 should have been uploaded as cures = true
--********************************************************/
		
UPDATE openchpl.cures_update_event
SET cures_update = true
WHERE id = 1655;

DELETE FROM openchpl.cures_update_event
WHERE id = 1660;