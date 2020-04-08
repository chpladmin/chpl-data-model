-- Deployment file for version 19.2.0
--     as of 2020-04-08
-- ocd-3252.sql
DROP TABLE IF EXISTS openchpl.cures_update_event CASCADE;
CREATE TABLE openchpl.cures_update_event (
        id bigserial NOT NULL,
       	cures_update boolean NOT NULL DEFAULT false,
	certified_product_id bigint NOT NULL,
	event_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cures_update_event_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id) REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);
;
-- ocd-3292.sql
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria added for new listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria added for new listing');
    
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria added for existing listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria added for existing listing');

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria changed to ICS', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria changed to ICS');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.2.0', '2020-04-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
