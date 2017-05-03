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
	requires_acb boolean NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT notification_type_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.notification_type (name, description, requires_acb, last_modified_user)
VALUES ('ONC-ACB Daily Surveillance Broken Rules', 'A daily email of surveillance rules that have been broken within the last day for listings certified by a specific ONC-ACB.', true, -1), 
('ONC-ACB Weekly Surveillance Broken Rules', 'A weekly email of all surveillance rules that are currently broken for listings certified by a specific ONC-ACB.', true, -1),
('ONC Daily Surveillance Broken Rules', 'A daily email of surveillance rules that have been broken within the last day for any listing.', false, -1), 
('ONC Weekly Surveillance Broken Rules', 'A weekly email of all surveillance rules that are currently broken for any listing.', false, -1);

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
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ONC-ACB Daily Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, 2, -1 FROM openchpl.notification_type WHERE name = 'ONC-ACB Daily Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, -2, -1 FROM openchpl.notification_type WHERE name = 'ONC-ACB Weekly Surveillance Broken Rules';
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
SELECT id, 2, -1 FROM openchpl.notification_type WHERE name = 'ONC-ACB Weekly Surveillance Broken Rules';
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


------------------------------------------------------------
-- OCD-746: add edition reference to test functionality
------------------------------------------------------------
ALTER TABLE openchpl.test_functionality
DROP COLUMN IF EXISTS certification_edition_id;

ALTER TABLE openchpl.test_functionality 
ADD COLUMN certification_edition_id bigint;

--fill in all certification edition ids for existing test functionality
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(4)(iii)' and name = 'Optional: 170.314(a)(4)(iii) Plot and electronically display, upon request, growth charts for patients';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(1)(i)(B)' and name = 'Optional: 170.314(b)(1)(i)(B) Receive summary care record using the standards specified at §170.202(a) and (b) (Direct and XDM Validation)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(1)(i)(C)' and name = 'Optional: 170.314(b)(1)(i)(C) Receive summary care record using the standards specified at §170.202(b) and (c) (SOAP Protocols)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(f)(3)(i)(B)' and name = 'Optional: 170.314(f)(3)(i)(B) Create syndrome-based public health surveillance information for transmission using the standard specified at §170.205(d)(3) (urgent care visit scenario)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(f)(7)(i)' and name = 'Optional: (f)(7)(i) EHR technology must be able to electronically create syndrome-based public health surveillance information for electronic transmission that contains the following data: (A) Patient demographics; (B) Provider specialty; (C) Provider address; (D) Problem list; (E) Vital signs; (F) Laboratory test values/results; (G) Procedures; (H) Medication list; and (I) Insurance';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(5)(i)' and name = 'Ambulatory setting: 170.314(a)(5)(i) Over multiple encounters in accordance with, at a minimum, the version of the standard specified in §170.207(a)(3)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(6)(i)' and name = 'Ambulatory setting: 170.314(a)(6)(i) Over multiple encounters';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(7)(i)' and name = 'Ambulatory setting: 170.314(a)(7)(i) Over multiple encounters';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(8)(iii)(B)(3)' and name = 'Ambulatory setting: 170.314(a)(8)(iii)(B)(3) When a patient''s laboratory tests and values/results are incorporated pursuant to paragraph (b)(5)(i)(A)(1) of this section';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(14)(vi)' and name = 'Ambulatory setting: 170.314(a)(14)(vi) Patient communication preferences';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(2)(i)(E)' and name = 'Ambulatory setting: 170.314(b)(2)(i)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(7)(v)' and name = 'Ambulatory setting: 170.314(b)(7)(v) The reason for referral; and referring or transitioning provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(8)(iii)(E)' and name = 'Ambulatory setting: 170.314(b)(8)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(A)(2)' and name = 'Ambulatory setting: 170.314(e)(1)(i)(A)(2) Provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(B)(1)(i)' and name = 'Ambulatory setting: 170.314(e)(1)(i)(B)(1)(i) All of the data in the Common MU Data Set (which should be in their English (i.e., noncoded) representation if they associate with a vocabulary/code set) and the Provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(f)(3)(i)' and name = 'Ambulatory setting: 170.314(f)(3)(i) (A) The standard specified in §170.205(d)(2). (B) Optional. The standard (and applicable implementation specifications) specified in §170.205(d)(3)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(5)(ii)' and name = 'Inpatient setting: 170.314(a)(5)(ii) For the duration of an entire hospitalization in accordance with, at a minimum, the version of the standard specified in §170.207(a)(3)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(6)(ii)' and name = 'Inpatient setting: 170.314(a)(6)(ii) For the duration of an entire hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(a)(7)(ii)' and name = 'Inpatient setting: 170.314(a)(7)(ii) For the duration of an entire hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(2)(i)(F)' and name = 'Inpatient setting: 170.314(b)(2)(i)(F) Discharge instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(7)(vi)' and name = 'Inpatient setting: 170.314(b)(7)(vi) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(b)(8)(iii)(F)' and name = 'Inpatient setting: 170.314(b)(8)(iii)(F) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(A)(3)' and name = 'Inpatient setting: 170.314(e)(1)(i)(A)(3) Admission and discharge dates and locations; discharge instructions; and reason(s) for hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(B)(1)(ii)' and name = 'Inpatient setting: 170.314(e)(1)(i)(B)(1)(ii) All of the data in the Common MU Data Set (which should be in their English (i.e., noncoded) representation if they associate with a vocabulary/code set) and the admission and discharge dates and locations; discharge instructions; and reason(s) for hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(B)(2)' and name = 'Inpatient setting: 170.314(e)(1)(i)(B)(2) Electronically download transition of care/referral summaries that were created as a result of a transition of care (pursuant to the capability expressed in the certification criterion adopted at paragraph (b)(2) of this section)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(e)(1)(i)(C)(2)' and name = 'Inpatient setting: 170.314(e)(1)(i)(C)(2) Electronically transmit transition of care/referral summaries (as a result of a transition of care/referral) selected by the patient (or their authorized representative) in accordance with at least one of the following: (i) The standard specified in §170.202(a). (ii) Through a method that conforms to the standard specified at §170.202(d) and that leads to such summary being processed by a service that has implemented the standard specified in §170.202(a)';
UPDATE openchpl.test_functionality SET certification_edition_id = 2 WHERE number = '(f)(3)(ii)' and name = 'Inpatient setting: 170.314(f)(3)(ii)  The standard (and applicable implementation specifications) specified in §170.205(d)(3)';

