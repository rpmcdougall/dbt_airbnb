--- minimum_nights should start at 1 by default
select minimum_nights from {{ ref('stg_airbnb__listings')}} where minimum_nights < 0