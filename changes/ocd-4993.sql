-- This index improves the performance of the get_testing_lab_code function, which is used to generate the chpl product number
-- This made a significant difference in the speed of getting the chpl product number for each listing
create index if not exists cptl_idx on openchpl.certified_product_testing_lab_map (certified_product_id);
analyze openchpl.certified_product_testing_lab_map;

-- These indices are used in the get_chpl_product_number function to join the certified product -> version -> product -> developer
-- I didn't see much performance improvement by adding them, but it shouldn't hurt anything (and may help)
create index if not exists developer_idx on openchpl.product (vendor_id);
analyze openchpl.product;
create index if not exists product_idx on openchpl.product_version (product_id);
analyze openchpl.product_version;
