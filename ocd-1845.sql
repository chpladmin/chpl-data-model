update openchpl.upload_template_version as utv
set deleted = true
where utv.name = 'New 2014 CHPL Upload Template v10'
or utv.name = '2015 CHPL Upload Template v10';

update openchpl.upload_template_version as utv
set available_as_of_date = '2017-11-06'
where utv.name = 'New 2014 CHPL Upload Template v11';
