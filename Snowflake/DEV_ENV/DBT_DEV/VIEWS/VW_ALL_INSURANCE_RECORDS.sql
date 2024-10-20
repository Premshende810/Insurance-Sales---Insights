create or replace view DEV_ENV.DBT_DEV.VW_ALL_INSURANCE_RECORDS(
	CUST_ID,
	AGENT_ID,
	POLICY_NUM,
	FULL_NAME,
	DOB,
	AGE,
	GENDER,
	COUNTRY,
	POLICY_TYPE,
	COVERAGE,
	TERM_AMT,
	ISSUED_DATE,
	PAYMENT_ID,
	DEDUCTIBLE,
	CLAIM_ID,
	CLAIM_DATE,
	PAYMENT_AMOUNT,
	SETTLEMENT_DATE,
	CLAIM_STATUS,
	TOTAL_REVENUE
) as (
    
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
        PAYMENT_AMOUNT,
        SETTLEMENT_DATE,
        TOTAL_REVENUE, 
        ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY ISSUED_DATE DESC) AS rn
 from DEV_ENV.DBT_DEV.vw_union_all_insurance
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
    PAYMENT_AMOUNT,
    SETTLEMENT_DATE,
    claim_status,
    TOTAL_REVENUE 

from d 
where rn<=1
  );
