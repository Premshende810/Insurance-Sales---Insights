-- models/dimensions/dim_life_insurance.sql

with life_insurance_data as (
    select
        LIFE_POLICY_ID,
        POLICY_NUM,
        CUST_ID,
        AGENT_ID,
        COVERAGE_AMOUNT,
        PREMIUM,
        TERM_LENGTH,
        BENEFICIARY_NAME,
        ISSUE_DATE
    from 
        {{ source('ods_dev', 'LIFE_INSURANCE') }}
)

select
    LIFE_POLICY_ID,
    POLICY_NUM,
    CUST_ID,
    AGENT_ID,
    COVERAGE_AMOUNT,
    PREMIUM,
    TERM_LENGTH,
    BENEFICIARY_NAME,
    ISSUE_DATE
from life_insurance_data
