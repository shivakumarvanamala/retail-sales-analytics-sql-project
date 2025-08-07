insert into fact_sale (
    sale_date,
    store_id,
    product_id,
    qty,
    net_sales,
    discount,
    ticket_no
)
select
    t.sale_date,
    s.store_id,
    p.product_id,
    t.qty,
    t.net_sales,
    t.discount,
    t.ticket_no
from staging.stg_pos_txn t
join dim_store    s on s.store_code = t.store_code
join dim_product  p on p.sku_code  = t.sku_code
                    and t.sale_date between p.eff_from and p.eff_to
on conflict (sale_date, store_id, product_id, ticket_no)
do update set
    qty        = excluded.qty,
    net_sales  = excluded.net_sales,
    discount   = excluded.discount;