--
-- OCD-1996
--

--these two tables could generate questionable activity from a listing update API call
--and any listing update API call could have a reason
ALTER TABLE openchpl.questionable_activity_certification_result DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.questionable_activity_listing DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.questionable_activity_certification_result ADD COLUMN reason text;
ALTER TABLE openchpl.questionable_activity_listing ADD COLUMN reason text;

DROP TABLE IF EXISTS openchpl.pending_certified_product_system_update;
DROP TABLE IF EXISTS openchpl.fuzzy_choices;
DROP TYPE IF EXISTS openchpl.fuzzy_type;

CREATE TYPE openchpl.fuzzy_type as enum('UCD Process', 'QMS Standard', 'Accessibility Standard');

CREATE TABLE openchpl.fuzzy_choices(
	fuzzy_choices_id bigserial not null,
	fuzzy_type openchpl.fuzzy_type not null,
	choices text not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT fuzzy_choices_pk PRIMARY KEY (fuzzy_choices_id)
);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
values ('UCD Process', '["Home Grown","ISO 13407","ISO 16982","ISO 9001","ISO 9241","ISO 9241-10","ISO 9241-11","ISO 9241-210","ISO 9241-210:2010 4.2","ISO/IEC 25062:2006","ISO/IEC 62366","ISO/IEC 62366-1","ISO/IEC 62367","Internal Process Used","Multiple Standards","NISTIR 7741","NISTIR 7742","See User Centered Design document"]', -1);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
values ('QMS Standard', '["(Deming) PDCA Cycle","21 CFR Part 820","21 CFR Part 820;IS0 9001","Agile Scrum","Home Grown","Home Grown mapped to ISO 12207","Home Grown mapped to ISO 9001","IEC 62304","IEEE 730","IS0 9001","IS0 9001;ISM/ISO/IEC 27001","IS0 9001;ISO 13485","ISO 12207","ISO 13485","ISO 13485:2003","ISO 13485:2003;ISO 13485:2012;ISO 9001:2008","ISO 13485:2003;ISO 9001:2008","ISO 13485:2012","ISO 14971","ISO 80001","ISO 9001:2000","ISO 9001:2008","ISO 9001:2015","ISO PDCA;ISO 9001:2015","Microsoft Solution Framework; Microsoft Operations Framework","Modified ISO 9001:2015","Modified QMS/Mapped","N/A","None","Other Federal or SDO QMS Standard","Other QMS","Scrum mapped to ISO 9001"]', -1);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
values ('Accessibility Standard', '["170.204(a)(1)","170.204(a)(2)","ETSI ES 202 076","ICO/IEC 24786: 2009","IEC 17398","IEC 1743","IEC 80416-1","IEC 80416-2","IEC 80416-3","IEC 80416-4","IEC 80416-71","IEC 80416-74","IEC ISO 3864","ISO 9001","ISO 9241-110","ISO 9241-171: 2008","ISO/IEC 40500","ISO/IEC 40500:2012","NISTIR 7741","None","Section 508 of the Rehabilitation Act","Section 508 of the Rehabilitation Act;WCAG 2.0 Level AA","W3C Web Design and Applications","W3C Web of Devices","WCAG","WCAG 2.0","WCAG 2.0 Level A","WCAG 2.0 Level A;ISO/IEC 40500","WCAG 2.0 Level AA","WCAG Level"]', -1);

CREATE TRIGGER fuzzy_choices_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER fuzzy_choices_timestamp BEFORE UPDATE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- OCD-2024
--
ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS pending_certified_product_id;
ALTER TABLE openchpl.certified_product ADD COLUMN pending_certified_product_id bigint;
ALTER TABLE openchpl.certified_product
	ADD CONSTRAINT pending_certified_product_fk
	FOREIGN KEY (pending_certified_product_id)
	REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION;

