-- models/staging/payment.sql

WITH payment_data AS (
    SELECT 
        PAYMENT_ID,
        CUST_ID,
        PAYMENT_DATE,
        POLICY_NUM,
        PAYMENT_AMOUNT
    FROM 
        {{ source('ods_dev', 'PAYMENT') }}
)

SELECT 
    PAYMENT_ID,
    CUST_ID,
    PAYMENT_DATE,
    POLICY_NUM,
    PAYMENT_AMOUNT as PYMT_AMT
FROM payment_data
