ALTER TABLE openchpl.macra_criteria_map
DROP COLUMN IF EXISTS removed;

ALTER TABLE openchpl.macra_criteria_map
ADD COLUMN removed boolean NOT NULL DEFAULT false;

UPDATE openchpl.macra_criteria_map
SET removed = true
WHERE value = 'RT13 EH/CAH Stage 3';