DROP TABLE IF EXISTS openchpl.subscription_observation;
DROP TABLE IF EXISTS openchpl.subscription;
DROP TABLE IF EXISTS openchpl.subscription_subject;
DROP TABLE IF EXISTS openchpl.subscription_object_type;
DROP TABLE IF EXISTS openchpl.subscription_consolidation_method;
DROP TABLE IF EXISTS openchpl.subscription_reason;
DROP TABLE IF EXISTS openchpl.subscriber;
DROP TABLE IF EXISTS openchpl.subscriber_status;

-- Subscriber status. Indicates if the subscriber has confirmed their email.
CREATE TABLE openchpl.subscriber_status (
	id bigserial NOT NULL,
	name varchar(100) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscriber_status (name, last_modified_user)
VALUES ('Pending', -1),
('Confirmed', -1);

CREATE TRIGGER subscriber_status_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscriber_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscriber_status_timestamp BEFORE UPDATE ON openchpl.subscriber_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Subscriber. An email address and token that can be used to get to subscriptions related to that email address for management purposes.
-- A subscriber must be confirmed by clicking a link so we know their email is valid.
CREATE TABLE openchpl.subscriber (
	id uuid NOT NULL,
	subscriber_status_id bigint NOT NULL,
	email text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	CONSTRAINT subscriber_status_fk FOREIGN KEY (subscriber_status_id) REFERENCES openchpl.subscriber_status(id) 
		ON DELETE RESTRICT
);

CREATE TRIGGER subscriber_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscriber FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscriber_timestamp BEFORE UPDATE ON openchpl.subscriber FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
  

-- Subscribed object type. Tells whether the type of thing subscribed to is a Listing, Developer, or Product
CREATE TABLE openchpl.subscription_object_type (
	id bigserial NOT NULL,
	name varchar(200) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscription_object_type (name, last_modified_user)
VALUES ('Listing', -1),
('Developer', -1), 
('Product', -1);

CREATE TRIGGER subscription_object_type_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_object_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_object_type_timestamp BEFORE UPDATE ON openchpl.subscription_object_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Subscription subject. Tells what specific changes we are looking for
CREATE TABLE openchpl.subscription_subject (
	id bigserial NOT NULL,
	subscription_object_type_id bigint NOT NULL,
	subject varchar(200) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	CONSTRAINT subscription_object_type_fk FOREIGN KEY (subscription_object_type_id) REFERENCES openchpl.subscription_object_type(id) 
		ON DELETE RESTRICT
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
VALUES ((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Status Changed', -1),
((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Criterion Added', -1),
((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Criterion Removed', -1),
((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Real World Testing Updated', -1),
((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Developer'), 'New Listing Confirmed', -1), 
((SELECT id FROM openchpl.subscription_object_type WHERE name = 'Product'), 'New Listing Confirmed', -1);
-- TODO: Decide to add all these subjects now or later?

CREATE TRIGGER subscription_subject_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_subject FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_subject_timestamp BEFORE UPDATE ON openchpl.subscription_subject FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Consolidation Method. Tells the sort of batching that observations will be sent to the subscriber
CREATE TABLE openchpl.subscription_consolidation_method (
	id bigserial NOT NULL,
	name varchar(200) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscription_consolidation_method (name, last_modified_user)
VALUES ('Daily', -1),
('Weekly', -1);
-- I feel like we could implement 'Push' at some point but maybe it's not useful to put it in here at this time.

CREATE TRIGGER subscription_consolidation_method_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_consolidation_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_consolidation_method_timestamp BEFORE UPDATE ON openchpl.subscription_consolidation_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();



-- Ask if we want to keep the "Persona" language in the UI. I find the term to be a big turn-off to filling it out.
-- Ask if we want the persona attached to the subscriber or to the subscription
CREATE TABLE openchpl.subscription_reason (
	id bigserial NOT NULL,
	name varchar(300) NOT NULL,
	sort_order int NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscription_reason (name, sort_order, last_modified_user)
VALUES ('Researcher', 1, -1),
('Developer', 2, -1),
('Other', 3, -1),
('Prefer Not to Answer', 4, -1);

CREATE TRIGGER subscription_reason_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_reason FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_reason_timestamp BEFORE UPDATE ON openchpl.subscription_reason FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Subscription.
-- Once the status of the subscriber_id is Confirmed we will log observations for all subscriptions for that subscriber
CREATE TABLE openchpl.subscription (
    id bigserial NOT NULL,	
	subscriber_id uuid NOT NULL, 
    subscription_reason_id bigint NOT NULL,  
	subscription_subject_id bigint NOT NULL,
	subscribed_object_id bigint NOT NULL, -- the ID of the developer, product, listing, etc. 
	subscription_consolidation_method_id bigint NOT NULL, -- We would always default to Daily for now I think...
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	CONSTRAINT subscriber_fk FOREIGN KEY (subscriber_id) REFERENCES openchpl.subscriber(id) 
		ON DELETE RESTRICT,
	CONSTRAINT subscription_reason_fk FOREIGN KEY (subscription_reason_id) REFERENCES openchpl.subscription_reason(id) 
		ON DELETE RESTRICT,
	CONSTRAINT subscription_subject_fk FOREIGN KEY (subscription_subject_id) REFERENCES openchpl.subscription_subject(id) 
		ON DELETE RESTRICT,
	CONSTRAINT subscription_consolidation_method_fk FOREIGN KEY (subscription_consolidation_method_id) REFERENCES openchpl.subscription_consolidation_method(id) 
		ON DELETE RESTRICT
);

CREATE TRIGGER subscription_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_timestamp BEFORE UPDATE ON openchpl.subscription FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


-- Subscription Observations. Whenever a relevant change is observed we will save that fact here.
CREATE TABLE openchpl.subscription_observation (
    id bigserial NOT NULL,
	subscription_id bigint NOT NULL,
	activity_id bigint NOT NULL,  -- May need to be null at some point in the future for negative actions
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	CONSTRAINT subscription_fk FOREIGN KEY (subscription_id) REFERENCES openchpl.subscription(id) 
		ON DELETE RESTRICT,
	CONSTRAINT activity_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity(activity_id) 
		ON DELETE RESTRICT
);

CREATE TRIGGER subscription_observation_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER subscription_observation_timestamp BEFORE UPDATE ON openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

