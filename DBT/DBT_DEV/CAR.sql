-- models/dimensions/dim_car.sql

with car_data as (
    select
        VEHICLE_ID,
        POLICY_NUM,
        CUST_ID,
        MAKE,
        MODEL_NUM,
        DOORS,
        YEAR,
        COLOR
    from 
        {{ source('ods_dev', 'CAR') }}
)

select
    VEHICLE_ID,
    POLICY_NUM,
    CUST_ID,
    MODEL_NUM,
    DOORS,
    YEAR,
    COLOR
from car_data
