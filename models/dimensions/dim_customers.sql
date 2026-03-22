with customer as (

    select * 
    from {{ ref('stg_olist__customers')}}
),

orders as (

    select *
    from {{ ref('stg_olist__orders')}}
),

customer_orders as (
    select customer_unique_id,
    count(o.order_id) as total_orders,
    min(o.order_purchase_timestamp) as first_order_date,
    max(o.order_purchase_timestamp) as last_order_date

    from customer c
    left join orders o
    on c.customer_id = o.customer_id
    group by customer_unique_id
)

select
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,
    co.total_orders,
    co.first_order_date,
    co.last_order_date

from customer c
left join customer_orders co on c.customer_unique_id = co.customer_unique_id