---
--- OCD-1938
---
update openchpl.accessibility_standard set name = 'ETSI ES 202 076' where name = 'ETSI ES 202 076 -';
update openchpl.accessibility_standard set name = 'ICO/IEC 24786: 2009' where name = 'Other - ICO/IEC 24786: 2009';
update openchpl.accessibility_standard set name = 'ISO 9001' where name = 'Other - Mapped to ISO 9001';
update openchpl.accessibility_standard set name = 'ISO 9241-110' where name = 'Other - ISO 9241-110';
update openchpl.accessibility_standard set name = 'ISO 9241-171: 2008' where name = 'ISO 9241-151 (2008) -';
update openchpl.accessibility_standard set name = 'ISO 9241-171: 2008' where name = 'ISO 9241-171 (2008) -';
update openchpl.accessibility_standard set name = 'ISO/IEC 40500' where name = 'Other - ISO/IEC 4050';
update openchpl.accessibility_standard set name = 'ISO/IEC 40500' where name = 'Other - ISO/IEC 40500';
update openchpl.accessibility_standard set name = 'ISO/IEC 40500:2012' where name = 'Other - ISO/IEC 40500:2012';
update openchpl.accessibility_standard set name = 'NISTIR 7741' where name = 'Other - NIST 7741';
update openchpl.accessibility_standard set name = 'None' where name = 'None -';
update openchpl.accessibility_standard set name = 'None' where name = 'none';
update openchpl.accessibility_standard set name = 'Section 508 of the Rehabilitation Act' where name = 'Section 508 and WCAG 2.0 AA';
update openchpl.accessibility_standard set name = 'Section 508 of the Rehabilitation Act' where name = 'Section 508 of the Rehabilitation Act -';
update openchpl.accessibility_standard set name = 'Section 508 of the Rehabilitation Act' where name = 'Section 508';
update openchpl.accessibility_standard set name = 'Section 508 of the Rehabilitation Act;WCAG 2.0 Level AA' where name = 'Section 508 of the Rehabilitation Act';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level A' where name = 'Other - WCAG 2.0 Level A';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level A' where name = 'WCAG 2.0 A';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level A;ISO/IEC 40500' where name = 'Other - WCAG 2.0 Level A - ISO/IEC 40500';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level AA' where name = 'Other - WCAG 2.0 Level AA';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level AA' where name = 'Other - WCAG Level AA';
update openchpl.accessibility_standard set name = 'WCAG 2.0 Level AA' where name = 'WCAG 2.0 AA';
update openchpl.accessibility_standard set name = 'WCAG 2.0' where name = 'Other - WCAG 2.0';
update openchpl.accessibility_standard set name = 'WCAG Level' where name = 'Other - WCAG Level';
update openchpl.accessibility_standard set name = 'WCAG' where name = 'Other - WCAG';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = '21 CFR 820';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = '21 CFR Part 820 Quality System Regulations; ISO 13485:2003; EN ISO 13485:2012 Medical Devices - Quality Management Systems; ISO 9001:2008 Quality Management Systems';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = '21 CFR Part 820 Quality System Regulations; ISO 13485:2003; ISO 9001:2008';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = '21 CFR Part 820; ISO 13485:2003; ISO 9001:2008';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = 'FDA 21 Code of Federal Regulation (CFR) Part 820';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = 'FDA Quality System Regulation - 21 CFR Part 820';
update openchpl.qms_standard set name = '21 CFR Part 820' where name = 'Food and Drug Administration�s Code of Federal Regulations Title 21 Part 820 Quality System Regulation';
update openchpl.qms_standard set name = '21 CFR Part 820;IS0 9001' where name = 'ISO 9001; FDA Quality Systems Requirements';
update openchpl.qms_standard set name = 'Agile Scrum' where name = 'Scrum';
update openchpl.qms_standard set name = 'Home Grown mapped to ISO 12207' where name = 'Homegrown mapped to ISO 12207';
update openchpl.qms_standard set name = 'Home Grown mapped to ISO 9001' where name = 'Home-grown Agile methodology mapped to ISO:9001';
update openchpl.qms_standard set name = 'Home Grown mapped to ISO 9001' where name = 'Homegrown mapped to ISO 9001';
update openchpl.qms_standard set name = 'Home Grown' where name = 'Home-Grown';
update openchpl.qms_standard set name = 'Home Grown' where name = 'Homegrown or Modified Standard';
update openchpl.qms_standard set name = 'Home Grown' where name = 'Homegrown';
update openchpl.qms_standard set name = 'Home Grown' where name = 'Self-Develop';
update openchpl.qms_standard set name = 'Home Grown' where name = 'Self-developed';
update openchpl.qms_standard set name = 'IS0 9001' where name = 'ISO 9001';
update openchpl.qms_standard set name = 'IS0 9001' where name = 'ISO-9001';
update openchpl.qms_standard set name = 'IS0 9001;ISM/ISO/IEC 27001' where name = 'ISO 9001; ISMS/ISO/IEC 27001';
update openchpl.qms_standard set name = 'IS0 9001;ISO 13485' where name = 'ISO 9001; ISO 13485';
update openchpl.qms_standard set name = 'ISO 13485' where name = 'ISO 13458';
update openchpl.qms_standard set name = 'ISO 13485' where name = 'ISO 13485 Medical Devices � Quality Management Systems';
update openchpl.qms_standard set name = 'ISO 13485' where name = 'ISO 13485, 9001, 13485';
update openchpl.qms_standard set name = 'ISO 13485:2003;ISO 13485:2012;ISO 9001:2008' where name = 'ISO 13485:2003 and EN ISO 13485:2012 Medical Devices - Quality management systems - Requirements for regulatory purposes and ISO 9001:2008 Quality management systems - Requirements';
update openchpl.qms_standard set name = 'ISO 13485:2003;ISO 9001:2008' where name = 'ISO 13485:2003 and ISO 9001:2008 Quality management systems';
update openchpl.qms_standard set name = 'ISO 13485:2003;ISO 9001:2008' where name = 'ISO-9001:2008, Quality Management Systems Requirements, ISO 13485:2003 Medical Devices Quality Management System - Requirements for Regulatory Purposes';
update openchpl.qms_standard set name = 'ISO 9001:2008' where name = 'ISO 9001: 2008';
update openchpl.qms_standard set name = 'ISO 9001:2015' where name = 'ISO9001:2015';
update openchpl.qms_standard set name = 'ISO PDCA;ISO 9001:2015' where name = 'ISO PDCA, ISO 9001:2015';
update openchpl.qms_standard set name = 'Modified ISO 9001:2015' where name = 'Modified ISO-9001-2015';
update openchpl.qms_standard set name = 'Modified ISO 9001:2015' where name = 'Modified';
update openchpl.ucd_process set name = 'Home Grown' where name = 'Home grown';
update openchpl.ucd_process set name = 'Home Grown' where name = 'Homegrown';
update openchpl.ucd_process set name = 'ISO/IEC 62366' where name = 'IEC 62366';
update openchpl.ucd_process set name = 'ISO/IEC 62366' where name = 'ISO 62366';
update openchpl.ucd_process set name = 'ISO/IEC 62366-1' where name = 'IEC 62366-1';
update openchpl.ucd_process set name = 'NISTIR 7741' where name = '(NISTIR 7741) NIST Guide to the Processes Approach for Improving the Usability of Electronic Health Records';
update openchpl.ucd_process set name = 'NISTIR 7741' where name = 'NISIR 7741';
update openchpl.ucd_process set name = 'NISTIR 7741' where name = 'NIST 7741';
update openchpl.ucd_process set name = 'NISTIR 7741' where name = 'NISTIR 7741- NIST Guide to the Processes Approach
for Improving the Usability of Electronic Health Records';

