-- SCHEMA: shared_data

CREATE SCHEMA IF NOT EXISTS shared_data
    AUTHORIZATION openchpl_dev;
	
GRANT ALL ON SCHEMA shared_data TO openchpl_dev;
GRANT USAGE ON SCHEMA shared_data TO openchpl;

CREATE TABLE IF NOT EXISTS shared_data.shared_data (
	type TEXT NOT NULL,
	key TEXT NOT NULL,
	value TEXT,
	put_date TIMESTAMP NOT NULL DEFAULT NOW()
	PRIMARY KEY(type, key)
);
