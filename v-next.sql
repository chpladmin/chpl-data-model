----------------------------------------------------
-- OCD-2609 Add ROLE_ONC
----------------------------------------------------
INSERT INTO openchpl.user_permission
    (name, description, authority, last_modified_user)
SELECT 'ONC', 'This permission gives ONC users administrative privileges.', 'ROLE_ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.user_permission WHERE name = 'ONC'
    );
----------------------------------------------------
-- OCD-2609 Convert all current ROLE_ADMIN users
-- (except our admin) to ROLE_ONC.
----------------------------------------------------
UPDATE openchpl.global_user_permission_map 
SET user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission where name = 'ONC')
WHERE user_permission_id_user_permission = -2
AND user_id != -2; -- our admin

--
-- OCD-2637 - update test functionalities
--

-- removing some
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9225 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9098 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9371 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9339 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9340 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8976 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9543 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9745 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9569 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9570 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9179 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9571 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9572 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9178 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9166 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9166 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9455 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9481 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9194 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9194 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9657 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9658 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9196 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9195 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9656 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9193 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9193 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9482 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9659 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9559 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8974 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9549 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9320 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9693 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9314 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9167 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9644 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9223 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9197 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9591 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9189 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9594 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9593 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9190 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9199 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9592 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9198 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9595 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8970 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9054 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9390 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8856 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8873 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8863 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9221 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9106 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8362 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8807 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9673 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9718 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9672 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8884 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9459 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9303 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9661 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9661 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 7966 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8481 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8511 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8878 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9401 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9733 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8969 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8969 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8328 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8328 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8852 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8852 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8967 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8967 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8871 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8871 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8968 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8968 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8329 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8500 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8853 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8872 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8499 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8499 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9646 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8874 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9636 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8539 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9262 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9635 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9235 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9580 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9234 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9579 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 8596 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9099 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9097 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9100 and cc.number = '170.315 (b)(2)' and tf.name='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9744 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9048 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9555 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id = 9739 and cc.number = '170.315 (a)(13)' and tf.name='Optional: 170.315(a)(3)(ii) Include a "reason for order" field';

update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(6)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(6)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(8)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(8)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(9)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (g)(9)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(6)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(6)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(8)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(8)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(9)' and tf.name='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set deleted = true from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (g)(9)' and tf.name='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced';

-- changing some
update only openchpl.certification_result_test_functionality as crtf set test_functionality_id = (select tf.test_functionality_id from openchpl.test_functionality tf where tf.number = '(b)(5)(i)(E)') from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (b)(5)' and tf.name='Optional: 170.315(b)(4)(vii)(A)(2) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included';
update only openchpl.certification_result_test_functionality as crtf set test_functionality_id = (select tf.test_functionality_id from openchpl.test_functionality tf where tf.number = '(b)(5)(ii)(A)(5)(i)') from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9318 and cc.number = '170.315 (b)(5)' and tf.name='Ambulatory: 170.315(b)(4)(v) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set test_functionality_id = (select tf.test_functionality_id from openchpl.test_functionality tf where tf.number = '(b)(5)(ii)(A)(5)(i)') from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (b)(5)' and tf.name='Optional: 170.315(b)(4)(vii)(A)(2) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included';
update only openchpl.certification_result_test_functionality as crtf set test_functionality_id = (select tf.test_functionality_id from openchpl.test_functionality tf where tf.number = '170.102(13)(ii)(C)') from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =9187 and cc.number = '170.315 (b)(5)' and tf.name='Ambulatory: 170.315(b)(4)(v) The reason for referral; and referring or transitioning provider''s name and office contact information';
update only openchpl.certification_result_test_functionality as crtf set test_functionality_id = (select tf.test_functionality_id from openchpl.test_functionality tf where tf.number = '(b)(5)(i)(E)') from openchpl.test_functionality tf, openchpl.certification_result cr, openchpl.certification_criterion cc where crtf.test_functionality_id = tf.test_functionality_id and crtf.certification_result_id = cr.certification_result_id and cr.certification_criterion_id = cc.certification_criterion_id and cr.certified_product_id =8851 and cc.number = '170.315 (b)(5)' and tf.name='Ambulatory: 170.315(b)(4)(v) The reason for referral; and referring or transitioning provider''s name and office contact information';

-- cleanup
-- OCD-794
alter table openchpl.contact drop column if exists first_name;
alter table openchpl.contact drop column if exists last_name;

