ALTER TABLE openchpl.deprecated_api
ADD COLUMN IF NOT EXISTS removal_date date;

ALTER TABLE openchpl.deprecated_api
ADD COLUMN IF NOT EXISTS response_field text;

DROP INDEX openchpl.deprecated_api_unique_method_and_api_operation_and_parameter;

CREATE UNIQUE INDEX deprecated_api_unique_method_and_api_operation_and_parameter
ON openchpl.deprecated_api(http_method, api_operation, request_parameter, response_field)
WHERE deleted = false;

-- add all deprecated response field data
INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'transparencyAttestationUrl', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use mandatoryDisclosureUrl.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'meaningfulUseUserHistory', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use promotingInteroperabilityUserHistory.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'currentMeaningfulUseUsers', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please derive this data from promotingInteroperabilityUserHistory.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'number', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.number.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'title', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use certificationResults.criterion.title.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'startDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.startDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'endDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.endDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'status', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityStatus.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'dateOfDetermination', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.dayOfDetermination.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'capApprovalDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capApprovalDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'capStartDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capStartDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'capEndDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capEndDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'capMustCompleteDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.capMustCompleteDay.', -1);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, response_field, removal_date, change_description, last_modified_user)
VALUES ('GET', '/{certifiedProductId:^-?\\d+$}/details', 'nonconformityCloseDate', '2022-04-15', 'This field is deprecated and will be removed from the response data in a future release. Please use surveillance.requirements.nonconformities.nonconformityCloseDay.', -1);

