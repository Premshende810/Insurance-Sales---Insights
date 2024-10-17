-- models/staging/profit_and_loss.sql

with profit_and_loss_data as (
    select 
        CUST_ID,
        POLICY_NUM,
        AGENT_ID,
        TOTAL_REVENUE,
        TOTAL_EXPENSES,
        TOTAL_REVENUE - TOTAL_EXPENSES as PROFIT_LOSS,
        case 
            when TOTAL_REVENUE - TOTAL_EXPENSES > 0 then 'Profit'
            else 'Loss'
        end as PROFIT_LOSS_CATEGORY
    from 
        {{ source('ods_dev', 'PROFIT_AND_LOSS') }}
)

select 
    CUST_ID,
    POLICY_NUM,
    AGENT_ID,
    TOTAL_REVENUE,
    TOTAL_EXPENSES,
    PROFIT_LOSS,
    PROFIT_LOSS_CATEGORY
from profit_and_loss_data
