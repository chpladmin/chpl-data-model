SELECT pg_catalog.setval('openchpl.acl_entry_id_seq', 16, true);

--ff4j features needed for tests to run
INSERT INTO ff4j.features(feat_uid, enable, description, strategy, expression, groupname)
VALUES 
('ocd2820', 1, null, null, null, null),
('better-split', 1, null, null, null, null);