--
-- FIX UCD PROCESSES
--

-- delete references to ucd processes in certification results if ucd process name is blank
UPDATE openchpl.certification_result_ucd_process
SET deleted = true
WHERE ucd_process_id IN (SELECT ucd_process_id FROM openchpl.ucd_process WHERE name = '')
AND deleted != true;

-- delete the ucd_process rows that have blank names
UPDATE openchpl.ucd_process
SET deleted = true
WHERE name = ''
AND deleted != true;

CREATE OR REPLACE FUNCTION openchpl.replaceAllUcdProcessDuplicates() RETURNS void AS $$
DECLARE
    dupName varchar(200);
BEGIN
    FOR dupName IN SELECT name FROM openchpl.ucd_process WHERE deleted = false GROUP BY name HAVING count(*) > 1
    LOOP
	-- change the references to the duplicate ucd process
	RAISE NOTICE 'Changing all certification results pointing to ucd process %', dupName;

	UPDATE openchpl.certification_result_ucd_process
	SET ucd_process_id =
		-- get the first one of the ucd processes with this same name
		-- and set all certification results to point to it
		(SELECT ucd_process_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, ucd_process_id FROM openchpl.ucd_process WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row = 1)
	WHERE ucd_process_id IN (SELECT ucd_process_id FROM openchpl.ucd_process WHERE name = dupName)
	AND deleted = false;

	-- delete the duplicate ucd process(es)
	UPDATE openchpl.ucd_process
	SET deleted = true
	WHERE ucd_process_id IN
		-- get all non-first instances of this ucd process name
	       (SELECT ucd_process_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, ucd_process_id FROM openchpl.ucd_process WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row > 1)
	AND deleted = false;
    END LOOP;
    RETURN;
