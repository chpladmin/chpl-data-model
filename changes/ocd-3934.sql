-- SCHEMA: shared_store

CREATE SCHEMA IF NOT EXISTS shared_store
    AUTHORIZATION openchpl_dev;

GRANT ALL ON SCHEMA shared_store TO openchpl_dev;
GRANT USAGE ON SCHEMA shared_store TO openchpl;

CREATE TABLE IF NOT EXISTS shared_store.shared_store (
	domain TEXT NOT NULL,
	key TEXT NOT NULL,
	value TEXT,
	put_date TIMESTAMP NOT NULL DEFAULT NOW(),
	CONSTRAINT shared_store_pk PRIMARY KEY (domain, key)
);
