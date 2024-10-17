-- models/dimensions/dim_payment.sql

with payment_data as (
    select
        PAYMENT_ID,
        CUST_ID,
        PAYMENT_DATE,
        POLICY_NUM,
        PAYMENT_AMOUNT
    from 
        {{ source('ods_dev', 'PAYMENT') }}
)

select
    PAYMENT_ID as PMT_ID,
    CUST_ID,
    POLICY_NUM,
    PAYMENT_DATE as PMT_DATE,
    PAYMENT_AMOUNT as PMT_AMT
from payment_data
