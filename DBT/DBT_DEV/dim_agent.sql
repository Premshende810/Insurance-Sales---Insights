-- models/dim_agent.sql

WITH agent_data AS (
    SELECT
        AGENT_ID,
        FIRST_NAME,
        LAST_NAME,
        USER_NAME,
        PHONE,
        GENDER,
        ADDRESS,
        CITY,
        STATE,
        COUNTRY
    FROM 
        {{ source("ods_dev", "AGENT") }}
)

SELECT
    AGENT_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME,  -- Added missing comma here
    GENDER,
    CITY,
    STATE,
    COUNTRY
FROM agent_data
