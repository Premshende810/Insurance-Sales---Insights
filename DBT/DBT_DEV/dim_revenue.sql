-- models/staging/revenue.sql

with revenue_data as (
    select 
        REVENUE_ID,
        POLICY_NUM,
        CUST_ID,
        REVENUE_AMOUNT
    from 
        {{ source('ods_dev', 'REVENUE') }}
)

select 
    REVENUE_ID,
    POLICY_NUM,
    CUST_ID,
    REVENUE_AMOUNT as REVENUE_AMT
from revenue_data
