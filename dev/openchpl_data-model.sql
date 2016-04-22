-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.0
-- PostgreSQL version: 9.4
-- Project Site: pgmodeler.com.br
-- Model Author: ---


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: openchpl | type: DATABASE --
-- -- DROP DATABASE IF EXISTS openchpl;
-- CREATE DATABASE openchpl
-- ;
-- -- ddl-end --
--
-- object: openchpl | type: SCHEMA --
-- DROP SCHEMA IF EXISTS openchpl CASCADE;
CREATE SCHEMA openchpl;
-- ddl-end --
-- ALTER SCHEMA openchpl OWNER TO openchpl;
-- ddl-end --

SET search_path TO pg_catalog,public,openchpl;
-- ddl-end --

CREATE TYPE openchpl.attestation as enum('Affirmative', 'Negative', 'N/A');

-- object: openchpl.user | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.user CASCADE;
CREATE TABLE openchpl.user(
	user_id bigserial NOT NULL,
	user_name varchar(25) NOT NULL,
	password varchar(255) NOT NULL,
	account_expired bool NOT NULL,
	account_locked bool NOT NULL,
	credentials_expired bool NOT NULL,
	account_enabled bool NOT NULL,
	compliance_signature timestamp,
	failed_login_count int not null default 0,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	contact_id bigint,
	CONSTRAINT user_pk PRIMARY KEY (user_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.user OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.announcements | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.announcements CASCADE;
CREATE TABLE openchpl.announcement(
	announcement_id bigserial NOT NULL,
	announcement_title text NOT NULL,
	announcement_text text,
	start_date timestamp NOT NULL DEFAULT NOW(),
	end_date timestamp NOT NULL,
	isPublic boolean NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT announcement_pk PRIMARY KEY (announcement_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.announcements OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.certification_body | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_body CASCADE;
CREATE TABLE openchpl.certification_body(
	certification_body_id bigserial NOT NULL,
	acb_code varchar(16),
	address_id bigint,
	name varchar(250),
	website varchar(300),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user smallint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_body_pk PRIMARY KEY (certification_body_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certification_body OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.product | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.product CASCADE;
CREATE TABLE openchpl.product(
	product_id bigserial NOT NULL,
	vendor_id bigint NOT NULL,
	name varchar(300) NOT NULL,
	report_file_location varchar(255),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_pk PRIMARY KEY (product_id)

);
-- ddl-end --
COMMENT ON TABLE openchpl.product IS 'Table to store products that are submitted for vendors';
-- ddl-end --
--A LTER TABLE openchpl.product OWNER TO openchpl;
-- ddl-end --


CREATE SEQUENCE openchpl.vendor_vendor_code_seq
    INCREMENT 1
    MINVALUE 1000;
-- ALTER TABLE openchpl.vendor_vendor_code_seq OWNER TO openchpl;

-- object: openchpl.vendor | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.vendor CASCADE;
CREATE TABLE openchpl.vendor(
	vendor_id bigserial NOT NULL,
	vendor_code varchar(16) DEFAULT nextval('openchpl.vendor_vendor_code_seq'),
	address_id bigint,
	contact_id bigint,
	name varchar(300),
	website varchar(300),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_pk PRIMARY KEY (vendor_id)

);
-- ddl-end --
COMMENT ON TABLE openchpl.vendor IS 'Table to store vendors that are entered into the system';
-- ddl-end --
--A LTER TABLE openchpl.vendor OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.acb_vendor_map (
	acb_vendor_map_id bigserial NOT NULL,
	vendor_id bigint NOT NULL,
	certification_body_id bigint NOT NULL,
	transparency_attestation attestation,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT acb_vendor_pk PRIMARY KEY (acb_vendor_map_id),
    CONSTRAINT acb_vendor_map_vendor_id_certification_body_id_key UNIQUE (vendor_id, certification_body_id)
);

ALTER TABLE openchpl.acb_vendor_map OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.user_permission | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.user_permission CASCADE;
CREATE TABLE openchpl.user_permission(
	user_permission_id bigserial NOT NULL,
	name varchar(25) NOT NULL,
	description varchar(1000) NOT NULL,
	authority varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_permission_pk PRIMARY KEY (user_permission_id),
	CONSTRAINT authority_unique UNIQUE (authority)

);
-- ddl-end --
--A LTER TABLE openchpl.user_permission OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.qms_standard (
	qms_standard_id bigserial NOT NULL,
	name varchar(200) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT qms_standard_pk PRIMARY KEY (qms_standard_id)
);

CREATE TABLE openchpl.targeted_user (
	targeted_user_id bigserial NOT NULL,
	name varchar(300) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT targeted_user_pk PRIMARY KEY (targeted_user_id)
);

CREATE TABLE openchpl.accessibility_standard (
	accessibility_standard_id bigserial NOT NULL,
	name varchar(300) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT accessibility_standard_pk PRIMARY KEY (accessibility_standard_id)
);

-- object: openchpl.certified_product | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certified_product CASCADE;
CREATE TABLE openchpl.certified_product(
	certified_product_id bigserial NOT NULL,
	certification_edition_id bigint NOT NULL,
	product_version_id bigint NOT NULL,
	testing_lab_id bigint,
	certification_body_id bigint NOT NULL,
	chpl_product_number varchar(250),
	report_file_location varchar(255), -- test report
	sed_report_file_location varchar(255), 
	sed_intended_user_description text,
	sed_testing_end timestamp,
	acb_certification_id varchar(250),
	practice_type_id bigint,
	product_classification_type_id bigint,
	product_additional_software varchar(1000), -- legacy for ETL
	other_acb character varying(64),
	certification_status_id bigint NOT NULL,
    visible_on_chpl bool NOT NULL DEFAULT true,
	terms_of_use_url varchar(1024), --170.523 (k)(1)
	transparency_attestation_url varchar(1024),
	ics boolean,
	sed boolean,
	qms boolean,
	accessibility_certified boolean,
	product_code varchar(16),
	version_code varchar(16),
	ics_code varchar(16),
	additional_software_code varchar(16),
	certified_date_code varchar(16),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_pk PRIMARY KEY (certified_product_id)

);
-- ddl-end --
COMMENT ON TABLE openchpl.certified_product IS 'A product that has been Certified';
-- ddl-end --
-- ALTER TABLE openchpl.certified_product OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.certified_product_qms_standard(
	certified_product_qms_standard_id bigserial not null,
	certified_product_id bigint not null,
	qms_standard_id bigint not null,
	modification text,
	applicable_criteria text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_qms_standard_pk PRIMARY KEY (certified_product_qms_standard_id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT qms_standard_fk FOREIGN KEY (qms_standard_id)
      REFERENCES openchpl.qms_standard (qms_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.certified_product_targeted_user (
	certified_product_targeted_user_id bigserial not null,
	certified_product_id bigint not null,
	targeted_user_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_targeted_user_pk PRIMARY KEY (certified_product_targeted_user_id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT targeted_user_fk FOREIGN KEY (targeted_user_id)
      REFERENCES openchpl.targeted_user (targeted_user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.certified_product_accessibility_standard (
	certified_product_accessibility_standard_id bigserial not null,
	certified_product_id bigint not null,
	accessibility_standard_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_accessibility_standard_pk PRIMARY KEY (certified_product_accessibility_standard_id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT accessibility_standard_fk FOREIGN KEY (accessibility_standard_id)
      REFERENCES openchpl.accessibility_standard (accessibility_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- object: openchpl.product_version | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.product_version CASCADE;
CREATE TABLE openchpl.product_version(
	product_version_id bigserial NOT NULL,
	product_id bigint NOT NULL,
	version varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_version_pk PRIMARY KEY (product_version_id)

);
-- ddl-end --
COMMENT ON TABLE openchpl.product_version IS 'Table to store individual versions of a specific product';
-- ddl-end --
-- ALTER TABLE openchpl.product_version OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.certification_edition | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_edition CASCADE;
CREATE TABLE openchpl.certification_edition(
	certification_edition_id bigserial NOT NULL,
	year varchar(10),
	retired BOOLEAN NOT NULL DEFAULT FALSE,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_edition_pk PRIMARY KEY (certification_edition_id)

);
-- ddl-end --
--A LTER TABLE openchpl.certification_edition OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.certification_criterion | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_criterion CASCADE;
CREATE TABLE openchpl.certification_criterion(
	certification_criterion_id bigserial NOT NULL,
	certification_edition_id bigint NOT NULL,
	number varchar(30),
	title varchar(250),
	description varchar(1000),
	automated_numerator_capable bool,
	automated_measure_capable bool,
	requires_sed bool,
	parent_criterion_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_criterion_pk PRIMARY KEY (certification_criterion_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certification_criterion OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.education_type(
	education_type_id bigserial NOT NULL,
	name varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT education_type_pk PRIMARY KEY (education_type_id)

);

CREATE TABLE openchpl.test_task(
	test_task_id bigserial NOT NULL,
	description text,
	task_success_avg_pct float,
	task_success_stddev_pct float,
	task_path_deviation_observed int,
	task_path_deviation_optimal int,
	task_time_avg_seconds bigint,
	task_time_stddev_seconds int,
	task_time_deviation_observed_avg_seconds int,
	task_time_deviation_optimal_avg_seconds int,
	task_errors_pct float,
	task_errors_stddev_pct float,
	task_rating_scale varchar(50),
	task_rating float,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_task_pk PRIMARY KEY (test_task_id)

);

CREATE TABLE openchpl.test_participant(
	test_participant_id bigserial NOT NULL,
	gender varchar(100),
	age smallint,
	education_type_id bigint,
	occupation varchar(250),
	professional_experience_months int,
	computer_experience_months int,
	product_experience_months int,
	assistive_technology_needs varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_participant_pk PRIMARY KEY (test_participant_id),
	CONSTRAINT education_type_fk FOREIGN KEY (education_type_id)
		REFERENCES openchpl.education_type (education_type_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

-- object: openchpl.certification_result | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_result CASCADE;
CREATE TABLE openchpl.certification_result(
	certification_result_id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	certified_product_id bigint NOT NULL,
	success bool NOT NULL,
	gap bool,
	sed bool,
	g1_success bool,
	g2_success bool,
	api_documentation varchar(1024),
	privacy_security_framework varchar(100),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_pk PRIMARY KEY (certification_result_id)
);
-- ddl-end --
--ALTER TABLE openchpl.certification_result OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.certification_result_test_task (
	certification_result_test_task_id bigserial not null,
	certification_result_id bigint not null,
	test_task_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint certification_result_test_task_pk primary key (certification_result_test_task_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_task_fk FOREIGN KEY (test_task_id)
      REFERENCES openchpl.test_task (test_task_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.certification_result_test_task_participant (
	certification_result_test_task_participant_id bigserial not null,
	certification_result_test_task_id bigint not null,
	test_participant_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint certification_result_test_task_participant_pk primary key (certification_result_test_task_participant_id),
	CONSTRAINT certification_result_test_task_fk FOREIGN KEY (certification_result_test_task_id)
      REFERENCES openchpl.certification_result_test_task (certification_result_test_task_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_participant_fk FOREIGN KEY (test_participant_id)
      REFERENCES openchpl.test_participant (test_participant_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.test_standard (
	test_standard_id bigserial not null,
	number text not null,
	name varchar(1000),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint test_standard_pk primary key (test_standard_id)
);

CREATE TABLE openchpl.certification_result_test_standard (
	certification_result_test_standard_id bigserial NOT NULL,
	certification_result_id bigint not null,
	test_standard_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT certification_result_test_standard_pk PRIMARY KEY (certification_result_test_standard_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_standard_fk FOREIGN KEY (test_standard_id)
      REFERENCES openchpl.test_standard (test_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION

);

CREATE TABLE openchpl.test_functionality (
	test_functionality_id bigserial not null,
	number varchar(200) not null,
	name varchar(1000),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint test_functionality_pk primary key (test_functionality_id)
);

CREATE TABLE openchpl.certification_result_test_functionality 
(
	certification_result_test_functionality_id bigserial NOT NULL,
	certification_result_id bigint not null,
	test_functionality_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT certification_result_test_functionality_pk PRIMARY KEY (certification_result_test_functionality_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_functionality_fk FOREIGN KEY (test_functionality_id)
      REFERENCES openchpl.test_functionality (test_functionality_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION

);

CREATE TABLE openchpl.ucd_process (
	ucd_process_id bigserial not null,
	name varchar(500),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint ucd_process_pk primary key (ucd_process_id)
);

CREATE TABLE openchpl.certification_result_ucd_process 
(
	certification_result_ucd_process_id bigserial NOT NULL,
	certification_result_id bigint not null,
	ucd_process_id bigint not null,
	ucd_process_details text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT certification_result_ucd_process_pk PRIMARY KEY (certification_result_ucd_process_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT ucd_process_fk FOREIGN KEY (ucd_process_id)
      REFERENCES openchpl.ucd_process (ucd_process_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION

);

CREATE TABLE openchpl.certification_result_additional_software
(
  certification_result_additional_software_id bigserial,
  certification_result_id bigint NOT NULL,
  name varchar(500),
  version varchar(250),
  certified_product_id bigint,
  justification varchar(500),
  grouping varchar(10),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT certification_result_additional_software_pk PRIMARY KEY (certification_result_additional_software_id),
  CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
   CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

create table openchpl.test_procedure (
	test_procedure_id bigserial not null,
	version varchar(255) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_procedure_pk PRIMARY KEY (test_procedure_id)
);

-- object: openchpl.test_procedure_version | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_procedure_version CASCADE;
CREATE TABLE openchpl.certification_result_test_procedure (
	certification_result_test_procedure_id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	test_procedure_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_procedure_pk PRIMARY KEY (certification_result_test_procedure_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure (test_procedure_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE

);
-- ddl-end --
-- ALTER TABLE openchpl.test_procedure_version OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.certification_result_test_data | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_result_test_data CASCADE;
CREATE TABLE openchpl.certification_result_test_data(
	certification_result_test_data_id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	version varchar(100) not null,
	alteration text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_data_pk PRIMARY KEY (certification_result_test_data_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE

);

-- object: openchpl.test_tool | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_tool CASCADE;
CREATE TABLE openchpl.test_tool(
	test_tool_id bigserial NOT NULL,
	name varchar(100) NOT NULL,
	description varchar(1000),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_tool_pk PRIMARY KEY (test_tool_id)
);

CREATE TABLE openchpl.certification_result_test_tool (
	certification_result_test_tool_id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	test_tool_id bigint NOT NULL,
	version varchar(100),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_tool_pk PRIMARY KEY (certification_result_test_tool_id),
	CONSTRAINT test_tool_fk FOREIGN KEY (test_tool_id)
	REFERENCES openchpl.test_tool (test_tool_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE

);

-- object: openchpl.testing_lab | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.testing_lab CASCADE;
CREATE TABLE openchpl.testing_lab(
	testing_lab_id bigserial NOT NULL,
	testing_lab_code varchar(16),
	address_id bigint,
	name varchar(250) NOT NULL,
	accredidation_number varchar(25),
	website varchar(300),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT testing_lab_pk PRIMARY KEY (testing_lab_id)
);
-- ddl-end --
-- ALTER TABLE openchpl.testing_lab OWNER TO openchpl;
-- ddl-end --

-- object: vendor_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.product DROP CONSTRAINT IF EXISTS vendor_fk CASCADE;
ALTER TABLE openchpl.product ADD CONSTRAINT vendor_fk FOREIGN KEY (vendor_id)
REFERENCES openchpl.vendor (vendor_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.product_version DROP CONSTRAINT IF EXISTS product_fk CASCADE;
ALTER TABLE openchpl.product_version ADD CONSTRAINT product_fk FOREIGN KEY (product_id)
REFERENCES openchpl.product (product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: product_version_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS product_version_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT product_version_fk FOREIGN KEY (product_version_id)
REFERENCES openchpl.product_version (product_version_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: testing_lab_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS testing_lab_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT testing_lab_fk FOREIGN KEY (testing_lab_id)
REFERENCES openchpl.testing_lab (testing_lab_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_body_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS certification_body_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_edition_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS certification_edition_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT certification_edition_fk FOREIGN KEY (certification_edition_id)
REFERENCES openchpl.certification_edition (certification_edition_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_criterion_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_result DROP CONSTRAINT IF EXISTS certification_criterion_fk CASCADE;
ALTER TABLE openchpl.certification_result ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.global_user_permission_map | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.global_user_permission_map CASCADE;
CREATE TABLE openchpl.global_user_permission_map(
	user_id bigint,
	user_permission_id_user_permission bigint,
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool DEFAULT false,
global_user_permission_id bigserial NOT NULL,
	CONSTRAINT global_user_permission_map_pk PRIMARY KEY (user_id,user_permission_id_user_permission)

);
-- ALTER TABLE openchpl.global_user_permission_map OWNER TO openchpl;
-- ddl-end --

-- object: user_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.global_user_permission_map DROP CONSTRAINT IF EXISTS user_fk CASCADE;
ALTER TABLE openchpl.global_user_permission_map ADD CONSTRAINT user_fk FOREIGN KEY (user_id)
REFERENCES openchpl."user" (user_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: user_permission_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.global_user_permission_map DROP CONSTRAINT IF EXISTS user_permission_fk CASCADE;
ALTER TABLE openchpl.global_user_permission_map ADD CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id_user_permission)
REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certified_product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_result DROP CONSTRAINT IF EXISTS certified_product_fk CASCADE;
ALTER TABLE openchpl.certification_result ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.address | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.address CASCADE;
CREATE TABLE openchpl.address(
	address_id bigserial NOT NULL,
	street_line_1 varchar(250) NOT NULL,
	street_line_2 varchar(250),
	city varchar(250) NOT NULL,
	state varchar(100) NOT NULL,
	zipcode varchar(100) NOT NULL,
	country varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT now(),
	last_modified_date timestamp NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT address_pk PRIMARY KEY (address_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.address OWNER TO openchpl;
-- ddl-end --

-- object: address_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.vendor DROP CONSTRAINT IF EXISTS address_fk CASCADE;
ALTER TABLE openchpl.vendor ADD CONSTRAINT address_fk FOREIGN KEY (address_id)
REFERENCES openchpl.address (address_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: address_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.testing_lab DROP CONSTRAINT IF EXISTS address_fk CASCADE;
ALTER TABLE openchpl.testing_lab ADD CONSTRAINT address_fk FOREIGN KEY (address_id)
REFERENCES openchpl.address (address_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: address_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_body DROP CONSTRAINT IF EXISTS address_fk CASCADE;
ALTER TABLE openchpl.certification_body ADD CONSTRAINT address_fk FOREIGN KEY (address_id)
REFERENCES openchpl.address (address_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

ALTER TABLE openchpl.acb_vendor_map ADD CONSTRAINT vendor_fk FOREIGN KEY (vendor_id)
REFERENCES openchpl.vendor (vendor_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE openchpl.acb_vendor_map ADD CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- object: openchpl.contact | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.contact CASCADE;
CREATE TABLE openchpl.contact(
	contact_id bigserial NOT NULL,
	first_name varchar(250),
	last_name varchar(250) NOT NULL,
	email varchar(250) NOT NULL,
	phone_number varchar(50) NOT NULL,
	title varchar(250),
	signature_date timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT contact_pk PRIMARY KEY (contact_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.contact OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.atl_contact_map | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.atl_contact_map CASCADE;
CREATE TABLE openchpl.atl_contact_map(
	contact_id bigint,
	testing_lab_id_testing_lab bigint,
	authorize_representative bool,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT atl_contact_map_pk PRIMARY KEY (contact_id,testing_lab_id_testing_lab)

);
-- ALTER TABLE openchpl.atl_contact_map OWNER TO openchpl;
-- ddl-end --

-- object: contact_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.atl_contact_map DROP CONSTRAINT IF EXISTS contact_fk CASCADE;
ALTER TABLE openchpl.atl_contact_map ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: testing_lab_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.atl_contact_map DROP CONSTRAINT IF EXISTS testing_lab_fk CASCADE;
ALTER TABLE openchpl.atl_contact_map ADD CONSTRAINT testing_lab_fk FOREIGN KEY (testing_lab_id_testing_lab)
REFERENCES openchpl.testing_lab (testing_lab_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.acb_contact_map | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.acb_contact_map CASCADE;
CREATE TABLE openchpl.acb_contact_map(
	contact_id bigint,
	certification_body_id_certification_body bigint,
	authorized_representative bool,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT acb_contact_map_pk PRIMARY KEY (contact_id,certification_body_id_certification_body)

);
-- ALTER TABLE openchpl.acb_contact_map OWNER TO openchpl;
-- ddl-end --

-- object: contact_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acb_contact_map DROP CONSTRAINT IF EXISTS contact_fk CASCADE;
ALTER TABLE openchpl.acb_contact_map ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_body_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acb_contact_map DROP CONSTRAINT IF EXISTS certification_body_fk CASCADE;
ALTER TABLE openchpl.acb_contact_map ADD CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id_certification_body)
REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.cqm_criterion | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.cqm_criterion CASCADE;
CREATE TABLE openchpl.cqm_criterion(
	cqm_criterion_id bigserial NOT NULL,
	number varchar(20),
	cms_id varchar(15),
	title varchar(250),
	description varchar(1000),
	cqm_domain varchar(250),
	nqf_number varchar(50),
	creation_date timestamp NOT NULL DEFAULT now(),
	last_modified_date timestamp NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	cqm_version_id bigint,
	cqm_criterion_type_id bigint NOT NULL,
	retired BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT cqm_criterion_pk PRIMARY KEY (cqm_criterion_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.cqm_criterion OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.cqm_result | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.cqm_result CASCADE;
CREATE TABLE openchpl.cqm_result(
	cqm_result_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	success bool NOT NULL,
	cqm_criterion_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cqm_result_pk PRIMARY KEY (cqm_result_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.cqm_result OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.cqm_result_criteria (
	cqm_result_criteria_id bigserial not null,
	cqm_result_id bigint not null,
	certification_criterion_id bigint not null,
	
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT cqm_result_criteria_pk PRIMARY KEY (cqm_result_criteria_id),
	CONSTRAINT cqm_result_fk FOREIGN KEY (cqm_result_id)
      REFERENCES openchpl.cqm_result (cqm_result_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL
);

-- object: certification_edition_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_criterion DROP CONSTRAINT IF EXISTS certification_edition_fk CASCADE;
ALTER TABLE openchpl.certification_criterion ADD CONSTRAINT certification_edition_fk FOREIGN KEY (certification_edition_id)
REFERENCES openchpl.certification_edition (certification_edition_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: cqm_criterion_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.cqm_result DROP CONSTRAINT IF EXISTS cqm_criterion_fk CASCADE;
ALTER TABLE openchpl.cqm_result ADD CONSTRAINT cqm_criterion_fk FOREIGN KEY (cqm_criterion_id)
REFERENCES openchpl.cqm_criterion (cqm_criterion_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.cqm_criterion_type | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.cqm_criterion_type CASCADE;
CREATE TABLE openchpl.cqm_criterion_type(
	cqm_criterion_type_id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cqm_criterion_type_pk PRIMARY KEY (cqm_criterion_type_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.cqm_criterion_type OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.certification_event | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_event CASCADE;
CREATE TABLE openchpl.certification_event(
	certification_event_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	event_type_id bigint NOT NULL,
	event_date timestamp NOT NULL,
	city varchar(250),
	state varchar(25),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_events_pk PRIMARY KEY (certification_event_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certification_event OWNER TO openchpl;
-- ddl-end --

-- object: certified_product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_event DROP CONSTRAINT IF EXISTS certified_product_fk CASCADE;
ALTER TABLE openchpl.certification_event ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.event_type | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.event_type CASCADE;
CREATE TABLE openchpl.event_type(
	event_type_id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT event_type_pk PRIMARY KEY (event_type_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.event_type OWNER TO openchpl;
-- ddl-end --

-- object: event_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_event DROP CONSTRAINT IF EXISTS event_type_fk CASCADE;
ALTER TABLE openchpl.certification_event ADD CONSTRAINT event_type_fk FOREIGN KEY (event_type_id)
REFERENCES openchpl.event_type (event_type_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.product_classification_type | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.product_classification_type CASCADE;
CREATE TABLE openchpl.product_classification_type(
	product_classification_type_id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_classification_type_pk PRIMARY KEY (product_classification_type_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.product_classification_type OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.practice_type | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.practice_type CASCADE;
CREATE TABLE openchpl.practice_type(
	practice_type_id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT practice_type_pk PRIMARY KEY (practice_type_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.practice_type OWNER TO openchpl;
-- ddl-end --


-- object: openchpl.utilized_test_tool | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.utilized_test_tool CASCADE;
CREATE TABLE openchpl.utilized_test_tool(
	utilized_test_tool_id bigserial NOT NULL,
	selected bool NOT NULL,
	certification_result_id bigint NOT NULL,
	test_tool_id bigint,
	test_tool_version_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT utilized_test_tool_pk PRIMARY KEY (utilized_test_tool_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.utilized_test_tool OWNER TO openchpl;
-- ddl-end --

-- object: test_tool_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.utilized_test_tool DROP CONSTRAINT IF EXISTS test_tool_fk CASCADE;
ALTER TABLE openchpl.utilized_test_tool ADD CONSTRAINT test_tool_fk FOREIGN KEY (test_tool_id)
REFERENCES openchpl.test_tool (test_tool_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.standards_met | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.standards_met CASCADE;
CREATE TABLE openchpl.standards_met(
	standards_met_id bigserial NOT NULL,
	standard_met bool NOT NULL,
	criterion_standard_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	certification_result_id bigint NOT NULL,
	CONSTRAINT standards_met_pk PRIMARY KEY (standards_met_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.standards_met OWNER TO openchpl;
-- ddl-end --


-- object: openchpl.newer_standards_met | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.newer_standards_met CASCADE;
CREATE TABLE openchpl.newer_standards_met(
	newer_standards_met_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	version varchar(100) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT newer_standards_met_pk PRIMARY KEY (newer_standards_met_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.newer_standards_met OWNER TO openchpl;
-- ddl-end --

-- object: certified_product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.newer_standards_met DROP CONSTRAINT IF EXISTS certified_product_fk CASCADE;
ALTER TABLE openchpl.newer_standards_met ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_criterion_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.newer_standards_met DROP CONSTRAINT IF EXISTS certification_criterion_fk CASCADE;
ALTER TABLE openchpl.newer_standards_met ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.optional_functionality_met | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.optional_functionality_met CASCADE;
CREATE TABLE openchpl.optional_functionality_met(
	optional_functionality_met_id bigserial NOT NULL,
	criterion_optional_functionality_id bigint NOT NULL,
	functionality_met bool NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	certification_result_id bigint NOT NULL,
	CONSTRAINT optional_functionality_met_pk PRIMARY KEY (optional_functionality_met_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.optional_functionality_met OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.cqm_version | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.cqm_version CASCADE;
CREATE TABLE openchpl.cqm_version(
	cqm_version_id bigserial NOT NULL,
	version varchar(25) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cqm_version_pk PRIMARY KEY (cqm_version_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.cqm_version OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.test_result_summary_version | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_result_summary_version CASCADE;
CREATE TABLE openchpl.test_result_summary_version(
	test_result_summary_version_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	version varchar(10) NOT NULL,
	description varchar(250) NOT NULL,
	change_date timestamp NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_result_summary_version_pk PRIMARY KEY (test_result_summary_version_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.test_result_summary_version OWNER TO openchpl;
-- ddl-end --

-- object: certified_product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.test_result_summary_version DROP CONSTRAINT IF EXISTS certified_product_fk CASCADE;
ALTER TABLE openchpl.test_result_summary_version ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.test_event_details | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_event_details CASCADE;
CREATE TABLE openchpl.test_event_details(
	test_event_details_id bigserial NOT NULL,
	certification_event_id bigint NOT NULL,
	test_environment varchar(250),
	intended_user_description varchar(1000),
	user_task_description text,
	major_test_finding text,
	effectiveness text,
	efficiency text,
	satisfaction text,
	areas_for_improvement text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_event_details_pk PRIMARY KEY (test_event_details_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.test_event_details OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.experience_type | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.experience_type CASCADE;
CREATE TABLE openchpl.experience_type(
	experience_type_id bigint NOT NULL,
	name varchar(25) NOT NULL,
	description varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT experience_type_pk PRIMARY KEY (experience_type_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.experience_type OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.test_task_result | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_task_result CASCADE;
CREATE TABLE openchpl.test_task_result(
	test_task_result_id bigserial NOT NULL,
	test_task_id bigint NOT NULL,
	test_paticipant_id bigint NOT NULL,
	education_type_id bigint,
	computer_experience_id bigint,
	product_experience_id bigint,
	success bool,
	deviation bool,
	duration bigint,
	task_satisfication smallint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_task_result_pk PRIMARY KEY (test_task_result_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.test_task_result OWNER TO openchpl;
-- ddl-end --

-- object: education_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.test_task_result DROP CONSTRAINT IF EXISTS education_type_fk CASCADE;
ALTER TABLE openchpl.test_task_result ADD CONSTRAINT education_type_fk FOREIGN KEY (education_type_id)
REFERENCES openchpl.education_type (education_type_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: experience_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.test_task_result DROP CONSTRAINT IF EXISTS experience_type_fk CASCADE;
ALTER TABLE openchpl.test_task_result ADD CONSTRAINT experience_type_fk FOREIGN KEY (computer_experience_id)
REFERENCES openchpl.experience_type (experience_type_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_event_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.test_event_details DROP CONSTRAINT IF EXISTS certification_event_fk CASCADE;
ALTER TABLE openchpl.test_event_details ADD CONSTRAINT certification_event_fk FOREIGN KEY (certification_event_id)
REFERENCES openchpl.certification_event (certification_event_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.certified_product_checksum | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certified_product_checksum CASCADE;
CREATE TABLE openchpl.certified_product_checksum(
	certified_product_checksum varchar(64),
	stg_certification_certification_id varchar(64) NOT NULL,
	CONSTRAINT certified_product_checksum_pkey PRIMARY KEY (stg_certification_certification_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certified_product_checksum OWNER TO openchpl;
-- ddl-end --

-- object: practice_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS practice_type_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT practice_type_fk FOREIGN KEY (practice_type_id)
REFERENCES openchpl.practice_type (practice_type_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: product_classification_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS product_classification_type_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT product_classification_type_fk FOREIGN KEY (product_classification_type_id)
REFERENCES openchpl.product_classification_type (product_classification_type_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_result_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.optional_functionality_met DROP CONSTRAINT IF EXISTS certification_result_fk CASCADE;
ALTER TABLE openchpl.optional_functionality_met ADD CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certification_result_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.standards_met DROP CONSTRAINT IF EXISTS certification_result_fk CASCADE;
ALTER TABLE openchpl.standards_met ADD CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.acl_class | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.acl_class CASCADE;
CREATE TABLE openchpl.acl_class(
	id bigserial NOT NULL,
	class character varying(100) NOT NULL,
	CONSTRAINT acl_class_uk UNIQUE (class),
	CONSTRAINT ack_class_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE openchpl.acl_class OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.acl_entry | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.acl_entry CASCADE;
CREATE TABLE openchpl.acl_entry(
	id bigserial NOT NULL,
	acl_object_identity bigint NOT NULL,
	ace_order integer NOT NULL,
	sid bigint NOT NULL,
	mask integer NOT NULL,
	granting bool NOT NULL,
	audit_success bool NOT NULL,
	audit_failure bool NOT NULL,
	CONSTRAINT acl_entry_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE openchpl.acl_entry OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.acl_sid | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.acl_sid CASCADE;
CREATE TABLE openchpl.acl_sid(
	id bigserial NOT NULL,
	principal bool NOT NULL,
	sid character varying(100) NOT NULL,
	CONSTRAINT acl_sid_pk PRIMARY KEY (id),
	CONSTRAINT acl_sid_uk UNIQUE (principal,sid)

);
-- ddl-end --
-- ALTER TABLE openchpl.acl_sid OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.acl_object_identity | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.acl_object_identity CASCADE;
CREATE TABLE openchpl.acl_object_identity(
	id bigserial NOT NULL,
	object_id_class bigint NOT NULL,
	object_id_identity bigint NOT NULL,
	parent_object bigint,
	owner_sid bigint,
	entries_inheriting bool NOT NULL,
	CONSTRAINT acl_object_identity_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE openchpl.acl_object_identity OWNER TO openchpl;
-- ddl-end --

-- object: acl_class_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_object_identity DROP CONSTRAINT IF EXISTS acl_class_fk CASCADE;
ALTER TABLE openchpl.acl_object_identity ADD CONSTRAINT acl_class_fk FOREIGN KEY (object_id_class)
REFERENCES openchpl.acl_class (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: acl_sid_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_object_identity DROP CONSTRAINT IF EXISTS acl_sid_fk CASCADE;
ALTER TABLE openchpl.acl_object_identity ADD CONSTRAINT acl_sid_fk FOREIGN KEY (owner_sid)
REFERENCES openchpl.acl_sid (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: acl_object_identity_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_entry DROP CONSTRAINT IF EXISTS acl_object_identity_fk CASCADE;
ALTER TABLE openchpl.acl_entry ADD CONSTRAINT acl_object_identity_fk FOREIGN KEY (acl_object_identity)
REFERENCES openchpl.acl_object_identity (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: acl_sid_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_entry DROP CONSTRAINT IF EXISTS acl_sid_fk CASCADE;
ALTER TABLE openchpl.acl_entry ADD CONSTRAINT acl_sid_fk FOREIGN KEY (sid)
REFERENCES openchpl.acl_sid (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: acl_entry_uk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_entry DROP CONSTRAINT IF EXISTS acl_entry_uk CASCADE;
ALTER TABLE openchpl.acl_entry ADD CONSTRAINT acl_entry_uk UNIQUE (acl_object_identity,ace_order);
-- ddl-end --

-- object: cqm_version_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.cqm_criterion DROP CONSTRAINT IF EXISTS cqm_version_fk CASCADE;
ALTER TABLE openchpl.cqm_criterion ADD CONSTRAINT cqm_version_fk FOREIGN KEY (cqm_version_id)
REFERENCES openchpl.cqm_version (cqm_version_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: cqm_criterion_type_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.cqm_criterion DROP CONSTRAINT IF EXISTS cqm_criterion_type_fk CASCADE;
ALTER TABLE openchpl.cqm_criterion ADD CONSTRAINT cqm_criterion_type_fk FOREIGN KEY (cqm_criterion_type_id)
REFERENCES openchpl.cqm_criterion_type (cqm_criterion_type_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: certified_product_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.cqm_result DROP CONSTRAINT IF EXISTS certified_product_fk CASCADE;
ALTER TABLE openchpl.cqm_result ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: openchpl.certification_status | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.certification_status CASCADE;
CREATE TABLE openchpl.certification_status(
	certification_status_id bigserial NOT NULL,
	certification_status character varying(64),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_status_pk PRIMARY KEY (certification_status_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certification_status OWNER TO openchpl;
-- ddl-end --

-- object: certification_status_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS certification_status_fk CASCADE;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id)
REFERENCES openchpl.certification_status (certification_status_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: contact_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.user DROP CONSTRAINT IF EXISTS contact_fk CASCADE;
ALTER TABLE openchpl."user" ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: parent_criterion_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.certification_criterion DROP CONSTRAINT IF EXISTS parent_criterion_fk CASCADE;
ALTER TABLE openchpl.certification_criterion ADD CONSTRAINT parent_criterion_fk FOREIGN KEY (parent_criterion_id)
REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: product_experience_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.test_task_result DROP CONSTRAINT IF EXISTS product_experience_fk CASCADE;
ALTER TABLE openchpl.test_task_result ADD CONSTRAINT product_experience_fk FOREIGN KEY (product_experience_id)
REFERENCES openchpl.experience_type (experience_type_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: parent_object_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_object_identity DROP CONSTRAINT IF EXISTS parent_object_fk CASCADE;
ALTER TABLE openchpl.acl_object_identity ADD CONSTRAINT parent_object_fk FOREIGN KEY (parent_object)
REFERENCES openchpl.acl_object_identity (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: openchpl.pending_certified_product | type: TABLE --
--DROP TABLE IF EXISTS openchpl.pending_certified_product CASCADE;
CREATE TABLE openchpl.pending_certified_product(
	pending_certified_product_id bigserial NOT NULL,

	-- columns from the upload spreadsheet
	unique_id varchar(255),
	record_status varchar(50), --new, update, delete
	practice_type varchar(50), --Inpatient or Ambulatory
	testing_lab_name varchar(300),
	vendor_name varchar(300),
	product_name varchar(300),
	product_version varchar(250),
	certification_edition varchar(10),
	acb_certification_id varchar(250),
	certification_body_name varchar(250),
	product_classification_name varchar(250),
	product_classification_module varchar(260), -- we have no field in the db for this (it is only for Modular EHRs)
	certification_date timestamp,
	vendor_street_address varchar(250), -- not broken out into line1/line2
	vendor_city varchar(250),
	vendor_state varchar(250), 
	vendor_zip_code varchar(25), -- maps to nothing in our address table
	vendor_website varchar(300),
	vendor_email varchar(250), 
	vendor_contact_name varchar(250),
	vendor_phone varchar(100),
	vendor_transparency_attestation attestation,
	vendor_transparency_attestation_url varchar(1024),
	accessibility_certified boolean default false,
	test_report_url varchar(255), -- report_file_location
	sed_report_file_location varchar(255),
	sed_intended_user_description text,
	sed_testing_end timestamp,
	ics varchar(1024),
	terms_of_use_url varchar(1024),	-- k1 url
	
	-- foreign keys that have meaning if they are not mapped
	practice_type_id bigint, -- should never be null
	vendor_id bigint, -- may be null
	vendor_address_id bigint, -- may be null
	vendor_contact_id bigint, -- may be null
	product_id bigint, -- may be null
	product_version_id bigint, -- may be null
	certification_edition_id bigint, -- should never be null
	certification_body_id bigint, --should never be null
	product_classification_id bigint, -- should never be null
	testing_lab_id bigint,
	
	-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	certification_status_id bigint NOT NULL, -- pending, rejected, active
	CONSTRAINT pending_certified_product_pk PRIMARY KEY (pending_certified_product_id)
);
-- ddl-end --
COMMENT ON TABLE openchpl.pending_certified_product IS 'A product that has been uploaded but not confirmed by the user';
-- ddl-end --
-- ALTER TABLE openchpl.pending_certified_product OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.pending_certified_product_qms_standard(
	pending_certified_product_qms_standard_id bigserial not null,
	pending_certified_product_id bigint not null,
	qms_standard_id bigint,
	qms_standard_name varchar(255),
	modification text,
	applicable_criteria text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_qms_standard_pk PRIMARY KEY (pending_certified_product_qms_standard_id),
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT qms_standard_fk FOREIGN KEY (qms_standard_id)
      REFERENCES openchpl.qms_standard (qms_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certified_product_targeted_user (
	pending_certified_product_targeted_user_id bigserial not null,
	pending_certified_product_id bigint not null,
	targeted_user_id bigint,
	targeted_user_name varchar(300),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_targeted_user_pk PRIMARY KEY (pending_certified_product_targeted_user_id),
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT targeted_user_fk FOREIGN KEY (targeted_user_id)
      REFERENCES openchpl.targeted_user (targeted_user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certified_product_accessibility_standard (
	pending_certified_product_accessibility_standard_id bigserial not null,
	pending_certified_product_id bigint not null,
	accessibility_standard_id bigint,
	accessibility_standard_name varchar(500),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_accessibility_standard_pk PRIMARY KEY (pending_certified_product_accessibility_standard_id),
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	 CONSTRAINT accessibility_standard_fk FOREIGN KEY (accessibility_standard_id)
      REFERENCES openchpl.accessibility_standard (accessibility_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_test_participant (
	pending_test_participant_id bigserial not null,
	test_participant_unique_id varchar(20) not null,
	gender varchar(100),
	age smallint,
	education_type_id bigint,
	occupation varchar(250),
	professional_experience_months int,
	computer_experience_months int,
	product_experience_months int,
	assistive_technology_needs varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint pending_test_participant_pk primary key (pending_test_participant_id)
);

CREATE TABLE openchpl.pending_test_task (
	pending_test_task_id bigserial not null,
	test_task_unique_id varchar(20) not null,
	description text,
	task_success_avg_pct float,
	task_success_stddev_pct float,
	task_path_deviation_observed int,
	task_path_deviation_optimal int,
	task_time_avg_seconds bigint,
	task_time_stddev_seconds int,
	task_time_deviation_observed_avg_seconds int,
	task_time_deviation_optimal_avg_seconds int,
	task_errors_pct float,
	task_errors_stddev_pct float,
	task_rating_scale varchar(50),
	task_rating float,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint pending_test_task_pk primary key (pending_test_task_id)
);

-- object: openchpl.pending_certification_criterion | type: TABLE --
--DROP TABLE IF EXISTS openchpl.pending_certification_criterion CASCADE;
CREATE TABLE openchpl.pending_certification_result(
	pending_certification_result_id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	pending_certified_product_id bigint NOT NULL,
	meets_criteria boolean NOT NULL,
	gap bool,
	sed bool,
	g1_success bool,
	g2_success bool,
	api_documentation varchar(1024),
	privacy_security_framework varchar(100),
	
	-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_pk PRIMARY KEY (pending_certification_result_id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE openchpl.pending_certification_result_test_task (
	pending_certification_result_test_task_id bigserial not null,
	pending_certification_result_id bigint not null,
	pending_test_task_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint pending_certification_result_test_task_pk primary key (pending_certification_result_test_task_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT pending_test_task_fk FOREIGN KEY (pending_test_task_id)
      REFERENCES openchpl.pending_test_task (pending_test_task_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION  
);

CREATE TABLE openchpl.pending_certification_result_test_task_participant (
	pending_certification_result_test_task_participant_id bigserial not null,
	pending_certification_result_test_task_id bigint not null,
	pending_test_participant_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint pending_certification_result_test_task_participant_pk primary key (pending_certification_result_test_task_participant_id),
	CONSTRAINT pending_certification_result_test_task_fk FOREIGN KEY (pending_certification_result_test_task_id)
      REFERENCES openchpl.pending_certification_result_test_task (pending_certification_result_test_task_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT pending_test_participant_fk FOREIGN KEY (pending_test_participant_id)
      REFERENCES openchpl.pending_test_participant (pending_test_participant_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION  
);

CREATE TABLE openchpl.pending_certification_result_test_standard (
	pending_certification_result_test_standard_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	test_standard_id bigint,
	test_standard_number text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_test_standard_pk PRIMARY KEY (pending_certification_result_test_standard_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_standard_fk FOREIGN KEY (test_standard_id)
      REFERENCES openchpl.test_standard (test_standard_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certification_result_test_functionality 
(
	pending_certification_result_test_functionality_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	test_functionality_id bigint,
	test_functionality_number varchar(200),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_test_functionality_pk PRIMARY KEY (pending_certification_result_test_functionality_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT test_functionality_fk FOREIGN KEY (test_functionality_id)
      REFERENCES openchpl.test_functionality (test_functionality_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certification_result_ucd_process (
	pending_certification_result_ucd_process_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	ucd_process_id bigint,
	ucd_process_name varchar(200),
	ucd_process_details text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_ucd_process_pk PRIMARY KEY (pending_certification_result_ucd_process_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT ucd_process_fk FOREIGN KEY (ucd_process_id)
      REFERENCES openchpl.ucd_process (ucd_process_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certification_result_additional_software
(
  pending_certification_result_additional_software_id bigserial,
  pending_certification_result_id bigint NOT NULL,
  name varchar(500),
  version varchar(250),
  certified_product_id bigint,
  certified_product_chpl_id varchar(200),
  justification varchar(500),
  grouping varchar(10),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT pending_certification_result_additional_software_pk PRIMARY KEY (pending_certification_result_additional_software_id),
  CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
   CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_certification_result_test_procedure (
	pending_certification_result_test_procedure_id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	test_procedure_id bigint,
	test_procedure_version varchar(255),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_procedure_pk PRIMARY KEY (pending_certification_result_test_procedure_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure (test_procedure_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_certification_result_test_data(
	pending_certification_result_test_data_id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	version varchar(100) not null,
	alteration text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_data_pk PRIMARY KEY (pending_certification_result_test_data_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_certification_result_test_tool (
	pending_certification_result_test_tool_id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	test_tool_id bigint,
	test_tool_name varchar(100),
	test_tool_version varchar(50),
	
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_tool_pk PRIMARY KEY (pending_certification_result_test_tool_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_tool_fk FOREIGN KEY (test_tool_id)
	REFERENCES openchpl.test_tool (test_tool_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE

);

-- object: openchpl.pending_cqm_criterion | type: TABLE --
--DROP TABLE IF EXISTS openchpl.pending_cqm_criterion CASCADE;
CREATE TABLE openchpl.pending_cqm_criterion(
	pending_cqm_criterion_id bigserial NOT NULL,
	cqm_criterion_id bigint NOT NULL,
	pending_certified_product_id bigint NOT NULL,
	meets_criteria boolean NOT NULL,

	-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT pending_cqm_criterion_pk PRIMARY KEY (pending_cqm_criterion_id),
	CONSTRAINT cqm_criterion_fk FOREIGN KEY (cqm_criterion_id)
      REFERENCES openchpl.cqm_criterion (cqm_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE openchpl.pending_cqm_certification_criteria (
	pending_cqm_certification_criteria_id bigserial not null,
	pending_cqm_criterion_id bigint not null,
	certification_criterion_id bigint not null,
	
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT pending_cqm_certification_criteria_pk PRIMARY KEY (pending_cqm_certification_criteria_id),
	CONSTRAINT pending_cqm_criterion_fk FOREIGN KEY (pending_cqm_criterion_id)
      REFERENCES openchpl.pending_cqm_criterion (pending_cqm_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE openchpl.activity
(
   activity_id bigserial NOT NULL,
   description character varying(1000),
   certification_body bigint DEFAULT null,
   original_data text,
   new_data text,
   activity_date timestamp without time zone NOT NULL DEFAULT now(),
   activity_object_id bigint NOT NULL,
   activity_object_concept_id bigint NOT NULL,
   creation_date timestamp without time zone NOT NULL DEFAULT now(),
   last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
   last_modified_user bigint,
   deleted boolean NOT NULL DEFAULT false,
   CONSTRAINT activity_id_pk PRIMARY KEY (activity_id)
)
WITH (
  OIDS = FALSE
)
;
--ALTER TABLE openchpl.activity  OWNER TO openchpl;

CREATE TABLE openchpl.activity_concept
(
  activity_concept_id bigserial NOT NULL,
  concept character varying,
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT activity_concept_id_pk PRIMARY KEY (activity_concept_id)
)
WITH (
  OIDS=FALSE
);
-- ALTER TABLE openchpl.activity_concept  OWNER TO openchpl;

ALTER TABLE openchpl.activity ADD CONSTRAINT activity_object_concept_fk FOREIGN KEY (activity_object_concept_id) REFERENCES openchpl.activity_concept (activity_concept_id);

-- object: openchpl.invited_user | type: TABLE --
--DROP TABLE IF EXISTS openchpl.invited_user CASCADE;
CREATE TABLE openchpl.invited_user(
	invited_user_id bigserial NOT NULL,
	email varchar(300) NOT NULL,
	certification_body_id bigint,
	testing_lab_id bigint,
	invite_token varchar(500),
	confirm_token varchar(500),
	created_user_id bigint DEFAULT NULL,

-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT invited_user_pk PRIMARY KEY (invited_user_id),
	CONSTRAINT invite_token_unique UNIQUE (invite_token),
	CONSTRAINT confirm_token_unique UNIQUE (confirm_token)
);
-- ddl-end --
COMMENT ON TABLE openchpl.invited_user IS 'A user that has been invited to use the CHPL system.';
-- ddl-end --
-- ALTER TABLE openchpl.invited_user OWNER TO openchpl;
-- ddl-end --

-- object: openchpl.invited_user_permission | type: TABLE --
--DROP TABLE IF EXISTS openchpl.invited_user_permission CASCADE;
CREATE TABLE openchpl.invited_user_permission(
	invited_user_permission_id bigserial NOT NULL,
	invited_user_id bigint NOT NULL,
	user_permission_id bigint NOT NULL,

	-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT invited_user_permission_fk PRIMARY KEY (invited_user_permission_id),
	CONSTRAINT permission_unique UNIQUE (invited_user_id, user_permission_id)
);
-- ddl-end --
ALTER TABLE openchpl.invited_user_permission ADD CONSTRAINT invited_user_id_fk FOREIGN KEY (invited_user_id)
REFERENCES openchpl.invited_user (invited_user_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE openchpl.invited_user_permission ADD CONSTRAINT user_permission_id_fk FOREIGN KEY (user_permission_id)
REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

COMMENT ON TABLE openchpl.invited_user_permission IS 'A user that has been invited to use the CHPL system.';
-- ddl-end --
-- ALTER TABLE openchpl.invited_user_permission OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.corrective_action_plan(
	corrective_action_plan_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	surveillance_start timestamp NOT NULL,
	surveillance_result boolean NOT NULL,
	surveillance_end timestamp,
	noncompliance_determination_date timestamp NOT NULL, -- the date noncompliance was determined by an ACB
	approval_date timestamp, -- the date ONC approved a corrective action plan
	start_date timestamp, -- the date corrective action began
	completion_date_required timestamp, -- the date corrective action must be completed
	completion_date_actual timestamp, -- the date corrective action was completed
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT corrective_action_plan_pk PRIMARY KEY (corrective_action_plan_id)
);

ALTER TABLE openchpl.corrective_action_plan ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ALTER TABLE openchpl.corrective_action_plan OWNER TO openchpl;

CREATE TABLE openchpl.corrective_action_plan_certification_result (
	corrective_action_plan_certification_result_id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	corrective_action_plan_id bigint NOT NULL,
	summary text, 
	developer_explanation text,
	resolution text,
	num_sites_passed int,
	num_sites_total int,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT corrective_action_plan_certification_result_pk PRIMARY KEY (corrective_action_plan_certification_result_id)
);

ALTER TABLE openchpl.corrective_action_plan_certification_result ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE openchpl.corrective_action_plan_certification_result ADD CONSTRAINT corrective_action_plan_fk FOREIGN KEY (corrective_action_plan_id)
REFERENCES openchpl.corrective_action_plan (corrective_action_plan_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;


-- ALTER TABLE openchpl.corrective_action_plan_certification_result OWNER TO openchpl;

CREATE TABLE openchpl.corrective_action_plan_documentation (
	corrective_action_plan_documentation_id bigserial NOT NULL,
	corrective_action_plan_id bigint NOT NULL,
	filename varchar(250) NOT NULL,
	filetype varchar(250),
	filedata bytea not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT corrective_action_plan_documentation_pk PRIMARY KEY (corrective_action_plan_documentation_id)
);

ALTER TABLE openchpl.corrective_action_plan_documentation ADD CONSTRAINT corrective_action_plan_fk FOREIGN KEY (corrective_action_plan_id)
REFERENCES openchpl.corrective_action_plan (corrective_action_plan_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- ALTER TABLE openchpl.corrective_action_plan_documentation OWNER TO openchpl;

CREATE TABLE openchpl.api_key
(
  api_key_id bigserial NOT NULL,
  api_key character varying(32) NOT NULL,
  email character varying(256) NOT NULL,
  name_organization character varying(256),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT pk_api_key_id PRIMARY KEY (api_key_id)
);

-- ALTER TABLE openchpl.api_key  OWNER TO openchpl;

CREATE TABLE openchpl.api_key_activity
(
  api_key_activity_id bigserial NOT NULL,
  api_key_id bigint NOT NULL,
  api_call_path character varying(2083),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT api_key_activity_pk PRIMARY KEY (api_key_activity_id)
);

-- ALTER TABLE openchpl.api_key_activity  OWNER TO openchpl;

ALTER TABLE openchpl.api_key_activity ADD CONSTRAINT api_key_fk FOREIGN KEY (api_key_id) REFERENCES openchpl.api_key (api_key_id);


 -- Sequence: openchpl.ehr_cert_product_map_id_ehr_cert_product_map_id_seq

CREATE SEQUENCE openchpl.ehr_cert_product_map_id_ehr_cert_product_map_id_seq
  INCREMENT 1
  MINVALUE 1;
-- ALTER TABLE openchpl.ehr_cert_product_map_id_ehr_cert_product_map_id_seq OWNER TO openchpl;
  
-- Sequence: openchpl.ehr_certification_id_ehr_certification_id_id_seq

CREATE SEQUENCE openchpl.ehr_certification_id_ehr_certification_id_id_seq
  INCREMENT 1
  MINVALUE 1;
-- ALTER TABLE openchpl.ehr_certification_id_ehr_certification_id_id_seq OWNER TO openchpl;

-- Table: openchpl.ehr_certification_id

-- DROP TABLE openchpl.ehr_certification_id;

CREATE TABLE openchpl.ehr_certification_id
(
  ehr_certification_id_id bigint NOT NULL DEFAULT nextval('openchpl.ehr_certification_id_ehr_certification_id_id_seq'::regclass),
  key text NOT NULL, -- The unique product collection key
  certification_id text NOT NULL, -- The unqiue CMS EHR Certification ID
  practice_type_id bigint,
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
  year text NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT ehr_certification_id_pk PRIMARY KEY (ehr_certification_id_id),
  CONSTRAINT practice_type_id_fk FOREIGN KEY (practice_type_id)
      REFERENCES openchpl.practice_type (practice_type_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT unique_certification_id UNIQUE (certification_id),
  CONSTRAINT unique_year_key UNIQUE (year, key)
)
WITH (
  OIDS=FALSE
);
--ALTER TABLE openchpl.ehr_certification_id OWNER TO openchpl;
COMMENT ON TABLE openchpl.ehr_certification_id
  IS 'CMS EHR Certification IDs';
COMMENT ON COLUMN openchpl.ehr_certification_id.key IS 'The unique product collection key';
COMMENT ON COLUMN openchpl.ehr_certification_id.certification_id IS 'The unqiue CMS EHR Certification ID';
ALTER TABLE openchpl.ehr_certification_id ALTER COLUMN year SET STORAGE PLAIN;


-- Index: openchpl.fki_practice_type_id_fk

-- DROP INDEX openchpl.fki_practice_type_id_fk;

CREATE INDEX fki_practice_type_id_fk
  ON openchpl.ehr_certification_id
  USING btree
  (practice_type_id);


-- Table: openchpl.ehr_certification_id_product_map

-- DROP TABLE openchpl.ehr_certification_id_product_map;

CREATE TABLE openchpl.ehr_certification_id_product_map
(
  ehr_certification_id_product_map_id bigint NOT NULL DEFAULT nextval('openchpl.ehr_cert_product_map_id_ehr_cert_product_map_id_seq'::regclass),
  ehr_certification_id_id bigint NOT NULL,
  certified_product_id bigint NOT NULL,
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT ehr_certification_id_product_map_pk PRIMARY KEY (ehr_certification_id_product_map_id),
  CONSTRAINT ehr_certification_id_product_map_certified_product_id_fkey FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT ehr_certification_id_product_map_ehr_certification_id_id_fkey FOREIGN KEY (ehr_certification_id_id)
      REFERENCES openchpl.ehr_certification_id (ehr_certification_id_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
--ALTER TABLE openchpl.ehr_certification_id_product_map OWNER TO openchpl;

-- Index: openchpl.fki_certified_product_id_fk

-- DROP INDEX openchpl.fki_certified_product_id_fk;

CREATE INDEX fki_certified_product_id_fk
  ON openchpl.ehr_certification_id_product_map
  USING btree
  (certified_product_id);

-- Index: openchpl.fki_ehr_certification_id_fk

-- DROP INDEX openchpl.fki_ehr_certification_id_fk;

CREATE INDEX fki_ehr_certification_id_fk
  ON openchpl.ehr_certification_id_product_map
  USING btree
  (ehr_certification_id_id);
 