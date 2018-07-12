-- OCD-2360
-- bulk withdrawal of Listings
-- function returns false if one of a variety of conditions is true, indicated in comments
create or replace function openchpl.can_add_new_status(db_id bigint, eff_date timestamp, chpl_id varchar(64)) returns boolean as $$
    begin
-- most recent status is after effective date
    if (select cse.event_date from openchpl.certification_status_event cse where cse.certified_product_id = db_id order by cse.event_date desc limit 1) > eff_date then
    raise warning 'ID % cannot be updated as it has a later status CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
-- most recent status is already "Withdrawn by Developer"
    if (select cse.certification_status_id from openchpl.certification_status_event cse where cse.certified_product_id = db_id order by cse.event_date desc limit 1) = 3 then
    raise warning 'ID % cannot be updated as it would be a double status CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
-- most recent status anything other than "Active"
    if (select cse.certification_status_id from openchpl.certification_status_event cse where cse.certified_product_id = db_id order by cse.event_date desc limit 1) != 1 then
    raise warning 'ID % cannot be updated as Listing is not in status: Active CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
-- has open surveillance
    if (select count(s.start_date) from openchpl.surveillance s where s.certified_product_id = db_id and s.end_date is null) > 0 then
    raise warning 'ID % cannot be updated as it has an open surveillance CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
-- had open surveillance at effective date
    if (select count(*) from openchpl.surveillance s where s.certified_product_id = db_id and s.start_date < eff_date and s.end_date > eff_date) > 0 then
    raise warning 'ID % cannot be updated as it had an open surveillance at the effective date CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
-- had any surveillance starting after effective date
    if (select count(*) from openchpl.surveillance s where s.certified_product_id = db_id and s.start_date > eff_date) > 0 then
    raise warning 'ID % cannot be updated as it had an opened surveillance after the effective date CHPL ID: %', db_id, chpl_id;
    return false;
    end if;
    return true;
    end;
    $$ language plpgsql
    stable;

create or replace function openchpl.add_new_status(db_id bigint, eff_date timestamp, chpl_id varchar(64)) returns void as $$
    begin
insert into openchpl.certification_status_event (certified_product_id, certification_status_id, event_date, last_modified_user) select db_id, 3, eff_date, -1
where openchpl.can_add_new_status(db_id, eff_date, chpl_id) = true;
    end;
    $$ language plpgsql;

-- OCD - 2351 - nonconformity chart statistics

