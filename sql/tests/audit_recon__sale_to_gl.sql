with gl as (
    select sale_date, sum(net_amount) as gl_net
    from finance.gl_entries
    where account = 'SALES'
    group by sale_date
),
dw as (
    select sale_date, sum(net_sales) as dw_net
    from fact_sale
    group by sale_date
)
select
    g.sale_date,
    g.gl_net,
    d.dw_net,
    abs(g.gl_net - d.dw_net) as variance,
    case
        when abs(g.gl_net - d.dw_net) <= 0.001 * g.gl_net then 'OK'
        else 'FAIL'
    end as status
from gl g
join dw d using (sale_date)
order by sale_date desc
limit 30;