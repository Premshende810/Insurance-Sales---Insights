{{ config(materialized = 'view') }}
with d as 
(
    select 
        cust_id,
        AGENT_ID,
        POLICY_NUM,
        FULL_NAME,
        DOB,
        GENDER,	
        COUNTRY,
        TYPE,
        COVERAGE,
        TERM_AMT,	
        ISSUED_DATE,	
        PAYMENT_ID,	
        DEDUCTIBLE,
        claim_id,
        claim_date,
        claim_status,	
        TOTAL_REVENUE, 
        ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY ISSUED_DATE DESC) AS rn
 from {{ ref('vw_union_all_insurance') }}
 )
 select 
    cust_id,
    AGENT_ID,   
    POLICY_NUM,
    FULL_NAME,	
    DOB,
    FLOOR(DATEDIFF(YEAR, dob, CURRENT_DATE)) AS AGE,
    GENDER,	
    COUNTRY,
    TYPE as POLICY_TYPE,
    COVERAGE,
    TERM_AMT,
    ISSUED_DATE,
    PAYMENT_ID,	
    DEDUCTIBLE,	
    claim_id,
    claim_date,
    claim_status,
    TOTAL_REVENUE 

from d 
where rn<=1

