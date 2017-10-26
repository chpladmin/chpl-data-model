-- add generated CHPL Product Number into certified_product_details view. It has all the other information needed but has been missing this piece
-- but it is much faster to join on than the certified_product_search (the only other place this field was available).
DROP VIEW IF EXISTS openchpl.certified_product_details CASCADE;
	
DROP TABLE IF EXISTS openchpl.questionable_activity_version;
DROP TABLE IF EXISTS openchpl.questionable_activity_product;
DROP TABLE IF EXISTS openchpl.questionable_activity_developer;
DROP TABLE IF EXISTS openchpl.questionable_activity_listing;
DROP TABLE IF EXISTS openchpl.questionable_activity_certification_result;
DROP TABLE IF EXISTS openchpl.questionable_activity_trigger;
DROP TYPE IF EXISTS openchpl.questionable_activity_trigger_level;

--sort of an enum of the possible objects that can trigger activity
CREATE TYPE openchpl.questionable_activity_trigger_level as enum('Version', 'Product', 'Developer', 'Listing', 'Certification Criteria');

-- a lookup table with all of the things that can trigger questionable activity in the system
CREATE TABLE openchpl.questionable_activity_trigger (
	id bigserial NOT NULL,
	name varchar(500) NOT NULL,
	level openchpl.questionable_activity_trigger_level NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_trigger_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.questionable_activity_version (
	id bigserial NOT NULL,
	questionable_activity_trigger_id bigint NOT NULL,
	version_id bigint NOT NULL,
	before_data text,
	after_data text,
	activity_date timestamp NOT NULL,
	activity_user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_version_pk PRIMARY KEY (id),
	CONSTRAINT version_fk FOREIGN KEY (version_id)
		REFERENCES openchpl.product_version (product_version_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id)
		REFERENCES openchpl.questionable_activity_trigger (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY (activity_user_id)
		REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.questionable_activity_product (
	id bigserial NOT NULL,
	questionable_activity_trigger_id bigint NOT NULL,
	product_id bigint NOT NULL,
	before_data text,
	after_data text,
	activity_date timestamp NOT NULL,
	activity_user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_product_pk PRIMARY KEY (id),
	CONSTRAINT product_fk FOREIGN KEY (product_id)
		REFERENCES openchpl.product (product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id)
		REFERENCES openchpl.questionable_activity_trigger (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY (activity_user_id)
		REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.questionable_activity_developer (
	id bigserial NOT NULL,
	questionable_activity_trigger_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	before_data text,
	after_data text,
	activity_date timestamp NOT NULL,
	activity_user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_developer_ok PRIMARY KEY (id),
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id)
		REFERENCES openchpl.questionable_activity_trigger (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY (activity_user_id)
		REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.questionable_activity_listing (
	id bigserial NOT NULL,
	questionable_activity_trigger_id bigint NOT NULL,
	listing_id bigint NOT NULL,
	before_data text,
	after_data text,
	activity_date timestamp NOT NULL,
	activity_user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_listing_pk PRIMARY KEY (id),
	CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id)
		REFERENCES openchpl.questionable_activity_trigger (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY (activity_user_id)
		REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.questionable_activity_certification_result (
	id bigserial NOT NULL,
	questionable_activity_trigger_id bigint NOT NULL,
	certification_result_id bigint NOT NULL,
	before_data text,
	after_data text,
	activity_date timestamp NOT NULL,
	activity_user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT questionable_activity_certification_result_pk PRIMARY KEY (id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id)
		REFERENCES openchpl.questionable_activity_trigger (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY (activity_user_id)
		REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
VALUES
('Certification Criteria Added', 'Listing', -1),
('Certification Criteria Removed', 'Listing', -1),
('CQM Added', 'Listing', -1),
('CQM Removed', 'Listing', -1),
('Measure Successfully Tested for 170.314 (g)(1) Edited', 'Certification Criteria', -1),
('Measure Successfully Tested for 170.314 (g)(2) Edited', 'Certification Criteria', -1),
('Measures Successfully Tested for 170.315 (g)(1) Added', 'Certification Criteria', -1),
('Measures Successfully Tested for 170.315 (g)(1) Removed', 'Certification Criteria', -1),
('Measures Successfully Tested for 170.315 (g)(2) Added', 'Certification Criteria', -1),
('Measures Successfully Tested for 170.315 (g)(2) Removed', 'Certification Criteria', -1),
('GAP Status Edited', 'Certification Criteria', -1),
('Surveillance Removed', 'Listing', -1),
('2011 Listing Edited', 'Listing', -1),
('Certification Status Edited', 'Listing', -1),
('Developer Name Edited', 'Developer', -1),
('Developer Status Edited', 'Developer', -1),
('Developer Status History Edited', 'Developer', -1),
('Developer Status History Added', 'Developer', -1),
('Developer Status History Removed', 'Developer', -1),
('Product Name Edited', 'Product', -1),
('Product Owner Edited', 'Product', -1),
('Product Owner History Edited', 'Product', -1),
('Product Owner History Added', 'Product', -1),
('Product Owner History Removed', 'Product', -1),
('Version Name Edited', 'Version', -1);


CREATE TRIGGER questionable_activity_trigger_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_trigger FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_trigger_timestamp BEFORE UPDATE on openchpl.questionable_activity_trigger FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_version_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_version_timestamp BEFORE UPDATE on openchpl.questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_product_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_product_timestamp BEFORE UPDATE on openchpl.questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_developer_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_developer_timestamp BEFORE UPDATE on openchpl.questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_listing_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_listing_timestamp BEFORE UPDATE on openchpl.questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER questionable_activity_certification_result_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER questionable_activity_certification_result_timestamp BEFORE UPDATE on openchpl.questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-create views
\i dev/openchpl_views.sql
--re-run grants 
\i dev/openchpl_grant-all.sql
