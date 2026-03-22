with sellers as (

    select * from {{ ref('stg_olist__sellers') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

seller_orders as (

    select
        seller_id,
        count(distinct order_id) as total_orders,
        count(order_item_id) as total_items_sold,
        sum(price) as total_revenue,
        sum(freight_value) as total_freight_value

    from order_items
    group by seller_id

)

select
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    so.total_orders,
    so.total_items_sold,
    so.total_revenue,
    so.total_freight_value

from sellers s
left join seller_orders so on s.seller_id = so.seller_id