--2015
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(4)(ii)(B)(1)' and name = 'Alternative: 170.315(a)(4)(ii)(B)(1) To a specific set of identified users';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(4)(ii)(B)(2)' and name = 'Alternative: 170.315(a)(4)(ii)(B)(2) As a system administrative function';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(10)(i)' and name = 'Alternative: 170.315(a)(10)(i) Drug formulary checks. Automatically check whether a drug formulary exists for a given patient and medication';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(10)(ii)' and name = 'Alternative: 170.315(a)(10)(ii)  Preferred drug list checks. Automatically check whether a preferred drug list exists for a given patient and medication';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(14)(iii)(A)(1)' and name = 'Alternative: 170.315(a)(14)(iii)(A)(1) The "GMDN PT Name" attribute associated with the Device Identifier in the Global Unique Device Identification Database';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(14)(iii)(A)(2)' and name = 'Alternative: 170.315(a)(14)(iii)(A)(2) The "SNOMED CT Description" mapped to the attribute referenced in (a)(14)(iii)(1) (The "GMDN PT Name" attribute associated with the Device Identifier in the Global Unique Device Identification Database)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(1)(ii)(A)(5)(i)' and name = 'Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(1)(ii)(A)(5)(ii)' and name = 'Alternative: 170.315(b)(1)(ii)(A)(5)(ii) Review the errors produced';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(5)(ii)(A)(5)(i)' and name = 'Alternative: 170.315(b)(5)(ii)(A)(5)(i) Be notified of the errors produced';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(5)(ii)(A)(5)(ii)' and name = 'Alternative: 170.315(b)(5)(ii)(A)(5)(ii) Review the errors produced';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(6)(i)(B)(1)' and name = 'Alternative: 170.315(b)(6)(i)(B)(1) To a specific set of identified users';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(6)(i)(B)(2)' and name = 'Alternative: 170.315(b)(6)(i)(B)(2) As a system administrative function';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(d)(7)(i)' and name = 'Alternative: 170.315(d)(7)(i) Technology that is designed to locally store electronic health information on end-user devices must encrypt the electronic health information stored on such devices after use of the technology on those devices stops';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(d)(7)(ii)' and name = 'Alternative: 170.315(d)(7)(ii) Technology is designed to prevent electronic health information from being locally stored on end-user devices after use of the technology on those devices stops';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(d)(9)(i)' and name = 'Alternative: 170.315(d)(9)(i) Message-level. Encrypt and integrity protect message contents in accordance with the standards specified in § 170.210(a)(2) and (c)(2)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(d)(9)(ii)' and name = 'Alternative: 170.315(d)(9)(ii) Transport-level. Use a trusted connection in accordance with the standards specified in § 170.210(a)(2) and (c)(2)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(g)(4)(i)(A)' and name = 'Alternative: 170.315(g)(4)(i)(A) The QMS used is established by the Federal government or a standards developing organization';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(g)(4)(i)(B)' and name = 'Alternative: 170.315(g)(4)(i)(B) The QMS used is mapped to one or more QMS established by the Federal government or standards developing organization(s)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(g)(5)(i)' and name = 'Alternative: 170.315(g)(5)(i) When a single accessibility-centered design standard or law was used for applicable capabilities, it would only need to be identified once';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(g)(5)(ii)' and name = 'Alternative: 170.315(g)(5)(ii) When different accessibility-centered design standards and laws were applied to specific capabilities, each accessibility-centered design standard or law applied would need to be identified. This would include the application of an accessibility-centered design standard or law to some capabilities and none to others';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(g)(5)(iii)' and name = 'Alternative: 170.315(g)(5)(iii) When no accessibility-centered design standard or law was applied to all applicable capabilities such a response is acceptable to satisfy this certification criterion';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(1)(ii)' and name = 'Optional: 170.315(a)(1)(ii)  Include a "reason for order" field';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(2)(ii)' and name = 'Optional: 170.315(a)(2)(ii) Include a "reason for order" field';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(3)(ii)' and name = 'Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(13)(ii)' and name = 'Optional: 170.315(a)(13)(ii) Request that patient-specific education resources be identified in accordance with the standard in § 170.207(g)(2)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(1)(iii)(G)(1)(ii)' and name = 'Optional: 170.315(b)(1)(iii)(G)(1)(ii) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(3)(iii)' and name = 'Optional: 170.315(b)(3)(iii) For each transaction listed in paragraph (b)(3)(i) of this section, the technology must be able to receive and transmit the reason for the prescription using the indication elements in the SIG Segment';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(4)(vii)(A)(2)' and name = 'Optional: 170.315(b)(4)(vii)(A)(2) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(c)(3)(ii)' and name = 'Optional: 170.315(c)(3)(ii) That can be electronically accepted by CMS';

