select certified_product_id, product_code, version_code, ics_code from openchpl.certified_product
where certified_product.product_code !~ '^\w*$'
    or certified_product.version_code !~ '^\w*$'
    or certified_product.ics_code !~ '^\d*$';
