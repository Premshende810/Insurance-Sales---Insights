{{ config(materialized = 'view') }}
with union_views as (
    select * from {{ ref('vw_total_car_insurance_customer') }}
    union
    select * from {{ ref('vw_total_life_insurance_customer') }}
    union
    select * from {{ ref('vw_total_health_insurance_customer') }}
    union
    select * from {{ ref('vw_total_house_insurance_customer') }}
)

select * from union_views
