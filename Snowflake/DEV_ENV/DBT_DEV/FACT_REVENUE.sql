create or replace TRANSIENT TABLE DEV_ENV.DBT_DEV.FACT_REVENUE (
	REVENUE_ID VARCHAR(16777216),
	POLICY_NUM NUMBER(38,0),
	CUST_ID NUMBER(38,0),
	REVENUE_AMT NUMBER(10,2)
);
