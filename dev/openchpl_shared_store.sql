-- SCHEMA: shared_data

CREATE SCHEMA shared_store
    AUTHORIZATION openchpl_dev;

GRANT ALL ON SCHEMA shared_store TO openchpl_dev;
GRANT USAGE ON SCHEMA shared_store TO openchpl;

CREATE TABLE shared_store.shared_store (
	type TEXT NOT NULL,
	key TEXT NOT NULL,
	value TEXT,
	put_date TIMESTAMP NOT NULL DEFAULT NOW()
	PRIMARY KEY(type, key)
);
