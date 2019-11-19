ALTER TABLE openchpl.certification_criterion
DROP COLUMN IF EXISTS removed;

ALTER TABLE openchpl.certification_criterion
ADD COLUMN removed boolean NOT NULL DEFAULT false;