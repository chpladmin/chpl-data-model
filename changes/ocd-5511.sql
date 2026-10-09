UPDATE openchpl.report_metadata
SET title = 'Direct Review Activities'
WHERE title = 'Direct Review Non-conformities'
AND report_group = 'onc-dashboard';

-- TODO will also likely need to update the height
