-- 1. Duplicate SKUs
select 'dim_product duplicate sku_code' as test, sku_code, count(*)
from dim_product
group by sku_code
having count(*) > 1;

-- 2. Orphaned fact rows
select 'orphan fact_sale product' as test, product_id, count(*)
from fact_sale
where product_id not in (select product_id from dim_product)
group by product_id
limit 10;