select
    max(sale_date) as latest_sale,
    current_date - max(sale_date) as days_lag,
    case
        when current_date - max(sale_date) <= 1 then 'OK'
        else 'FAIL'
    end as status
from fact_sale;