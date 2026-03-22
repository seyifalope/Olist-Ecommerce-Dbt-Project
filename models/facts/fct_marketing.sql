with qualified_leads as (

    select * from {{ ref('stg_olist__qualified_leads') }}

),

closed_deals as (

    select * from {{ ref('stg_olist__closed_deals') }}

)

select
    ql.mql_id,
    ql.first_contact_date,
    ql.landing_page_id,
    ql.origin,
    cd.seller_id,
    cd.sdr_id,
    cd.sr_id,
    cd.won_date,
    cd.business_segment,
    cd.lead_type,
    cd.lead_behaviour_profile,
    cd.has_company,
    cd.has_gtin,
    cd.average_stock,
    cd.business_type,
    cd.declared_product_catalog_size,
    cd.declared_monthly_revenue,
    case
        when cd.mql_id is not null then true
        else false
    end as is_converted

from qualified_leads ql
left join closed_deals cd on ql.mql_id = cd.mql_id