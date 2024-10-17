create or replace TABLE ODS_DEV.CONTROL.COPY_CTRL (
	STAGE_TABLE_NAME VARCHAR(16777216) NOT NULL,
	SCHEMA_NAME VARCHAR(16777216) NOT NULL,
	DATABASE_NAME VARCHAR(16777216) NOT NULL,
	STORAGE_LOC VARCHAR(16777216),
	FILES_TYP VARCHAR(16777216),
	FILES_PATTERN VARCHAR(16777216),
	FIELD_DELIM VARCHAR(16777216),
	ON_ERROR VARCHAR(16777216),
	SKIP_HEADER NUMBER(38,0),
	FORCE BOOLEAN,
	TRUNCATE_COLS BOOLEAN,
	IS_ACTIVE BOOLEAN,
	primary key (STAGE_TABLE_NAME, SCHEMA_NAME, DATABASE_NAME)
);


INSERT INTO ODS_DEV.control.copy_ctrl VALUES
('customer', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/customers.csv', 'csv', '.*customer.*', '|', 'CONTINUE', 1, True, True, True),
('agent', 'staging','ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/agents.csv', 'csv', '.*agent.*', '|', 'CONTINUE', 1, True, True, True), 
('car', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/cars.csv', 'csv', '.*car.*', '|', 'CONTINUE', 1, True, True, True),
('policy', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/policies.csv', 'csv', '.*policy.*', '|', 'CONTINUE', 1, True, True, True),
('revenue', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/revenue.csv', 'csv', '.*revenue.*', '|', 'CONTINUE', 1, True, True, True),
('expenses', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/expenses.csv', 'csv', '.*expenses.*', '|', 'CONTINUE', 1, True, True, True),
('health_care', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/healthcare.csv', 'csv', '.*healthcare.*', '|', 'CONTINUE', 1, True, True, True),
('house', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/houses.csv', 'csv', '.*house.*', '|', 'CONTINUE', 1, True, True, True),
('payment', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/payments.csv', 'csv', '.*payment.*', '|', 'CONTINUE', 1, True, True, True),
('sales_transactions', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/transactions.csv', 'csv', '.*transactions.*', '|', 'CONTINUE', 1, True, True, True),
('life_insurance', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/life_insurance.csv', 'csv', '.*life_insurance.*', '|', 'CONTINUE', 1, True, True, True),
('profit_and_loss', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/profit_loss.csv', 'csv', '.*profit_and_loss.*', '|', 'CONTINUE', 1, True, True, True),
('claims', 'staging', 'ODS_DEV', '@ODS_DEV.STAGING.ODS_STAGE/claims.csv', 'csv', '.*claims.*', '|', 'CONTINUE', 1, True, True, True);
