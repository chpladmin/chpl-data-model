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

--need the drop command here because of the name of the index is getting truncated
DROP INDEX IF EXISTS openchpl.deprecated_response_field_api_usage_unique_api_key_and_deprecat;
CREATE UNIQUE INDEX deprecated_response_field_api_usage_unique_api_key_and_deprecated_api
ON openchpl.deprecated_api_usage(api_key_id, deprecated_api_id)
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
	VALUES (5, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (5, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (6, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (6, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (7, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (7, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}/certification_results', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (8, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (8, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (9, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (10, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}/details', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (11, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (12, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{chplPrefix}-{identifier}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (13, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/{certifiedProductId:^-?\d+$}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (14, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/certified_products/pending/{pcpId:^-?\d+$}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (15, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/certified_products/{certifiedProductId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (16, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/certified_products/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (17, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

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
	VALUES (19, 'surveillances.surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (19, 'surveillances.surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.surveillance.endDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/complaints', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (20, 'results.surveillances.surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.surveillances.surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (20, 'results.surveillances.surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.surveillances.surveillance.endDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/complaints/{complaintId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (21, 'surveillances.surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (21, 'surveillances.surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.surveillance.endDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/developers/merge', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (22, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/developers/{developerId}/split', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (23, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/listings/pending/{id}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'certificationResults.number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'certificationResults.title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (24, 'surveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/promoting-interoperability/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (25, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/schedules/triggers/one_time', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (26, 'results.job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (27, 'results.job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/schedules/jobs', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (28, 'results.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (29, 'results.job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/schedules/jobs', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (30, 'results.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/schedules/triggers', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (31, 'results.job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/search/beta', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results.numMeaningfulUse', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.promotingInteroperabilityUserCount.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results.numMeaningfulUseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserDate.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (32, 'results.transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.mandatoryDisclosures.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/search/beta', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results.numMeaningfulUse', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.promotingInteroperabilityUserCount.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results.numMeaningfulUseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserDate.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (33, 'results.transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.mandatoryDisclosures.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance/pending/confirm', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (34, 'requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (35, 'requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance/reports/activity', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (36, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance/pending', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (37, 'pendingSurveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('PUT', '/surveillance/{surveillanceId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (38, 'requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance/upload', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.startDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.endDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.nonconformityStatus.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.dayOfDetermination.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capApprovalDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capStartDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capEndDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.capMustCompleteDay.', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (39, 'pendingSurveillance.requirements.nonconformities.nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use pendingSurveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('POST', '/surveillance-report/quarterly', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (40, 'reactiveSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use reactiveSurveillanceSummary.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (40, 'transparencyDisclosureSummary', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use disclosureRequirementsSummary.', -1);	
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/export/annual/{annualReportId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (41, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/export/quarterly/{quarterlyReportId}', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (42, 'job.frequency', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release.', -1);
	

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
	VALUES (45, 'results.surveillances.surveillance.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.surveillances.surveillance.startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (45, 'results.surveillances.surveillance.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use results.surveillances.surveillance.endDay.', -1);	

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
	VALUES ('GET', '/surveillance-report/quarterly/{quarterlyReportId}/listings', -1);
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (46, 'surveillances.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (46, 'surveillances.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.endDay.', -1);	

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
	VALUES (49, 'surveillances.startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.startDay.', -1);	
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
	VALUES (49, 'surveillances.endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillances.endDay.', -1);	
