UPDATE openchpl.report_metadata
SET title = 'Direct Review Activities', height = '350px'
WHERE title = 'Direct Review Non-conformities'
AND report_group = 'onc-dashboard';
