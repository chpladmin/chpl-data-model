update openchpl.pending_certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = 'N/A');
update openchpl.certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = 'N/A');
update openchpl.test_tool set deleted = true where name = 'N/A';

update openchpl.pending_certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = '');
update openchpl.certification_result_test_tool set deleted = true where test_tool_id = (select test_tool_id from openchpl.test_tool where name = '');
update openchpl.test_tool set deleted = true where name = '';