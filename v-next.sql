------------------------------------------------------------
-- OCD-1433 - Find any current products that have bad values
------------------------------------------------------------
DO $$
BEGIN
raise notice 'Updating openchpl.certification_result and openchpl.pending_certification_result to remove whitespace from privacy_security_framework';
END; 
$$;

-- remove leading and trailing whitespace from privacy_security_framework
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;

BEGIN;
UPDATE openchpl.pending_certification_result 
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;

-- update comma to semicolon
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, ',', ';');
END;

BEGIN;
UPDATE openchpl.pending_certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, ',', ';');
END;

-- remove space after semicolon
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, '; ', ';');
END;

BEGIN;
UPDATE openchpl.pending_certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, '; ', ';');
END;

---------------------- certified products with bad data

DO $$
BEGIN
raise notice 'The following certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT cr.certified_product_id, cc.number, cr.privacy_security_framework
FROM openchpl.certification_result cr
LEFT JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
WHERE cr.privacy_security_framework IS NOT NULL
AND cr.privacy_security_framework <> ''
AND REPLACE(cr.privacy_security_framework, ' ', '') NOT IN ('Approach1', 'Approach2', 'Approach1;Approach2', 'Approach1,Approach2');

---------------------- pending products with bad data
DO $$
BEGIN
raise notice 'The following pending_certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT pr.pending_certified_product_id, cc.number, pr.privacy_security_framework
FROM openchpl.pending_certification_result pr
LEFT JOIN openchpl.certification_criterion cc ON pr.certification_criterion_id = cc.certification_criterion_id
WHERE pr.privacy_security_framework IS NOT NULL 
AND pr.privacy_security_framework <> ''
AND REPLACE(pr.privacy_security_framework, ' ', '') NOT IN ('Approach1', 'Approach2', 'Approach1;Approach2', 'Approach1,Approach2');

------------------------------------------------------------
-- OCD-1443 - Update values for CQMs with typos
------------------------------------------------------------
BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication'
WHERE title = 'ADHD: Follow-Up Care for Children Prescribed AttentionDeficit/Hyperactivi ty Disorder (ADHD) Medication';
END; 

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Functional Status Assessment for Total Hip Replacement'
WHERE title = 'Functional Status Assessment for Hip Replacemen';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Heart Failure (HF): Beta-Blocker Therapy for Left Ventricular Systolic Dysfunction (LVSD)'
WHERE title = 'Heart Failure (HF): BetaBlocker Therapy for Left Ventricular Systolic Dysfunction (LVSD)';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Heart Failure (HF): Angiotensin-Converting Enzyme (ACE) Inhibitor or Angiotensin Receptor Blocker (ARB) Therapy for Left Ventricular Systolic Dysfunction (LVSD)'
WHERE title = 'Heart Failure (HF): AngiotensinConverting Enzyme (ACE) Inhibitor or Angiotensin Receptor Blocker (ARB) Therapy for Left Ventricular Systolic Dysfunction (LVSD)';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Incidence of Potentially-Preventable Venous Thromboembolism'
WHERE title = 'Incidence of PotentiallyPreventable Venous Thromboembolism';
END;

------------------------------------------------------------
-- OCD-1448 - Add tables for notification subscriptions
------------------------------------------------------------
--types of reports in the system
DROP TABLE IF EXISTS openchpl.notification_type CASCADE;

CREATE TABLE openchpl.notification_type(
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	description varchar(1024),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT notification_type_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.notification_type (name, description, last_modified_user)
VALUES ('ACB Daily Surveillance Broken Rules', 'A daily email of surveillance rules that have been broken within the last day for listings certified by a specific ACB.', -1), 
('ACB Weekly Surveillance Broken Rules', 'A weekly email of all surveillance rules that are currently broken for listings certified by a specific ACB.', -1),
('ONC Daily Surveillance Broken Rules', 'A daily email of surveillance rules that have been broken within the last day for any listing.', -1), 
('ONC Weekly Surveillance Broken Rules', 'A weekly email of all surveillance rules that are currently broken for any listing.', -1);

CREATE TRIGGER notification_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.notification_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER notification_type_timestamp BEFORE UPDATE on openchpl.notification_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TABLE IF EXISTS openchpl.notification_type_permission;
CREATE TABLE openchpl.notification_type_permission(
	id bigserial NOT NULL,
	notification_type_id bigint NOT NULL,
	permission_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT notification_type_permission_pk PRIMARY KEY (id),
	CONSTRAINT notification_type_fk FOREIGN KEY (notification_type_id)
      REFERENCES openchpl.notification_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT permission_fk FOREIGN KEY (permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);

INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ACB Daily Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, 2, -1 FROM openchpl.notification_type WHERE name = 'ACB Daily Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ACB Weekly Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, 2, -1 FROM openchpl.notification_type WHERE name = 'ACB Weekly Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ONC Daily Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user) 
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ONC Weekly Surveillance Broken Rules';

CREATE TRIGGER notification_type_permission_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.notification_type_permission FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER notification_type_permission_timestamp BEFORE UPDATE on openchpl.notification_type_permission FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- email addresses that may receive reports
DROP TABLE IF EXISTS openchpl.notification_recipient CASCADE;

CREATE TABLE openchpl.notification_recipient(
	id bigserial NOT NULL,
	email varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT notification_recipient_pk PRIMARY KEY (id)
);

CREATE TRIGGER notification_recipient_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.notification_recipient FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER notification_recipient_timestamp BEFORE UPDATE on openchpl.notification_recipient FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- mapping of report recipients to report types with optional acb restriction
DROP TABLE IF EXISTS openchpl.notification_type_recipient_map CASCADE;

CREATE TABLE openchpl.notification_type_recipient_map(
	id bigserial NOT NULL,
	recipient_id bigint NOT NULL,
	notification_type_id bigint NOT NULL,
	acb_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT notification_type_recipient_map_pk PRIMARY KEY (id),
	CONSTRAINT recipient_fk FOREIGN KEY (recipient_id)
      REFERENCES openchpl.notification_recipient (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT notification_type_fk FOREIGN KEY (notification_type_id)
      REFERENCES openchpl.notification_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT acb_fk FOREIGN KEY (acb_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER notification_type_recipient_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.notification_type_recipient_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER notification_type_recipient_map_timestamp BEFORE UPDATE on openchpl.notification_type_recipient_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

GRANT ALL ON ALL TABLES IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL TABLES IN SCHEMA audit TO openchpl;
GRANT ALL ON ALL SEQUENCES IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL SEQUENCES IN SCHEMA audit TO openchpl;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA audit TO openchpl;