
--THIS SCRIPT WILL TAKE A LONG TIME TO RUN!!

--Change datatype so that the column can be indexed on month and year
ALTER TABLE audit.logged_actions ALTER COLUMN action_tstamp TYPE timestamp WITHOUT time zone;

--Add indexes on month and year to help with performance
CREATE INDEX IF NOT EXISTS ix_api_key_activity_month_year ON openchpl.api_key_activity (EXTRACT(MONTH FROM creation_date), EXTRACT(YEAR FROM creation_date));
CREATE INDEX IF NOT EXISTS ix_logged_actions_month_year ON audit.logged_actions (EXTRACT(MONTH FROM action_tstamp), EXTRACT(YEAR FROM action_tstamp));
