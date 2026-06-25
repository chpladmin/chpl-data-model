-- After HTI-5 the user only has to specify one or the other of UCD Process or freetext details
-- so we need to allow the mapping to UCD Process to be null

ALTER TABLE openchpl.certification_result_ucd_process 
ALTER COLUMN ucd_process_id DROP NOT NULL;
