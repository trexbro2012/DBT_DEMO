with BIKE as (
    select distinct 
        start_station_id as station_id,
        start_station_name as station_name,
        start_lat as station_lat,
        start_lng as station_lng
    from {{ ref('stg_bike') }}

    where RIDE_ID != '"bikeid"'
)

select * from BIKE 