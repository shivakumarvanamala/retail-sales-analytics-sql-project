create table if not exists fact_sale (
    sale_id     bigserial,
    sale_date   date   not null,
    store_id    int    not null references dim_store(store_id),
    product_id  int    not null references dim_product(product_id),
    ticket_no   bigint not null,
    qty         int    not null,
    net_sales   numeric(12,2) not null,
    discount    numeric(12,2) not null default 0,
    primary key (sale_date, store_id, product_id, ticket_no)
) partition by range (sale_date);

-- create first monthly partition
create table if not exists fact_sale_2023_01
partition of fact_sale
for values from ('2023-01-01') to ('2023-02-01');