-- OCD-1739
DROP TABLE IF EXISTS openchpl.accurate_as_of_date;
ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS meaningful_use_users;

--OCD-1897 Cleanup
-- clean up views that needed atl
drop VIEW if exists openchpl.certified_product_summary;
CREATE OR REPLACE VIEW openchpl.certified_product_summary AS
 SELECT cp.certified_product_id,
    cp.certification_edition_id,
    cp.product_version_id,
    cp.certification_body_id,
    cp.chpl_product_number,
    cp.report_file_location,
    cp.sed_report_file_location,
    cp.sed_intended_user_description,
    cp.sed_testing_end,
    cp.acb_certification_id,
    cp.practice_type_id,
    cp.product_classification_type_id,
    cp.product_additional_software,
    cp.other_acb,
    cp.transparency_attestation_url,
    cp.ics,
    cp.sed,
    cp.qms,
    cp.accessibility_certified,
    cp.product_code,
    cp.version_code,
    cp.ics_code,
    cp.additional_software_code,
    cp.certified_date_code,
    cp.creation_date,
    cp.last_modified_date,
    cp.last_modified_user,
    cp.deleted,
    cp.pending_certified_product_id,
	muuResult.meaningful_use_users,
    ce.year,
    p.name AS product_name,
    v.name AS vendor_name,
    v.vendor_code,
    cs.certification_status,
    cb.acb_code,
    cb.name AS certification_body_name,
    cb.website AS certification_body_website
   FROM openchpl.certified_product cp
     JOIN openchpl.certification_edition ce ON cp.certification_edition_id = ce.certification_edition_id
     JOIN ( SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.event_date AS last_certification_status_change
           FROM openchpl.certification_status_event cse
             JOIN ( SELECT certification_status_event.certified_product_id,
                    max(certification_status_event.event_date) AS event_date
                   FROM openchpl.certification_status_event
                  WHERE certification_status_event.deleted <> true
                  GROUP BY certification_status_event.certified_product_id) cseinner ON cse.certified_product_id = cseinner.certified_product_id AND cse.event_date = cseinner.event_date
          WHERE cse.deleted <> true) max_cse ON max_cse.certified_product_id = cp.certified_product_id
     JOIN openchpl.certification_status cs ON cs.certification_status_id = max_cse.certification_status_id
     JOIN openchpl.product_version pv ON cp.product_version_id = pv.product_version_id
     JOIN openchpl.product p ON pv.product_id = p.product_id
     JOIN openchpl.vendor v ON p.vendor_id = v.vendor_id
     JOIN openchpl.certification_body cb ON cp.certification_body_id = cb.certification_body_id
	 LEFT OUTER JOIN ( SELECT muu.meaningful_use_users,
            muu.certified_product_id,
            muu.meaningful_use_users_date AS meaningful_use_users_date
           FROM openchpl.meaningful_use_user muu
             JOIN ( SELECT meaningful_use_user.certified_product_id,
                    max(meaningful_use_user.meaningful_use_users_date) AS meaningful_use_users_date
                   FROM openchpl.meaningful_use_user
                  WHERE meaningful_use_user.deleted <> true
                  GROUP BY meaningful_use_user.certified_product_id) muuInner ON muu.certified_product_id = muuInner.certified_product_id AND muu.meaningful_use_users_date = muuInner.meaningful_use_users_date
              WHERE muu.deleted <> true) muuResult ON muuResult.certified_product_id = cp.certified_product_id;

