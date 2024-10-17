-- models/dimensions/dim_customer.sql

with customer_data as (
    select
        CUST_ID,
        AGENT_ID,
        POLICY_NUM,
        FIRST_NAME,
        LAST_NAME,
        DOB,
        CITY,
        STATE,
        ZIP,
        DL_NUM,
        SSN,
        GENDER,
        COUNTRY
    from 
        {{ source("ods_dev", "CUSTOMER") }}
)

select
    CUST_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) as FULL_NAME,
    AGENT_ID,
    POLICY_NUM,
    DOB,
    FLOOR(DATEDIFF(YEAR, dob, CURRENT_DATE)) AS AGE,
    GENDER,
    CITY,
    STATE,
    COUNTRY
from customer_data
