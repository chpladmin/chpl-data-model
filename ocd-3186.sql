
-- This will delete all duplicate status records based on listing, status and date
update openchpl.certification_status_event a
set deleted = true
from openchpl.certification_status_event b
where a.certification_status_event_id > b.certification_status_event_id
and a.certified_product_id = b.certified_product_id
and a.certification_status_id = b.certification_status_id
and a.event_date = b.event_date
and a.deleted = false
and b.deleted = false;
