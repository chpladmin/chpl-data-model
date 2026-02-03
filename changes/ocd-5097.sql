--
-- Remove all calculated updated criteria status data from before the ticket OCD-5059
-- was deployed to prod and the first overnight calculation job ran after that deployment.
-- The calculated data was not entirely correct up until that ticket was deployed to production.
--
DELETE FROM openchpl.updated_criterion_status_report
WHERE report_day < '2025-12-23';
