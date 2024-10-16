-- Used to set up tables in snowflake
create database if not exists bronze;
use database bronze;
create schema if not exists airbnb;
use schema airbnb;

-- Load listings
create or replace table raw_listings (
    id integer,
    listing_url string,
    name string,
    room_type string,
    minimum_nights integer,
    host_id integer,
    price string,
    created_at datetime,
    updated_at datetime
);
                    
copy into raw_listings (id, listing_url, name, room_type, minimum_nights, host_id, price, created_at, updated_at)
from 's3://dbtlearn/listings.csv'
file_format = (type = 'csv' skip_header = 1 field_optionally_enclosed_by = '"');

-- Load reviews    
create or replace table raw_reviews (
    id integer autoincrement start 1 increment 1,
    listing_id integer,
    date datetime,
    reviewer_name string,
    comments string,
    sentiment string
);

copy into raw_reviews (listing_id, date, reviewer_name, comments, sentiment)
from 's3://dbtlearn/reviews.csv'
file_format = (type = 'csv' skip_header = 1 field_optionally_enclosed_by = '"');      

-- Load hosts
create or replace table raw_hosts (
    id integer,
    name string,
    is_superhost string,
    created_at datetime,
    updated_at datetime
);

copy into raw_hosts (id, name, is_superhost, created_at, updated_at)
from 's3://dbtlearn/hosts.csv'
file_format = (type = 'csv' skip_header = 1 field_optionally_enclosed_by = '"');