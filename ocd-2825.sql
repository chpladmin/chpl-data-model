---------------------------------------
-- OCD-2825
---------------------------------------
update openchpl.certification_status set deleted = true where certification_status = 'Pending';
