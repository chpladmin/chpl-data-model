update openchpl.upload_template_version as utv
set deleted = true
where utv.deprecated = true;
