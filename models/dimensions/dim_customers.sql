with customers as (

    select * from {{ ref('stg_olist__customers') }}

),

orders as (

    select * from {{ ref('stg_olist__orders') }}

),

customer_orders as (

    select
        customer_unique_id,
        count(o.order_id) as total_orders,
        min(o.order_purchase_timestamp) as first_order_date,
        max(o.order_purchase_timestamp) as last_order_date

    from customers c
    left join orders o on c.customer_id = o.customer_id
    group by customer_unique_id

),

deduplicated as (

    select
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state,
        row_number() over (
            partition by customer_unique_id
            order by customer_unique_id
        ) as rn

    from customers

)

select
    d.customer_unique_id,
    d.customer_zip_code_prefix,
    d.customer_city,
    d.customer_state,
    co.total_orders,
    co.first_order_date,
    co.last_order_date

from deduplicated d
left join customer_orders co
    on d.customer_unique_id = co.customer_unique_id
where d.rn = 1