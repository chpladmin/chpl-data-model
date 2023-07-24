-- Deployment file for version 23.11.0
--     as of 2023-07-24
-- ./changes/ocd-4059.sql
--
-- Add Additional Software to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS additional_software bool NOT NULL default false;

--
-- All Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET additional_software = true;

--
-- Add Api Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS api_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- g7
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 56;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 57;

-- g9
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 58;

-- g9Cures
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 181;

-- g10
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 182;


--
-- Add Attestation Answer to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS attestation_answer bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d12
UPDATE openchpl.certification_criterion_attribute
SET attestation_answer = true
WHERE criterion_id = 176;

-- d13
UPDATE openchpl.certification_criterion_attribute
SET attestation_answer = true
WHERE criterion_id = 177;


--
-- Add Documentation URL to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS documentation_url bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d12
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 176;

-- d13
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 177;



--
-- Add Export Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS export_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- b10
UPDATE openchpl.certification_criterion_attribute
SET export_documentation = true
WHERE criterion_id = 171;



--
-- Add GAP to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS gap bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 4;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 8;


-- a10
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 10;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 11;

--d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 29;


--d4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 32;

--d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 33;

--d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 34;

--d7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 35;

--d11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 39;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 45;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 61;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 67;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 77;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 80;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 86;

-- d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 94;

-- d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 98;

-- d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 99;

-- d8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 101;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 102;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 106;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 112;

-- h1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 117;

-- h2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 118;

-- h3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 119;



--
-- Add G1 Success to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS g1_success bool NOT NULL default false;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 61;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 67;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 69;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 76;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 77;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 87;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 105;


--
-- Add G2 Success to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS g2_success bool NOT NULL default false;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 61;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 67;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 69;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 76;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 77;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 87;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 105;


--
-- Add SED  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS sed bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 8;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 9;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 14;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 17;

-- b2Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 166;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 167;


--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 61;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 62;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 68;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 76;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 80;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 84;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 90;



--
-- Add Test Standard  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS test_standard bool NOT NULL default false;

--
-- 2014 Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET test_standard = true
WHERE criterion_id IN 
	(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE certification_edition_id = 2);


--
-- Add Use Cases to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS use_cases bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d13
UPDATE openchpl.certification_criterion_attribute
SET use_cases = true
WHERE criterion_id = 177;
;
-- ./changes/ocd-4175.sql
drop table if exists openchpl.chpl_uptime_monitor_test;
drop table if exists openchpl.chpl_uptime_monitor;

create table if not exists openchpl.url_uptime_monitor (
	id bigserial not null,
	developer_id bigint not null,
	url text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint url_uptime_monitor_pk primary key (id),
	constraint developer_fk foreign key (developer_id)
	    references openchpl.vendor (vendor_id)
        match simple on update no action on delete restrict
);
drop trigger if exists url_uptime_monitor_audit on openchpl.url_uptime_monitor;
create trigger url_uptime_monitor_audit after insert or update or delete on openchpl.url_uptime_monitor for each row execute procedure audit.if_modified_func();
drop trigger if exists url_uptime_monitor_timestamp on openchpl.url_uptime_monitor;
create trigger url_uptime_monitor_timestamp before update on openchpl.url_uptime_monitor for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.url_uptime_monitor_test (
	id bigserial not null,
	url_uptime_monitor_id bigint not null,
	datadog_test_key text not null,
	check_time timestamp not null,
	passed bool not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint url_uptime_monitor_test_pk primary key (id),
	constraint url_uptime_monitor_fk foreign key (url_uptime_monitor_id)
	    references openchpl.url_uptime_monitor (id)
        match simple on update no action on delete restrict
);
drop trigger if exists url_uptime_monitor_test_audit on openchpl.url_uptime_monitor_test;
create trigger url_uptime_monitor_test_audit after insert or update or delete on openchpl.url_uptime_monitor_test for each row execute procedure audit.if_modified_func();
drop trigger if exists url_uptime_monitor_test_timestamp on openchpl.url_uptime_monitor_test;
create trigger url_uptime_monitor_test_timestamp before update on openchpl.url_uptime_monitor_test for each row execute procedure openchpl.update_last_modified_date_column();

alter table openchpl.url_uptime_monitor drop column if exists datadog_public_id;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.11.0', '2023-07-24', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
