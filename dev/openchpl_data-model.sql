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
 ALTER SCHEMA openchpl OWNER TO openchpl_dev;
-- ddl-end --

SET search_path TO pg_catalog,public,openchpl;
-- ddl-end --

CREATE TYPE openchpl.fuzzy_type as enum('UCD Process', 'QMS Standard', 'Accessibility Standard');
CREATE TYPE openchpl.validation_message_type as enum('Error', 'Warning');
CREATE TYPE openchpl.job_status_type as enum('In Progress', 'Complete', 'Error');
CREATE TYPE openchpl.questionable_activity_trigger_level as enum('Version', 'Product', 'Developer', 'Listing', 'Certification Criteria');
CREATE TYPE openchpl.certified_product_upload_status as enum ('UPLOAD_PROCESSING', 'UPLOAD_SUCCESS', 'UPLOAD_FAILURE',
	'CONFIRMATION_PROCESSING', 'CONFIRMED', 'REJECTED');

create table openchpl.data_model_version(
        id bigserial not null,
        version varchar(16) not null,
        deploy_date timestamp not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
        constraint data_model_version_pk primary key (id)
        );

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

-- object: openchpl.user | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.user CASCADE;
CREATE TABLE openchpl.user(
	user_id bigserial NOT NULL,
	user_name varchar(25),
	password varchar(255) NOT NULL,
	account_expired bool NOT NULL,
	account_locked bool NOT NULL,
	credentials_expired bool NOT NULL,
	account_enabled bool NOT NULL,
	compliance_signature timestamp,
    password_reset_required bool not null default false,
	failed_login_count int not null default 0,
    last_logged_in_date timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	contact_id bigint,
	user_permission_id bigint NOT NULL,
	CONSTRAINT user_pk PRIMARY KEY (user_id),
	CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT

);
-- ddl-end --
-- ALTER TABLE openchpl.user OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.user_reset_token(
	user_reset_token_id bigserial NOT NULL,
	user_reset_token varchar(128) NOT NULL,
	user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_reset_token_pk PRIMARY KEY (user_reset_token_id),
	CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES openchpl.user (user_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

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
CREATE TABLE openchpl.certification_body (
	certification_body_id bigserial NOT NULL,
	acb_code varchar(16),
	address_id bigint,
	name varchar(250),
	website varchar(300),
	retired boolean NOT NULL DEFAULT false,
        retirement_date timestamp,
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
	contact_id bigint,
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

CREATE TABLE openchpl.vendor_status(
	vendor_status_id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_status_pk PRIMARY KEY (vendor_status_id),
	CONSTRAINT vendor_status_unique_key UNIQUE (name)
);

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
	vendor_status_id bigint DEFAULT 1,
	name varchar(300),
	website varchar(300),
    self_developer bool NOT NULL DEFAULT false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_pk PRIMARY KEY (vendor_id),
	CONSTRAINT vendor_status_fk FOREIGN KEY (vendor_status_id)
      REFERENCES openchpl.vendor_status (vendor_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT

);
-- ddl-end --
COMMENT ON TABLE openchpl.vendor IS 'Table to store vendors that are entered into the system';
-- ddl-end --
--A LTER TABLE openchpl.vendor OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.vendor_status_history (
	vendor_status_history_id  bigserial NOT NULL,
	vendor_id bigint NOT NULL,
	vendor_status_id bigint NOT NULL,
	reason text,
	status_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_status_history_pk PRIMARY KEY (vendor_status_history_id),
	CONSTRAINT vendor_fk FOREIGN KEY (vendor_id) REFERENCES openchpl.vendor (vendor_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT vendor_status_fk FOREIGN KEY (vendor_status_id) REFERENCES openchpl.vendor_status (vendor_status_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.qms_standard (
	qms_standard_id bigserial NOT NULL,
	name varchar(255) NOT NULL,
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
	name varchar(500) NOT NULL,
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
	mandatory_disclosures varchar(1024),
	ics boolean,
	sed boolean,
	qms boolean,
	accessibility_certified boolean,
	product_code varchar(4),
	version_code varchar(2),
	ics_code varchar(2),
	additional_software_code varchar(1),
	certified_date_code varchar(6),
	pending_certified_product_id bigint,
    rwt_eligibility_year integer,
    rwt_plans_url text,
    rwt_plans_check_date date,
    rwt_results_url text,
    rwt_results_check_date date,
    svap_notice_url text,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_pk PRIMARY KEY (certified_product_id),
	CONSTRAINT product_code_regexp CHECK (product_code ~ $$^[a-zA-Z0-9_]{4}\Z$$),
	CONSTRAINT version_code_regexp CHECK (version_code ~ $$^[a-zA-Z0-9_]{2}\Z$$),
	CONSTRAINT ics_code_regexp CHECK (ics_code ~ $$^[0-9]{2}\Z$$),
	CONSTRAINT additional_software_code_regexp CHECK (additional_software_code ~ $$^0|1\Z$$),
	CONSTRAINT certified_date_code_regexp CHECK (certified_date_code ~ $$^[0-9]{6}\Z$$)
);
-- ddl-end --
COMMENT ON TABLE openchpl.certified_product IS 'A product that has been Certified';
-- ddl-end --
-- ALTER TABLE openchpl.certified_product OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.certified_product_chpl_product_number_history (
	id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	chpl_product_number text NOT NULL,
	end_date timestamp NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_chpl_product_number_history_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.listing_to_listing_map (
	listing_to_listing_map_id bigserial NOT NULL,
	parent_listing_id bigint NOT NULL,
	child_listing_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT listing_to_listing_map_pk PRIMARY KEY (listing_to_listing_map_id),
	CONSTRAINT parent_listing_fk FOREIGN KEY (parent_listing_id)
		REFERENCES openchpl.certified_product(certified_product_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT child_listing_fk FOREIGN KEY (child_listing_id)
		REFERENCES openchpl.certified_product(certified_product_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

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

CREATE TABLE openchpl.promoting_interoperability_user (
	id  bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	user_count bigint NOT NULL,
	user_count_date date NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT promoting_interoperability_user_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id) REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
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
CREATE TABLE openchpl.certification_criterion (
	certification_criterion_id bigserial NOT NULL,
	certification_edition_id bigint NOT NULL,
	number varchar(30),
	title varchar(250),
	description varchar(1000),
	automated_numerator_capable bool,
	automated_measure_capable bool,
	requires_sed bool,
	parent_criterion_id bigint,
	removed boolean NOT NULL DEFAULT false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_criterion_pk PRIMARY KEY (certification_criterion_id)

);
-- ddl-end --
-- ALTER TABLE openchpl.certification_criterion OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.test_participant_age(
	test_participant_age_id bigserial NOT NULL,
	age varchar(32),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_participant_age_pk PRIMARY KEY (test_participant_age_id)
);


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
	description text NOT NULL,
	task_success_avg_pct float NOT NULL,
	task_success_stddev_pct float NOT NULL,
	task_path_deviation_observed int NOT NULL,
	task_path_deviation_optimal int NOT NULL,
	task_time_avg_seconds bigint NOT NULL,
	task_time_stddev_seconds int NOT NULL,
	task_time_deviation_observed_avg_seconds int NOT NULL,
	task_time_deviation_optimal_avg_seconds int NOT NULL,
	task_errors_pct float NOT NULL,
	task_errors_stddev_pct float NOT NULL,
	task_rating_scale varchar(50) NOT NULL,
	task_rating float NOT NULL,
	task_rating_stddev float NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_task_pk PRIMARY KEY (test_task_id)
);

CREATE TABLE openchpl.test_participant(
	test_participant_id bigserial NOT NULL,
	gender varchar(100) NOT NULL,
    test_participant_age_id bigint NOT NULL,
	education_type_id bigint NOT NULL,
	occupation varchar(250) NOT NULL,
	professional_experience_months int NOT NULL,
	computer_experience_months int NOT NULL,
	product_experience_months int NOT NULL,
	assistive_technology_needs varchar(250) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_participant_pk PRIMARY KEY (test_participant_id),
	CONSTRAINT education_type_fk FOREIGN KEY (education_type_id)
	REFERENCES openchpl.education_type (education_type_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT test_participant_age_fk FOREIGN KEY (test_participant_age_id)
	REFERENCES openchpl.test_participant_age (test_participant_age_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.test_task_participant_map (
	id bigserial NOT NULL,
	test_task_id bigint NOT NULL,
	test_participant_id bigint NOT NULL,
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool DEFAULT false,
	CONSTRAINT test_task_participant_map_pk PRIMARY KEY (id),
	CONSTRAINT test_task_fk FOREIGN KEY (test_task_id)
		REFERENCES openchpl.test_task (test_task_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT test_participant_fk FOREIGN KEY (test_participant_id)
		REFERENCES openchpl.test_participant (test_participant_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

--allowable values per criteria for g1/g2
CREATE TABLE openchpl.macra_criteria_map (
	id bigserial not null,
	criteria_id bigint not null,
	value varchar(100) not null,
	name varchar(255) not null,
	description varchar(512) not null,
	removed boolean NOT NULL DEFAULT false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT macra_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT macra_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT macra_criteria_unique UNIQUE (criteria_id, value)
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
        attestation_answer bool,
	api_documentation varchar(1024),
	export_documentation varchar(1024),
	documentation_url varchar(1024),
	use_cases varchar(1024),
	service_base_url_list varchar(1024),
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

CREATE TABLE openchpl.test_standard (
	test_standard_id bigserial not null,
	number text not null,
	name varchar(1000),
	certification_edition_id bigint NOT NULL,
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

CREATE TABLE openchpl.optional_standard (
  id bigserial not null,
  citation varchar(256) not null,
  description text not null,
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL DEFAULT false,
  constraint optional_standard_pk primary key (id)
);

CREATE TABLE openchpl.optional_standard_criteria_map (
 id bigserial NOT NULL,
 optional_standard_id bigint NOT NULL,
 criterion_id bigint NOT NULL,
 creation_date timestamp NOT NULL DEFAULT NOW(),
 last_modified_date timestamp NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted bool NOT NULL DEFAULT false,
 CONSTRAINT optional_standard_criteria_map_pk PRIMARY KEY (id),
 CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
 REFERENCES openchpl.optional_standard (id)
 MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
 CONSTRAINT criterion_fk FOREIGN KEY (criterion_id)
 REFERENCES openchpl.certification_criterion (certification_criterion_id)
 MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.certification_result_optional_standard (
  id bigserial NOT NULL,
  certification_result_id bigint not null,
  optional_standard_id bigint,
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL default false,
  CONSTRAINT certification_result_optional_standard_pk PRIMARY KEY (id),
  CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
  REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
  REFERENCES openchpl.optional_standard (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION
);

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

CREATE TABLE openchpl.test_functionality (
	test_functionality_id bigserial not null,
	number varchar(200) not null,
	name varchar(1000),
	certification_edition_id bigint NOT NULL,
	practice_type_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint test_functionality_pk primary key (test_functionality_id),
    CONSTRAINT practice_type_fk FOREIGN KEY (practice_type_id)
        REFERENCES openchpl.practice_type (practice_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE openchpl.certification_result_test_functionality
(
	certification_result_test_functionality_id bigserial NOT NULL,
	certification_result_id bigint not null,
	test_functionality_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
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
	name varchar(200),
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
	deleted bool NOT NULL default false,
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

CREATE TABLE openchpl.conformance_method (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	removal_date date,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT conformance_method_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.conformance_method_criteria_map (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	conformance_method_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT conformance_method_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT conformance_method_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.test_procedure (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_procedure_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.test_procedure_criteria_map (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	test_procedure_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_procedure_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT test_procedure_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.test_data (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_data_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.test_data_criteria_map (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	test_data_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_data_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT test_procedure_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_data_fk FOREIGN KEY (test_data_id)
		REFERENCES openchpl.test_data (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.certification_result_conformance_method (
    id bigint NOT NULL,
    certification_result_id bigint NOT NULL,
    conformance_method_id bigint NOT NULL,
    version character varying(50),
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
    CONSTRAINT certification_result_conformance_method_pk PRIMARY KEY (id),
    CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
        REFERENCES openchpl.certification_result (certification_result_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
        REFERENCES openchpl.conformance_method (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.certification_result_test_procedure (
	id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	test_procedure_id bigint NOT NULL,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_procedure_pk PRIMARY KEY (id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure (id) MATCH FULL
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
	test_data_id bigint NOT NULL,
	version varchar(50) not null,
	alteration text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_data_pk PRIMARY KEY (certification_result_test_data_id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_data_fk FOREIGN KEY (test_data_id)
		REFERENCES openchpl.test_data (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE

);

-- object: openchpl.test_tool | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.test_tool CASCADE;
CREATE TABLE openchpl.test_tool(
	test_tool_id bigserial NOT NULL,
	name varchar(100) NOT NULL,
	description varchar(1000),
	retired boolean NOT NULL DEFAULT false,
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
	version varchar(50),
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
CREATE TABLE openchpl.testing_lab (
	testing_lab_id bigserial NOT NULL,
	testing_lab_code varchar(16),
	address_id bigint,
	name varchar(300) NOT NULL,
	accredidation_number varchar(25),
	website varchar(300),
	retired boolean not null default false,
        retirement_date timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT testing_lab_pk PRIMARY KEY (testing_lab_id)
);

create table openchpl.certified_product_testing_lab_map (
  	id bigserial not null,
  	certified_product_id bigint not null,
	testing_lab_id bigint not null,
  	creation_date timestamp without time zone not null default now(),
  	last_modified_date timestamp without time zone not null default now(),
  	last_modified_user bigint not null,
  	deleted boolean not null default false,
        constraint certified_product_testing_lab_map_pk primary key (id),
	constraint certified_product_fk foreign key (certified_product_id)
        references openchpl.certified_product (certified_product_id) match simple
        on update no action on delete no action,
	constraint testing_lab_fk foreign key (testing_lab_id)
        references openchpl.testing_lab (testing_lab_id) match simple
        on update no action on delete no action
);

CREATE TABLE openchpl.product_owner_history_map (
	id bigserial NOT NULL,
	product_id bigint NOT NULL,
	vendor_id bigint NOT NULL,
	transfer_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_owner_history_map_pk PRIMARY KEY (id),
	CONSTRAINT product_fk FOREIGN KEY (product_id)
		REFERENCES product (product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT vendor_fk FOREIGN KEY (vendor_id)
		REFERENCES vendor (vendor_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
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
	state varchar(250) NOT NULL,
	zipcode varchar(25) NOT NULL,
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

-- object: openchpl.contact | type: TABLE --
-- DROP TABLE IF EXISTS openchpl.contact CASCADE;
CREATE TABLE openchpl.contact(
	contact_id bigserial NOT NULL,
    full_name varchar(500) NOT NULL,
    friendly_name varchar(250),
	email varchar(250) NOT NULL,
	phone_number varchar(100),
	title varchar(250),
	signature_date timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT contact_pk PRIMARY KEY (contact_id)

);

ALTER TABLE openchpl.product ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

-- ddl-end --
-- ALTER TABLE openchpl.contact OWNER TO openchpl;
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

CREATE TABLE openchpl.certification_status_event (
	certification_status_event_id  bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	certification_status_id bigint NOT NULL,
	event_date timestamp NOT NULL DEFAULT NOW(),
	reason varchar(500),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_status_event_pk PRIMARY KEY (certification_status_event_id),
	CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id) REFERENCES openchpl.certification_status (certification_status_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

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

-- object: parent_object_fk | type: CONSTRAINT --
-- ALTER TABLE openchpl.acl_object_identity DROP CONSTRAINT IF EXISTS parent_object_fk CASCADE;
ALTER TABLE openchpl.acl_object_identity ADD CONSTRAINT parent_object_fk FOREIGN KEY (parent_object)
REFERENCES openchpl.acl_object_identity (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

CREATE TABLE openchpl.certified_product_upload (
	id bigserial NOT NULL,
	chpl_product_number text NOT NULL,
	certification_body_id bigint NOT NULL,
	vendor_name text,
	product_name text,
	version_name text,
	certification_date date,
	error_count integer,
	warning_count integer,
	status openchpl.certified_product_upload_status,
	contents text NOT NULL,
	certified_product_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_upload_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certified_product_id_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE UNIQUE INDEX certified_product_upload_unique_chpl_product_number
ON openchpl.certified_product_upload(chpl_product_number)
WHERE deleted = false;

-- object: openchpl.pending_certified_product | type: TABLE --
--DROP TABLE IF EXISTS openchpl.pending_certified_product CASCADE;
CREATE TABLE openchpl.pending_certified_product (
	pending_certified_product_id bigserial NOT NULL,
	processing boolean NOT NULL default false,
	error_count int,
	warning_count int,

	-- columns from the upload spreadsheet
	unique_id text,
	record_status varchar(50), --new, update, delete
	practice_type varchar(50), --Inpatient or Ambulatory
	testing_lab_name varchar(300),
	vendor_name text,
	product_name text,
	product_version text,
	certification_edition text,
	acb_certification_id text,
	certification_body_name text,
	product_classification_name varchar(250),
	product_classification_module varchar(260), -- we have no field in the db for this (it is only for Modular EHRs)
	certification_date timestamp,
	vendor_street_address text, -- not broken out into line1/line2
	vendor_city text,
	vendor_state text,
	vendor_zip_code text, -- maps to nothing in our address table
	vendor_website text,
	vendor_email text,
	vendor_contact_name text,
	vendor_phone text,
	vendor_mandatory_disclosures varchar(1024),
	self_developer bool,
	accessibility_certified boolean default false,
	test_report_url varchar(255), -- report_file_location
	sed_report_file_location varchar(255),
	sed_intended_user_description text,
	sed_testing_end timestamp,
	ics varchar(1024),
	has_qms boolean,

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

	-- fields we need for auditing/tracking
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_pk PRIMARY KEY (pending_certified_product_id)
);
-- ddl-end --
COMMENT ON TABLE openchpl.pending_certified_product IS 'A product that has been uploaded but not confirmed by the user';

ALTER TABLE openchpl.certified_product ADD CONSTRAINT pending_certified_product_fk 
	FOREIGN KEY (pending_certified_product_id)
	REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION;
	
-- ddl-end --
-- ALTER TABLE openchpl.pending_certified_product OWNER TO openchpl;
-- ddl-end --

create table openchpl.pending_certified_product_testing_lab_map (
  	id bigserial not null,
  	pending_certified_product_id bigint not null,
	testing_lab_id bigint not null,
	testing_lab_name varchar(300),
  	creation_date timestamp without time zone not null default now(),
  	last_modified_date timestamp without time zone not null default now(),
  	last_modified_user bigint not null,
  	deleted boolean not null default false,
        constraint pending_certified_product_testing_lab_map_pk primary key (id),
	constraint pending_certified_product_fk foreign key (pending_certified_product_id)
        references openchpl.pending_certified_product (pending_certified_product_id) match simple
        on update no action on delete no action,
	constraint testing_lab_fk foreign key (testing_lab_id)
        references openchpl.testing_lab (testing_lab_id) match simple
        on update no action on delete no action
);

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

CREATE TABLE openchpl.pending_certified_product_qms_standard(
	pending_certified_product_qms_standard_id bigserial not null,
	pending_certified_product_id bigint not null,
	qms_standard_id bigint,
	qms_standard_name text,
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
	targeted_user_name text,
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

CREATE TABLE openchpl.pending_certified_product_parent_listing
(
  id bigserial NOT NULL,
  pending_certified_product_id bigint NOT NULL,
  parent_certified_product_id bigint,
  parent_certified_product_unique_id character varying(50), --the entered value
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT pending_certified_product_parent_listing_pk PRIMARY KEY (id),
  CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT parent_certified_product_id_fk FOREIGN KEY (parent_certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.pending_test_participant (
	pending_test_participant_id bigserial not null,
	test_participant_unique_id varchar(20) not null,
	gender varchar(100),
    test_participant_age_id bigint,
	user_entered_age varchar(32),
	education_type_id bigint,
	user_entered_education_type varchar(250),
	occupation varchar(250),
	professional_experience_months text,
	computer_experience_months text,
	product_experience_months text,
	assistive_technology_needs varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	constraint pending_test_participant_pk primary key (pending_test_participant_id),
    CONSTRAINT test_participant_age_fk FOREIGN KEY (test_participant_age_id)
	REFERENCES openchpl.test_participant_age (test_participant_age_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_test_task (
	pending_test_task_id bigserial not null,
	test_task_unique_id varchar(20) not null,
	description text,
	task_success_avg_pct text,
	task_success_stddev_pct text,
	task_path_deviation_observed text,
	task_path_deviation_optimal text,
	task_time_avg_seconds text,
	task_time_stddev_seconds text,
	task_time_deviation_observed_avg_seconds text,
	task_time_deviation_optimal_avg_seconds text,
	task_errors_pct text,
	task_errors_stddev_pct text,
	task_rating_scale varchar(50),
	task_rating text,
	task_rating_stddev text,
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
	meets_criteria boolean not null,
	gap bool,
	sed bool,
	g1_success bool,
	g2_success bool,
        attestation_answer bool,
	api_documentation text,
	export_documentation text,
	documentation_url text,
	use_cases text,
        service_base_url_list text,
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

CREATE TABLE openchpl.pending_certification_result_optional_standard (
	pending_certification_result_optional_standard_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	optional_standard_id bigint,
	citation text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_optional_standard_pk PRIMARY KEY (pending_certification_result_optional_standard_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
      REFERENCES openchpl.optional_standard (id) MATCH SIMPLE
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
  grouping text,
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

CREATE TABLE openchpl.pending_certification_result_conformance_method (
	id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	conformance_method_id bigint,
	conformance_method_name text,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_conformance_method_pk PRIMARY KEY (id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_certification_result_test_procedure (
	id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	test_procedure_id bigint,
	test_procedure_name text,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_procedure_pk PRIMARY KEY (id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT test_procedure_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_certification_result_test_data(
	pending_certification_result_test_data_id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	test_data_id bigint,
	test_data_name text,
	version varchar(50) not null,
	alteration text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_data_pk PRIMARY KEY (pending_certification_result_test_data_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_data_fk FOREIGN KEY (test_data_id)
		REFERENCES openchpl.test_data (id) MATCH FULL
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
	user_permission_id bigint NOT NULL,
	permission_object_id bigint, -- acb id or atl id (null if other type of permission)
	invite_token varchar(500),
	confirm_token varchar(500),
	created_user_id bigint DEFAULT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT invited_user_pk PRIMARY KEY (invited_user_id),
	CONSTRAINT invite_token_unique UNIQUE (invite_token),
	CONSTRAINT confirm_token_unique UNIQUE (confirm_token),
	CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
-- ddl-end --
COMMENT ON TABLE openchpl.invited_user IS 'A user that has been invited to use the CHPL system.';
-- ddl-end --
-- ALTER TABLE openchpl.invited_user OWNER TO openchpl;
-- ddl-end --

CREATE TABLE openchpl.api_key
(
  api_key_id bigserial NOT NULL,
  api_key character varying(32) NOT NULL,
  email character varying(256) NOT NULL,
  name_organization character varying(256),
  unrestricted boolean NOT NULL DEFAULT false,
  last_used_date timestamp without time zone DEFAULT now(),
  delete_warning_sent_date timestamp without time zone,
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT pk_api_key_id PRIMARY KEY (api_key_id)
);

CREATE OR REPLACE FUNCTION openchpl.reset_api_key_delete_warning_sent_date_func()
RETURNS TRIGGER 
AS $$
BEGIN
	IF NEW.last_used_date <> OLD.last_used_date THEN
		NEW.delete_warning_sent_date = NULL;
	END IF;
	RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER reset_api_key_delete_warning_sent_date BEFORE UPDATE on openchpl.api_key FOR EACH ROW EXECUTE PROCEDURE openchpl.reset_api_key_delete_warning_sent_date_func();

CREATE TABLE openchpl.api_key_activity
(
  api_key_activity_id bigserial NOT NULL,
  api_key_id bigint NOT NULL,
  api_call_path character varying(2083),
  api_call_method character varying(16),
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT api_key_activity_pk PRIMARY KEY (api_key_activity_id)
);

-- ALTER TABLE openchpl.api_key_activity  OWNER TO openchpl;

ALTER TABLE openchpl.api_key_activity ADD CONSTRAINT api_key_fk FOREIGN KEY (api_key_id) REFERENCES openchpl.api_key (api_key_id);

CREATE TABLE openchpl.surveillance_type (
	id bigserial not null,
	name varchar(50) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_type_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_type_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance_requirement_type (
	id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_requirement_type_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_requirement_type_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance_result (
	id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_result_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_result_name_key UNIQUE (name)
);

CREATE TABLE openchpl.surveillance (
	id bigserial not null,
	certified_product_id bigint not null,
	friendly_id varchar(10), -- will be null when inserted but filled in with a trigger. in practice, will not be null
	start_date date not null,
	end_date date,
	type_id bigint not null,
	randomized_sites_used integer, -- required if type is Randomized
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
		REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT type_fk FOREIGN KEY (type_id)
		REFERENCES openchpl.surveillance_type (id)
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT user_permission_id_fk FOREIGN KEY (user_permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.surveillance_requirement (
	id bigserial not null,
	surveillance_id bigint not null,
	type_id bigint not null,
	-- either criteria or requirement text is required
	certification_criterion_id bigint,
	requirement varchar(1024),
	result_id bigint, -- required if parent surveillance has an end date
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_requirement_id PRIMARY KEY (id),
	CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT type_fk FOREIGN KEY (type_id)
		REFERENCES openchpl.surveillance_requirement_type (id)
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT result_fk FOREIGN KEY (result_id)
		REFERENCES openchpl.surveillance_result (id)
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE openchpl.surveillance_nonconformity (
	id bigserial not null,
	surveillance_requirement_id bigint not null,
	-- either criteria or type is required
	certification_criterion_id bigint,
	nonconformity_type varchar(1024),
	non_conformity_close_date date,
	date_of_determination date not null,
	corrective_action_plan_approval_date date,
	corrective_action_start_date date,
	corrective_action_must_complete_date date,
	corrective_action_end_date date,
	summary varchar(2048) not null, -- required if nonconformity type+certification_criterion is not null
	findings text not null, -- required if nonconformity type+certification_criterion is not null
	sites_passed integer, -- only pertintent to Randomized surveillance
	total_sites integer,
	developer_explanation text,
	resolution text, -- required if status is Closed
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_nonconformity_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_requirement_fk FOREIGN KEY (surveillance_requirement_id)
		REFERENCES openchpl.surveillance_requirement (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT nonconformity_status_fk FOREIGN KEY (nonconformity_status_id)
		REFERENCES openchpl.nonconformity_status (id)
		MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE openchpl.surveillance_nonconformity_document (
	id bigserial not null,
	surveillance_nonconformity_id bigint not null,
	filename varchar(250) NOT NULL,
	filetype varchar(250),
	filedata bytea not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_nonconformity_document_pk PRIMARY KEY (id),
	CONSTRAINT surveillance_nonconformity_fk FOREIGN KEY (surveillance_nonconformity_id)
		REFERENCES openchpl.surveillance_nonconformity (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.surveillance_outcome (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_outcome_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.surveillance_process_type (
    id bigserial not null,
	name varchar(100) not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT surveillance_process_type_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.pending_surveillance (
	id bigserial not null,
	surveillance_id_to_replace varchar(10),
	certified_product_id bigint,
	certified_product_unique_id varchar(30),
	start_date date,
	end_date date,
	type_value varchar(30),
	randomized_sites_used integer,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_pk PRIMARY KEY (id),
	CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
		REFERENCES openchpl.user_permission (user_permission_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_surveillance_requirement (
	id bigserial not null,
	pending_surveillance_id bigint not null,
	type_value varchar(50),
	requirement varchar(1024),
	certification_criterion_id bigint,
	result_value varchar(30),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_requirement_id PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_fk FOREIGN KEY (pending_surveillance_id)
		REFERENCES openchpl.pending_surveillance (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_surveillance_nonconformity (
	id bigserial not null,
	pending_surveillance_requirement_id bigint not null,
	nonconformity_type varchar(1024),
	certification_criterion_id bigint,
	nonconformity_status varchar(15),
	non_conformity_close_date date,
	date_of_determination date,
	corrective_action_plan_approval_date date,
	corrective_action_start_date date,
	corrective_action_must_complete_date date,
	corrective_action_end_date date,
	summary varchar(2048),
	findings text,
	sites_passed integer,
	total_sites integer,
	developer_explanation text,
	resolution text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_nonconformity_pk PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_requirement_fk FOREIGN KEY (pending_surveillance_requirement_id)
		REFERENCES openchpl.pending_surveillance_requirement (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.pending_surveillance_validation (
	id bigserial NOT NULL,
	pending_surveillance_id bigint NOT NULL,
	message_type openchpl.validation_message_type NOT NULL,
	message text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_validation_pk PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_fk FOREIGN KEY (pending_surveillance_id)
		REFERENCES openchpl.pending_surveillance (id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

-- friendly id trigger/function

CREATE OR REPLACE FUNCTION openchpl.friendly_surveillance_id_func()
RETURNS TRIGGER AS $$
DECLARE
	v_num_survs text;
BEGIN
	SELECT cast (count(*)+1 as text) INTO v_num_survs from openchpl.surveillance where certified_product_id = NEW.certified_product_id;
	NEW.friendly_id = 'SURV' || lpad(v_num_survs, 2, '0');
	RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER surveillance_friendly_id BEFORE INSERT on openchpl.surveillance FOR EACH ROW EXECUTE PROCEDURE openchpl.friendly_surveillance_id_func();

-- Table: openchpl.ehr_certification_id

-- DROP TABLE openchpl.ehr_certification_id;

CREATE TABLE openchpl.ehr_certification_id
(
  ehr_certification_id_id bigserial,
  key text NOT NULL, -- The unique product collection key
  year text NOT NULL, -- The attestation year
  certification_id text NOT NULL, -- The unqiue CMS EHR Certification ID
  practice_type_id bigint, -- The practice type if applicable (e.g. 2011)
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
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
GRANT ALL ON TABLE openchpl.ehr_certification_id TO openchpl;
COMMENT ON TABLE openchpl.ehr_certification_id
  IS 'CMS EHR Certification IDs';
COMMENT ON COLUMN openchpl.ehr_certification_id.key IS 'The unique product collection key';
COMMENT ON COLUMN openchpl.ehr_certification_id.year IS 'The attestation year';
COMMENT ON COLUMN openchpl.ehr_certification_id.certification_id IS 'The unqiue CMS EHR Certification ID';
COMMENT ON COLUMN openchpl.ehr_certification_id.practice_type_id IS 'The practice type if applicable (e.g. 2011)';
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
  ehr_certification_id_product_map_id bigserial,
  ehr_certification_id_id bigint NOT NULL,
  certified_product_id bigint NOT NULL,
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
  deleted bool NOT NULL DEFAULT false,
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
-- ALTER TABLE openchpl.ehr_certification_id_product_map OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.ehr_certification_id_product_map TO openchpl;

CREATE TABLE openchpl.upload_template_version (
	id bigserial NOT NULL,
	name varchar(500) NOT NULL,
	available_as_of_date timestamp DEFAULT NOW(),
	deprecated bool NOT NULL DEFAULT false,
	header_csv text NOT NULL, --comma-separated string with each header column. used to determine which version a user is uploading.
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT upload_template_version_pk PRIMARY KEY (id)
);

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
	reason text,
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
	certification_status_change_reason text,
	reason text,
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
	reason text,
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

CREATE TABLE openchpl.nonconformity_type_statistics
(
  	id bigserial NOT NULL,
	nonconformity_type varchar(1024),
	criterion_id bigint,
	nonconformity_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  	CONSTRAINT nonconformity_type_statistics_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE openchpl.sed_participants_statistics_count
(
  	id bigserial NOT NULL,
	participant_count bigint NOT NULL,
	sed_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  	CONSTRAINT sed_participants_statistics_count_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.participant_gender_statistics
(
  	id bigserial NOT NULL,
  	male_count bigint NOT NULL,
	female_count bigint NOT NULL,
	unknown_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_gender_statistics_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.participant_age_statistics
(
  	id bigserial NOT NULL,
  	age_count bigint NOT NULL,
	test_participant_age_id bigint NOT NULL REFERENCES openchpl.test_participant_age (test_participant_age_id),
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_age_statistics_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.participant_education_statistics
(
  	id bigserial NOT NULL,
  	education_count bigint NOT NULL,
	education_type_id bigint NOT NULL REFERENCES openchpl.education_type (education_type_id),
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_education_statistics_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.participant_experience_statistics
(
  	id bigserial NOT NULL,
	experience_type_id bigint NOT NULL,
  	participant_count bigint NOT NULL,
	experience_months bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_experience_statistics_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.criterion_product_statistics (
        id bigserial NOT NULL,
        product_count bigint NOT NULL,
        certification_criterion_id bigint NOT NULL REFERENCES openchpl.certification_criterion (certification_criterion_id),
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT criterion_product_statistics_pk PRIMARY KEY (id)
        );

CREATE TABLE openchpl.incumbent_developers_statistics (
        id bigserial NOT NULL,
        new_count bigint NOT NULL,
        incumbent_count bigint NOT NULL,
        old_certification_edition_id bigint NOT NULL,
        new_certification_edition_id bigint NOT NULL,
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT incumbent_developers_statistics_pk PRIMARY KEY (id),
        CONSTRAINT old_certification_edition_fk FOREIGN KEY (old_certification_edition_id)
        REFERENCES openchpl.certification_edition (certification_edition_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT new_certification_edition_fk FOREIGN KEY (new_certification_edition_id)
        REFERENCES openchpl.certification_edition (certification_edition_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
        );

CREATE TABLE openchpl.listing_count_statistics (
        id bigserial NOT NULL,
        developer_count bigint NOT NULL,
        product_count bigint NOT NULL,
        certification_edition_id bigint NOT NULL,
        certification_status_id bigint NOT NULL,
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT listing_count_statistics_pk PRIMARY KEY (id),
        CONSTRAINT certification_edition_fk FOREIGN KEY (certification_edition_id)
        REFERENCES openchpl.certification_edition (certification_edition_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id)
        REFERENCES openchpl.certification_status (certification_status_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
        );

CREATE TABLE openchpl.summary_statistics
(
    summary_statistics_id bigserial NOT NULL,
    end_date timestamp without time zone NOT NULL,
    summary_statistics json,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT summary_statistics_pk PRIMARY KEY (summary_statistics_id)
);

CREATE TABLE openchpl.inheritance_errors_report
(
    id bigserial NOT NULL,
    chpl_product_number varchar(250) NOT NULL,
    developer varchar(300) NOT NULL,
    product varchar(300) NOT NULL,
    version varchar(250) NOT NULL,
    certification_body_id bigint NOT NULL,
    url varchar(250) NOT NULL,
    reason text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT inheritance_errors_report_id_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_id_fk FOREIGN KEY (certification_body_id)
        REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.broken_surveillance_rules
(
    id bigserial NOT NULL,
    developer varchar(300) NOT NULL,
    product varchar(300) NOT NULL,
    version varchar(250) NOT NULL,
    chpl_product_number varchar(250) NOT NULL,
    url varchar(250) NOT NULL,
    certification_body_id bigint NOT NULL,
    certification_status varchar(64) NOT NULL,
    date_of_last_status_change varchar(64) NOT NULL,
    surveillance_id varchar(64),
    date_surveillance_began varchar(64),
    date_surveillance_ended varchar(64),
    surveillance_type varchar(64),
    lengthy_suspension_rule varchar(64),
    cap_not_approved_rule varchar(64),
    cap_not_started_rule varchar(64),
    cap_not_completed_rule varchar(64),
    cap_not_closed_rule varchar(64),
    closed_cap_with_open_nonconformity_rule varchar(64),
    nonconformity boolean NOT NULL,
    nonconformity_status varchar(64),
	non_conformity_close_date date,
    nonconformity_criteria varchar(64),
    date_of_determination_of_nonconformity varchar(64),
    corrective_action_plan_approved_date varchar(64),
    date_corrective_action_began varchar(64),
    date_corrective_action_must_be_completed varchar(64),
    date_corrective_action_was_completed varchar(64),
    number_of_days_from_determination_to_cap_approval bigint,
    number_of_days_from_determination_to_present bigint,
    number_of_days_from_cap_approval_to_cap_began bigint,
    number_of_days_from_cap_approval_to_present bigint,
    number_of_days_from_cap_began_to_cap_completed bigint,
    number_of_days_from_cap_began_to_present bigint,
    difference_from_cap_completed_and_cap_must_be_completed bigint,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT broken_surveillance_rules_id_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_id_fk FOREIGN KEY (certification_body_id)
        REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.url_type (
	id bigserial NOT NULL,
	name varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_type_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.url_check_result (
	id bigserial NOT NULL,
	url_type_id bigint NOT NULL,
	url text NOT NULL,
	response_code int, --allow null in case something times out?
	response_message text, -- if there is some additional text about the response (error message?)
	checked_date timestamp, -- null to indicate we know about the URL in the system but haven't checked it yet
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT url_check_result_pk PRIMARY KEY (id),
	CONSTRAINT url_type_fk FOREIGN KEY (url_type_id)
		REFERENCES openchpl.url_type (id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.test_functionality_criteria_map
(
    id bigserial NOT NULL,
    criteria_id bigint NOT NULL,
    test_functionality_id bigint NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT test_functionality_criteria_map_pk PRIMARY KEY (id),
    CONSTRAINT test_functionality_criteria_fk FOREIGN KEY (criteria_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT test_functionality_fk FOREIGN KEY (test_functionality_id)
        REFERENCES openchpl.test_functionality (test_functionality_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE openchpl.file_type
(
    file_type_id bigserial NOT NULL,
    name text NOT NULL,
    description text,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT file_type_pk PRIMARY KEY (file_type_id)
);

CREATE TABLE openchpl.chpl_file
(
    chpl_file_id bigserial NOT NULL,
    file_type_id bigint NOT NULL,
    file_name text,
    content_type text,
    file_data bytea NOT NULL,
    associated_date timestamp without time zone NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT chpl_file_pk PRIMARY KEY (chpl_file_id),
    CONSTRAINT file_type_fk FOREIGN KEY (file_type_id)
        REFERENCES openchpl.file_type (file_type_id) MATCH FULL
        ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.user_certification_body_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	certification_body_id bigint NOT NULL,
	retired bool NOT NULL DEFAULT false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_certification_body_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.user_testing_lab_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	testing_lab_id bigint NOT NULL,
	retired bool NOT NULL DEFAULT false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_testing_lab_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT testing_lab_fk FOREIGN KEY (testing_lab_id)
		REFERENCES openchpl.testing_lab (testing_lab_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.user_developer_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_developer_map_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.filter_type (
	filter_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT filter_type_pk PRIMARY KEY (filter_type_id)
);

CREATE TABLE openchpl.filter (
	filter_id bigserial not null,
	name text not null,
	user_id bigint not null,
	filter_type_id bigint not null,
	filter json not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT filter_id_pk PRIMARY KEY (filter_id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
        REFERENCES openchpl.user (user_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT filter_type_fk FOREIGN KEY (filter_type_id)
        REFERENCES openchpl.filter_type (filter_type_id) MATCH FULL
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.complainant_type (
	complainant_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complainant_type_pk PRIMARY KEY (complainant_type_id)
);

CREATE TABLE openchpl.complaint (
    complaint_id bigserial not null,
    certification_body_id bigint not null,
    complainant_type_id bigint not null,
    complainant_type_other text,
    onc_complaint_id text,
    acb_complaint_id text,
    received_date date not null,
    summary text not null,
    actions text,
    complainant_contacted boolean not null DEFAULT false,
    developer_contacted boolean not null DEFAULT false,
    onc_atl_contacted boolean not null DEFAULT false,
    flag_for_onc_review boolean not null DEFAULT false,
    closed_date date,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_pk PRIMARY KEY (complaint_id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT complainant_type_fk FOREIGN KEY (complainant_type_id)
		REFERENCES openchpl.complainant_type (complainant_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TABLE openchpl.complaint_criterion_map (
    complaint_criterion_map_id bigserial not null,
    complaint_id bigint not null,
    certification_criterion_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_criterion_map_pk PRIMARY KEY (complaint_criterion_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.complaint_listing_map (
    complaint_listing_map_id bigserial not null,
    complaint_id bigint not null,
    listing_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_listing_map_pk PRIMARY KEY (complaint_listing_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.complaint_surveillance_map (
    complaint_surveillance_map_id bigserial not null,
    complaint_id bigint not null,
    surveillance_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_surveillance_map_pk PRIMARY KEY (complaint_surveillance_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.annual_report (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	year integer NOT NULL,
	obstacle_summary text,
	findings_summary text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT annual_report_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);

--lookup table for quarter
CREATE TABLE openchpl.quarter (
	id bigserial NOT NULL,
	name varchar(2) NOT NULL,
	quarter_begin_month integer NOT NULL,
	quarter_begin_day integer NOT NULL,
	quarter_end_month integer NOT NULL,
	quarter_end_day integer NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT quarter_pk PRIMARY KEY (id),
	CONSTRAINT quarter_name_unique UNIQUE (name)
);

CREATE TABLE openchpl.quarterly_report (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	year integer NOT NULL,
	quarter_id bigint NOT NULL,
	activities_and_outcomes_summary text,
	reactive_surveillance_summary text,
	prioritized_element_summary text,
	disclosure_requirements_summary text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT quarterly_report_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT quarter_fk FOREIGN KEY (quarter_id)
      REFERENCES openchpl.quarter (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.quarterly_report_excluded_listing_map (
    id bigserial not null,
    quarterly_report_id bigint not null,
    listing_id bigint not null,
	reason text not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT quarterly_report_excluded_listing_map_pk PRIMARY KEY (id),
    CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.quarterly_report_surveillance_map (
	id bigserial not null,
	quarterly_report_id bigint not null,
	surveillance_id bigint not null,
	k1_reviewed boolean,
	surveillance_outcome_id bigint,
	surveillance_outcome_other text,
	surveillance_process_type_id bigint,
	surveillance_process_type_other text,
	grounds_for_initiating text,
	nonconformity_causes text,
	nonconformity_nature text,
	steps_to_surveil text,
	steps_to_engage text,
	additional_costs_evaluation text,
	limitations_evaluation text,
	nondisclosure_evaluation text,
	direction_developer_resolution text,
	completed_cap_verification text,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT quarterly_report_surveillance_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_outcome_fk FOREIGN KEY (surveillance_outcome_id)
		REFERENCES openchpl.surveillance_outcome (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_process_type_fk FOREIGN KEY (surveillance_process_type_id)
		REFERENCES openchpl.surveillance_process_type (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.change_request_type (
    id bigserial NOT NULL,
    name text NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_type_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.change_request_status_type (
    id bigserial NOT NULL,
    name text NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_status_type_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.change_request (
    id bigserial NOT NULL,
    change_request_type_id bigint NOT NULL,
    developer_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_pk PRIMARY KEY (id),
    CONSTRAINT change_request_type_fk FOREIGN KEY (change_request_type_id)
	    REFERENCES openchpl.change_request_type (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT developer_fk FOREIGN KEY (developer_id)
        REFERENCES openchpl.vendor (vendor_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.change_request_status (
    id bigserial NOT NULL,
    change_request_id bigint NOT NULL,
    change_request_status_type_id bigint NOT NULL,
    status_change_date timestamp NOT NULL,
    comment text,
    user_permission_id bigint NOT NULL,
    certification_body_id bigint,
    creation_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_user bigint NOT NULL,
    deleted bool NOT NULL DEFAULT false,
    CONSTRAINT change_request_status_pk PRIMARY KEY (id),
    CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
	    REFERENCES openchpl.change_request (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT change_request_status_type_fk FOREIGN KEY (change_request_status_type_id)
	    REFERENCES openchpl.change_request_status_type (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
	    REFERENCES openchpl.user_permission (user_permission_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
	    REFERENCES openchpl.certification_body (certification_body_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.change_request_developer_demographics (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	self_developer boolean,
 	website text,
	street_line_1 varchar(250),
	street_line_2 varchar(250),
	city varchar(250),
	state varchar(250),
	zipcode varchar(25),
	country varchar(250),
	full_name varchar(500),
	email varchar(250),
	phone_number varchar(100),
	title varchar(250),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_developer_demographics_pk PRIMARY KEY (id),
	CONSTRAINT change_request_fk FOREIGN KEY (change_request_id)
	    REFERENCES openchpl.change_request (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.svap (
    id bigserial NOT NULL,
    regulatory_text_citation varchar(30) NOT NULL,
    approved_standard_version text NOT NULL,
	replaced bool NOT NULL DEFAULT false,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT svap_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.svap_criteria_map (
    id bigserial NOT NULL,
    svap_id bigint NOT NULL,
    criteria_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT svap_criteria_map_pk PRIMARY KEY (id),
    CONSTRAINT svap_fk FOREIGN KEY (svap_id)
	    REFERENCES openchpl.svap (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT svap_criteria_map_fk FOREIGN KEY (criteria_id)
	    REFERENCES openchpl.certification_criterion (certification_criterion_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TABLE openchpl.certification_result_svap (
    id bigserial NOT NULL,
    certification_result_id bigint NOT NULL,
    svap_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
    CONSTRAINT certification_result_svap_pk PRIMARY KEY (id),
    CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
	    REFERENCES openchpl.certification_result (certification_result_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT svap_fk FOREIGN KEY (svap_id)
	    REFERENCES openchpl.svap (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT

CREATE TABLE openchpl.measure_domain (
 id                 bigserial NOT NULL,
 domain             text NOT NULL,
 creation_date      timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_measure_domain PRIMARY KEY ( id )
);

CREATE TABLE openchpl.measure_type (
 id                 bigserial NOT NULL,
 name               text NOT NULL,
 creation_date      timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_measure_type PRIMARY KEY ( id )
);

CREATE TABLE openchpl.measure (
 id                          bigserial NOT NULL,
 measure_domain_id              bigint NOT NULL,
 required_test_abbr          text NOT NULL,
 required_test               text NOT NULL,
 measure_name                text NOT NULL,
 criteria_selection_required boolean NOT NULL,
 removed                     boolean NOT NULL,
 creation_date               timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date          timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user          bigint NOT NULL,
 deleted                     boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_measure PRIMARY KEY ( id ),
 CONSTRAINT measure_domain_fk FOREIGN KEY (measure_domain_id)
      REFERENCES openchpl.measure_domain (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.allowed_measure_criteria (
 id                         bigserial NOT NULL,
 certification_criterion_id bigint NOT NULL,
 measure_id                 bigint NOT NULL,
 macra_criteria_map_id      bigint,
 creation_date              timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date         timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user         bigint NOT NULL,
 deleted                    boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_allowed_measure_criteria PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT measure_fk FOREIGN KEY (measure_id)
      REFERENCES openchpl.measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT macra_criteria_map_fk FOREIGN KEY (macra_criteria_map_id)
      REFERENCES openchpl.macra_criteria_map (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
 
 );

CREATE TABLE openchpl.certified_product_measure (
 id                   bigserial NOT NULL,
 certified_product_id bigint NOT NULL,
 measure_id           bigint NOT NULL,
 measure_type_id      bigint NOT NULL,
 creation_date        timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date   timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user   bigint NOT NULL,
 deleted              boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_certified_product_measures PRIMARY KEY ( id ),
 CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT measure_fk FOREIGN KEY (measure_id)
      REFERENCES openchpl.measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT measure_type_fk FOREIGN KEY (measure_type_id)
      REFERENCES openchpl.measure_type (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.certified_product_measure_criteria (
 id                                bigserial NOT NULL,
 certification_criterion_id        bigint NOT NULL,
 certified_product_measure_id      bigint NOT NULL,
 creation_date                     timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date                timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user                bigint NOT NULL,
 deleted                           boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_certified_products_mips_measure_criteria PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT certified_product_measure_fk FOREIGN KEY (certified_product_measure_id)
      REFERENCES openchpl.certified_product_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.pending_certified_product_measure (
 id                           bigserial NOT NULL,
 pending_certified_product_id bigint NOT NULL,
 measure_id                   bigint,
 measure_type_id              bigint,
 uploaded_value               text, 
 creation_date                timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date           timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user           bigint NOT NULL,
 deleted                      boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_pending_certified_product_measures PRIMARY KEY ( id ),
 CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT measure_fk FOREIGN KEY (measure_id)
      REFERENCES openchpl.measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT measure_type_fk FOREIGN KEY (measure_type_id)
      REFERENCES openchpl.measure_type (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.pending_certified_product_measure_criteria (
 id                                        bigserial NOT NULL,
 certification_criterion_id                bigint NOT NULL,
 pending_certified_product_measure_id      bigint NOT NULL,
 creation_date                             timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date                        timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user                        bigint NOT NULL,
 deleted                                   boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_pending_certified_products_mips_measure_criteria PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT pending_certified_product_measure_fk FOREIGN KEY (pending_certified_product_measure_id)
      REFERENCES openchpl.pending_certified_product_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.certification_criterion_attribute (
  id                      bigserial NOT NULL,
  criterion_id            bigint NOT NULL,
  optional_standard       bool NOT NULL DEFAULT false,
  svap                    bool NOT NULL DEFAULT false,
  service_base_url_list   bool NOT NULL DEFAULT false,
  test_procedure          bool NOT NULL DEFAULT false,
  conformance_method      bool NOT NULL DEFAULT false,
  test_tool               bool NOT NULL DEFAULT false,
  creation_date           timestamp NOT NULL DEFAULT NOW(),
  last_modified_date      timestamp NOT NULL DEFAULT NOW(),
  last_modified_user      bigint NOT NULL,
  deleted                 bool NOT NULL DEFAULT false,
  CONSTRAINT certification_criterion_attribute_pk PRIMARY KEY (id),
  CONSTRAINT certification_criterion_id_fk FOREIGN KEY (criterion_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT criterion_unique UNIQUE (criterion_id)
);

CREATE TABLE openchpl.listing_validation_report (
  id                        bigserial NOT NULL,
  certified_product_id      bigint NOT NULL,
  chpl_product_number       text NOT NULL,
  certification_body_id     bigint NOT NULL,
  product                   text NOT NULL,
  version                   text NOT NULL,
  developer                 text NOT NULL,
  certification_body        text NOT NULL,
  certification_status_name text NOT NULL,
  listing_modified_date     timestamp NOT NULL,
  error_message             text NOT NULL,
  report_date               timestamp NOT NULL DEFAULT NOW(),
  creation_date             timestamp NOT NULL DEFAULT NOW(),
  last_modified_date        timestamp NOT NULL DEFAULT NOW(),
  last_modified_user        bigint NOT NULL,
  deleted                   boolean NOT NULL DEFAULT false,
  CONSTRAINT PK_listing_validation_report PRIMARY KEY ( id )
);

CREATE TABLE openchpl.api_key_request (
  id                 bigserial NOT NULL,
  name_organization  text NOT NULL,
  email              text NOT NULL,
  api_request_token  text NOT NULL,
  creation_date      timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted            bool NOT NULL DEFAULT false,
  CONSTRAINT api_key_request_id_pk PRIMARY KEY (id),
);

CREATE TABLE openchpl.criterion_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT criterion_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_criterion_listing_stat_date on openchpl.criterion_listing_statistic (statistic_date);

CREATE TABLE openchpl.criterion_upgraded_from_original_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT criterion_upgraded_from_original_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_criterion_upgraded_from_original_listing_stat_date on openchpl.criterion_upgraded_from_original_listing_statistic (statistic_date);

CREATE TABLE openchpl.cures_criterion_upgraded_without_original_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT cures_criterion_upgraded_without_original_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_cures_criterion_upgraded_without_original_listing_stat_date on openchpl.cures_criterion_upgraded_without_original_listing_statistic (statistic_date);

CREATE TABLE openchpl.privacy_and_security_listing_statistic (
	id bigserial NOT NULL,
	listings_with_privacy_and_security_count bigint NOT NULL,
	listings_requiring_privacy_and_security_count bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT privacy_and_security_listing_statistic_pk PRIMARY KEY (id)
);
CREATE INDEX idx_privacy_and_security_listing_stat_date on openchpl.privacy_and_security_listing_statistic (statistic_date);

CREATE TABLE openchpl.listing_cures_status_statistic (
	id bigserial NOT NULL,
	cures_listings_count bigint NOT NULL,
	total_listings_count bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_cures_status_statistic_pk PRIMARY KEY (id)
);
CREATE INDEX idx_listing_cures_status_stat_date on openchpl.listing_cures_status_statistic (statistic_date);

CREATE TABLE openchpl.listing_to_criterion_for_cures_achievement_statistic (
	id bigserial NOT NULL,
	listing_id bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_to_criterion_for_cures_achievement_statistic_pk PRIMARY KEY (id),
	CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_listing_to_criterion_for_cures_achievement_stat_date on openchpl.listing_to_criterion_for_cures_achievement_statistic (statistic_date);

CREATE TABLE openchpl.cures_criteria_statistics_by_acb (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	original_criterion_id bigint,
	cures_criterion_id bigint,
	original_criterion_upgraded_count bigint,
	cures_criterion_created_count bigint,
    criteria_needing_upgrade_count bigint,
	statistic_date timestamp NOT NULL DEFAULT NOW(),
	CONSTRAINT cures_criteria_statistics_by_acb_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_id_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT original_criterion_id_fk FOREIGN KEY (original_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT cures_criterion_id_fk FOREIGN KEY (cures_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.cures_listing_statistics_by_acb (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	cures_listing_without_cures_criteria_count bigint,
	cures_listing_withcures_criteria_count bigint,
	non_cures_listing_count bigint,
	statistic_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cures_listing_statistics_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_id_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE openchpl.deprecated_api (
	id bigserial NOT NULL,
	http_method varchar(10) NOT NULL,
	api_operation text NOT NULL,
	request_parameter text,
	change_description text NOT NULL,
	removal_date date NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_pk PRIMARY KEY (id),
	CONSTRAINT deprecated_api_method_and_api_operation_and_parameter_idx UNIQUE (http_method, api_operation, request_parameter)
);

CREATE TABLE openchpl.deprecated_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	deprecated_api_id bigint NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
	notification_sent timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_usage_pk PRIMARY KEY (id),
	CONSTRAINT api_key_id_fk FOREIGN KEY (api_key_id)
      REFERENCES openchpl.api_key (api_key_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_api_id_fk FOREIGN KEY (deprecated_api_id)
      REFERENCES openchpl.deprecated_api (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_api_usage_api_key_and_deprecated_api_idx UNIQUE (api_key_id, deprecated_api_id, notification_sent)
);

CREATE TABLE openchpl.deprecated_response_field_api (
	id bigserial NOT NULL,
	http_method varchar(10) NOT NULL,
	api_operation text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_response_field_api_pk PRIMARY KEY (id),
	CONSTRAINT deprecated_response_field_api_method_and_api_operation_idx UNIQUE (http_method, api_operation)
);

CREATE TABLE openchpl.deprecated_response_field (
	id bigserial NOT NULL,
	deprecated_api_id bigint NOT NULL,
	response_field text,
	removal_date date NOT NULL,
	change_description text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_response_field_pk PRIMARY KEY (id),
	CONSTRAINT deprecated_api_id_fk FOREIGN KEY (deprecated_api_id)
      REFERENCES openchpl.deprecated_response_field_api (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_response_field_response_field_idx UNIQUE (deprecated_api_id, response_field)
);

CREATE TABLE openchpl.deprecated_response_field_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	deprecated_response_field_api_id bigint NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
	notification_sent timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_response_field_api_usage_pk PRIMARY KEY (id),
	CONSTRAINT api_key_id_fk FOREIGN KEY (api_key_id)
      REFERENCES openchpl.api_key (api_key_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_api_id_fk FOREIGN KEY (deprecated_api_id)
      REFERENCES openchpl.deprecated_response_field_api (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_response_field_api_usage_idx UNIQUE (api_key_id, deprecated_response_field_api_id, notification_sent)
);

CREATE TABLE openchpl.test_tool_criteria_map (
	id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	test_tool_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_tool_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT criteria_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_tool_fk FOREIGN KEY (test_tool_id)
		REFERENCES openchpl.test_tool (test_tool_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS openchpl.attestation_period (
	id bigserial NOT NULL,
	period_start date NOT NULL,
	period_end date NOT NULL,
	submission_start date NOT NULL,
	submission_end date NOT NULL,
	description text NULL,
	form_id bigint NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_pk PRIMARY KEY (id),
	constraint form_fk foreign key (form_id)
	    references openchpl.form (id)
        match simple on update no action on delete restrict
);

CREATE TABLE IF NOT EXISTS openchpl.attestation_condition (
	id bigserial NOT NULL,
	name text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_condition_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS openchpl.attestation (
	id bigserial NOT NULL,
	attestation_condition_id bigint NOT NULL,
	description text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_pk PRIMARY KEY (id),
	CONSTRAINT attestation_condition_id_fk FOREIGN KEY (attestation_condition_id)
      REFERENCES openchpl.attestation_condition (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.attestation_valid_response (
	id bigserial NOT NULL,
	response text NOT NULL,
	meaning text,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_valid_response_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS openchpl.attestation_form (
	id bigserial NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_form_pk PRIMARY KEY (id),
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_submission (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_submission_pk PRIMARY KEY (id),
	CONSTRAINT change_request_id_fk FOREIGN KEY (change_request_id)
      REFERENCES openchpl.change_request (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_response (
	id bigserial NOT NULL,
	change_request_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT change_request_attestation_submission_id_fk FOREIGN KEY (change_request_attestation_submission_id)
      REFERENCES openchpl.change_request_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_submission (
	id bigserial NOT NULL,
	developer_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestation_submission_pk PRIMARY KEY (id),
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_response (
	id bigserial NOT NULL,
	developer_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT developer_attestation_id_fk FOREIGN KEY (developer_attestation_submission_id)
      REFERENCES openchpl.developer_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.attestation_period_developer_exception (
	id bigserial NOT NULL,
	attestation_period_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	exception_end date NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_developer_exception_pk PRIMARY KEY (id),
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

create table if not exists openchpl.response_cardinality_type (
    id bigserial not null,
    description text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint response_cardinality_type_pk primary key (id)
);

create table if not exists openchpl.section_heading (
    id bigserial not null,
    name text not null,
    sort_order int8 not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint section_heading_pk primary key (id)
);

create table if not exists openchpl.question (
    id bigserial not null,
    question text not null,
    response_cardinality_type_id bigint not null,
    section_heading_id bigint,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint question_pk primary key (id),
	constraint response_cardinality_type_fk foreign key (response_cardinality_type_id)
	    references openchpl.response_cardinality_type (id)
        match simple on update no action on delete restrict,
    constraint section_heading_fk foreign key (section_heading_id)
	    references openchpl.section_heading (id)
        match simple on update no action on delete restrict
);

create table if not exists openchpl.allowed_response (
	id bigserial not null,
    response text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint allowed_response_pk primary key (id)
);

create table if not exists openchpl.question_allowed_response_map (
	id bigserial not null,
	question_id bigint not null,
	allowed_response_id bigint not null,
	sort_order int8 not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint question_allowed_response_map_pk primary key (id)
);

create table if not exists openchpl.form (
	id bigserial not null,
	description text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint form_pk primary key (id)
);

create table if not exists openchpl.form_item (
	id bigserial not null,
	form_id bigint not null,
	question_id bigint not null,
	parent_form_item_id bigint,
	parent_response_id bigint,
	sort_order int8 not null,
	required boolean not null default true,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint form_item_pk primary key (id),
	constraint question_fk foreign key (question_id)
	    references openchpl.question (id)
        match simple on update no action on delete restrict,
    constraint parent_response_fk foreign key (parent_response_id)
	    references openchpl.allowed_response (id)
        match simple on update no action on delete restrict
);

--Cannot seem to create self-referencing constraint when table is created
alter table openchpl.form_item
add constraint parent_form_item_fk foreign key (parent_form_item_id)
	    references openchpl.form_item (id)
        match simple on update no action on delete restrict;

create table if not exists openchpl.attestation_submission (
	id bigserial not null,
	developer_id bigint not null,
	attestation_period_id bigint not null,
	signature text not null,
	signature_email text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	drop_developer_attestation_submission_id bigint,
	constraint attestation_submission_pk primary key (id),
	constraint developer_id_fk foreign key (developer_id)
        references openchpl.vendor (vendor_id) match full
        on update cascade on delete restrict,
	constraint attestation_period_id_fk foreign key (attestation_period_id)
        references openchpl.attestation_period (id) match full
        on update cascade on delete restrict
);

create table if not exists openchpl.attestation_submission_response (
	id bigserial not null,
	attestation_submission_id bigint not null,
	response_id bigint not null,
	form_item_id bigint not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	constraint attestation_submission_response_pk primary key (id),
	constraint attestation_submission_fk foreign key (attestation_submission_id)
        references openchpl.attestation_submission (id) match full
        on update cascade on delete restrict,
	constraint response_fk foreign key (response_id)
        references openchpl.allowed_response (id) match full
        on update cascade on delete restrict,
   constraint form_item_fk foreign key (form_item_id)
        references openchpl.form_item (id) match full
        on update cascade on delete restrict
);

create table if not exists openchpl.change_request_attestation_submission_response (
	id bigserial not null,
	change_request_attestation_submission_id bigint not null,
	response_id bigint not null,
	form_item_id bigint not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	constraint change_request_attestation_submission_response_pk primary key (id),
	constraint change_request_attestation_submission_fk foreign key (change_request_attestation_submission_id)
        references openchpl.change_request_attestation_submission (id) match full
        on update cascade on delete restrict,
	constraint response_fk foreign key (response_id)
        references openchpl.allowed_response (id) match full
        on update cascade on delete restrict,
   constraint form_item_fk foreign key (form_item_id)
        references openchpl.form_item (id) match full
        on update cascade on delete restrict
);

CREATE INDEX fki_certified_product_id_fk
ON openchpl.ehr_certification_id_product_map
USING btree
(certified_product_id);

CREATE INDEX fki_ehr_certification_id_fk
ON openchpl.ehr_certification_id_product_map
USING btree
(ehr_certification_id_id);

CREATE INDEX ix_certified_product ON openchpl.certified_product (certified_product_id, certification_edition_id, product_version_id,
testing_lab_id, certification_body_id, acb_certification_id, practice_type_id, product_classification_type_id, deleted);

CREATE INDEX ix_product ON openchpl.product (product_id, vendor_id, deleted);

CREATE INDEX ix_vendor ON openchpl.vendor (vendor_id, address_id, contact_id, vendor_status_id, deleted);

CREATE INDEX ix_certification_criterion ON openchpl.certification_criterion (certification_criterion_id, certification_edition_id, deleted);

CREATE INDEX ix_certification_result ON openchpl.certification_result (certification_result_id, certification_criterion_id, certified_product_id, deleted);

CREATE INDEX ix_certification_result_additional_software ON openchpl.certification_result_additional_software (certification_result_additional_software_id, certification_result_id, certified_product_id, deleted);

CREATE INDEX ix_certification_result_test_data ON openchpl.certification_result_test_data (certification_result_test_data_id, certification_result_id, deleted);

CREATE INDEX ix_certification_result_test_functionality ON openchpl.certification_result_test_functionality (certification_result_test_functionality_id, certification_result_id, test_functionality_id, deleted);

CREATE INDEX ix_certification_result_test_procedure ON openchpl.certification_result_test_procedure (id, certification_result_id, test_procedure_id, deleted);

CREATE INDEX ix_certification_result_test_standard ON openchpl.certification_result_test_standard (certification_result_test_standard_id, certification_result_id,
test_standard_id, deleted);

CREATE INDEX ix_certification_result_test_task ON openchpl.certification_result_test_task (certification_result_test_task_id, certification_result_id,
test_task_id, deleted);

CREATE INDEX ix_certification_result_test_tool ON openchpl.certification_result_test_tool (certification_result_test_tool_id, certification_result_id,
test_tool_id, deleted);

CREATE INDEX ix_certification_result_ucd_process ON openchpl.certification_result_ucd_process (certification_result_ucd_process_id, certification_result_id,
ucd_process_id, deleted);

CREATE INDEX ix_certified_product_qms_standard ON openchpl.certified_product_qms_standard (certified_product_qms_standard_id, certified_product_id,
qms_standard_id, deleted);

CREATE INDEX ix_contact ON openchpl.contact (contact_id, deleted);

CREATE INDEX ix_cqm_criterion ON openchpl.cqm_criterion (cqm_criterion_id, deleted);

CREATE INDEX ix_cqm_result ON openchpl.cqm_result (cqm_criterion_id, deleted);

CREATE INDEX ix_ehr_certification_id ON openchpl.ehr_certification_id (ehr_certification_id_id, certification_id, practice_type_id);

CREATE INDEX ix_ehr_certification_id_product_map ON openchpl.ehr_certification_id_product_map (ehr_certification_id_product_map_id, ehr_certification_id_id, certified_product_id);

CREATE INDEX ix_pending_certification_result ON openchpl.pending_certification_result (pending_certification_result_id, certification_criterion_id,
pending_certified_product_id, deleted);

CREATE INDEX ix_pending_certification_result_additional_software ON openchpl.pending_certification_result_additional_software (pending_certification_result_additional_software_id, pending_certification_result_id, certified_product_id, certified_product_chpl_id, deleted);

CREATE INDEX ix_pending_certification_result_test_data ON openchpl.pending_certification_result_test_data (pending_certification_result_test_data_id, pending_certification_result_id, deleted);

CREATE INDEX ix_pending_certification_result_test_functionality ON openchpl.pending_certification_result_test_functionality (pending_certification_result_test_functionality_id, pending_certification_result_id, test_functionality_id, deleted);

CREATE INDEX ix_pending_certification_result_test_procedure ON openchpl.pending_certification_result_test_procedure
(id, pending_certification_result_id, test_procedure_id, deleted);

CREATE INDEX ix_pending_certification_result_test_standard ON openchpl.pending_certification_result_test_standard
(pending_certification_result_test_standard_id, pending_certification_result_id, test_standard_id, deleted);

CREATE INDEX ix_pending_certification_result_test_task ON openchpl.pending_certification_result_test_task
(pending_certification_result_test_task_id, pending_certification_result_id, pending_test_task_id, deleted);

CREATE INDEX ix_pending_certification_result_test_task_participant ON openchpl.pending_certification_result_test_task_participant (pending_certification_result_test_task_participant_id, pending_certification_result_test_task_id, pending_test_participant_id, deleted);

CREATE INDEX ix_pending_certification_result_test_tool ON openchpl.pending_certification_result_test_tool (pending_certification_result_test_tool_id, pending_certification_result_id, test_tool_id, deleted);

CREATE INDEX ix_pending_certification_result_ucd_process ON openchpl.pending_certification_result_ucd_process (pending_certification_result_ucd_process_id, pending_certification_result_id, ucd_process_id, deleted);

CREATE INDEX ix_pending_certified_product ON openchpl.pending_certified_product (pending_certified_product_id, unique_id, acb_certification_id, practice_type_id, vendor_id, vendor_address_id, vendor_contact_id, product_id, product_version_id, certification_edition_id, certification_body_id, product_classification_id, deleted);

CREATE INDEX ix_pending_certified_product_accessibility_standard ON openchpl.pending_certified_product_accessibility_standard
(pending_certified_product_accessibility_standard_id, pending_certified_product_id, accessibility_standard_id, deleted);

CREATE INDEX ix_pending_certified_product_qms_standard ON openchpl.pending_certified_product_qms_standard (pending_certified_product_qms_standard_id, 			pending_certified_product_id, qms_standard_id, deleted);

CREATE INDEX ix_pending_cqm_certification_criteria ON openchpl.pending_cqm_certification_criteria (pending_cqm_certification_criteria_id, pending_cqm_criterion_id,
certification_criterion_id, deleted);

CREATE INDEX ix_pending_cqm_criterion ON openchpl.pending_cqm_criterion (pending_cqm_criterion_id, cqm_criterion_id, pending_certified_product_id, deleted);

CREATE INDEX ix_pending_test_participant ON openchpl.pending_test_participant (pending_test_participant_id, test_participant_unique_id, education_type_id, deleted,
test_participant_age_id);

CREATE INDEX ix_pending_test_task ON openchpl.pending_test_task (pending_test_task_id, test_task_unique_id, deleted);

CREATE INDEX ix_product_version ON openchpl.product_version (product_version_id, product_id, deleted);

CREATE INDEX ix_surveillance ON openchpl.surveillance (id, certified_product_id, friendly_id, type_id, deleted);

CREATE INDEX ix_surveillance_nonconformity ON openchpl.surveillance_nonconformity (id, surveillance_requirement_id, certification_criterion_id, nonconformity_type,nonconformity_status_id, deleted);

CREATE INDEX ix_surveillance_requirement ON openchpl.surveillance_requirement (id, surveillance_id, type_id, certification_criterion_id, requirement, result_id, creation_date, last_modified_date, last_modified_user, deleted);

CREATE INDEX ix_surveillance_requirement_type ON openchpl.surveillance_requirement_type (id, deleted);

CREATE INDEX ix_test_functionality ON openchpl.test_functionality (test_functionality_id, deleted);

CREATE INDEX ix_test_participant ON openchpl.test_participant (test_participant_id, education_type_id, deleted, test_participant_age_id);

CREATE INDEX ix_test_procedure ON openchpl.test_procedure (id, deleted);

CREATE INDEX ix_test_standard ON openchpl.test_standard (test_standard_id, deleted);

CREATE INDEX ix_listing_to_listing_map_parent_id_deleted ON openchpl.listing_to_listing_map (parent_listing_id, deleted);

CREATE INDEX ix_listing_to_listing_map_child_id_deleted ON openchpl.listing_to_listing_map (child_listing_id, deleted);

CREATE INDEX ix_api_key_activity_month_year ON openchpl.api_key_activity (EXTRACT(MONTH FROM creation_date), EXTRACT(YEAR FROM creation_date));
