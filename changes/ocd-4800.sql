ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS ics_surveillance_summary text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS developer_complaints_log_review text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS post_certification_performance text;

ALTER TABLE openchpl.quarterly_report
ADD COLUMN IF NOT EXISTS appropriate_design_mark_use text;

ALTER TABLE openchpl.quarterly_report_surveillance_map
ADD COLUMN IF NOT EXISTS surveillance_findings text;
