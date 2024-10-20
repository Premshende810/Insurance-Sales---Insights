create or replace view DEV_ENV.DBT_DEV.VW_UNION_ALL_INSURANCE(
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
    
with union_views as (
    select * from DEV_ENV.DBT_DEV.vw_total_car_insurance_customer
    union
    select * from DEV_ENV.DBT_DEV.vw_total_life_insurance_customer
    union
    select * from DEV_ENV.DBT_DEV.vw_total_health_insurance_customer
    union
    select * from DEV_ENV.DBT_DEV.vw_total_house_insurance_customer
)

select * from union_views
  );
