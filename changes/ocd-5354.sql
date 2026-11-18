-- update height of Listing Attributes because of measures removal
UPDATE openchpl.report_metadata
SET height = '750px'
WHERE title = 'Listing Attributes'
AND report_group = 'charts';
