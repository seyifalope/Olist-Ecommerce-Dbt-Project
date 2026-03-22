with geolocation as (

    select * from {{ ref('stg_olist__geolocation') }}

),

geolocation_aggregated as (

    select
        geolocation_zip_code_prefix,
        geolocation_city,
        geolocation_state,
        avg(geolocation_lat) as avg_lat,
        avg(geolocation_lng) as avg_lng

    from geolocation
    group by
        geolocation_zip_code_prefix,
        geolocation_city,
        geolocation_state

)

select * from geolocation_aggregated