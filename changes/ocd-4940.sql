--
-- Drop unused fields
--
ALTER TABLE openchpl.report_metadata
DROP COLUMN IF EXISTS report_group;

ALTER TABLE openchpl.report_metadata
DROP COLUMN IF EXISTS display_order;

-- 
-- Each report can be associated with zero or more roles
-- If no role is mapped then the report can be visible to the public
--
DROP TABLE IF EXISTS openchpl.report_metadata_role_map;
CREATE TABLE IF NOT EXISTS openchpl.report_metadata_role_map (
	id bigserial NOT NULL,
	report_metadata_id bigint NOT NULL,
	role_name text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT report_metadata_role_map_pk PRIMARY KEY (id),
	CONSTRAINT report_metadata_id_fk FOREIGN KEY (report_metadata_id)
			REFERENCES openchpl.report_metadata (id)
);

-- Reports 1-4 - Developer Statistics visible to anyone

-- Surviellance Statistics (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (5, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (5, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (5, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Surviellance Statistics (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (6, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (6, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (6, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Surviellance Statistics (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (7, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (7, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (7, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Surviellance Statistics (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (8, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (8, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (8, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- There are no reports with ID 9-12, not sure why.
-- Reports 13-16 - a9-b11 visible to anyone
-- Reports 17-20 Product Statistics visible to anyone
-- Reports 21-24 Listing Statistics visible to anyone

-- Direct Review Statistics (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (25, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (25, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (25, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Direct Review Statistics (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (26, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (26, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (26, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Direct Review Statistics (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (27, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (27, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (27, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Direct Review Statistics (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (28, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (28, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (28, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Reports 29-32 - Unique Products visible to anyone
-- Reports 33-36 - Criteria Attributes visible to anyone
-- Reports 37-40 - Service Base URL List visible to anyone

-- Developer Attestations (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (41, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (41, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (41, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Developer Attestations (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (42, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (42, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (42, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Developer Attestations (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (43, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (43, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (43, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Developer Attestations (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (44, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (44, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (44, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Reports 45-48 - NonConformity Counts visible to anyone

-- RWT Summary (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (49, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (49, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (49, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- RWT Summary (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (50, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (50, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (50, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- RWT Summary (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (51, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (51, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (51, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- RWT Summary (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (52, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (52, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (52, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Reports 53-56 - SVAP Usage by Criteria visible to anyone
-- Reports 57-60 - SVAP Usage by SVAP visible to anyone
-- Reports 61-64 Listing Attributes visible to anyone

-- Updated Criteria Status (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (65, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (65, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (65, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Updated Criteria Status (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (66, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (66, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (66, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Updated Criteria Status (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (67, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (67, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (67, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Updated Criteria Status (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (68, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (68, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (68, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Questionable URLs (DEV)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (69, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (69, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (69, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Questionable URLs (QA)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (70, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (70, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (70, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Questionable URLs (STG)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (71, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (71, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (71, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Questionable URLs (PROD)
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (72, 'chpl-admin', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (72, 'chpl-onc', '6498c4f8-b0f1-70b5-55de-d84faae73402');
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
VALUES (72, 'chpl-onc-acb', '6498c4f8-b0f1-70b5-55de-d84faae73402');

-- Add triggers needed for the new table
CREATE OR replace TRIGGER report_metadata_role_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.report_metadata_role_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER report_metadata_role_map_timestamp BEFORE UPDATE on openchpl.report_metadata_role_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS report_metadata_role_map_last_modified_user_constraint ON openchpl.report_metadata_role_map;
CREATE CONSTRAINT TRIGGER report_metadata_role_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.report_metadata_role_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();