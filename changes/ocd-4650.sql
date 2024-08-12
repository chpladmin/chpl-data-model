create or replace function openchpl.backfill_170210g_standard() returns void as $$
declare
    cert_result_id bigint;
begin
	for cert_result_id in 
		select certification_result_id from openchpl.certification_result where certification_criterion_id IN (173,174,175,176)
	loop 
		insert into openchpl.certification_result_standard(standard_id, certification_result_id, last_modified_user)
		select
			(select id from openchpl.standard where regulatory_text_citation = '170.210(g)'),
			cert_result_id,
			-1
		where not exists ( 
				select *
				from openchpl.certification_result_standard
				where certification_result_id = cert_result_id
				and standard_id = (select id from openchpl.standard where regulatory_text_citation = '170.210(g)')
		);
	end loop;
end;
$$ language plpgsql
volatile;

select openchpl.backfill_170210g_standard();

drop function openchpl.backfill_170210g_standard();