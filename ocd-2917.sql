-- Remove all previously entered quarterly reports; they're not valid with the new format
DELETE FROM openchpl.quarterly_report_excluded_listing_map;
DELETE FROM openchpl.quarterly_report;

ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS annual_report_id;
ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS certification_body_id;
ALTER TABLE openchpl.quarterly_report DROP COLUMN IF EXISTS year;

ALTER TABLE openchpl.quarterly_report ADD COLUMN certification_body_id bigint NOT NULL;
ALTER TABLE openchpl.quarterly_report ADD CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT;
ALTER TABLE openchpl.quarterly_report ADD COLUMN year integer NOT NULL;
