--- listing_price_usd should have $ removed
select listing_price_usd from {{ ref("stg_airbnb__listings") }} where listing_price_usd like '$*' 