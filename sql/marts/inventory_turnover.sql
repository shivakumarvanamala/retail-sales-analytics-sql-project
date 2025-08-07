create or replace view kpi_inventory_turnover as
select
    i.store_id,
    i.product_id,
    d.fiscal_year,
    d.fiscal_period,
    sum(s.qty)           as units_sold,
    avg(i.on_hand_qty)   as avg_inventory,
    case
        when avg(i.on_hand_qty) = 0 then null
        else sum(s.qty) / nullif(avg(i.on_hand_qty),0)
    end as turnover_ratio
from fact_inventory i
join fact_sale s
  on s.sale_date = i.snapshot_date
 and s.store_id  = i.store_id
 and s.product_id= i.product_id
join dim_date d on d.calendar_date = i.snapshot_date
group by 1,2,3,4;