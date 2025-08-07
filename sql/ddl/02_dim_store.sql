create table if not exists dim_store (
    store_id      serial primary key,
    store_code    varchar(10) unique not null,
    store_name    varchar(100)       not null,
    region        varchar(50),
    opened_date   date,
    eff_from      date               not null,
    eff_to        date               not null default '9999-12-31',
    is_current    boolean            not null default true
);