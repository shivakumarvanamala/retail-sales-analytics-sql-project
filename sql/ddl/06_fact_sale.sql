create table if not exists fact_inventory (
    snapshot_date date   not null,
    store_id      int    not null references dim_store(store_id),
    product_id    int    not null references dim_product(product_id),
    on_hand_qty   int    not null,
    on_hand_cost  numeric(12,2),
    primary key (snapshot_date, store_id, product_id)
);