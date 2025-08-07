insert into dim_product (
    product_id,
    sku_code,
    description,
    category,
    supplier,
    eff_from,
    eff_to,
    is_current
)
select
    nextval('dim_product_product_id_seq') as product_id,
    s.sku_code,
    s.description,
    s.category,
    s.supplier,
    s.load_date      as eff_from,
    '9999-12-31'     as eff_to,
    true             as is_current
from staging.stg_product s
left join dim_product d
  on d.sku_code = s.sku_code
 and d.is_current = true
where d.product_id is null      -- new SKU
   or (d.description <> s.description
    or d.category    <> s.category
    or d.supplier    <> s.supplier);

-- expire previous version
update dim_product
set
    eff_to    = s.load_date - interval '1 day',
    is_current = false
from staging.stg_product s
where dim_product.sku_code = s.sku_code
  and dim_product.is_current = true
  and (dim_product.description <> s.description
    or dim_product.category    <> s.category
    or dim_product.supplier    <> s.supplier);