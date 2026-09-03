UPDATE openchpl.report_metadata
SET title = 'Surveillance Non-conformities'
WHERE title = 'Non-conformities'
AND report_group = 'onc-dashboard';
