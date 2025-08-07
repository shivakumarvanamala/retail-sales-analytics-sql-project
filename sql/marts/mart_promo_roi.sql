create or replace view mart_promo_roi as
with promo_period as (
    select
        pr.promo_id,
        pr.store_id,
        pr.product_id,
        generate_series(pr.start_date, pr.end_date, interval '1 day')::date as sale_date
    from dim_promo pr
),
baseline as (
    select
        s.product_id,
        s.store_id,
        avg(s.qty) filter (
            where s.sale_date between pr.start_date - 28 and pr.start_date - 1
        ) as avg_qty_4w,
        avg(s.net_sales) filter (
            where s.sale_date between pr.start_date - 28 and pr.start_date - 1
        ) as avg_sales_4w
    from fact_sale s
    join promo_period pr using (product_id, store_id)
    group by 1,2
),
promo_result as (
    select
        pr.promo_id,
        pr.store_id,
        pr.product_id,
        sum(s.qty)      as promo_qty,
        sum(s.net_sales) as promo_sales
    from fact_sale s
    join promo_period pr using (product_id, store_id, sale_date)
    group by 1,2,3
)
select
    p.promo_id,
    p.store_id,
    p.product_id,
    p.promo_sales,
    p.promo_qty,
    (p.promo_sales - coalesce(b.avg_sales_4w,0) * 28) as incremental_sales,
    (p.promo_qty   - coalesce(b.avg_qty_4w,0)   * 28) as incremental_qty
from promo_result p
left join baseline b using (product_id, store_id);