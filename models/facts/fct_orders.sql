with orders as (
    select *
    from {{ ref('stg_olist__orders')}}
),

order_payments as (
select *
from {{ ref('stg_olist__order_payments')}}

),

order_items as (
    select *
    from {{ ref('stg_olist__order_items')}}

),

payments_aggregated as (

    select order_id, 
    sum(payment_value) as total_payment_value,
    count(payment_sequential) as total_payment_menthod,
    max(payment_installments) as max_payment_installments

    from order_payments
    group by order_id
),

item_aggregated as (
    select order_id,
    count(order_item_id) as total_items,
    sum(price) as total_price,
    sum(freight_value) as total_freight_value

    from order_items
    group by order_id

)


select


o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    p.total_payment_value,
    p.max_payment_installments,
    i.total_items,
    i.total_price,
    i.total_freight_value


from orders  o
left join payments_aggregated  p on o.order_id = p.order_id
left join item_aggregated  i on o.order_id = i.order_id