{{ config(
    tags=["silver"]
) }}
with source as (
    select * from {{ source('airbnb', 'raw_listings') }}
), renamed as (
    select
        id as listing_id,
        listing_url,
        name as listing_name,
        room_type,
        minimum_nights,
        host_id,
        replace(price, '$', '')::number as listing_price_usd,
        created_at,
        updated_at
    from source
)
select * from renamed