CREATE INDEX ix_api_key_activity_month_year ON openchpl.api_key_activity (EXTRACT(MONTH FROM creation_date), EXTRACT(YEAR FROM creation_date));

