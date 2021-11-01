-- Deployment file for version 20.9.0
--     as of 2021-11-01
-- ./changes/ocd-3693.sql
CREATE TABLE IF NOT EXISTS openchpl.cures_criteria_statistics_by_acb (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	original_criterion_id bigint,
	cures_criterion_id bigint,
	original_criterion_upgraded_count bigint,
	cures_criterion_created_count bigint,
	criteria_needing_upgrade_count bigint,
	statistic_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
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

CREATE TABLE IF NOT EXISTS openchpl.cures_listing_statistics_by_acb (
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

DROP TRIGGER IF EXISTS cures_criteria_statistics_by_acb_audit ON openchpl.cures_criteria_statistics_by_acb;
DROP TRIGGER IF EXISTS cures_criteria_statistics_by_acb_timestamp ON openchpl.cures_criteria_statistics_by_acb;
CREATE TRIGGER cures_criteria_statistics_by_acb_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_criteria_statistics_by_acb FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cures_criteria_statistics_by_acb_timestamp BEFORE UPDATE on openchpl.cures_criteria_statistics_by_acb FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TRIGGER IF EXISTS cures_listing_statistics_by_acb_audit ON openchpl.cures_listing_statistics_by_acb;
DROP TRIGGER IF EXISTS cures_listing_statistics_by_acb_timestamp ON openchpl.cures_listing_statistics_by_acb;
CREATE TRIGGER cures_listing_statistics_by_acb_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_listing_statistics_by_acb FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cures_listing_statistics_by_acb_timestamp BEFORE UPDATE on openchpl.cures_listing_statistics_by_acb FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ./changes/ocd-3734.sql
DROP TABLE IF EXISTS openchpl.deprecated_response_field_api_usage CASCADE;
DROP TABLE IF EXISTS openchpl.deprecated_response_field CASCADE;
DROP TABLE IF EXISTS openchpl.deprecated_response_field_api CASCADE;

CREATE TABLE openchpl.deprecated_response_field_api (
	id bigserial NOT NULL,
	http_method varchar(10) NOT NULL,
	api_operation text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_response_field_api_pk PRIMARY KEY (id)
);

CREATE UNIQUE INDEX deprecated_response_field_api_unique_method_and_api_operation
ON openchpl.deprecated_response_field_api(http_method, api_operation)
WHERE deleted = false;

CREATE TRIGGER deprecated_response_field_api_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_api_timestamp BEFORE UPDATE on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

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
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE UNIQUE INDEX deprecated_response_field_unique_response_field
ON openchpl.deprecated_response_field(deprecated_api_id, response_field)
WHERE deleted = false;

CREATE TRIGGER deprecated_response_field_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_timestamp BEFORE UPDATE on openchpl.deprecated_response_field FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.deprecated_response_field_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	deprecated_response_field_api_id bigint NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_response_field_api_usage_pk PRIMARY KEY (id),
	CONSTRAINT api_key_id_fk FOREIGN KEY (api_key_id)
      REFERENCES openchpl.api_key (api_key_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT deprecated_response_field_api_fk FOREIGN KEY (deprecated_response_field_api_id)
      REFERENCES openchpl.deprecated_response_field_api (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE UNIQUE INDEX deprecated_response_field_api_usage_unique_record
ON openchpl.deprecated_response_field_api_usage(api_key_id, deprecated_response_field_api_id)
WHERE deleted = false;

CREATE TRIGGER deprecated_response_field_api_usage_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field_api_usage FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_api_usage_timestamp BEFORE UPDATE on openchpl.deprecated_response_field_api_usage FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- add all deprecated response field data
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/key/confirm', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (1, 'apiKey', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use key.', -1);


INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/key', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (2, 'apiKey', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use key.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/certification_ids', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (3, 'isValid', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use valid.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certification_ids/search', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (4, 'isValid', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use valid.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/certified_products/pending/{pcpId:^-?\d+$}/beta/confirm', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (6, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (6, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (7, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (7, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (8, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (8, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/pending/{pcpId:^-?\d+$}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/certified_products/{certifiedProductId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/certified_products/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from pendingCertifiedProducts -> promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingCertifiedProducts -> surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/collections/certified-products', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (18, 'numMeaningfulUse', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserCount.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (18, 'numMeaningfulUseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserDate.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (18, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosures.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/complaints', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (19, 'surveillances -> surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (19, 'surveillances -> surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> surveillance -> endDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/complaints', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (20, 'results -> surveillances -> surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> surveillances -> surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (20, 'results -> surveillances -> surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> surveillances -> surveillance -> endDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/complaints/{complaintId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (21, 'surveillances -> surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (21, 'surveillances -> surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> surveillance -> endDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/developers/merge', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (22, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/developers/{developerId}/split', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (23, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/listings/pending/{id}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'certificationResults -> number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'certificationResults -> title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults -> criterion -> title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/promoting-interoperability/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (25, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/schedules/triggers/one_time', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (26, 'results -> job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (27, 'results -> job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/schedules/jobs', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (28, 'results -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (29, 'results -> job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/schedules/jobs', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (30, 'results -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (31, 'results -> job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/search/beta', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results -> numMeaningfulUse', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> promotingInteroperabilityUserCount.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results -> numMeaningfulUseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> promotingInteroperabilityUserDate.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results -> transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> mandatoryDisclosures.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/search/beta', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results -> numMeaningfulUse', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> promotingInteroperabilityUserCount.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results -> numMeaningfulUseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> promotingInteroperabilityUserDate.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results -> transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> mandatoryDisclosures.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance/pending/confirm', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance/reports/activity', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (36, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance/pending', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/surveillance/{surveillanceId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance -> requirements -> nonconformities -> nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance -> requirements -> nonconformities -> nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance-report/quarterly', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (40, 'reactiveSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use reactiveSurveillanceSummary.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (40, 'transparencyDisclosureSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use disclosureRequirementsSummary.', -1);	
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/export/annual/{annualReportId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (41, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/export/quarterly/{quarterlyReportId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (42, 'job -> frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/quarterly', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (43, 'reactiveSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use reactiveSurveillanceSummary.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (43, 'transparencyDisclosureSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use disclosureRequirementsSummary.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/quarterly/{quarterlyReportId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (44, 'reactiveSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use reactiveSurveillanceSummary.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (44, 'transparencyDisclosureSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use disclosureRequirementsSummary.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/quarterly/{quarterlyReportId}/complaints', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (45, 'results -> surveillances -> surveillance -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> surveillances -> surveillance -> startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (45, 'results -> surveillances -> surveillance -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results -> surveillances -> surveillance -> endDay.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/quarterly/{quarterlyReportId}/listings', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (46, 'surveillances -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (46, 'surveillances -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> endDay.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/surveillance-report/quarterly/{quarterlyReportId}/surveillance/{surveillanceId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (47, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (47, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/surveillance-report/quarterly', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (48, 'reactiveSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use reactiveSurveillanceSummary.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (48, 'transparencyDisclosureSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use disclosureRequirementsSummary.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/surveillance-reportquarterly/{quarterlyReportId}/listings/{listingId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (49, 'surveillances -> startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (49, 'surveillances -> endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances -> endDay.', -1);	
;
-- ./changes/ocd-3745.sql
ALTER TABLE openchpl.surveillance_nonconformity DROP COLUMN IF EXISTS nonconformity_status_id;

DROP TABLE IF EXISTS openchpl.nonconformity_status;
;
-- ./changes/ocd-3749.sql
alter table openchpl.certification_criterion_attribute drop column if exists conformance_method;
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS conformance_method BOOL NOT NULL DEFAULT FALSE;
alter table openchpl.certification_criterion_attribute drop column if exists test_procedure;
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS test_procedure BOOL NOT NULL DEFAULT FALSE;

-- make sure all 2014 and 2015 criteria have entries in the attribute table
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 1, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 1);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 2, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 2);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 3, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 3);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 4, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 4);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 5, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 5);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 6, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 6);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 7, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 7);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 8, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 8);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 10, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 10);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 11, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 11);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 12, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 12);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 13, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 13);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 14, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 14);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 15, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 15);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 16, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 16);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 17, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 17);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 18, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 18);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 19, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 19);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 20, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 20);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 21, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 21);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 22, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 22);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 23, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 23);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 24, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 24);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 25, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 25);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 26, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 26);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 27, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 27);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 28, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 28);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 29, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 29);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 30, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 30);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 31, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 31);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 32, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 32);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 33, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 33);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 34, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 34);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 35, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 35);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 36, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 36);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 37, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 37);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 38, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 38);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 39, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 39);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 40, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 40);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 41, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 41);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 42, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 42);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 43, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 43);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 44, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 44);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 45, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 45);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 46, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 46);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 47, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 47);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 48, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 48);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 49, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 49);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 50, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 50);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 51, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 51);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 52, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 52);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 53, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 53);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 54, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 54);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 55, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 55);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 56, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 56);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 57, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 57);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 58, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 58);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 59, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 59);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 60, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 60);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 165, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 165);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 166, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 166);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 167, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 167);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 168, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 168);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 169, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 169);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 170, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 170);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 171, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 171);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 172, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 172);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 173, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 173);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 174, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 174);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 175, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 175);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 176, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 176);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 177, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 177);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 178, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 178);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 179, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 179);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 180, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 180);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 181, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 181);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 182, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 182);

