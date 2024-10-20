create or replace view DEV_ENV.DBT_DEV.VW_TOTAL_HOUSE_INSURANCE_CUSTOMER(
	CUST_ID,
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
	CLAIM_ID,
	CLAIM_TYPE,
	CLAIM_DATE,
	CLAIM_STATUS,
	PAYMENT_AMOUNT,
	SETTLEMENT_DATE,
	DEDUCTIBLE,
	TOTAL_REVENUE
) as (
    
WITH house_insurance AS (
    SELECT 
        c.cust_id, 
        a.agent_id,
        p.policy_num,
        c.FULL_NAME,
        c.DOB,
        c.gender,
        c.country,
        'Home Insurance' AS Type,
        p.COVERAGE,
        p.TERM_AMT,
        p.ISSUED_DATE,
        t.PAYMENT_ID,
        h.HOUSE_COST,
        h.house_id,
        i.claim_id,
        i.claim_type,
        i.claim_date,
        i.PAYMENT_AMOUNT,
        i.SETTLEMENT_DATE,
        i.claim_status,
        p.DEDUCTIBLE,
        ROW_NUMBER() OVER (PARTITION BY c.cust_id ORDER BY p.ISSUED_DATE DESC) AS rn
    FROM DEV_ENV.DBT_DEV.dim_customer AS c
    INNER JOIN DEV_ENV.DBT_DEV.fact_policy AS p ON c.policy_num = p.policy_num
    JOIN DEV_ENV.DBT_DEV.fact_payment AS t ON t.payment_id = p.payment_id
    JOIN DEV_ENV.DBT_DEV.house h ON h.policy_num = p.policy_num
    JOIN DEV_ENV.DBT_DEV.dim_agent a ON a.agent_id = c.agent_id
    JOIN DEV_ENV.DBT_DEV.dim_claims i ON i.policy_num = p.policy_num
)

 SELECT 
        cust_id,
        agent_id,
        policy_num,
        FULL_NAME,
        DOB,
        gender,
        country,
        Type,
        COVERAGE,
        TERM_AMT,
        ISSUED_DATE,
        PAYMENT_ID,
        claim_id,
        claim_type,
        claim_date,
        claim_status,
        PAYMENT_AMOUNT,
        SETTLEMENT_DATE,
        DEDUCTIBLE,
        SUM(TERM_AMT) OVER (PARTITION BY agent_id) AS total_revenue
    FROM house_insurance
    WHERE rn = 1
  );
