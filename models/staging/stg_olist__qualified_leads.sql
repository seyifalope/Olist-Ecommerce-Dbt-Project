with source as (
    Select * from {{ source('olist', 'QUALIFIED_LEADS') }}

),

renamed as (

    select 
        mql_id,
        first_contact_date,
        landing_page_id,
        origin

from source

)

select * from renamed
