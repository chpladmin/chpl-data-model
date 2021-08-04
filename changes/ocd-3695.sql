DROP TABLE IF EXISTS openchpl.deprecated_api_usage;
DROP TABLE IF EXISTS openchpl.deprecated_api;

CREATE TABLE openchpl.deprecated_api (
	id bigserial NOT NULL,
	http_method varchar(10) NOT NULL,
	api_operation text NOT NULL,
	request_parameter text,
	change_description text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT deprecated_api_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX deprecated_api_unique_method_and_api_operation_and_parameter
ON openchpl.deprecated_api(http_method, api_operation, request_parameter)
WHERE deleted = false;

CREATE TRIGGER deprecated_api_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.deprecated_api_usage (
	id bigserial NOT NULL,
	api_key_id bigint NOT NULL,
	deprecated_api_id bigint NOT NULL,
	api_call_count bigint NOT NULL DEFAULT 0,
	last_accessed_date timestamp NOT NULL DEFAULT NOW(),
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
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE UNIQUE INDEX deprecated_api_usage_unique_api_key_and_deprecated_api
ON openchpl.deprecated_api_usage(api_key_id, deprecated_api_id)
WHERE deleted = false;

CREATE TRIGGER deprecated_api_usage_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_usage_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, last_modified_user)
VALUES 
-- all of the activity endpoints
('GET', '/activity/acbs', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/acbs to access ONC-ACB activity.', -1),
('GET', '/activity/metadata/acbs', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/acbs to access ONC-ACB activity.', -1),
('GET', '/activity/acbs/{id}', 'This endpoint is deprecated and its response format will be changed in a future release. Please use /activity/metadata/acbs/{id} to access activity for a specific ONC-ACB.', -1),

('GET', '/activity/announcements', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/announcements to access announcement activity.', -1),
('GET', '/activity/announcements/{id}', 'This endpoint is deprecated and will be removed in a future release.', -1),
('GET', '/activity/metadata/announcements', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/announcements to access accouncement activity.', -1),


('GET', '/activity/api_keys', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/api-keys to access API Key activity.', -1),
('GET', '/activity/metadata/api-keys', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/api-keys to access API Key activity.', -1),

('GET', '/activity/atls', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/atls to access ONC-ATL activity.', -1),
('GET', '/activity/metadata/atls', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/atls to access ONC-ATL activity.', -1),
('GET', '/activity/atls/{id}', 'This endpoint is deprecated and its response format will be changed in a future release. Please use /activity/metadata/atls/{id} to access activity for a specific ONC-ATL.', -1),

('GET', '/activity/certified_products', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/listings to access listing activity.', -1),
('GET', '/activity/certified_products/{id:^-?\d+$}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/listings/{id:^-?\d+$} to access activity for a specific listing ID.', -1),
('GET', '/activity/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/listings/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode} to access activity for a specific CHPL Product Number.', -1),
('GET', '/activity/certified_products/{chplPrefix}-{identifier}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/listings/{chplPrefix}-{identifier} to access activity for a specific legacy CHPL Product Number.', -1),


('GET', '/activity/metadata/corrective_action_plans', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/corrective-action-plans to access corrective action plan activity.', -1),

('GET', '/activity/developers', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/developers to access developer activity.', -1),
('GET', '/activity/developers/{id}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/developers/{id} to access activity for a specific developer.', -1),
('GET', '/activity/metadata/developers', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/developers to access developer activity.', -1),

('GET', '/activity/metadata/listings', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/listings to access listing activity.', -1),

('GET', '/activity/pending_certified_products', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/pending-listings to access pending listing activity.', -1),
('GET', '/activity/pending_certified_products/{id}', 'This endpoint is deprecated and will be removed in a future release.', -1),
('GET', '/activity/metadata/pending_listings', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/pending-listings to access pending listing activity.', -1),

('GET', '/activity/metadata/pending_surveillances', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/pending-surveillances to access pending surveillance activity.', -1),

('GET', '/activity/products', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/products to access product activity.', -1),
('GET', '/activity/products/{id}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/products/{id} to access activity for a specific product.', -1),
('GET', '/activity/metadata/products', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/products to access product activity.', -1),

('GET', '/activity/versions', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/versions to access version activity.', -1),
('GET', '/activity/versions/{id}', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/versions/{id} to access activity for a specific version.', -1),
('GET', '/activity/metadata/versions', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/versions to access version activity.', -1),

('GET', '/activity/users', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/beta/users to access user activity.', -1),
('GET', '/activity/metadata/users', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /activity/metadata/beta/users to access user activity.', -1),

('GET', '/activity/user_activities', 'This endpoint is deprecated and will be removed in a future release. Please use /activity/user_activities/{id} to access activity performed by a specific user.', -1),

-- auth endpoints
('GET', '/auth/impersonate', 'This endpoint is deprecated and its request format will be changed in a future release. Please use /auth/beta/impersonate to impersonate a specific user.', -1),

-- certified products
('GET', '/certified_products/pending', 'This endpoint is deprecated and will be removed in a future release. Please use /certified_products/pending/metadata to get a list of all pending certified products.', -1),
('POST', '/certified_products/pending/{pcpId}/confirm', 'This endpoint is deprecated and its request format will be changed in a future release. Please use /certified_products/pending/{pcpId}/beta/confirm to confirm a specific pending certified product.', -1),

-- collections
('GET', '/collections/certified_products', 'This endpoint is deprecated and will be removed in a future release. Please use /collections/certified-products to access this data.', -1),
('GET', '/collections/developers', 'This endpoint is deprecated and will be removed in a future release.', -1),

-- dimensional data endpoints
('GET', '/data/decertifications/developers', 'This endpoint is deprecated and will be removed in a future release. Please use /collections/decertified-developers to access this data.', -1),
('GET', '/data/nonconformity_types', 'This endpoint is deprecated and will be removed in a future release. Please use /data/nonconformity-types to access this data.', -1),
('GET', '/data/search_options', 'This endpoint is deprecated and will be removed in a future release. Please use /data/search-options to access this data.', -1),
('GET', '/data/surveillance_requirements', 'This endpoint is deprecated and will be removed in a future release. Please use /data/surveillance-requirements to access this data.', -1),

-- muu/pi
('POST', '/meaningful_use/upload', 'This endpoint is deprecated and will be removed in a future release. Please use /promoting-interoperability/upload.', -1),

-- search
('GET', '/search', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /search/beta to search CHPL data.', -1),
('POST', '/search', 'This endpoint is deprecated and its request and response formats will change in a future release. Please use /search/beta to search CHPL data.', -1),

-- status
('GET', '/status', 'This endpoint is deprecated and will be removed in a future release. Please use /system-status to access this data.', -1),
('GET', '/cache_status', 'This endpoint is deprecated and will be removed in a future release. Please use /system-status to access this data.', -1),

-- users
('GET', '/users/{userName}/details', 'This endpoint is deprecated and will be removed in a future release. Please use /users/beta/{id}/details to access a specific users data.', -1);

UPDATE openchpl.api_key SET email = 'chpl@ainq.com' where api_key_id = 1;