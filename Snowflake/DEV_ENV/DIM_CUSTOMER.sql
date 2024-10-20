create or replace TRANSIENT TABLE DEV_ENV.DBT_DEV.DIM_CUSTOMER (
	CUST_ID NUMBER(38,0),
	FULL_NAME VARCHAR(16777216),
	AGENT_ID NUMBER(38,0),
	POLICY_NUM NUMBER(38,0),
	DOB DATE,
	AGE NUMBER(9,0),
	GENDER VARCHAR(16777216),
	CITY VARCHAR(16777216),
	STATE VARCHAR(16777216),
	COUNTRY VARCHAR(16777216)
);
