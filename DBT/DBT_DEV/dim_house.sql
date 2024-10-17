-- models/dimensions/dim_house.sql

with house_data as (
    select
        HOUSE_ID,
        CUST_ID,
        POLICY_NUM,
        HOUSE_COST
    from 
        {{ source('ods_dev', 'HOUSE') }}
)

select
    HOUSE_ID,
    CUST_ID,
    POLICY_NUM,
    HOUSE_COST
from house_data
