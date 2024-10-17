with claim_amt as (
    select * from {{ ref("vw_all_insurance_records") }}

)
    
select sum(DEDUCTIBLE) from claim_amt
where claim_status = 'Approved'
