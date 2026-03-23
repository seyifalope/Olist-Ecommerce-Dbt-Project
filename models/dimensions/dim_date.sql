with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2016-01-01' as date)",
        end_date="cast('2018-12-31' as date)"
    ) }}
),

final as (
    select
        cast(date_day as date) as date_id,
        date_day as full_date,
        year(date_day) as year,
        quarter(date_day) as quarter,
        month(date_day) as month_number,
        monthname(date_day) as month_name,
        day(date_day) as day_of_month,
        dayofweek(date_day) as day_of_week,
        dayname(date_day) as day_name,
        weekofyear(date_day) as week_of_year,
        case
            when dayofweek(date_day) in (1, 7) then false
            else true
        end as is_weekday,
        concat(year(date_day), '-Q', quarter(date_day)) as year_quarter,
        date_trunc('month', date_day) as month_start_date
    from date_spine
)

select * from final