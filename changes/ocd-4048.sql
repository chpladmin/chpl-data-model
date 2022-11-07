DROP VIEW openchpl.openchpl.product_active_owner_history_map;

ALTER TABLE openchpl.product_owner_history_map
ALTER COLUMN transfer_date TYPE date;
