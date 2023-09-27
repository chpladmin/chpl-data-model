DROP VIEW openchpl.requirement_type;
DROP VIEW openchpl.nonconformity_type;

ALTER TABLE openchpl.certification_criterion
DROP COLUMN IF EXISTS removed;
