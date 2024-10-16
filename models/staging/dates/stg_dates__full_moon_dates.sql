{{ config(
    tags=["silver"]
) }}
with renamed as (
    select
        dateadd(day, 1, full_moon_date) as full_moon_review_date
    from {{ ref('sd__full_moon_dates') }}
)
select * from renamed