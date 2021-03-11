-- Undelete summary stats for use in the new PDF
UPDATE openchpl.summary_statistics
SET deleted = false
WHERE end_date > '2021-01-01'::date;

