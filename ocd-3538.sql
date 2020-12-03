CREATE INDEX ix_api_key_activity_month_year ON openchpl.api_key_activity (EXTRACT(MONTH FROM creation_date), EXTRACT(YEAR FROM creation_date));

ALTER TABLE audit.logged_actions ALTER COLUMN action_tstamp TYPE timestamp WITHOUT time zone;
CREATE INDEX ix_logged_actions_month_year ON audit.logged_actions (EXTRACT(MONTH FROM action_tstamp), EXTRACT(YEAR FROM action_tstamp));
