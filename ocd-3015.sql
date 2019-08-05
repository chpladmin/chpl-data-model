insert into openchpl.activity_concept (concept, last_modified_user)
select 'QUARTERLY_REPORT', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'QUARTERLY_REPORT');

insert into openchpl.activity_concept (concept, last_modified_user)
select 'QUARTERLY_REPORT_LISTING', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'QUARTERLY_REPORT_LISTING');

insert into openchpl.activity_concept (concept, last_modified_user)
select 'ANNUAL_REPORT', -1
where not exists
        (select *
        from openchpl.activity_concept
        where concept = 'ANNUAL_REPORT');