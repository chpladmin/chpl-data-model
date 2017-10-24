--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = openchpl, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: questionable_activity_certification_result; Type: TABLE; Schema: openchpl; Owner: postgres; Tablespace: 
--

CREATE TABLE questionable_activity_certification_result (
    id bigint NOT NULL,
    questionable_activity_trigger_id bigint NOT NULL,
    certification_result_id bigint NOT NULL,
    before_data text,
    after_data text,
    activity_date timestamp without time zone NOT NULL,
    activity_user_id bigint NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_user bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE questionable_activity_certification_result OWNER TO postgres;

--
-- Name: questionable_activity_certification_result_id_seq; Type: SEQUENCE; Schema: openchpl; Owner: postgres
--

CREATE SEQUENCE questionable_activity_certification_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questionable_activity_certification_result_id_seq OWNER TO postgres;

--
-- Name: questionable_activity_certification_result_id_seq; Type: SEQUENCE OWNED BY; Schema: openchpl; Owner: postgres
--

ALTER SEQUENCE questionable_activity_certification_result_id_seq OWNED BY questionable_activity_certification_result.id;


--
-- Name: questionable_activity_developer; Type: TABLE; Schema: openchpl; Owner: postgres; Tablespace: 
--

CREATE TABLE questionable_activity_developer (
    id bigint NOT NULL,
    questionable_activity_trigger_id bigint NOT NULL,
    developer_id bigint NOT NULL,
    before_data text,
    after_data text,
    activity_date timestamp without time zone NOT NULL,
    activity_user_id bigint NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_user bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE questionable_activity_developer OWNER TO postgres;

--
-- Name: questionable_activity_developer_id_seq; Type: SEQUENCE; Schema: openchpl; Owner: postgres
--

CREATE SEQUENCE questionable_activity_developer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questionable_activity_developer_id_seq OWNER TO postgres;

--
-- Name: questionable_activity_developer_id_seq; Type: SEQUENCE OWNED BY; Schema: openchpl; Owner: postgres
--

ALTER SEQUENCE questionable_activity_developer_id_seq OWNED BY questionable_activity_developer.id;


--
-- Name: questionable_activity_listing; Type: TABLE; Schema: openchpl; Owner: postgres; Tablespace: 
--

CREATE TABLE questionable_activity_listing (
    id bigint NOT NULL,
    questionable_activity_trigger_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    before_data text,
    after_data text,
    activity_date timestamp without time zone NOT NULL,
    activity_user_id bigint NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_user bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE questionable_activity_listing OWNER TO postgres;

--
-- Name: questionable_activity_listing_id_seq; Type: SEQUENCE; Schema: openchpl; Owner: postgres
--

CREATE SEQUENCE questionable_activity_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questionable_activity_listing_id_seq OWNER TO postgres;

--
-- Name: questionable_activity_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: openchpl; Owner: postgres
--

ALTER SEQUENCE questionable_activity_listing_id_seq OWNED BY questionable_activity_listing.id;


--
-- Name: questionable_activity_product; Type: TABLE; Schema: openchpl; Owner: postgres; Tablespace: 
--

CREATE TABLE questionable_activity_product (
    id bigint NOT NULL,
    questionable_activity_trigger_id bigint NOT NULL,
    product_id bigint NOT NULL,
    before_data text,
    after_data text,
    activity_date timestamp without time zone NOT NULL,
    activity_user_id bigint NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_user bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE questionable_activity_product OWNER TO postgres;

--
-- Name: questionable_activity_product_id_seq; Type: SEQUENCE; Schema: openchpl; Owner: postgres
--

CREATE SEQUENCE questionable_activity_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questionable_activity_product_id_seq OWNER TO postgres;

--
-- Name: questionable_activity_product_id_seq; Type: SEQUENCE OWNED BY; Schema: openchpl; Owner: postgres
--

ALTER SEQUENCE questionable_activity_product_id_seq OWNED BY questionable_activity_product.id;


--
-- Name: questionable_activity_version; Type: TABLE; Schema: openchpl; Owner: postgres; Tablespace: 
--

CREATE TABLE questionable_activity_version (
    id bigint NOT NULL,
    questionable_activity_trigger_id bigint NOT NULL,
    version_id bigint NOT NULL,
    before_data text,
    after_data text,
    activity_date timestamp without time zone NOT NULL,
    activity_user_id bigint NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_user bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE questionable_activity_version OWNER TO postgres;

--
-- Name: questionable_activity_version_id_seq; Type: SEQUENCE; Schema: openchpl; Owner: postgres
--

CREATE SEQUENCE questionable_activity_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questionable_activity_version_id_seq OWNER TO postgres;

--
-- Name: questionable_activity_version_id_seq; Type: SEQUENCE OWNED BY; Schema: openchpl; Owner: postgres
--

ALTER SEQUENCE questionable_activity_version_id_seq OWNED BY questionable_activity_version.id;


--
-- Name: id; Type: DEFAULT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_certification_result ALTER COLUMN id SET DEFAULT nextval('questionable_activity_certification_result_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_developer ALTER COLUMN id SET DEFAULT nextval('questionable_activity_developer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_listing ALTER COLUMN id SET DEFAULT nextval('questionable_activity_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_product ALTER COLUMN id SET DEFAULT nextval('questionable_activity_product_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_version ALTER COLUMN id SET DEFAULT nextval('questionable_activity_version_id_seq'::regclass);


--
-- Data for Name: questionable_activity_certification_result; Type: TABLE DATA; Schema: openchpl; Owner: postgres
--

COPY questionable_activity_certification_result (id, questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, creation_date, last_modified_date, last_modified_user, deleted) FROM stdin;
1	5	363367	false	true	2017-10-24 15:16:55.58	-2	2017-10-24 15:16:55.494	2017-10-24 15:16:55.494	-2	f
2	11	363367	false	true	2017-10-24 15:16:55.58	-2	2017-10-24 15:16:55.494	2017-10-24 15:16:55.494	-2	f
3	6	363367	false	true	2017-10-24 15:19:09.258	-2	2017-10-24 15:19:09.236	2017-10-24 15:19:09.236	-2	f
4	6	363367	true	false	2017-10-24 15:19:53.201	-2	2017-10-24 15:19:53.105	2017-10-24 15:19:53.105	-2	f
5	5	363367	true	false	2017-10-24 15:20:51.383	-2	2017-10-24 15:20:51.32	2017-10-24 15:20:51.32	-2	f
6	6	363367	false	true	2017-10-24 15:20:51.383	-2	2017-10-24 15:20:51.32	2017-10-24 15:20:51.32	-2	f
7	11	363367	true	false	2017-10-24 15:20:51.383	-2	2017-10-24 15:20:51.32	2017-10-24 15:20:51.32	-2	f
8	5	263335	false	true	2017-10-24 15:25:37.243	-2	2017-10-24 15:25:37.168	2017-10-24 15:25:37.168	-2	f
9	5	263335	true	false	2017-10-24 15:27:12.985	-2	2017-10-24 15:27:12.915	2017-10-24 15:27:12.915	-2	f
10	7	450496	\N	RT2a EC Group	2017-10-24 15:29:33.924	-2	2017-10-24 15:29:33.901	2017-10-24 15:29:33.901	-2	f
11	7	450496	\N	RT2a EC Individual (TIN/NPI)	2017-10-24 15:29:33.924	-2	2017-10-24 15:29:33.901	2017-10-24 15:29:33.901	-2	f
12	9	450496	\N	RT4a EP Individual	2017-10-24 15:29:33.924	-2	2017-10-24 15:29:33.901	2017-10-24 15:29:33.901	-2	f
13	9	450496	\N	RT4b EC Individual (TIN/NPI)	2017-10-24 15:29:33.924	-2	2017-10-24 15:29:33.901	2017-10-24 15:29:33.901	-2	f
14	9	450496	\N	RT4b EP Individual	2017-10-24 15:29:33.924	-2	2017-10-24 15:29:33.901	2017-10-24 15:29:33.901	-2	f
15	8	450496	RT2a EC Group	\N	2017-10-24 15:31:23.163	-2	2017-10-24 15:31:22.971	2017-10-24 15:31:22.971	-2	f
16	10	450496	RT4b EC Individual (TIN/NPI)	\N	2017-10-24 15:31:23.163	-2	2017-10-24 15:31:22.971	2017-10-24 15:31:22.971	-2	f
\.


--
-- Name: questionable_activity_certification_result_id_seq; Type: SEQUENCE SET; Schema: openchpl; Owner: postgres
--

SELECT pg_catalog.setval('questionable_activity_certification_result_id_seq', 16, true);


--
-- Data for Name: questionable_activity_developer; Type: TABLE DATA; Schema: openchpl; Owner: postgres
--

COPY questionable_activity_developer (id, questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, creation_date, last_modified_date, last_modified_user, deleted) FROM stdin;
1	15	1886	Acentec, Inc.	Acentec, Inc. Renamed	2017-10-24 15:00:05.791	-2	2017-10-24 15:00:04.528	2017-10-24 15:00:04.528	-2	f
2	15	1886	Acentec, Inc. Renamed	Acentec, Inc.	2017-10-24 15:00:30.325	-2	2017-10-24 15:00:30.2	2017-10-24 15:00:30.2	-2	f
3	18	1886	\N	Suspended by ONC (2017-10-20 15:00:16.065)	2017-10-24 15:00:30.325	-2	2017-10-24 15:00:30.2	2017-10-24 15:00:30.2	-2	f
4	18	1886	\N	Active (2017-10-24 15:00:25.893)	2017-10-24 15:00:30.325	-2	2017-10-24 15:00:30.2	2017-10-24 15:00:30.2	-2	f
5	15	448	Epic Systems Corporation	Epic Systems Corp.	2017-10-24 15:06:15.947	-2	2017-10-24 15:06:15.896	2017-10-24 15:06:15.896	-2	f
\.


--
-- Name: questionable_activity_developer_id_seq; Type: SEQUENCE SET; Schema: openchpl; Owner: postgres
--

SELECT pg_catalog.setval('questionable_activity_developer_id_seq', 5, true);


--
-- Data for Name: questionable_activity_listing; Type: TABLE DATA; Schema: openchpl; Owner: postgres
--

COPY questionable_activity_listing (id, questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, creation_date, last_modified_date, last_modified_user, deleted) FROM stdin;
1	14	8556	Active	Suspended by ONC-ACB	2017-10-24 15:10:28.777	-2	2017-10-24 15:10:28.457	2017-10-24 15:10:28.457	-2	f
2	13	3841	\N	\N	2017-10-24 15:14:59.406	-2	2017-10-24 15:14:59.398	2017-10-24 15:14:59.398	-2	f
3	1	5309	\N	170.314 (a)(17)	2017-10-24 15:25:37.243	-2	2017-10-24 15:25:37.168	2017-10-24 15:25:37.168	-2	f
4	2	5309	170.314 (a)(17)	\N	2017-10-24 15:27:12.985	-2	2017-10-24 15:27:12.915	2017-10-24 15:27:12.915	-2	f
5	12	8125	\N	\N	2017-10-24 15:36:00.996	33	2017-10-24 15:36:00.981	2017-10-24 15:36:00.981	33	f
\.


--
-- Name: questionable_activity_listing_id_seq; Type: SEQUENCE SET; Schema: openchpl; Owner: postgres
--

SELECT pg_catalog.setval('questionable_activity_listing_id_seq', 5, true);


--
-- Data for Name: questionable_activity_product; Type: TABLE DATA; Schema: openchpl; Owner: postgres
--

COPY questionable_activity_product (id, questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, creation_date, last_modified_date, last_modified_user, deleted) FROM stdin;
1	20	291	Discharge 1-2-3	Discharge 123	2017-10-24 15:01:26.37	-2	2017-10-24 15:01:26.164	2017-10-24 15:01:26.164	-2	f
2	23	291	\N	3M Health Information Systems (Sat Sep 30 20:00:00 EDT 2017)	2017-10-24 15:02:08.737	-2	2017-10-24 15:02:08.541	2017-10-24 15:02:08.541	-2	f
3	23	291	\N	Callibra, Inc. (Mon Oct 23 20:00:00 EDT 2017)	2017-10-24 15:02:08.737	-2	2017-10-24 15:02:08.541	2017-10-24 15:02:08.541	-2	f
4	20	28	4medica iEHR® Cloud Ambulatory Solution	4medica iEHR® Cloud Ambulatory Solution Renamed	2017-10-24 15:05:30.252	-2	2017-10-24 15:05:30.207	2017-10-24 15:05:30.207	-2	f
5	21	2629	Epic Systems Corp.	Enterprise Healthcare Systems Inc. (MDPlus.Net)	2017-10-24 15:06:43.238	-2	2017-10-24 15:06:43.163	2017-10-24 15:06:43.163	-2	f
6	23	2629	\N	Epic Systems Corp. (Tue Oct 24 15:06:40 EDT 2017)	2017-10-24 15:06:43.238	-2	2017-10-24 15:06:43.163	2017-10-24 15:06:43.163	-2	f
\.


--
-- Name: questionable_activity_product_id_seq; Type: SEQUENCE SET; Schema: openchpl; Owner: postgres
--

SELECT pg_catalog.setval('questionable_activity_product_id_seq', 6, true);


--
-- Data for Name: questionable_activity_version; Type: TABLE DATA; Schema: openchpl; Owner: postgres
--

COPY questionable_activity_version (id, questionable_activity_trigger_id, version_id, before_data, after_data, activity_date, activity_user_id, creation_date, last_modified_date, last_modified_user, deleted) FROM stdin;
1	25	939	15.10	15.TEN	2017-10-24 15:05:07.559	-2	2017-10-24 15:05:07.374	2017-10-24 15:05:07.374	-2	f
2	25	939	15.TEN	15.11	2017-10-24 15:05:12.314	-2	2017-10-24 15:05:12.293	2017-10-24 15:05:12.293	-2	f
\.


--
-- Name: questionable_activity_version_id_seq; Type: SEQUENCE SET; Schema: openchpl; Owner: postgres
--

SELECT pg_catalog.setval('questionable_activity_version_id_seq', 2, true);


--
-- Name: questionable_activity_certification_result_pk; Type: CONSTRAINT; Schema: openchpl; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questionable_activity_certification_result
    ADD CONSTRAINT questionable_activity_certification_result_pk PRIMARY KEY (id);


--
-- Name: questionable_activity_developer_ok; Type: CONSTRAINT; Schema: openchpl; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questionable_activity_developer
    ADD CONSTRAINT questionable_activity_developer_ok PRIMARY KEY (id);


--
-- Name: questionable_activity_listing_pk; Type: CONSTRAINT; Schema: openchpl; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questionable_activity_listing
    ADD CONSTRAINT questionable_activity_listing_pk PRIMARY KEY (id);


--
-- Name: questionable_activity_product_pk; Type: CONSTRAINT; Schema: openchpl; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questionable_activity_product
    ADD CONSTRAINT questionable_activity_product_pk PRIMARY KEY (id);


--
-- Name: questionable_activity_version_pk; Type: CONSTRAINT; Schema: openchpl; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questionable_activity_version
    ADD CONSTRAINT questionable_activity_version_pk PRIMARY KEY (id);


--
-- Name: questionable_activity_certification_result_audit; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_certification_result_audit AFTER INSERT OR DELETE OR UPDATE ON questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();


--
-- Name: questionable_activity_certification_result_timestamp; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_certification_result_timestamp BEFORE UPDATE ON questionable_activity_certification_result FOR EACH ROW EXECUTE PROCEDURE update_last_modified_date_column();


--
-- Name: questionable_activity_developer_audit; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_developer_audit AFTER INSERT OR DELETE OR UPDATE ON questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();


--
-- Name: questionable_activity_developer_timestamp; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_developer_timestamp BEFORE UPDATE ON questionable_activity_developer FOR EACH ROW EXECUTE PROCEDURE update_last_modified_date_column();


--
-- Name: questionable_activity_listing_audit; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_listing_audit AFTER INSERT OR DELETE OR UPDATE ON questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();


--
-- Name: questionable_activity_listing_timestamp; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_listing_timestamp BEFORE UPDATE ON questionable_activity_listing FOR EACH ROW EXECUTE PROCEDURE update_last_modified_date_column();


--
-- Name: questionable_activity_product_audit; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_product_audit AFTER INSERT OR DELETE OR UPDATE ON questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();


--
-- Name: questionable_activity_product_timestamp; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_product_timestamp BEFORE UPDATE ON questionable_activity_product FOR EACH ROW EXECUTE PROCEDURE update_last_modified_date_column();


--
-- Name: questionable_activity_version_audit; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_version_audit AFTER INSERT OR DELETE OR UPDATE ON questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();


--
-- Name: questionable_activity_version_timestamp; Type: TRIGGER; Schema: openchpl; Owner: postgres
--

CREATE TRIGGER questionable_activity_version_timestamp BEFORE UPDATE ON questionable_activity_version FOR EACH ROW EXECUTE PROCEDURE update_last_modified_date_column();


--
-- Name: certification_result_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_certification_result
    ADD CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id) REFERENCES certification_result(certification_result_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: developer_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_developer
    ADD CONSTRAINT developer_fk FOREIGN KEY (developer_id) REFERENCES vendor(vendor_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: listing_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_listing
    ADD CONSTRAINT listing_fk FOREIGN KEY (listing_id) REFERENCES certified_product(certified_product_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_product
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES product(product_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_trigger_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_version
    ADD CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id) REFERENCES questionable_activity_trigger(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_trigger_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_product
    ADD CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id) REFERENCES questionable_activity_trigger(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_trigger_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_developer
    ADD CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id) REFERENCES questionable_activity_trigger(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_trigger_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_listing
    ADD CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id) REFERENCES questionable_activity_trigger(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_trigger_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_certification_result
    ADD CONSTRAINT questionable_activity_trigger_fk FOREIGN KEY (questionable_activity_trigger_id) REFERENCES questionable_activity_trigger(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_version
    ADD CONSTRAINT user_fk FOREIGN KEY (activity_user_id) REFERENCES "user"(user_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_product
    ADD CONSTRAINT user_fk FOREIGN KEY (activity_user_id) REFERENCES "user"(user_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_developer
    ADD CONSTRAINT user_fk FOREIGN KEY (activity_user_id) REFERENCES "user"(user_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_listing
    ADD CONSTRAINT user_fk FOREIGN KEY (activity_user_id) REFERENCES "user"(user_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_certification_result
    ADD CONSTRAINT user_fk FOREIGN KEY (activity_user_id) REFERENCES "user"(user_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: version_fk; Type: FK CONSTRAINT; Schema: openchpl; Owner: postgres
--

ALTER TABLE ONLY questionable_activity_version
    ADD CONSTRAINT version_fk FOREIGN KEY (version_id) REFERENCES product_version(product_version_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionable_activity_certification_result; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON TABLE questionable_activity_certification_result FROM PUBLIC;
REVOKE ALL ON TABLE questionable_activity_certification_result FROM postgres;
GRANT ALL ON TABLE questionable_activity_certification_result TO postgres;
GRANT ALL ON TABLE questionable_activity_certification_result TO openchpl;


--
-- Name: questionable_activity_certification_result_id_seq; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON SEQUENCE questionable_activity_certification_result_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questionable_activity_certification_result_id_seq FROM postgres;
GRANT ALL ON SEQUENCE questionable_activity_certification_result_id_seq TO postgres;
GRANT ALL ON SEQUENCE questionable_activity_certification_result_id_seq TO openchpl;


--
-- Name: questionable_activity_developer; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON TABLE questionable_activity_developer FROM PUBLIC;
REVOKE ALL ON TABLE questionable_activity_developer FROM postgres;
GRANT ALL ON TABLE questionable_activity_developer TO postgres;
GRANT ALL ON TABLE questionable_activity_developer TO openchpl;


--
-- Name: questionable_activity_developer_id_seq; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON SEQUENCE questionable_activity_developer_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questionable_activity_developer_id_seq FROM postgres;
GRANT ALL ON SEQUENCE questionable_activity_developer_id_seq TO postgres;
GRANT ALL ON SEQUENCE questionable_activity_developer_id_seq TO openchpl;


--
-- Name: questionable_activity_listing; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON TABLE questionable_activity_listing FROM PUBLIC;
REVOKE ALL ON TABLE questionable_activity_listing FROM postgres;
GRANT ALL ON TABLE questionable_activity_listing TO postgres;
GRANT ALL ON TABLE questionable_activity_listing TO openchpl;


--
-- Name: questionable_activity_listing_id_seq; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON SEQUENCE questionable_activity_listing_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questionable_activity_listing_id_seq FROM postgres;
GRANT ALL ON SEQUENCE questionable_activity_listing_id_seq TO postgres;
GRANT ALL ON SEQUENCE questionable_activity_listing_id_seq TO openchpl;


--
-- Name: questionable_activity_product; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON TABLE questionable_activity_product FROM PUBLIC;
REVOKE ALL ON TABLE questionable_activity_product FROM postgres;
GRANT ALL ON TABLE questionable_activity_product TO postgres;
GRANT ALL ON TABLE questionable_activity_product TO openchpl;


--
-- Name: questionable_activity_product_id_seq; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON SEQUENCE questionable_activity_product_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questionable_activity_product_id_seq FROM postgres;
GRANT ALL ON SEQUENCE questionable_activity_product_id_seq TO postgres;
GRANT ALL ON SEQUENCE questionable_activity_product_id_seq TO openchpl;


--
-- Name: questionable_activity_version; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON TABLE questionable_activity_version FROM PUBLIC;
REVOKE ALL ON TABLE questionable_activity_version FROM postgres;
GRANT ALL ON TABLE questionable_activity_version TO postgres;
GRANT ALL ON TABLE questionable_activity_version TO openchpl;


--
-- Name: questionable_activity_version_id_seq; Type: ACL; Schema: openchpl; Owner: postgres
--

REVOKE ALL ON SEQUENCE questionable_activity_version_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questionable_activity_version_id_seq FROM postgres;
GRANT ALL ON SEQUENCE questionable_activity_version_id_seq TO postgres;
GRANT ALL ON SEQUENCE questionable_activity_version_id_seq TO openchpl;


--
-- PostgreSQL database dump complete
--

