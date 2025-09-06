{{ config(materialized='table')}}

WITH CTE AS (
    select 
        TO_TIMESTAMP(STARTED_AT) as STARTED_AT,
        DATE(TO_TIMESTAMP(STARTED_AT)) as DATE_STARTED_AT,
        HOUR(TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT,
        CASE WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) in ('Sat', 'Sun') THEN 'WEEKEND'
             ELSE 'BUSINESSDAY' 
        END as DAY_TYPE,

        CASE WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (12, 1, 2) THEN 'WINTER'
             WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (3, 4, 5) THEN 'SPRING'
             WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (6, 7, 8) THEN 'SUMMER'
            ELSE 'AUTUMN'
        END as STATION_OF_YEAR

    from {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select * 
from CTE 
