

CREATE TABLE openchpl.api_key
(
  api_key_id bigserial NOT NULL,
  api_key character varying(32) NOT NULL,
  email character varying(256) NOT NULL,
  name_organization character varying(256),
  CONSTRAINT pk_api_key_id PRIMARY KEY (api_key_id)
);

ALTER TABLE openchpl.api_key
  OWNER TO openchpl;



CREATE TABLE openchpl.api_key_activity
(
  api_activity_id bigserial NOT NULL,
  api_key_id bigint NOT NULL,
  api_call_url character varying(2083),
  CONSTRAINT api_activity_pk PRIMARY KEY (api_activity_id)
);

ALTER TABLE openchpl.api_key_activity
  OWNER TO openchpl;

ALTER TABLE openchpl.api_key_activity ADD CONSTRAINT api_key_fk FOREIGN KEY (api_key_id) REFERENCES openchpl.api_key (api_key_id);