update openchpl.certification_criterion_attribute set test_procedure = true where criterion_id <= 119 or criterion_id >= 165; -- all 2014 and 2015 Criteria can have TP, until flag is toggled // data is updated

-- allow specific 2015 criteria to have conformance_method (including removed criteria)
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(8)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(9)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(11)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(12)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(13)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(14)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(15)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(8)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(9)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(11)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(12)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(13)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(8)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)');

drop table if exists openchpl.conformance_method cascade;
CREATE TABLE openchpl.conformance_method (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT conformance_method_pk PRIMARY KEY (id)
);

drop table if exists openchpl.pending_certification_result_conformance_method;
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

drop table if exists openchpl.certification_result_conformance_method;
CREATE TABLE openchpl.certification_result_conformance_method (
	id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	conformance_method_id bigint NOT NULL,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_conformance_method_pk PRIMARY KEY (id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists openchpl.conformance_method_criteria_map;
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

CREATE TRIGGER certification_result_conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_conformance_method_timestamp BEFORE UPDATE on openchpl.certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER conformance_method_timestamp BEFORE UPDATE on openchpl.conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER conformance_method_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.conformance_method_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER conformance_method_criteria_map_timestamp BEFORE UPDATE on openchpl.conformance_method_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_conformance_method_timestamp BEFORE UPDATE on openchpl.pending_certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

insert into openchpl.conformance_method (name, last_modified_user) values
('Attestation', -1),
('ONC Test Procedure', -1),
('NCQA eCQM Test Method', -1),
('HIMSS-IIP Test Method', -1),
('ONC Test Method - Surescripts (Alternative)', -1);

-- Attestation
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(8)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(9)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(11)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(12)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(13)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(14)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(15)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(8)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(9)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(11)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(12)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(13)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
-- ONC Test Procedure
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(8)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
-- NCQA eCQM Test Method
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
-- HIMSS-IIP Test Method
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'HIMSS-IIP Test Method'), -1;
-- ONC Test Method - Surescripts (Alternative)
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Method - Surescripts (Alternative)'), -1;
;
-- ./changes/ocd-3778.sql
------- New
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT NULL,
	'CMS646',
	'Intravesical Bacillus-Calmette-Guerin for non-muscle invasive bladder cancer',
	'Percentage of patients initially diagnosed with non-muscle invasive bladder cancer and who received intravesical Bacillus-Calmette-Guerin (BCG) within 6 months of bladder cancer staging.',
	'Effective Clinical Care',
	'N/A',
	-1,
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'),
	(SELECT cqm_criterion_type_id FROM openchpl.cqm_criterion_type WHERE name = 'Inpatient'),
	false
WHERE NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS646');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT NULL,
	'CMS844',
	'Core Clinical Data Elements for the Hybrid Hospital-Wide (All-Condition, All-Procedure) Risk-Standardized Mortality Measure (HWM)',
	'This logic is intended to extract electronic clinical data. This is not an electronic clinical quality measure and this logic will not produce measure results. Instead, it will produce a file containing the data that CMS will link with administrative claims to risk adjust the Hybrid HWM outcome measure. It is designed to extract the first resulted set of vital signs and basic laboratory results obtained from encounters for adult Medicare Fee-For-Service patients admitted to acute care short stay hospitals.',
	'N/A',
	'3502',
	-1,
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'),
	(SELECT cqm_criterion_type_id FROM openchpl.cqm_criterion_type WHERE name = 'Inpatient'),
	false
WHERE NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS844');

-------Version 10
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS22'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS22');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS50'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS50');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS56'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS56');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS66'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS66');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS69'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS69');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS75'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS75');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS117'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS117');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS122'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS122');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS124'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS124');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS125'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS125');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS127'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS127');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS128'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS128');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS130'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS130');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS131'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS131');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS133'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS133');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS134'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS134');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS135'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS135');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS137'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS137');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS138'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS138');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS139'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS139');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS142'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS142');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS143'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS143');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS144'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS144');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS145'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS145');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS146'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS146');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS149'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS149');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS153'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS153');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS154'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS154');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS155'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS155');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS156'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS156');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS157'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS157');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS159'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS159');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS161'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS161');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS165'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS165');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS177'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS177');

-------Version 11
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS2'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS2');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS68'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS68');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS74'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS74');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS90'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS90');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS129'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS129');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS136'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS136');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v11'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v10'
WHERE cc.cms_id = 'CMS147'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v11' WHERE cc.cms_id = 'CMS147');

-------Version 2
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v1'
WHERE cc.cms_id = 'CMS529'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS529');

-------Version 3
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v3'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v2'
WHERE cc.cms_id = 'CMS771'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v3' WHERE cc.cms_id = 'CMS771');

-------Version 4
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v4'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v3'
WHERE cc.cms_id = 'CMS249'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v4' WHERE cc.cms_id = 'CMS249');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v4'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v3'
WHERE cc.cms_id = 'CMS349'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v4' WHERE cc.cms_id = 'CMS349');

-------Version 5
INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v5'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v4'
WHERE cc.cms_id = 'CMS347'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v5' WHERE cc.cms_id = 'CMS249');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v5'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v4'
WHERE cc.cms_id = 'CMS645'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v5' WHERE cc.cms_id = 'CMS645');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.9.0', '2021-11-01', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
