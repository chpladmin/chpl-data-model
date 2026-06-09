ALTER TABLE openchpl.report_metadata
DROP COLUMN report_key;

UPDATE openchpl.report_metadata
SET title = 'Service Base URL List'
WHERE title = 'Service Base URL List Report';

UPDATE openchpl.report_metadata
SET title = 'Non-conformity Counts'
WHERE title = 'Non-Conformity Counts';

UPDATE openchpl.report_metadata
SET title = 'Real World Testing'
WHERE title = 'Real World Testing Summary';

UPDATE openchpl.report_metadata
SET title = 'Non-conformities'
WHERE title = 'Non-Conformities';