DROP VIEW IF EXISTS openchpl.developers_with_attestations;
drop VIEW if exists openchpl.certified_product_details;
CREATE OR REPLACE VIEW openchpl.certified_product_details AS
 SELECT a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.certification_body_id,
    ( SELECT get_chpl_product_number.chpl_product_number
           FROM openchpl.get_chpl_product_number(a.certified_product_id) get_chpl_product_number(chpl_product_number)) AS chpl_product_number,
    a.report_file_location,
    a.sed_report_file_location,
    a.sed_intended_user_description,
    a.sed_testing_end,
    a.acb_certification_id,
    a.practice_type_id,
    a.product_classification_type_id,
    a.other_acb,
    a.creation_date,
    a.deleted,
    a.product_code,
    a.version_code,
    a.ics_code,
    a.additional_software_code,
    a.certified_date_code,
    a.transparency_attestation_url,
    a.ics,
    a.sed,
    a.qms,
    a.accessibility_certified,
    a.product_additional_software,
    a.last_modified_date,
    muuresult.meaningful_use_users,
    muuresult.meaningful_use_users_date,
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_deleted,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
    v.vendor_status_id,
    v.vendor_status_name,
    vendorstatus.last_vendor_status_change,
    t.address_id,
    t.street_line_1,
    t.street_line_2,
    t.city,
    t.state,
    t.zipcode,
    t.country,
    u.contact_id,
    u.full_name,
    u.email,
    u.phone_number,
    u.title,
    i.certification_date,
    decert.decertification_date,
    COALESCE(k.count_certifications, 0::bigint) AS count_certifications,
    COALESCE(m.count_cqms, 0::bigint) AS count_cqms,
    COALESCE(surv.count_surveillance_activities, 0::bigint) AS count_surveillance_activities,
    COALESCE(surv_open.count_open_surveillance_activities, 0::bigint) AS count_open_surveillance_activities,
    COALESCE(surv_closed.count_closed_surveillance_activities, 0::bigint) AS count_closed_surveillance_activities,
    COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS count_open_nonconformities,
    COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS count_closed_nonconformities,
    r.certification_status_id,
    r.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation
   FROM openchpl.certified_product a
     LEFT JOIN ( SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.event_date AS last_certification_status_change
           FROM openchpl.certification_status_event cse
             JOIN ( SELECT certification_status_event.certified_product_id,
                    max(certification_status_event.event_date) AS event_date
                   FROM openchpl.certification_status_event
                  WHERE certification_status_event.deleted <> true
                  GROUP BY certification_status_event.certified_product_id) cseinner ON cse.certified_product_id = cseinner.certified_product_id AND cse.event_date = cseinner.event_date
          WHERE cse.deleted <> true) r ON r.certified_product_id = a.certified_product_id
     LEFT JOIN ( SELECT certification_status.certification_status_id,
            certification_status.certification_status AS certification_status_name
           FROM openchpl.certification_status) n ON r.certification_status_id = n.certification_status_id
     LEFT JOIN ( SELECT muu.meaningful_use_users,
            muu.certified_product_id,
            muu.meaningful_use_users_date
           FROM openchpl.meaningful_use_user muu
             JOIN ( SELECT meaningful_use_user.certified_product_id,
                    max(meaningful_use_user.meaningful_use_users_date) AS meaningful_use_users_date
                   FROM openchpl.meaningful_use_user
                  WHERE meaningful_use_user.deleted <> true
                  GROUP BY meaningful_use_user.certified_product_id) muuinner ON muu.certified_product_id = muuinner.certified_product_id AND muu.meaningful_use_users_date = muuinner.meaningful_use_users_date
          WHERE muu.deleted <> true) muuresult ON muuresult.certified_product_id = a.certified_product_id
     LEFT JOIN ( SELECT certification_edition.certification_edition_id,
            certification_edition.year
           FROM openchpl.certification_edition) b ON a.certification_edition_id = b.certification_edition_id
     LEFT JOIN ( SELECT certification_body.certification_body_id,
            certification_body.name AS certification_body_name,
            certification_body.acb_code AS certification_body_code,
            certification_body.deleted AS acb_is_deleted
           FROM openchpl.certification_body) c ON a.certification_body_id = c.certification_body_id
     LEFT JOIN ( SELECT product_classification_type.product_classification_type_id,
            product_classification_type.name AS product_classification_name
           FROM openchpl.product_classification_type) d ON a.product_classification_type_id = d.product_classification_type_id
     LEFT JOIN ( SELECT practice_type.practice_type_id,
            practice_type.name AS practice_type_name
           FROM openchpl.practice_type) e ON a.practice_type_id = e.practice_type_id
     LEFT JOIN ( SELECT product_version.product_version_id,
            product_version.version AS product_version,
            product_version.product_id
           FROM openchpl.product_version) f ON a.product_version_id = f.product_version_id
     LEFT JOIN ( SELECT product.product_id,
            product.vendor_id,
            product.name AS product_name
           FROM openchpl.product) g ON f.product_id = g.product_id
     LEFT JOIN ( SELECT vendor.vendor_id,
            vendor.name AS vendor_name,
            vendor.vendor_code,
            vendor.website AS vendor_website,
            vendor.address_id AS vendor_address,
            vendor.contact_id AS vendor_contact,
            vendor.vendor_status_id
           FROM openchpl.vendor) h ON g.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT acb_vendor_map.vendor_id,
            acb_vendor_map.certification_body_id,
            acb_vendor_map.transparency_attestation
           FROM openchpl.acb_vendor_map) p ON h.vendor_id = p.vendor_id AND a.certification_body_id = p.certification_body_id
     LEFT JOIN ( SELECT address.address_id,
            address.street_line_1,
            address.street_line_2,
            address.city,
            address.state,
            address.zipcode,
            address.country
           FROM openchpl.address) t ON h.vendor_address = t.address_id
     LEFT JOIN ( SELECT contact.contact_id,
            contact.full_name,
            contact.email,
            contact.phone_number,
            contact.title
           FROM openchpl.contact) u ON h.vendor_contact = u.contact_id
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_vendor_status_change
           FROM openchpl.vendor_status_history vshistory
             JOIN ( SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner 
				ON vshistory.vendor_id = vsinner.vendor_id 
				AND vshistory.status_date = vsinner.status_date
				AND vshistory.deleted = false) vendorstatus ON vendorstatus.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
            vendor_status.name AS vendor_status_name
           FROM openchpl.vendor_status) v ON vendorstatus.vendor_status_id = v.vendor_status_id
     LEFT JOIN ( SELECT min(certification_status_event.event_date) AS certification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE certification_status_event.certification_status_id = 1 AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) i ON a.certified_product_id = i.certified_product_id
     LEFT JOIN ( SELECT max(certification_status_event.event_date) AS decertification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE (certification_status_event.certification_status_id = ANY (ARRAY[3::bigint, 4::bigint, 8::bigint])) AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) decert ON a.certified_product_id = decert.certified_product_id
     LEFT JOIN ( SELECT j.certified_product_id,
            count(*) AS count_certifications
           FROM ( SELECT certification_result.certification_result_id,
                    certification_result.certification_criterion_id,
                    certification_result.certified_product_id,
                    certification_result.success,
                    certification_result.gap,
                    certification_result.sed,
                    certification_result.g1_success,
                    certification_result.g2_success,
                    certification_result.api_documentation,
                    certification_result.privacy_security_framework,
                    certification_result.creation_date,
                    certification_result.last_modified_date,
                    certification_result.last_modified_user,
                    certification_result.deleted
                   FROM openchpl.certification_result
                  WHERE certification_result.success = true AND certification_result.deleted <> true) j
          GROUP BY j.certified_product_id) k ON a.certified_product_id = k.certified_product_id
     LEFT JOIN ( SELECT l.certified_product_id,
            count(*) AS count_cqms
           FROM ( SELECT DISTINCT a_1.certified_product_id,
                    COALESCE(b_1.cms_id, b_1.nqf_number) AS cqm_id
                   FROM openchpl.cqm_result a_1
                     LEFT JOIN openchpl.cqm_criterion b_1 ON a_1.cqm_criterion_id = b_1.cqm_criterion_id
                  WHERE a_1.success = true AND a_1.deleted <> true AND b_1.deleted <> true) l
          GROUP BY l.certified_product_id
          ORDER BY l.certified_product_id) m ON a.certified_product_id = m.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true) n_1
          GROUP BY n_1.certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND (surveillance.end_date IS NULL OR surveillance.end_date >= now())) n_1
          GROUP BY n_1.certified_product_id) surv_open ON a.certified_product_id = surv_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND surveillance.end_date IS NOT NULL AND surveillance.end_date <= now()) n_1
          GROUP BY n_1.certified_product_id) surv_closed ON a.certified_product_id = surv_closed.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_nonconformities
           FROM ( SELECT surv_1.id,
                    surv_1.certified_product_id,
                    surv_1.friendly_id,
                    surv_1.start_date,
                    surv_1.end_date,
                    surv_1.type_id,
                    surv_1.randomized_sites_used,
                    surv_1.creation_date,
                    surv_1.last_modified_date,
                    surv_1.last_modified_user,
                    surv_1.deleted,
                    surv_1.user_permission_id,
                    surv_req.id,
                    surv_req.surveillance_id,
                    surv_req.type_id,
                    surv_req.certification_criterion_id,
                    surv_req.requirement,
                    surv_req.result_id,
                    surv_req.creation_date,
                    surv_req.last_modified_date,
                    surv_req.last_modified_user,
                    surv_req.deleted,
                    surv_nc.id,
                    surv_nc.surveillance_requirement_id,
                    surv_nc.certification_criterion_id,
                    surv_nc.nonconformity_type,
                    surv_nc.nonconformity_status_id,
                    surv_nc.date_of_determination,
                    surv_nc.corrective_action_plan_approval_date,
                    surv_nc.corrective_action_start_date,
                    surv_nc.corrective_action_must_complete_date,
                    surv_nc.corrective_action_end_date,
                    surv_nc.summary,
                    surv_nc.findings,
                    surv_nc.sites_passed,
                    surv_nc.total_sites,
                    surv_nc.developer_explanation,
                    surv_nc.resolution,
                    surv_nc.creation_date,
                    surv_nc.last_modified_date,
                    surv_nc.last_modified_user,
                    surv_nc.deleted,
                    nc_status.id,
                    nc_status.name,
                    nc_status.creation_date,
                    nc_status.last_modified_date,
                    nc_status.last_modified_user,
                    nc_status.deleted
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                     JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                  WHERE surv_1.deleted <> true AND nc_status.name::text = 'Open'::text) n_1(id, certified_product_id, friendly_id, start_date, end_date, type_id, randomized_sites_used, creation_date, last_modified_date, last_modified_user, deleted, user_permission_id, id_1, surveillance_id, type_id_1, certification_criterion_id, requirement, result_id, creation_date_1, last_modified_date_1, last_modified_user_1, deleted_1, id_2, surveillance_requirement_id, certification_criterion_id_1, nonconformity_type, nonconformity_status_id, date_of_determination, corrective_action_plan_approval_date, corrective_action_start_date, corrective_action_must_complete_date, corrective_action_end_date, summary, findings, sites_passed, total_sites, developer_explanation, resolution, creation_date_2, last_modified_date_2, last_modified_user_2, deleted_2, id_3, name, creation_date_3, last_modified_date_3, last_modified_user_3, deleted_3)
          GROUP BY n_1.certified_product_id) nc_open ON a.certified_product_id = nc_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_nonconformities
           FROM ( SELECT surv_1.id,
                    surv_1.certified_product_id,
                    surv_1.friendly_id,
                    surv_1.start_date,
                    surv_1.end_date,
                    surv_1.type_id,
                    surv_1.randomized_sites_used,
                    surv_1.creation_date,
                    surv_1.last_modified_date,
                    surv_1.last_modified_user,
                    surv_1.deleted,
                    surv_1.user_permission_id,
                    surv_req.id,
                    surv_req.surveillance_id,
                    surv_req.type_id,
                    surv_req.certification_criterion_id,
                    surv_req.requirement,
                    surv_req.result_id,
                    surv_req.creation_date,
                    surv_req.last_modified_date,
                    surv_req.last_modified_user,
                    surv_req.deleted,
                    surv_nc.id,
                    surv_nc.surveillance_requirement_id,
                    surv_nc.certification_criterion_id,
                    surv_nc.nonconformity_type,
                    surv_nc.nonconformity_status_id,
                    surv_nc.date_of_determination,
                    surv_nc.corrective_action_plan_approval_date,
                    surv_nc.corrective_action_start_date,
                    surv_nc.corrective_action_must_complete_date,
                    surv_nc.corrective_action_end_date,
                    surv_nc.summary,
                    surv_nc.findings,
                    surv_nc.sites_passed,
                    surv_nc.total_sites,
                    surv_nc.developer_explanation,
                    surv_nc.resolution,
                    surv_nc.creation_date,
                    surv_nc.last_modified_date,
                    surv_nc.last_modified_user,
                    surv_nc.deleted,
                    nc_status.id,
                    nc_status.name,
                    nc_status.creation_date,
                    nc_status.last_modified_date,
                    nc_status.last_modified_user,
                    nc_status.deleted
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                     JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                  WHERE surv_1.deleted <> true AND nc_status.name::text = 'Closed'::text) n_1(id, certified_product_id, friendly_id, start_date, end_date, type_id, randomized_sites_used, creation_date, last_modified_date, last_modified_user, deleted, user_permission_id, id_1, surveillance_id, type_id_1, certification_criterion_id, requirement, result_id, creation_date_1, last_modified_date_1, last_modified_user_1, deleted_1, id_2, surveillance_requirement_id, certification_criterion_id_1, nonconformity_type, nonconformity_status_id, date_of_determination, corrective_action_plan_approval_date, corrective_action_start_date, corrective_action_must_complete_date, corrective_action_end_date, summary, findings, sites_passed, total_sites, developer_explanation, resolution, creation_date_2, last_modified_date_2, last_modified_user_2, deleted_2, id_3, name, creation_date_3, last_modified_date_3, last_modified_user_3, deleted_3)
          GROUP BY n_1.certified_product_id) nc_closed ON a.certified_product_id = nc_closed.certified_product_id;
