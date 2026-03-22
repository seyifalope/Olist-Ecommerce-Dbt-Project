with products as (

    select * from {{ ref('stg_olist__products') }}

),

category_translation as (

    select * from {{ ref('stg_olist__product_category_translation') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

product_orders as (

    select
        product_id,
        count(distinct order_id) as total_orders,
        sum(price) as total_revenue,
        sum(freight_value) as total_freight_value

    from order_items
    group by product_id

)

select
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    po.total_orders,
    po.total_revenue,
    po.total_freight_value

from products p
left join category_translation ct on p.product_category_name = ct.product_category_name
left join product_orders po on p.product_id = po.product_id