DROP TABLE openchpl.nonconformity_type_statistics IF EXISTS;
CREATE TABLE openchpl.nonconformity_type_statistics
(
  	id bigserial NOT NULL,
  	nonconformity_count bigint NOT NULL,
	nonconformity_type bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  	CONSTRAINT nonconformity_type_statistics_pk PRIMARY KEY (id)
);
CREATE TRIGGER nonconformity_type_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_type_statistics_timestamp BEFORE UPDATE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
--Cerner
select openchpl.add_new_status(7864,'2018-07-16','14.03.07.1221.HEI2.03.01.1.160711');
select openchpl.add_new_status(7867,'2018-07-16','14.03.07.1221.HEI3.03.01.1.160711');
select openchpl.add_new_status(7869,'2018-07-16','14.03.07.1221.HEA2.03.01.1.160711');
select openchpl.add_new_status(7874,'2018-07-16','14.03.07.1221.HEA3.03.01.1.160711');
select openchpl.add_new_status(7885,'2018-07-16','14.03.07.1221.POI2.03.01.1.160711');
select openchpl.add_new_status(7887,'2018-07-16','14.03.07.1221.FIA1.03.01.1.160711');
select openchpl.add_new_status(7889,'2018-07-16','14.03.07.1221.POA5.03.01.1.160711');
select openchpl.add_new_status(7892,'2018-07-16','14.03.07.1221.FII3.03.01.1.160711');
select openchpl.add_new_status(7894,'2018-07-16','14.03.07.1221.POI3.03.01.1.160711');
select openchpl.add_new_status(7904,'2018-07-16','14.03.07.1221.HEI3.01.01.1.160711');
select openchpl.add_new_status(7905,'2018-07-16','14.03.07.1221.HEI2.01.01.1.160711');
select openchpl.add_new_status(7906,'2018-07-16','14.03.07.1221.POA5.01.01.1.160711');
select openchpl.add_new_status(7907,'2018-07-16','14.03.07.1221.POI5.01.01.1.160711');
select openchpl.add_new_status(7908,'2018-07-16','14.03.07.1221.POI2.01.01.1.160711');
select openchpl.add_new_status(7909,'2018-07-16','14.03.07.1221.FIA2.01.01.1.160711');
select openchpl.add_new_status(7910,'2018-07-16','14.03.07.1221.FII3.01.01.1.160711');
select openchpl.add_new_status(7911,'2018-07-16','14.03.07.1221.HEA3.01.01.1.160711');
select openchpl.add_new_status(7915,'2018-07-16','14.03.07.1221.FIA1.01.01.1.160711');
select openchpl.add_new_status(7916,'2018-07-16','14.03.07.1221.HEA2.01.01.1.160711');
select openchpl.add_new_status(7919,'2018-07-16','14.03.07.1221.POI3.01.01.1.160711');
select openchpl.add_new_status(7920,'2018-07-16','14.07.07.1221.POA1.01.01.1.160711');
select openchpl.add_new_status(7925,'2018-07-16','14.07.07.1221.POA1.03.01.1.160711');
select openchpl.add_new_status(7928,'2018-07-16','14.03.07.1221.FIA2.03.01.1.160711');
select openchpl.add_new_status(7929,'2018-07-16','14.03.07.1221.POI5.03.01.1.160711');
select openchpl.add_new_status(7936,'2018-07-16','14.03.07.1221.FII1.01.01.1.160711');
select openchpl.add_new_status(7939,'2018-07-16','14.03.07.1221.FII1.03.01.1.160711');
select openchpl.add_new_status(7993,'2018-07-16','14.07.07.1221.POA1.04.01.1.160906');
select openchpl.add_new_status(8015,'2018-07-16','14.07.07.1221.HEI3.04.01.1.160906');
select openchpl.add_new_status(8016,'2018-07-16','14.07.07.1221.FII1.04.01.1.160906');
select openchpl.add_new_status(8017,'2018-07-16','14.07.07.1221.HEA3.04.01.1.160906');
select openchpl.add_new_status(8019,'2018-07-16','14.07.07.1221.FIA1.04.01.1.160906');
select openchpl.add_new_status(8020,'2018-07-16','14.07.07.1221.HEI2.04.01.1.160906');
select openchpl.add_new_status(8021,'2018-07-16','14.07.07.1221.POI2.04.01.1.160906');
select openchpl.add_new_status(8022,'2018-07-16','14.07.07.1221.FIA2.04.01.1.160906');
select openchpl.add_new_status(8024,'2018-07-16','14.07.07.1221.HEA2.04.01.1.160906');
select openchpl.add_new_status(8025,'2018-07-16','14.07.07.1221.POI5.04.01.1.160906');
select openchpl.add_new_status(8028,'2018-07-16','14.07.07.1221.FII3.04.01.1.160906');
select openchpl.add_new_status(8030,'2018-07-16','14.07.07.1221.POI3.04.01.1.160906');
select openchpl.add_new_status(8032,'2018-07-16','14.07.07.1221.POA5.04.01.1.160906');
select openchpl.add_new_status(8145,'2018-07-16','14.07.07.1221.FII1.04.01.1.161108');
select openchpl.add_new_status(8150,'2018-07-16','14.07.07.1221.FIA1.04.01.1.161108');
select openchpl.add_new_status(8151,'2018-07-16','14.07.07.1221.POA5.04.01.1.161108');
select openchpl.add_new_status(8152,'2018-07-16','14.07.07.1221.POI5.04.01.1.161108');
select openchpl.add_new_status(8153,'2018-07-16','14.07.07.1221.POA1.04.01.1.161108');
select openchpl.add_new_status(8154,'2018-07-16','14.07.07.1221.POI3.04.01.1.161108');
select openchpl.add_new_status(8155,'2018-07-16','14.07.07.1221.HEI2.04.01.1.161108');
select openchpl.add_new_status(8156,'2018-07-16','14.07.07.1221.POI2.04.01.1.161108');
select openchpl.add_new_status(8157,'2018-07-16','14.07.07.1221.FII3.04.01.1.161108');
select openchpl.add_new_status(8161,'2018-07-16','14.07.07.1221.HEA3.04.01.1.161108');
select openchpl.add_new_status(8163,'2018-07-16','14.07.07.1221.FIA2.04.01.1.161108');
select openchpl.add_new_status(8165,'2018-07-16','14.07.07.1221.HEI3.04.01.1.161108');
select openchpl.add_new_status(8166,'2018-07-16','14.07.07.1221.HEA2.04.01.1.161108');
select openchpl.add_new_status(8264,'2018-07-16','14.07.07.1221.POA1.04.01.1.161227');
select openchpl.add_new_status(8265,'2018-07-16','14.07.07.1221.FII1.04.01.1.161227');
select openchpl.add_new_status(8266,'2018-07-16','14.07.07.1221.FII3.04.01.1.161227');
select openchpl.add_new_status(8267,'2018-07-16','14.07.07.1221.HEA3.04.01.1.161227');
select openchpl.add_new_status(8269,'2018-07-16','14.07.07.1221.HEI3.04.01.1.161227');
select openchpl.add_new_status(8271,'2018-07-16','14.07.07.1221.POI3.04.01.1.161227');
select openchpl.add_new_status(8272,'2018-07-16','14.07.07.1221.FIA1.04.01.1.161227');
select openchpl.add_new_status(8273,'2018-07-16','14.07.07.1221.POA5.04.01.1.161227');
select openchpl.add_new_status(8275,'2018-07-16','14.07.07.1221.HEI2.04.01.1.161227');
select openchpl.add_new_status(8276,'2018-07-16','14.07.07.1221.HEA2.04.01.1.161227');
select openchpl.add_new_status(8277,'2018-07-16','14.07.07.1221.POI5.04.01.1.161227');
select openchpl.add_new_status(8278,'2018-07-16','14.07.07.1221.POI2.04.01.1.161227');
select openchpl.add_new_status(8280,'2018-07-16','14.07.07.1221.FIA2.04.01.1.161227');
select openchpl.add_new_status(8305,'2018-07-16','14.07.07.1222.MOI1.03.01.0.161230');
select openchpl.add_new_status(8306,'2018-07-16','14.07.07.1222.MOA1.03.01.0.161230');
select openchpl.add_new_status(8315,'2018-07-16','14.07.07.1222.MOA2.03.01.0.161230');
select openchpl.add_new_status(8339,'2018-07-16','14.07.07.1221.P2I0.01.01.0.170210');
select openchpl.add_new_status(8340,'2018-07-16','14.07.07.1221.P2A0.01.01.0.170210');
select openchpl.add_new_status(8406,'2018-07-16','14.07.07.1221.HEA3.08.01.1.170308');
select openchpl.add_new_status(8407,'2018-07-16','14.07.07.1221.POA5.08.01.1.170308');
select openchpl.add_new_status(8408,'2018-07-16','14.07.07.1221.POI5.08.01.1.170308');
select openchpl.add_new_status(8409,'2018-07-16','14.07.07.1221.POA1.08.01.1.170308');
select openchpl.add_new_status(8410,'2018-07-16','14.07.07.1221.FIA1.08.01.1.170308');
select openchpl.add_new_status(8411,'2018-07-16','14.07.07.1221.HEI2.08.01.1.170308');
select openchpl.add_new_status(8412,'2018-07-16','14.07.07.1221.HEA2.08.01.1.170308');
select openchpl.add_new_status(8414,'2018-07-16','14.07.07.1221.FIA2.08.01.1.170308');
select openchpl.add_new_status(8415,'2018-07-16','14.07.07.1221.FII1.08.01.1.170308');
select openchpl.add_new_status(8416,'2018-07-16','14.07.07.1221.HEI3.08.01.1.170308');
select openchpl.add_new_status(8417,'2018-07-16','14.07.07.1221.POI2.08.01.1.170308');
select openchpl.add_new_status(8418,'2018-07-16','14.07.07.1221.POI3.08.01.1.170308');
select openchpl.add_new_status(8440,'2018-07-16','14.07.07.1221.FII3.08.01.1.170308');
select openchpl.add_new_status(8546,'2018-07-16','15.07.07.1221.P201.01.00.0.170619');
select openchpl.add_new_status(8566,'2018-07-16','15.07.07.1221.AN03.01.00.1.170705');
select openchpl.add_new_status(8624,'2018-07-16','14.07.07.1221.FIA1.10.01.1.170320');
select openchpl.add_new_status(8625,'2018-07-16','14.07.07.1221.FIA2.10.01.1.170320');
select openchpl.add_new_status(8627,'2018-07-16','14.07.07.1221.FII1.10.01.1.170320');
select openchpl.add_new_status(8628,'2018-07-16','14.07.07.1221.HEA2.15.01.1.170320');
select openchpl.add_new_status(8629,'2018-07-16','14.07.07.1221.HEI3.10.01.1.170320');
select openchpl.add_new_status(8630,'2018-07-16','14.07.07.1221.FII3.09.01.1.170320');
select openchpl.add_new_status(8632,'2018-07-16','14.07.07.1221.HEA3.10.01.1.170320');
select openchpl.add_new_status(8633,'2018-07-16','14.07.07.1221.HEI2.15.01.1.170320');
select openchpl.add_new_status(8635,'2018-07-16','14.07.07.1221.POA1.15.01.1.170320');
select openchpl.add_new_status(8637,'2018-07-16','14.07.07.1221.POA5.15.01.1.170320');
select openchpl.add_new_status(8638,'2018-07-16','14.07.07.1221.POI2.15.01.1.170320');
select openchpl.add_new_status(8639,'2018-07-16','14.07.07.1221.POI3.15.01.1.170320');
select openchpl.add_new_status(8641,'2018-07-16','14.07.07.1221.POI5.15.01.1.170320');
select openchpl.add_new_status(8738,'2018-07-16','14.07.07.1221.FIA1.17.01.1.170705');
select openchpl.add_new_status(8739,'2018-07-16','14.07.07.1221.FIA2.16.01.1.170705');
select openchpl.add_new_status(8741,'2018-07-16','14.07.07.1221.FII1.17.01.1.170705');
select openchpl.add_new_status(8742,'2018-07-16','14.07.07.1221.FII3.15.01.1.170705');
select openchpl.add_new_status(8744,'2018-07-16','14.07.07.1221.HEA2.22.01.1.170705');
select openchpl.add_new_status(8745,'2018-07-16','14.07.07.1221.HEA3.16.01.1.170705');
select openchpl.add_new_status(8746,'2018-07-16','14.07.07.1221.HEI2.22.01.1.170705');
select openchpl.add_new_status(8747,'2018-07-16','14.07.07.1221.HEI3.16.01.1.170705');
select openchpl.add_new_status(8749,'2018-07-16','14.07.07.1221.POA1.22.01.1.170705');
select openchpl.add_new_status(8751,'2018-07-16','14.07.07.1221.POA5.22.01.1.170705');
select openchpl.add_new_status(8753,'2018-07-16','14.07.07.1221.POI2.22.01.1.170705');
select openchpl.add_new_status(8754,'2018-07-16','14.07.07.1221.POI3.22.01.1.170705');
select openchpl.add_new_status(8756,'2018-07-16','14.07.07.1221.POI5.22.01.1.170705');
select openchpl.add_new_status(8771,'2018-07-16','14.07.07.1221.FIA1.19.01.1.170727');
select openchpl.add_new_status(8774,'2018-07-16','14.07.07.1221.FIA2.18.01.1.170727');
select openchpl.add_new_status(8776,'2018-07-16','14.07.07.1221.FII3.17.01.1.170727');
select openchpl.add_new_status(8777,'2018-07-16','14.07.07.1221.FII1.19.01.1.170727');
select openchpl.add_new_status(8779,'2018-07-16','14.07.07.1221.HEA2.24.01.1.170727');
select openchpl.add_new_status(8780,'2018-07-16','14.07.07.1221.HEA3.18.01.1.170727');
select openchpl.add_new_status(8781,'2018-07-16','14.07.07.1221.POA5.24.01.1.170727');
select openchpl.add_new_status(8782,'2018-07-16','14.07.07.1221.HEI2.24.01.1.170727');
select openchpl.add_new_status(8783,'2018-07-16','14.07.07.1221.HEI3.18.01.1.170727');
select openchpl.add_new_status(8784,'2018-07-16','14.07.07.1221.POA1.24.01.1.170727');
select openchpl.add_new_status(8786,'2018-07-16','14.07.07.1221.POI2.24.01.1.170727');
select openchpl.add_new_status(8787,'2018-07-16','14.07.07.1221.POI3.24.01.1.170727');
select openchpl.add_new_status(8789,'2018-07-16','14.07.07.1221.POI5.24.01.1.170727');
select openchpl.add_new_status(8790,'2018-07-16','14.07.07.1221.FIA1.20.01.1.170728');
select openchpl.add_new_status(8791,'2018-07-16','14.07.07.1221.FIA2.19.01.1.170728');
select openchpl.add_new_status(8793,'2018-07-16','14.07.07.1221.FII1.20.01.1.170728');
select openchpl.add_new_status(8794,'2018-07-16','14.07.07.1221.FII3.18.01.1.170728');
select openchpl.add_new_status(8796,'2018-07-16','14.07.07.1221.HEA2.25.01.1.170728');
select openchpl.add_new_status(8797,'2018-07-16','14.07.07.1221.HEA3.19.01.1.170728');
select openchpl.add_new_status(8798,'2018-07-16','14.07.07.1221.HEI2.25.01.1.170728');
select openchpl.add_new_status(8799,'2018-07-16','14.07.07.1221.HEI3.19.01.1.170728');
select openchpl.add_new_status(8800,'2018-07-16','14.07.07.1221.POA1.25.01.1.170728');
select openchpl.add_new_status(8802,'2018-07-16','14.07.07.1221.POA5.25.01.1.170728');
select openchpl.add_new_status(8803,'2018-07-16','14.07.07.1221.POI2.25.01.1.170728');
select openchpl.add_new_status(8804,'2018-07-16','14.07.07.1221.POI3.25.01.1.170728');
select openchpl.add_new_status(8806,'2018-07-16','14.07.07.1221.POI5.25.01.1.170728');
select openchpl.add_new_status(8815,'2018-07-16','15.07.07.1221.CE01.20.00.1.170823');
select openchpl.add_new_status(8879,'2018-07-16','14.07.07.1221.FI03.21.01.1.171109');
select openchpl.add_new_status(8880,'2018-07-16','14.07.07.1221.PO05.26.01.1.171109');
select openchpl.add_new_status(8888,'2018-07-16','14.07.07.1221.FI01.21.01.1.171109');
select openchpl.add_new_status(8893,'2018-07-16','14.07.07.1221.HE02.26.01.1.171109');
select openchpl.add_new_status(8894,'2018-07-16','14.07.07.1221.PO01.27.01.1.171109');
select openchpl.add_new_status(8895,'2018-07-16','14.07.07.1221.HE03.20.01.1.171109');
select openchpl.add_new_status(8896,'2018-07-16','14.07.07.1221.PO05.27.01.1.171109');
select openchpl.add_new_status(8900,'2018-07-16','14.07.07.1221.FI02.20.01.1.171109');
select openchpl.add_new_status(8901,'2018-07-16','14.07.07.1221.FI01.22.01.1.171109');
select openchpl.add_new_status(8902,'2018-07-16','14.07.07.1221.HE02.27.01.1.171109');
select openchpl.add_new_status(8907,'2018-07-16','14.07.07.1221.PO01.28.01.1.171109');
select openchpl.add_new_status(8908,'2018-07-16','14.07.07.1221.FI02.21.01.1.171109');
select openchpl.add_new_status(8912,'2018-07-16','14.07.07.1221.HE03.21.01.1.171109');
select openchpl.add_new_status(8913,'2018-07-16','14.07.07.1221.FI01.23.01.1.171109');
select openchpl.add_new_status(8914,'2018-07-16','14.07.07.1221.PO05.28.01.1.171109');
select openchpl.add_new_status(8917,'2018-07-16','14.07.07.1221.HE02.28.01.1.171109');
select openchpl.add_new_status(8919,'2018-07-16','14.07.07.1221.HE03.22.01.1.171109');
select openchpl.add_new_status(8921,'2018-07-16','14.07.07.1221.PO01.29.01.1.171109');
select openchpl.add_new_status(8922,'2018-07-16','14.07.07.1221.FI02.22.01.1.171109');
select openchpl.add_new_status(9003,'2018-07-16','14.07.07.1222.HEI5.02.01.1.171205');
select openchpl.add_new_status(9005,'2018-07-16','14.07.07.1222.HEI5.04.01.1.171205');
select openchpl.add_new_status(9006,'2018-07-16','14.07.07.1221.POA5.30.01.1.171206');
select openchpl.add_new_status(9007,'2018-07-16','14.07.07.1221.HEA3.24.01.1.171206');
select openchpl.add_new_status(9010,'2018-07-16','14.07.07.1221.FIA2.24.01.1.171206');
select openchpl.add_new_status(9012,'2018-07-16','14.07.07.1221.POA5.29.01.1.171206');
select openchpl.add_new_status(9013,'2018-07-16','14.07.07.1221.FIA1.24.01.1.171206');
select openchpl.add_new_status(9014,'2018-07-16','14.07.07.1221.HEA3.23.01.1.171206');
select openchpl.add_new_status(9015,'2018-07-16','14.07.07.1221.FIA1.25.01.1.171206');
select openchpl.add_new_status(9017,'2018-07-16','14.07.07.1221.POA1.30.01.1.171206');
select openchpl.add_new_status(9019,'2018-07-16','14.07.07.1221.FIA2.23.01.1.171206');
select openchpl.add_new_status(9022,'2018-07-16','14.07.07.1221.POI5.30.01.1.171206');
select openchpl.add_new_status(9023,'2018-07-16','14.07.07.1221.HEI3.24.01.1.171206');
select openchpl.add_new_status(9025,'2018-07-16','14.07.07.1221.FII1.25.01.1.171206');
select openchpl.add_new_status(9027,'2018-07-16','14.07.07.1221.FII3.23.01.1.171206');
select openchpl.add_new_status(9031,'2018-07-16','14.07.07.1221.FII1.24.01.1.171206');
select openchpl.add_new_status(9032,'2018-07-16','14.07.07.1221.POI5.29.01.1.171206');
select openchpl.add_new_status(9033,'2018-07-16','14.07.07.1221.HEI3.23.01.1.171206');
select openchpl.add_new_status(9036,'2018-07-16','14.07.07.1221.POI3.30.01.1.171206');
select openchpl.add_new_status(9039,'2018-07-16','14.07.07.1221.FII3.22.01.1.171206');
select openchpl.add_new_status(9062,'2018-07-16','14.07.07.1221.HEA2.30.03.1.171206');
select openchpl.add_new_status(9063,'2018-07-16','14.07.07.1221.PO01.31.02.1.171206');
select openchpl.add_new_status(9064,'2018-07-16','14.07.07.1221.HEA2.29.02.1.171206');
select openchpl.add_new_status(9065,'2018-07-16','14.07.07.1221.HEI2.30.03.1.171206');
select openchpl.add_new_status(9066,'2018-07-16','14.07.07.1221.PO04.29.02.1.171206');
select openchpl.add_new_status(9067,'2018-07-16','14.07.07.1221.PO03.31.02.1.171206');
select openchpl.add_new_status(9068,'2018-07-16','14.07.07.1221.HEI2.29.02.1.171206');
select openchpl.add_new_status(9069,'2018-07-16','14.07.07.1221.PO02.30.03.1.171206');
select openchpl.add_new_status(9118,'2018-07-16','14.07.07.1221.FI01.21.01.1.171110');
select openchpl.add_new_status(9120,'2018-07-16','14.07.07.1221.FI01.22.01.1.171110');
select openchpl.add_new_status(9121,'2018-07-16','14.07.07.1221.PO05.27.01.1.171110');
select openchpl.add_new_status(9124,'2018-07-16','14.07.07.1221.PO05.28.01.1.171110');
select openchpl.add_new_status(9127,'2018-07-16','14.07.07.1221.PO05.26.01.1.171110');
select openchpl.add_new_status(9129,'2018-07-16','14.07.07.1221.FI01.23.01.1.171110');
select openchpl.add_new_status(9130,'2018-07-16','14.07.07.1221.HE03.20.01.1.171110');
select openchpl.add_new_status(9131,'2018-07-16','14.07.07.1221.HE02.26.01.1.171110');
select openchpl.add_new_status(9132,'2018-07-16','14.07.07.1221.PO04.28.01.1.171110');
select openchpl.add_new_status(9133,'2018-07-16','14.07.07.1221.HE02.28.01.1.171110');
select openchpl.add_new_status(9135,'2018-07-16','14.07.07.1221.HE03.21.01.1.171110');
select openchpl.add_new_status(9136,'2018-07-16','14.07.07.1221.PO02.26.01.1.171110');
select openchpl.add_new_status(9138,'2018-07-16','14.07.07.1221.PO02.27.01.1.171110');
select openchpl.add_new_status(9141,'2018-07-16','14.07.07.1221.HE02.27.01.1.171110');
select openchpl.add_new_status(9143,'2018-07-16','14.07.07.1221.HE03.22.01.1.171110');
select openchpl.add_new_status(9146,'2018-07-16','14.07.07.1221.FI03.19.01.1.171110');
select openchpl.add_new_status(9147,'2018-07-16','14.07.07.1221.PO03.29.01.1.171110');
select openchpl.add_new_status(9148,'2018-07-16','14.07.07.1221.PO03.27.01.1.171110');
select openchpl.add_new_status(9149,'2018-07-16','14.07.07.1221.FI03.20.01.1.171110');
select openchpl.add_new_status(9150,'2018-07-16','14.07.07.1221.PO03.28.01.1.171110');
select openchpl.add_new_status(7234,'2018-07-16','CHP-028574');
select openchpl.add_new_status(5981,'2018-07-16','CHP-024479');
select openchpl.add_new_status(7347,'2018-07-16','CHP-025168');
select openchpl.add_new_status(7389,'2018-07-16','CHP-025166');
select openchpl.add_new_status(7390,'2018-07-16','CHP-025167');
select openchpl.add_new_status(7348,'2018-07-16','CHP-025169');
select openchpl.add_new_status(7350,'2018-07-16','CHP-025171');
select openchpl.add_new_status(7351,'2018-07-16','CHP-025172');
select openchpl.add_new_status(7353,'2018-07-16','CHP-025174');
select openchpl.add_new_status(7354,'2018-07-16','CHP-025175');
select openchpl.add_new_status(7358,'2018-07-16','CHP-025179');
select openchpl.add_new_status(7359,'2018-07-16','CHP-025180');
select openchpl.add_new_status(6313,'2018-07-16','CHP-025268');
select openchpl.add_new_status(6317,'2018-07-16','CHP-025270');
select openchpl.add_new_status(6339,'2018-07-16','CHP-025281');
select openchpl.add_new_status(6042,'2018-07-16','CHP-025532');
select openchpl.add_new_status(6048,'2018-07-16','CHP-025534');
select openchpl.add_new_status(6051,'2018-07-16','CHP-025535');
select openchpl.add_new_status(6054,'2018-07-16','CHP-025536');
select openchpl.add_new_status(6057,'2018-07-16','CHP-025537');
select openchpl.add_new_status(6072,'2018-07-16','CHP-025542');
select openchpl.add_new_status(6075,'2018-07-16','CHP-025543');
select openchpl.add_new_status(6222,'2018-07-16','CHP-027265');
select openchpl.add_new_status(7568,'2018-07-16','CHP-028481');
select openchpl.add_new_status(7570,'2018-07-16','CHP-028483');
select openchpl.add_new_status(7574,'2018-07-16','CHP-028487');
select openchpl.add_new_status(7576,'2018-07-16','CHP-028489');
select openchpl.add_new_status(7590,'2018-07-16','CHP-028491');
select openchpl.add_new_status(7591,'2018-07-16','CHP-028492');
select openchpl.add_new_status(5730,'2018-07-16','CHP-019313');
select openchpl.add_new_status(5733,'2018-07-16','CHP-019314');
select openchpl.add_new_status(7566,'2018-07-16','CHP-028479');
select openchpl.add_new_status(7567,'2018-07-16','CHP-028480');
select openchpl.add_new_status(7571,'2018-07-16','CHP-028484');
select openchpl.add_new_status(7595,'2018-07-16','CHP-028493');
select openchpl.add_new_status(7597,'2018-07-16','CHP-028495');
select openchpl.add_new_status(7598,'2018-07-16','CHP-028496');
select openchpl.add_new_status(7579,'2018-07-16','CHP-028499');
select openchpl.add_new_status(7188,'2018-07-16','CHP-028559');
select openchpl.add_new_status(7228,'2018-07-16','CHP-028560');
select openchpl.add_new_status(7191,'2018-07-16','CHP-028561');
select openchpl.add_new_status(7192,'2018-07-16','CHP-028562');
select openchpl.add_new_status(7193,'2018-07-16','CHP-028563');
select openchpl.add_new_status(7232,'2018-07-16','CHP-028565');
select openchpl.add_new_status(7208,'2018-07-16','CHP-028567');
select openchpl.add_new_status(7210,'2018-07-16','CHP-028569');
select openchpl.add_new_status(7229,'2018-07-16','CHP-028571');
select openchpl.add_new_status(7174,'2018-07-16','CHP-028577');
select openchpl.add_new_status(7175,'2018-07-16','CHP-028578');
select openchpl.add_new_status(7176,'2018-07-16','CHP-028579');
select openchpl.add_new_status(7454,'2018-07-16','CHP-028997');
select openchpl.add_new_status(5769,'2018-07-16','CHP-029218');
select openchpl.add_new_status(5799,'2018-07-16','CHP-029228');
select openchpl.add_new_status(5748,'2018-07-16','CHP-029211');
select openchpl.add_new_status(5754,'2018-07-16','CHP-029213');
select openchpl.add_new_status(5760,'2018-07-16','CHP-029215');
select openchpl.add_new_status(5763,'2018-07-16','CHP-029216');
select openchpl.add_new_status(5766,'2018-07-16','CHP-029217');
select openchpl.add_new_status(5772,'2018-07-16','CHP-029219');
select openchpl.add_new_status(5775,'2018-07-16','CHP-029220');
select openchpl.add_new_status(5781,'2018-07-16','CHP-029222');
select openchpl.add_new_status(5790,'2018-07-16','CHP-029225');
select openchpl.add_new_status(5796,'2018-07-16','CHP-029227');
select openchpl.add_new_status(5802,'2018-07-16','CHP-029229');

drop function openchpl.add_new_status(bigint, timestamp, varchar(64));
drop function openchpl.can_add_new_status(bigint, timestamp, varchar(64));
