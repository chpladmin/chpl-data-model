insert into openchpl.activity_concept (concept, last_modified_sso_user)
select 'CONFORMANCE_METHOD',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
where not exists (
        select * from openchpl.activity_concept where concept = 'CONFORMANCE_METHOD'
);
