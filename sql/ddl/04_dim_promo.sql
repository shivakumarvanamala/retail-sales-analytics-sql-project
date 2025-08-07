create table if not exists dim_promo (
    promo_id    serial primary key,
    promo_code  varchar(20) unique not null,
    description varchar(200),
    start_date  date               not null,
    end_date    date               not null,
    store_id    int references dim_store(store_id),
    product_id  int references dim_product(product_id)
);