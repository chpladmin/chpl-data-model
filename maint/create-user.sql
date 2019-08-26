DROP FUNCTION If EXISTS openchpl.create_user(text,character varying[],text,text,text,text,text,text) ;
CREATE FUNCTION openchpl.create_user(role_name text, orgs varchar[], username text, password text, fullname text, friendlyname text, email text, phonenumber text)
  RETURNS void AS $$
	DECLARE
	  acb varchar;
	  atl varchar;
	  dev varchar;
	BEGIN
		IF (SELECT COUNT(*) FROM openchpl.user where user_name = username AND deleted = false)>0 THEN
			-- user already exists, print error
			RAISE NOTICE 'User % already exists', username;
		ELSE
			-- insert the contact
			INSERT INTO openchpl.contact (full_name, friendly_name, email, phone_number, signature_date, last_modified_user)
			VALUES (fullname, friendlyname, email, phonenumber, now(), -2);

			-- insert the user
			INSERT INTO openchpl.user (user_name, password, account_expired, account_locked, credentials_expired, account_enabled, last_modified_user, contact_id, user_permission_id)
			VALUES (username, password, false, false, false, true, -2,
				(SELECT contact_id FROM openchpl.contact WHERE full_name = fullname AND friendly_name = friendlyname LIMIT 1),
				(SELECT user_permission_id FROM openchpl.user_permission WHERE authority = role_name));

			-- create spring acl sids
			INSERT INTO openchpl.acl_sid (principal, sid)
			VALUES (true, username);

			-- create ACL object for each sid
			INSERT INTO openchpl.acl_object_identity (object_id_class, object_id_identity, parent_object, owner_sid, entries_inheriting)
			VALUES (1, (SELECT user_id FROM openchpl.user WHERE user_name = username), null, -2, true);

			-- grant each user permission on themselves
			INSERT INTO openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure)
			VALUES ((SELECT id FROM openchpl.acl_object_identity WHERE object_id_class = 1 AND object_id_identity =
						(SELECT user_id FROM openchpl.user where user_name = username)), 0,
					(SELECT id FROM openchpl.acl_sid where sid = username), 16, true, false, false);

			RAISE NOTICE 'Created user %', username;

			-- if the user is ROLE_ACB, give them permission on the passed-in ACB(s)
			IF role_name = 'ROLE_ACB' THEN
				FOREACH acb IN ARRAY orgs
				LOOP
					RAISE NOTICE 'Adding permissions for % to ACB %', username, acb;
				    INSERT INTO openchpl.user_certification_body_map
					(user_id, certification_body_id, retired, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where user_name = username AND deleted = false),
						(SELECT certification_body_id FROM openchpl.certification_body where name = acb),
						false,
						-2
					);
				END LOOP;
			END IF;
			
			-- if the user is ROLE_ATL, give them permission on the passed-in orgs(s)
			IF role_name = 'ROLE_ATL' THEN
				FOREACH atl IN ARRAY orgs
				LOOP
					RAISE NOTICE 'Adding permissions for % to ATL %', username, atl;
				    INSERT INTO openchpl.user_testing_lab_map
					(user_id, testing_lab_id, retired, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where user_name = username AND deleted = false),
						(SELECT testing_lab_id FROM openchpl.testing_lab where name = atl),
						false,
						-2
					);
				END LOOP;
			END IF;

			-- if the user is ROLE_DEVELOPER, give them permission on the passed-in orgs(s)
			IF role_name = 'ROLE_DEVELOPER' THEN
				FOREACH dev IN ARRAY orgs
				LOOP
					RAISE NOTICE 'Adding permissions for % to Developer %', username, dev;
				    INSERT INTO openchpl.user_developer_map
					(user_id, developer_id, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where user_name = username AND deleted = false),
						(SELECT vendor_id FROM openchpl.vendor where name = dev and deleted = false limit 1),
						-2
					);
				END LOOP;
			END IF;
		END IF;
	END;
$$ language plpgsql
volatile;
