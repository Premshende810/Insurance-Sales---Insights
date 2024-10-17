-- models/fact_policy.sql

with claims_data as (
    select 
    	CLAIM_ID,
	    POLICY_NUM,
	    CLAIM_TYPE,
	    CLAIM_STATUS,
	    CLAIM_DATE
    from 
        {{ source('ods_dev', 'CLAIMS') }}
)

select 
        CLAIM_ID,
	    POLICY_NUM,
	    CLAIM_TYPE,
	    CLAIM_STATUS,
	    CLAIM_DATE
from claims_data
