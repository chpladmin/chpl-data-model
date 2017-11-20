update openchpl.upload_template_version as utv
set deleted = true
where utv.name = 'New 2014 CHPL Upload Template v10'
or utv.name = '2015 CHPL Upload Template v10';
