{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

with source_data as (
    select
        employee_id,
        parse_json(certification_json) as certification
    from {{ source('oliver_landing', 'employee_certifications') }}
)

select
    employee_id,
    certification:certification_name::varchar
        as certification_name,
    certification:certification_cost::number(12, 2)
        as certification_cost,
    certification:certification_awarded_date::date
        as certification_awarded_date
from source_data