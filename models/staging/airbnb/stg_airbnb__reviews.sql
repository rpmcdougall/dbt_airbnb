{{ config(
    tags=["silver"]
) }}
with source as (
    select * from {{ source('airbnb', 'raw_reviews') }}
), renamed as (
    select 
        id AS review_id,
        listing_id,
        date as review_date,
        reviewer_name,
        comments as review_text,
        sentiment as review_sentiment
    from source
)
select * from renamed