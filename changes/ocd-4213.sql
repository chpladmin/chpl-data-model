--
-- Subscriber status. Indicates if the subscriber has confirmed their email.
--
CREATE TABLE IF NOT EXISTS openchpl.subscriber_status (
	id bigserial NOT NULL,
	name varchar(100) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscriber_status (name, last_modified_user)
SELECT 'Pending', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_status WHERE name = 'Pending'
);

INSERT INTO openchpl.subscriber_status (name, last_modified_user)
SELECT 'Confirmed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_status WHERE name = 'Confirmed'
);

DROP TRIGGER IF EXISTS subscriber_status_audit on openchpl.subscriber_status;
CREATE TRIGGER subscriber_status_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscriber_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscriber_status_timestamp on openchpl.subscriber_status;
CREATE TRIGGER subscriber_status_timestamp BEFORE UPDATE ON openchpl.subscriber_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--
-- Subscriber role
--
CREATE TABLE IF NOT EXISTS openchpl.subscriber_role (
	id bigserial NOT NULL,
	name varchar(300) NOT NULL,
	sort_order int NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Health IT Vendor', 1, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Health IT Vendor'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'App Developer', 2, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'App Developer'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'HIE (Health Information Exchange)', 3, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'HIE (Health Information Exchange)'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Hospital or Healthcare System', 4, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Hospital or Healthcare System'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Healthcare Provider', 5, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Healthcare Provider'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Pharmacy or Laboratory Service', 6, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Pharmacy or Laboratory Service'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Patient/Healthcare Consumer', 7, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Patient/Healthcare Consumer'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Patient Advocacy Group', 8, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Patient Advocacy Group'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Payer', 9, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Payer'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'QIO (Quality Improvement Organization)', 10, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'QIO (Quality Improvement Organization)'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Public Health Department', 11, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Public Health Department'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Government (Federal, State, Local, Tribal)', 12, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Government (Federal, State, Local, Tribal)'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Regulator', 13, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Regulator'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Educational Institution', 14, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Educational Institution'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Researcher', 15, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Researcher'
);

INSERT INTO openchpl.subscriber_role (name, sort_order, last_modified_user)
SELECT 'Other', 16, -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscriber_role WHERE name = 'Other'
);

DROP TRIGGER IF EXISTS subscriber_role_audit on openchpl.subscriber_role;
CREATE TRIGGER subscriber_role_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscriber_role FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscriber_role_timestamp on openchpl.subscriber_role;
CREATE TRIGGER subscriber_role_timestamp BEFORE UPDATE ON openchpl.subscriber_role FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- Subscriber. An email address and token that can be used to get to subscriptions related to that email address for management purposes.
-- A subscriber must be confirmed by clicking a link so we know their email is valid.
--
CREATE TABLE IF NOT EXISTS openchpl.subscriber (
	id uuid NOT NULL,
	subscriber_status_id bigint NOT NULL,
	subscriber_role_id bigint NOT NULL,
	email text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	CONSTRAINT subscriber_status_fk FOREIGN KEY (subscriber_status_id) REFERENCES openchpl.subscriber_status(id) 
		ON DELETE RESTRICT,
	CONSTRAINT subscriber_role_fk FOREIGN KEY (subscriber_role_id) REFERENCES openchpl.subscriber_role(id) 
		ON DELETE RESTRICT
);

DROP TRIGGER IF EXISTS subscriber_audit on openchpl.subscriber;
CREATE TRIGGER subscriber_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscriber FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscriber_timestamp on openchpl.subscriber;
CREATE TRIGGER subscriber_timestamp BEFORE UPDATE ON openchpl.subscriber FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
  

--
-- Subscribed object type. Tells whether the type of thing subscribed to is a Listing, Developer, or Product
--
CREATE TABLE IF NOT EXISTS openchpl.subscription_object_type (
	id bigserial NOT NULL,
	name varchar(200) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscription_object_type (name, last_modified_user)
SELECT 'Listing', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'
);