--can't get a match when including 'name' criteria, i think a smartquotes issue but can't figure it out??
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '170.102(13)(ii)(C)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '170.102(19)(i)' and name = 'Optional: Common Clinical Data Set 170.102(19)(i) For certification to the 2015 Edition health IT certification criteria in accordance with the "Assessment and Plan Section (V2)" of the standard specified in § 170.205(a)(4);';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '170.102(19)(ii)' and name = 'Optional: Common Clincial Data Set 170.102(19)(ii)  For certification to the 2015 Edition health IT certification criteria in accordance with the "Assessment Section (V2)" and "Plan of Treatment Section (V2)" of the standard specified in § 170.205(a)(4). ';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(6)(i)' and name = 'Ambulatory: 170.315(a)(6)(i) Over multiple encounters in accordance with, at a minimum, the version of the standard specified in § 170.207(a)(4)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(7)(i)' and name = 'Ambulatory: 170.315(a)(7)(i) Over multiple encounters';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(8)(i)' and name = 'Ambulatory: 170.315(a)(8)(i) Over multiple encounters';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(1)(iii)(E)' and name = 'Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(4)(v)' and name = 'Ambulatory: 170.315(b)(4)(v) The reason for referral; and referring or transitioning provider''s name and office contact information';

UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(5)(i)(E)' and name = 'Ambulatory: 170.315(b)(5)(i)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';

UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(6)(ii)(E)' and name = 'Ambulatory: 170.315(b)(6)(ii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(A)(2)' and name = 'Ambulatory: 170.315(e)(1)(i)(A)(2) Provider''s name and office contact information';

--cannot get to work with name criteria, suspect newlines?? there is only one with this number though
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(B)(2)(i)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(5)(ii)' and name = 'Inpatient: 170.315(a)(5)(ii) Enable a user to record, change, and access the preliminary cause of death and date of death in the event of mortality';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(6)(ii)' and name = 'Inpatient: 170.315(a)(6)(ii) For the duration of an entire hospitalization in accordance with, at a minimum, the version of the standard specified in §170.207(a)(4)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(7)(ii)' and name = 'Inpatient: 170.315(a)(7)(ii) For the duration of an entire hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(a)(8)(ii)' and name = 'Inpatient: 170.315(a)(8)(ii) For the duration of an entire hospitalization';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(1)(iii)(F)' and name = 'Inpatient: 170.315(b)(1)(iii)(F) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(4)(vi)' and name = 'Inpatient: 170.315(b)(4)(vi) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(5)(i)(F)' and name = 'Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(b)(6)(ii)(F)' and name = 'Inpatient: 170.315(b)(6)(ii)(F) Discharge Instructions';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(A)(3)' and name = 'Inpatient: 170.315(e)(1)(i)(A)(3) Admission and discharge dates and locations; discharge instructions; and reason(s) for hospitalization';

--cannot get to work with name criteria, suspect newlines?? there is only one with this number though
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(B)(2)(ii)';
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(B)(3)' and name = 'Inpatient: 170.315(e)(1)(i)(B)(3) Patients (and their authorized representatives) must be able to download transition of care/referral summaries that were created as a result of a transition of care (pursuant to the capability expressed in the certification criterion specified in paragraph (b)(1) of this section)';

--cannot get to work with name criteria, suspect newlines?? there are two with this number but 2014 certification_edition_id gets filled first
UPDATE openchpl.test_functionality SET certification_edition_id = 3 WHERE number = '(e)(1)(i)(C)(2)' and certification_edition_id is null;


SELECT count(*)||' test functionality is/are left without certification_edition_id'
FROM openchpl.test_functionality
WHERE certification_edition_id IS NULL;

-- set column to not allow null
ALTER TABLE openchpl.test_functionality 
ALTER COLUMN certification_edition_id SET NOT NULL;

CREATE OR REPLACE FUNCTION openchpl.fixTestFunctionality() RETURNS VOID AS $$
DECLARE
	mismatchCount integer;
    mismatch RECORD;
    testFuncId bigint;
	
    BEGIN
	
		--get the records where listing edition does not match test func edition
		SELECT INTO mismatchCount result
		FROM
		(SELECT count(*) as result
		FROM openchpl.certification_result_test_functionality crtf
		JOIN openchpl.test_functionality tf ON crtf.test_functionality_id = tf.test_functionality_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crtf.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != tf.certification_edition_id) innerQuery;
		
		raise notice '# criteria with test functionality certification edition mismatches BEFORE update: %', mismatchCount;
	
		FOR mismatch IN 
		(SELECT distinct cp.certified_product_id, cr.certification_result_id, crtf.certification_result_test_functionality_id, 
			tf.number as test_func_number, 
			cp.certification_edition_id as listing_edition, 
			tf.certification_edition_id as criteria_edition
		FROM openchpl.certification_result_test_functionality crtf
		JOIN openchpl.test_functionality tf ON crtf.test_functionality_id = tf.test_functionality_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crtf.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != tf.certification_edition_id)
		LOOP
				-- look up test func id for listing edition and same test func number
				SELECT INTO testFuncId result
				FROM
				(SELECT test_functionality_id as result
				FROM openchpl.test_functionality
				WHERE number = mismatch.test_func_number
				AND certification_edition_id = mismatch.listing_edition) innerQuery;
				
				--update certification_result_test_functionality to point to correct test func id
				UPDATE openchpl.certification_result_test_functionality
				SET test_functionality_id = testFuncId
				WHERE certification_result_test_functionality_id = mismatch.certification_result_test_functionality_id;
				
		END LOOP;
		
		SELECT INTO mismatchCount result
		FROM
		(SELECT count(*) as result
		FROM openchpl.certification_result_test_functionality crtf
		JOIN openchpl.test_functionality tf ON crtf.test_functionality_id = tf.test_functionality_id
		JOIN openchpl.certification_result cr ON cr.certification_result_id = crtf.certification_result_id
		JOIN openchpl.certified_product cp ON cp.certified_product_id = cr.certified_product_id
		WHERE cp.certification_edition_id != tf.certification_edition_id) innerQuery;
		
		raise notice '# criteria with test functionality certification edition mismatches AFTER update: %', mismatchCount;
	END;
$$ LANGUAGE plpgsql;

SELECT openchpl.fixTestFunctionality();

DROP FUNCTION openchpl.fixTestFunctionality();