END
$$ LANGUAGE 'plpgsql' ;

SELECT * FROM openchpl.replaceAllUcdProcessDuplicates();
DROP FUNCTION openchpl.replaceAllUcdProcessDuplicates();

--
-- FIX QMS STANDARDS
--

CREATE OR REPLACE FUNCTION openchpl.replaceAllQmsStandardDuplicates() RETURNS void AS $$
DECLARE
    dupName varchar(200);
BEGIN
    FOR dupName IN SELECT name FROM openchpl.qms_standard WHERE deleted = false GROUP BY name HAVING count(*) > 1
    LOOP
	-- change the references to the duplicate ucd process
	RAISE NOTICE 'Changing all certified products pointing to qms standard %', dupName;

	UPDATE openchpl.certified_product_qms_standard
	SET qms_standard_id =
		-- get the first one of the qms standards with this same name
		-- and set all certification results to point to it
		(SELECT qms_standard_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, qms_standard_id FROM openchpl.qms_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row = 1)
	WHERE qms_standard_id IN (SELECT qms_standard_id FROM openchpl.qms_standard WHERE name = dupName)
	AND deleted = false;

	-- delete the duplicate qms standard(s)
	UPDATE openchpl.qms_standard
	SET deleted = true
	WHERE qms_standard_id IN
		-- get all non-first instances of this qms standard name
	       (SELECT qms_standard_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, qms_standard_id FROM openchpl.qms_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row > 1)
	AND deleted = false;
    END LOOP;
    RETURN;
END
$$ LANGUAGE 'plpgsql' ;

SELECT * FROM openchpl.replaceAllQmsStandardDuplicates();
DROP FUNCTION openchpl.replaceAllQmsStandardDuplicates();

CREATE OR REPLACE FUNCTION openchpl.replaceAllAccessibilityStandardDuplicates() RETURNS void AS $$
DECLARE
    dupName varchar(200);
BEGIN
    FOR dupName IN SELECT name FROM openchpl.accessibility_standard WHERE deleted = false GROUP BY name HAVING count(*) > 1
    LOOP
	-- change the references to the duplicate ucd process
	RAISE NOTICE 'Changing all certified products pointing to accessibility standard %', dupName;

	UPDATE openchpl.certified_product_accessibility_standard
	SET accessibility_standard_id =
		-- get the first one of the accessibility standards with this same name
		-- and set all certification results to point to it
		(SELECT accessibility_standard_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, accessibility_standard_id FROM openchpl.accessibility_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row = 1)
	WHERE accessibility_standard_id IN (SELECT accessibility_standard_id FROM openchpl.accessibility_standard WHERE name = dupName)
	AND deleted = false;

	-- delete the duplicate accessibility standard(s)
	UPDATE openchpl.accessibility_standard
	SET deleted = true
	WHERE accessibility_standard_id IN
		-- get all non-first instances of this accessibility standard name
	       (SELECT accessibility_standard_id
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, accessibility_standard_id FROM openchpl.accessibility_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row > 1)
	AND deleted = false;
    END LOOP;
    RETURN;