INSERT INTO openchpl.subscription_object_type (name, last_modified_user)
SELECT 'Developer', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_object_type WHERE name = 'Developer'
);

INSERT INTO openchpl.subscription_object_type (name, last_modified_user)
SELECT 'Product', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_object_type WHERE name = 'Product'
);

DROP TRIGGER IF EXISTS subscription_object_type_audit on openchpl.subscription_object_type;
CREATE TRIGGER subscription_object_type_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_object_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscription_object_type_timestamp on openchpl.subscription_object_type;
CREATE TRIGGER subscription_object_type_timestamp BEFORE UPDATE ON openchpl.subscription_object_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- Subscription subject. Tells what specific changes we are looking for
--
CREATE TABLE IF NOT EXISTS openchpl.subscription_subject (
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
SELECT (SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Status Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'Certification Status Changed'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT (SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Criterion Added', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'Certification Criterion Added'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT (SELECT id FROM openchpl.subscription_object_type WHERE name = 'Listing'), 'Certification Criterion Removed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'Certification Criterion Removed'
);

DROP TRIGGER IF EXISTS subscription_subject_audit on openchpl.subscription_subject;
CREATE TRIGGER subscription_subject_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_subject FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscription_subject_timestamp on openchpl.subscription_subject;
CREATE TRIGGER subscription_subject_timestamp BEFORE UPDATE ON openchpl.subscription_subject FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- Consolidation Method. Tells the sort of batching that observations will be sent to the subscriber
--
CREATE TABLE IF NOT EXISTS openchpl.subscription_consolidation_method (
	id bigserial NOT NULL,
	name varchar(200) NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (id)
);

INSERT INTO openchpl.subscription_consolidation_method (name, last_modified_user)
SELECT 'Daily', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_consolidation_method WHERE name = 'Daily'
);

INSERT INTO openchpl.subscription_consolidation_method (name, last_modified_user)
SELECT 'Weekly', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_consolidation_method WHERE name = 'Weekly'
);

DROP TRIGGER IF EXISTS subscription_consolidation_method_audit on openchpl.subscription_consolidation_method;
CREATE TRIGGER subscription_consolidation_method_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_consolidation_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscription_consolidation_method_timestamp on openchpl.subscription_consolidation_method;
CREATE TRIGGER subscription_consolidation_method_timestamp BEFORE UPDATE ON openchpl.subscription_consolidation_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- Subscription.
-- Once the status of the subscriber_id is Confirmed we will log observations for all subscriptions for that subscriber
--
CREATE TABLE IF NOT EXISTS openchpl.subscription (
    id bigserial NOT NULL,	
	subscriber_id uuid NOT NULL, 
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
	CONSTRAINT subscription_subject_fk FOREIGN KEY (subscription_subject_id) REFERENCES openchpl.subscription_subject(id) 
		ON DELETE RESTRICT,
	CONSTRAINT subscription_consolidation_method_fk FOREIGN KEY (subscription_consolidation_method_id) REFERENCES openchpl.subscription_consolidation_method(id) 
		ON DELETE RESTRICT
);

DROP TRIGGER IF EXISTS subscription_audit on openchpl.subscription;
CREATE TRIGGER subscription_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscription_timestamp on openchpl.subscription;
CREATE TRIGGER subscription_timestamp BEFORE UPDATE ON openchpl.subscription FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--
-- Subscription Observations. Whenever a relevant change is observed we will save that fact here.
--
CREATE TABLE IF NOT EXISTS openchpl.subscription_observation (
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

DROP TRIGGER IF EXISTS subscription_observation_audit on openchpl.subscription_observation;
CREATE TRIGGER subscription_observation_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS subscription_observation_timestamp on openchpl.subscription_observation;
CREATE TRIGGER subscription_observation_timestamp BEFORE UPDATE ON openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

