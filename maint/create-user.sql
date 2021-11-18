-- new one, without username
DROP FUNCTION If EXISTS openchpl.create_user(text,character varying[],text,text,text,text,text) ;
CREATE FUNCTION openchpl.create_user(role_name text, orgs varchar[], password text, fullname text, friendlyname text, emailaddress text, phonenumber text)
  RETURNS void AS $$
	DECLARE
	  acb varchar;
	  atl varchar;
	  dev varchar;
	BEGIN
		IF (SELECT COUNT(*) FROM openchpl.contact where email = emailaddress AND deleted = false)>0 THEN
			-- user already exists, print error
			RAISE NOTICE 'User % already exists', emailaddress;
		ELSE
			-- insert the contact
			INSERT INTO openchpl.contact (full_name, friendly_name, email, phone_number, signature_date, last_modified_user)
			VALUES (fullname, friendlyname, emailaddress, phonenumber, now(), -2);

			-- insert the user
			INSERT INTO openchpl.user (password, account_expired, account_locked, credentials_expired, account_enabled, last_modified_user, contact_id, user_permission_id)
			VALUES (password, false, false, false, true, -2,
				(SELECT contact_id FROM openchpl.contact WHERE full_name = fullname AND friendly_name = friendlyname LIMIT 1),
				(SELECT user_permission_id FROM openchpl.user_permission WHERE authority = role_name));

			RAISE NOTICE 'Created user %', emailaddress;

			-- if the user is ROLE_ACB, give them permission on the passed-in ACB(s)
			IF role_name = 'ROLE_ACB' THEN
				FOREACH acb IN ARRAY orgs
				LOOP
					RAISE NOTICE 'Adding permissions for % to ACB %', emailaddress, acb;
				    INSERT INTO openchpl.user_certification_body_map
					(user_id, certification_body_id, retired, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where contact_id = (SELECT contact_id from openchpl.contact where email = emailaddress AND deleted = false) AND deleted = false),
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
					RAISE NOTICE 'Adding permissions for % to ATL %', emailaddress, atl;
				    INSERT INTO openchpl.user_testing_lab_map
					(user_id, testing_lab_id, retired, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where contact_id = (SELECT contact_id from openchpl.contact where email = emailaddress AND deleted = false) AND deleted = false),
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
					RAISE NOTICE 'Adding permissions for % to Developer %', emailaddress, dev;
				    INSERT INTO openchpl.user_developer_map
					(user_id, developer_id, last_modified_user)
					VALUES
					(
						(SELECT user_id FROM openchpl.user where contact_id = (SELECT contact_id from openchpl.contact where email = emailaddress AND deleted = false) AND deleted = false),
						(SELECT vendor_id FROM openchpl.vendor where name = dev and deleted = false limit 1),
						-2
					);
				END LOOP;
			END IF;
		END IF;
	END;
$$ language plpgsql
volatile;

-- bootstrap to allow use of username in calling scripts; remove when calling scripts have been updated
DROP FUNCTION If EXISTS openchpl.create_user(text,character varying[],text,text,text,text,text,text) ;
CREATE FUNCTION openchpl.create_user(role_name text, orgs varchar[], user_name text, password text, fullname text, friendlyname text, emailaddress text, phonenumber text)
  RETURNS void AS $$
  BEGIN
    PERFORM openchpl.create_user(role_name, orgs, password, fullname, friendlyname, emailaddress, phonenumber);
  END;
$$ language plpgsql
volatile;