END
$$ LANGUAGE 'plpgsql' ;

SELECT * FROM openchpl.replaceAllAccessibilityStandardDuplicates();
DROP FUNCTION openchpl.replaceAllAccessibilityStandardDuplicates();

--
-- OCD-2064: Insert duplicate CMS ids
--
insert into openchpl.ehr_certification_id (key, year, certification_id, creation_date, last_modified_user) select 'DoubleEntryNewIdIs_0015H8GK6K0ZZB2','2014/2015','0015HVE5THE5STY','2018-01-18 18:50:40.5040', -1 where not exists(select * from openchpl.ehr_certification_id where certification_id ='0015HVE5THE5STY');
insert into openchpl.ehr_certification_id (key, year, certification_id, creation_date, last_modified_user) select 'DoubleEntryNewIdIs_0014E3X6JD31TV7','2014','0014EPW1J0Z968N','2018-01-18 22:42:15.4215', -1 where not exists(select * from openchpl.ehr_certification_id where certification_id ='0014EPW1J0Z968N');
insert into openchpl.ehr_certification_id (key, year, certification_id, creation_date, last_modified_user) select 'DoubleEntryNewIdIs_0015HMF1CK1NU6F','2014/2015','0015H3K3FVF3QLF','2018-01-19 18:05:03.53', -1 where not exists(select * from openchpl.ehr_certification_id where certification_id ='0015H3K3FVF3QLF');

-- insert mappings for ids
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8169, '2018-01-18 18:50:40.5040', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015HVE5THE5STY' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015HVE5THE5STY') and certified_product_id = 8169);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8969, '2018-01-18 18:50:40.5040', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015HVE5THE5STY' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015HVE5THE5STY') and certified_product_id = 8969);

insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 394, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 394);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8206, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8206);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8408, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8408);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8411, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8411);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8417, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8417);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8418, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8418);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8581, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 8581);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 9038, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 9038);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 9119, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 9119);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 9128, '2018-01-18 22:42:15.4215', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0014EPW1J0Z968N') and certified_product_id = 9128);

insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6840, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6840);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6926, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6926);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 9047, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 9047);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 8013, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 8013);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7946, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7946);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7945, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7945);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7820, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7820);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7819, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7819);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7771, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7771);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7769, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7769);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7768, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7768);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7749, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7749);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7740, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7740);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7615, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7615);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7614, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7614);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7537, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7537);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7535, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7535);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7329, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7329);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7319, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7319);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 7277, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 7277);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5478, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5478);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5546, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5546);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5642, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5642);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5670, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5670);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5711, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5711);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5712, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5712);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5716, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5716);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5934, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5934);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 5974, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 5974);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6027, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6027);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6030, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6030);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6102, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6102);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6372, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6372);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6395, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6395);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6397, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6397);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6622, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6622);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6707, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6707);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6733, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6733);
insert into openchpl.ehr_certification_id_product_map (ehr_certification_id_id, certified_product_id, creation_date, last_modified_user, deleted) select ec.ehr_certification_id_id, 6735, '2018-01-19 18:05:03.53', -1, false from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF' and not exists (select * from openchpl.ehr_certification_id_product_map where ehr_certification_id_id = (select ec.ehr_certification_id_id from openchpl.ehr_certification_id as ec where ec.certification_id = '0015H3K3FVF3QLF') and certified_product_id = 6735);

--re-run grants
\i dev/openchpl_grant-all.sql
