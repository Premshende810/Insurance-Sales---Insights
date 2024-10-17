create or replace TABLE ODS_DEV.STAGING.CUSTOMER (
	CUST_ID NUMBER(38,0) NOT NULL,
	AGENT_ID NUMBER(38,0),
	POLICY_NUM NUMBER(38,0),
	FIRST_NAME VARCHAR(16777216),
	LAST_NAME VARCHAR(16777216),
	USER_NAME VARCHAR(16777216),
	DOB DATE,
	PHONE VARCHAR(16777216),
	CITY VARCHAR(16777216),
	STATE VARCHAR(16777216),
	ZIP VARCHAR(16777216),
	DL_NUM VARCHAR(16777216),
	SSN VARCHAR(16777216),
	GENDER VARCHAR(16777216),
	COUNTRY VARCHAR(16777216),
	primary key (CUST_ID)
);
