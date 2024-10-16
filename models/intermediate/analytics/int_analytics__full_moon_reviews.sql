{{ config(
    tags=["silver"]
) }}
with reviews as (
    select * from {{ ref('stg_airbnb__reviews') }}
), full_moon_dates as (
    select * from {{ ref('stg_dates__full_moon_dates') }}
), joined as (
    select
        r.*,
        case
            when fm.full_moon_review_date is not null then true
            else false
        end as full_moon_review
    from reviews as r
    left join full_moon_dates as fm
    on r.review_date = fm.full_moon_review_date
)
select * from joined