CREATE OR REPLACE VIEW openchpl.developers_with_attestations AS
SELECT
    v.vendor_id as vendor_id,
    v.name as vendor_name,
    s.name as status_name,
    sum(case when certification_status.certification_status = 'Active' then 1 else 0 end) as countActiveListings,
    sum(case when certification_status.certification_status = 'Retired' then 1 else 0 end) as countRetiredListings,
    sum(case when certification_status.certification_status = 'Pending' then 1 else 0 end) as countPendingListings,
    sum(case when certification_status.certification_status = 'Withdrawn by Developer' then 1 else 0 end) as countWithdrawnByDeveloperListings,
    sum(case when certification_status.certification_status = 'Withdrawn by ONC-ACB' then 1 else 0 end) as countWithdrawnByOncAcbListings,
    sum(case when certification_status.certification_status = 'Suspended by ONC-ACB' then 1 else 0 end) as countSuspendedByOncAcbListings,
    sum(case when certification_status.certification_status = 'Suspended by ONC' then 1 else 0 end) as countSuspendedByOncListings,
    sum(case when certification_status.certification_status = 'Terminated by ONC' then 1 else 0 end) as countTerminatedByOncListings,
    sum(case when certification_status.certification_status = 'Withdrawn by Developer Under Surveillance/Review' then 1 else 0 end) as countWithdrawnByDeveloperUnderSurveillanceListings,
