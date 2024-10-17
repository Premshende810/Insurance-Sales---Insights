CREATE OR REPLACE PROCEDURESP_MIGRATE_TABLE_DDLS("SRCDB" VARCHAR, 
"SRCSCHEMA" VARCHAR, "TGTDB" VARCHAR, "TGTSCHEMA" VARCHAR, "ALL_FLAG" VARCHAR(1), "REPLACE_FLAG" VARCHAR(1)) 
RETURNS VARCHAR 
LANGUAGE SQL 
EXECUTE AS CALLER 
AS

DECLARE 

-- ALL_FLAG - 'Y' if you want to migrate all tables from the Schema, 'N' if you want to migrate specific tables
-- REPLACE_FLAG - 'Y' if you want to replace if the table already exists, 'N' if you want to skip

cur_all_tbl cursor for SELECT DISTINCT TABLE_NAME FROM TABLE(?) WHERE TABLE_SCHEMA = ? AND TABLE_TYPE = 'BASE TABLE';
cur_some_tbl cursor for SELECT DISTINCT TABLE_NAME FROM TABLE(?);

SRCTBL VARCHAR;
ddl_statement VARCHAR;

BEGIN


IF (:ALL_FLAG = 'Y') THEN

	OPEN cur_all_tbl USING(:SRCDB||'.INFORMATION_SCHEMA.TABLES', :SRCSCHEMA);
	
	for rec in cur_all_tbl do 
	
		SRCTBL := rec.TABLE_NAME;
		SELECT get_ddl('TABLE', :SRCDB||'.'||:SRCSCHEMA||'.'||:SRCTBL) into :ddl_statement;
				
		IF(:REPLACE_FLAG = 'Y') THEN 
			ddl_statement := REPLACE(:ddl_statement, 'create or replace TABLE ', 'create or replace table '||:TGTDB||'.'||:TGTSCHEMA||'.');
		ELSE 
			ddl_statement := REPLACE(:ddl_statement, 'create or replace TABLE ', 'create table if not exists '||:TGTDB||'.'||:TGTSCHEMA||'.');
		END IF;
		
		execute immediate :ddl_statement;	
		
	end for;
	CLOSE cur_all_tbl;
		
ELSE 
	OPEN cur_some_tbl USING(:TGTDB||'.WORK.MIGRATE_TABLES');
	
	for rec in cur_some_tbl do 
	
		SRCTBL := rec.TABLE_NAME;
		SELECT get_ddl('TABLE', :SRCDB||'.'||:SRCSCHEMA||'.'||:SRCTBL) into :ddl_statement;
		
		IF(:REPLACE_FLAG = 'Y') THEN 
			ddl_statement := REPLACE(:ddl_statement, 'create or replace TABLE ', 'create or replace table '||:TGTDB||'.'||:TGTSCHEMA||'.');
		ELSE 
			ddl_statement := REPLACE(:ddl_statement, 'create or replace TABLE ', 'create table if not exists '||:TGTDB||'.'||:TGTSCHEMA||'.');
        END IF;
		
		execute immediate :ddl_statement;	
		
	end for;
	CLOSE cur_some_tbl;

END IF;

RETURN 'Tables Migrated Successfully';

END;


-- CALL SP_MIGRATE_TABLE_DDLS('DEV_ENV', 'DBT_DEV', 'PROD_ENV', 'DBT_ENV', 'Y', 'Y');
