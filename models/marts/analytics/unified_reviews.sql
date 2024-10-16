{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'review_id',
        on_schema_change = 'fail',
        tags = 'gold'
    )
}}

with reviews as (
    select * from {{ ref('int_analytics__full_moon_reviews') }}
    {% if is_incremental() %}
    where review_date > (select max(review_date) from {{this}})
    {% endif %}
), listings as (
    select * from {{ ref('stg_airbnb__listings') }}
), hosts as (
    select * from {{ ref('stg_airbnb__hosts') }}
), unified_reviews as (
    select
        r.review_id,
        r.review_date,
        r.reviewer_name,
        r.review_text,
        r.review_sentiment,
        r.full_moon_review,
        l.listing_id,
        l.listing_url,
        l.listing_name,
        l.room_type,
        l.minimum_nights,
        l.listing_price_usd,
        h.host_id,
        h.host_name,
        h.is_superhost
    from reviews as r
    join listings as l
    on r.listing_id = l.listing_id
    join hosts as h 
    on l.host_id = h.host_id
)
select * from unified_reviews