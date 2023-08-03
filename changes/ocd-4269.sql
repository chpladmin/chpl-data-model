-- Drop criteria columns that are not useful
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS automated_numerator_capable;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS automated_measure_capable;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS requires_sed;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS parent_criterion_id;

-- Make edition nullable to certified products
ALTER TABLE openchpl.certified_product ALTER COLUMN certification_edition_ID DROP NOT NULL;