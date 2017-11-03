--
-- questionable activity stuff
--

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


--
-- Add new upload template
--
INSERT INTO openchpl.upload_template_version (name, available_as_of_date, header_csv, last_modified_user)
SELECT 'New 2014 CHPL Upload Template v11',
    '2017-11-06',
    'UNIQUE_CHPL_ID__C,RECORD_STATUS__C,PRACTICE_SETTING__C,VENDOR__C,PRODUCT__C,VERSION__C,CERT_YEAR__C,ACB_CERTIFICATION_ID__C,CERTIFYING_ACB__C,TESTING_ATL__C,Product Classification,CERTIFICATION_DATE__C,VENDOR_STREET_ADDRESS__C,VENDOR_STATE__C,VENDOR_CITY__C,VENDOR_ZIP__C,VENDOR_WEBSITE__C,VENDOR_EMAIL__C,VENDOR_PHONE__C,VENDOR_CONTACT_NAME__C,Test Results Summary URL,SED Report Hyperlink,QMS,QMS Standard,QMS Modification Description,ICS,170.523(k)(1) URL,170.523(k)(2) ATTESTATION,CQM Number,CQM Version,CRITERIA_170_314_A_1__C,GAP,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_2__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_3__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_A_4__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_A_5__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_A_6__C,GAP,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_7__C,GAP,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_8__C,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test procedure version,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_9__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_A_10__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_A_11__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_12__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_13__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_14__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_15__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_16__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_17__C,GAP,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_A_18__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_19__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_A_20__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_B_1__C,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_2__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_3__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_B_4__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_B_5A__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_5B__C,GAP,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_6__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_7__C,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_8__C,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_B_9__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,SED,UCD Process Selected,UCD Process Details,CRITERIA_170_314_C_1__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_C_2__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_C_3__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_D_1__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_2__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_3__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_4__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_5__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_6__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_7__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_8__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_D_9__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_E_1__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_E_2__C,Standard tested against,Functionality tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_E_3__C,Standard tested against,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_F_1__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_2__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_3__C,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_4__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_5__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_6__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_F_7__C,GAP,Standard tested against,Functionality tested,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_G_1__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_G_2__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_G_3__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_G_4__C,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test procedure version,CRITERIA_170_314_H_1__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_H_2__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_314_H_3__C,GAP,Standard tested against,Additional Software,CP Source,Non CP Source,Version,Test tool name,Test tool version,Test procedure version,Test data version,Test data alteration,Test data alteration description'
    , -1
WHERE NOT EXISTS (SELECT * FROM openchpl.upload_template_version WHERE name='New 2014 CHPL Upload Template v11');
UPDATE openchpl.upload_template_version SET name='New 2014 CHPL Upload Template v10' WHERE name = 'New 2014 CHPL Upload Template';
UPDATE openchpl.upload_template_version SET deprecated = true where name='New 2014 CHPL Upload Template v10';

-- add generated CHPL Product Number into certified_product_details view which will get put in at the end when the views are all re-created.
-- That view has all the other information needed but has been missing the generated CHPL Product Number.
-- It is much faster to join on the details view than the certified_product_search (the only other place this field was available).
DROP VIEW IF EXISTS openchpl.certified_product_details CASCADE;

--re-create views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql
