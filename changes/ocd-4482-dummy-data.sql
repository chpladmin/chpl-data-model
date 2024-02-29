update openchpl.code_set
set start_day = '2024-02-15'
where required_day = '2025-12-31';

insert into openchpl.code_set (required_day, start_day, last_modified_user)
select '2026-12-31', '2025-01-01', -1
where not exists (select * from openchpl.code_set where required_day = '2026-12-31');

insert into openchpl.code_set_criteria_map (certification_criterion_id, code_set_id, last_modified_user)
select crit_id,
	(select id from openchpl.code_set where required_day = '2026-12-31'),
	-1
from unnest('{5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167}'::int[]) crit_id
where not exists (
	select * 
	from openchpl.code_set_criteria_map 
	where certification_criterion_id = crit_id
	and code_set_id = (select id from openchpl.code_set where required_day = '2026-12-31')
);
