
with health_care_data as (
    select
        REPORT_ID,
        POLICY_NUM,
        CUST_ID,
        DATE
    from 
        {{ source('ods_dev', 'HEALTH_CARE') }}
)

select
    REPORT_ID as HEALTH_ID,
    POLICY_NUM,
    CUST_ID,
    DATE
from health_care_data
