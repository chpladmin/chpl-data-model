select
    cp.certified_product_id,
    cb.name as "acb name",
    openchpl.get_chpl_product_number(cp.certified_product_id) as "confirmed chpl id",
    pcp.unique_id as "pending chpl id",
    pcptu.targeted_user_name as "pending targeted user name",
    pcptu.targeted_user_id,
    d.name as "developer",
    p.name as "product",
    v.version as "version",
    i.certification_date,
    r.last_certification_status_change,
    n.certification_status_name
from
    openchpl.certified_product cp
    inner join openchpl.pending_certified_product pcp on cp.pending_certified_product_id = pcp.pending_certified_product_id
    left join openchpl.pending_certified_product_targeted_user pcptu on pcp.pending_certified_product_id = pcptu.pending_certified_product_id
    left join openchpl.certified_product_targeted_user cptu on cp.certified_product_id = cptu.certified_product_id
    left join openchpl.targeted_user tu on tu.targeted_user_id = cptu.targeted_user_id
    left join openchpl.certification_body cb on cp.certification_body_id = cb.certification_body_id
    left join openchpl.product_version v on cp.product_version_id = v.product_version_id
    left join openchpl.product p on v.product_id = p.product_id
    left join openchpl.vendor d on p.vendor_id = d.vendor_id
    left join ( select cse.certification_status_id,
        cse.certified_product_id,
        cse.event_date as last_certification_status_change
    from openchpl.certification_status_event cse
        join ( select certification_status_event.certified_product_id,
            max(certification_status_event.event_date) as event_date
        from openchpl.certification_status_event
        where certification_status_event.deleted <> true
        group by certification_status_event.certified_product_id) cseinner on cse.certified_product_id = cseinner.certified_product_id and cse.event_date = cseinner.event_date
    where cse.deleted <> true) r on r.certified_product_id = cp.certified_product_id
    left join ( select certification_status.certification_status_id,
        certification_status.certification_status as certification_status_name
    from openchpl.certification_status) n on r.certification_status_id = n.certification_status_id
    left join ( select min(certification_status_event.event_date) as certification_date,
        certification_status_event.certified_product_id
    from openchpl.certification_status_event
    where certification_status_event.certification_status_id = 1 and certification_status_event.deleted <> true
    group by certification_status_event.certified_product_id) i on cp.certified_product_id = i.certified_product_id
where
    (pcptu.targeted_user_name is not null or pcptu.targeted_user_id is not null)
    and tu.name is null
order by cp.certified_product_id
--limit 100
    ;
