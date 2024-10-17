{{ config(materialized = 'view') }}

WITH life_insurance AS (
    SELECT 
        c.cust_id, 
        a.agent_id,
        p.policy_num,
        c.FULL_NAME,
        c.DOB,
        c.gender,
        c.country,
        'Life Insurance' AS Type,
        p.COVERAGE,
        p.TERM_AMT,
        p.ISSUED_DATE,
        t.PAYMENT_ID,
        l.TERM_LENGTH,
        l.BENEFICIARY_NAME,
        i.claim_id,
        i.claim_type,
        i.claim_date,
        i.claim_status,
        p.DEDUCTIBLE,
        ROW_NUMBER() OVER (PARTITION BY c.cust_id ORDER BY p.ISSUED_DATE DESC) AS rn
    FROM {{ ref("dim_customer") }} AS c
    INNER JOIN {{ ref("fact_policy") }} AS p ON c.policy_num = p.policy_num
    JOIN {{ ref("fact_payment") }} AS t ON t.payment_id = p.payment_id
    JOIN {{ ref("life_insurance") }} as l ON l.policy_num = p.policy_num
    JOIN {{ ref("dim_agent") }} a ON a.agent_id = c.agent_id
    JOIN {{ ref("dim_claims") }} i ON i.policy_num = p.policy_num
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
        DEDUCTIBLE,
        SUM(TERM_AMT) OVER (PARTITION BY agent_id) AS total_revenue
FROM life_insurance
WHERE rn = 1
