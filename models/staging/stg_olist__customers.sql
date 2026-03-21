with source as (

    Select * from {{ source('olist', 'CUSTOMERS') }}
),

renamed  as ( 

    Select 
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state

    from source    

)

Select *
from renamed