--only include urls that are not empty strings and come from
-- a listing with one of the active... or suspended... statuses
    string_agg(DISTINCT
	case when
	listings.transparency_attestation_url::text != ''
	and
	(certification_status.certification_status = 'Active'
	    or
	    certification_status.certification_status = 'Suspended by ONC'
	    or
	    certification_status.certification_status = 'Suspended by ONC-ACB')
	then listings.transparency_attestation_url::text else null end, '☺')
    as "transparency_attestation_urls",
--using coalesce here because the attestation can be null and concatting null with anything just gives null
--so null/empty attestations are left out unless we replace null with empty string
    string_agg(DISTINCT acb.name::text||':'||COALESCE(attestations.transparency_attestation::text, ''), '☺') as "attestations"
FROM openchpl.vendor v
    LEFT OUTER JOIN openchpl.vendor_status s ON v.vendor_status_id = s.vendor_status_id
    LEFT OUTER JOIN openchpl.certified_product_details listings ON listings.vendor_id = v.vendor_id AND listings.deleted != true
    LEFT OUTER JOIN openchpl.certification_status ON listings.certification_status_id = certification_status.certification_status_id
    LEFT OUTER JOIN openchpl.acb_vendor_map attestations ON attestations.vendor_id = v.vendor_id AND attestations.deleted != true
    LEFT OUTER JOIN openchpl.certification_body acb ON attestations.certification_body_id = acb.certification_body_id AND acb.deleted != true
WHERE v.deleted != true
GROUP BY v.vendor_id, v.name, s.name;

create or replace function openchpl.get_chpl_product_number(id bigint) returns
    table (
        chpl_product_number varchar
        ) as $$
    begin
    return query
select
    COALESCE(a.chpl_product_number, substring(b.year from 3 for 2)||'.'||(select openchpl.get_testing_lab_code(a.certified_product_id))||'.'||c.certification_body_code||'.'||h.vendor_code||'.'||a.product_code||'.'||a.version_code||'.'||a.ics_code||'.'||a.additional_software_code||'.'||a.certified_date_code) as "chpl_product_number"
FROM openchpl.certified_product a
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
WHERE a.certified_product_id = id;
    end;
    $$ language plpgsql
stable;

-- * removing old ATL column from certified_product table
-- * as well as pending_certified_product table
alter table openchpl.certified_product
drop column if exists testing_lab_id;
alter table openchpl.pending_certified_product
drop column if exists testing_lab_id;

--OCD-2532
ALTER TABLE openchpl.test_functionality DROP COLUMN IF EXISTS certification_criterion_id_deleted;

--re-run grants
\i dev/openchpl_grant-all.sql
--re-add soft delete triggers
\i dev/openchpl_soft-delete.sql