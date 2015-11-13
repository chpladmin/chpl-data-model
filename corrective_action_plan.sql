CREATE TABLE openchpl.corrective_action_plan(
	corrective_action_plan_id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	acb_summary text, --comes from the developer
	developer_summary text, -- comes from the vendor/developer
	approval_date timestamp, -- the date ONC approved a corrective action plan
	effective_date timestamp, -- the date corrective action began
	completion_date_estimated timestamp, -- the date corrective action must be completed
	completion_date_actual timestamp, -- the date corrective action was completed
	resolution text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT corrective_action_plan_pk PRIMARY KEY (corrective_action_plan_id)

);

ALTER TABLE openchpl.corrective_action_plan ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE openchpl.corrective_action_plan OWNER TO openchpl;


CREATE TABLE openchpl.corrective_action_plan_certification_result (
	corrective_action_plan_certification_result_id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	corrective_action_plan_id bigint NOT NULL,
	acb_summary text, --comes from the developer
	developer_summary text, -- comes from the vendor/developer
	resolution text,
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

ALTER TABLE openchpl.corrective_action_plan_certification_result OWNER TO openchpl;

CREATE TABLE openchpl.surveillance (
	surveillance_id bigserial not null,
	certified_product_id bigint not null,
	site_name varchar(250) not null,
	surveillance_address bigint not null,
	start_date timestamp,
	end_date timestamp,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_pk PRIMARY KEY (surveillance_id)
);

ALTER TABLE openchpl.surveillance ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE openchpl.surveillance OWNER TO openchpl;

CREATE TABLE openchpl.surveillance_certification_result (
	surveillance_certification_id bigserial not null,
	surveillance_id bigint not null,
	certification_criterion_id bigint not null,
	pass boolean not null default false,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT surveillance_certification_pk PRIMARY KEY (surveillance_certification_id)
);

ALTER TABLE openchpl.surveillance_certification_result ADD CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
REFERENCES openchpl.surveillance (surveillance_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE openchpl.surveillance_certification_result ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE openchpl.surveillance_certification_result OWNER TO openchpl;
