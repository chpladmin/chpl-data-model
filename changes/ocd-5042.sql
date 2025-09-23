--
-- standards
--
ALTER TABLE openchpl.standard ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.standard
SET extension_end_day = '2026-02-01'
WHERE required_day = '2025-12-31';

--
-- code sets
--
ALTER TABLE openchpl.code_set ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.code_set
SET extension_end_day = '2026-02-01'
WHERE required_day = '2025-12-31';

--
-- functionality tested
--
ALTER TABLE openchpl.functionality_tested ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.functionality_tested
SET extension_end_day = '2026-02-01'
WHERE required_day = '2025-12-31';
