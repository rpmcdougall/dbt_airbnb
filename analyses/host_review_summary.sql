with listings as (
    select * from {{ ref('stg_airbnb__listings') }}
), hosts as (
    select * from {{ ref('stg_airbnb__hosts') }}
), reviews as (
    select * from {{ ref('stg_airbnb__reviews') }}
), listings_hosts_reviews as (
    select
        h.host_name,
        count(distinct l.listing_id) as number_of_listings,
        sum(case when r.review_sentiment = 'positive' then 1 else 0 end) as number_postive_reviews,
        sum(case when r.review_sentiment = 'neutral' then 1 else 0 end) as number_neutral_reviews,
        sum(case when r.review_sentiment = 'negative' then 1 else 0 end) as number_negative_reviews
    from listings as l
    join hosts as h 
    on l.host_id = h.host_id
    join reviews as r
    on l.listing_id = r.listing_id
    group by h.host_name
)
select * from listings_hosts_reviews