with source as (

    select * from {{ source('olist', 'PRODUCT_CATEGORY_TRANSLATION') }}

),

renamed as (

    select
       C1 as  product_category_name,
       C2 as  product_category_name_english

    from source

)

select * from renamed