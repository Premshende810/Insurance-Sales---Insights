-- models/staging/expenses.sql

with expenses_data as (
    select 
        EXPENSE_ID,
        CUST_ID,
        POLICY_NUM,
        AGENT_ID,
        EXPENSE_TYP,
        AMOUNT,
        DESCRIPTION,
        DATE
    from 
        {{ source('ods_dev', 'EXPENSES') }}
)

select 
    EXPENSE_ID,
    CUST_ID,  
    AGENT_ID,
    POLICY_NUM,
    EXPENSE_TYP,
    AMOUNT AS EXPENSE_AMT,
    DATE
from expenses_data
