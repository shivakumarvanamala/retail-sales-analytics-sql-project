create table if not exists dim_date (
    calendar_date  date        primary key,
    fiscal_year    int         not null,
    fiscal_period  int         not null,
    fiscal_week    int         not null,
    day_of_week    int         not null,
    is_weekend     boolean     not null
);

-- sample 5-year calendar (2019-01-01 .. 2023-12-31)
insert into dim_date
select
    d::date                                         as calendar_date,
    extract(year from d)                            as fiscal_year,
    ceil(extract(day from d) / 28.0)::int           as fiscal_period,
    ceil(extract(doy from d) / 7.0)::int            as fiscal_week,
    extract(dow from d)                             as day_of_week,
    extract(dow from d) in (0,6)                    as is_weekend
from generate_series('2019-01-01'::date, '2023-12-31'::date, '1 day') d
on conflict do nothing;