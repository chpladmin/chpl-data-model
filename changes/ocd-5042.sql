ALTER TABLE openchpl.standard ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.standard
SET extension_end_day = '2026-01-31'
WHERE end_day = '2025-12-31';
