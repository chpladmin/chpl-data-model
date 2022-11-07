alter table openchpl.certification_criterion_attribute
add column if not exists test_data boolean default false;

update openchpl.certification_criterion_attribute
set test_data = true
where criterion_id in
(61,63, 64, 65, 66, 67,69, 70, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
90, 91, 92, 93, 103, 104, 106, 107, 108, 109, 110, 111, 113, 114, 117, 118, 119, 16,
165, 17, 166, 18, 167, 19, 20, 21, 23, 169, 24, 170, 25, 26, 27, 172, 28, 40, 178,
43, 44, 45, 46, 49, 50, 51, 55, 180, 57, 181, 182, 59, 60, 22, 168);
