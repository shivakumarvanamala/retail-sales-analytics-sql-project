create table if not exists dim_product (
    product_id   serial primary key,
    sku_code     varchar(20) unique not null,
    description  varchar(200),
    category     varchar(50),
    supplier     varchar(100),
    eff_from     date               not null,
    eff_to       date               not null default '9999-12-31',
    is_current   boolean            not null default true
);