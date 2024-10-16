{{ config(
    tags=["silver"]
) }}
with source as (
    select * from {{ source('airbnb', 'raw_hosts') }}
), renamed as (
    select
        id as host_id,
        nvl(name, 'anonymous') as host_name,
        is_superhost::boolean as is_superhost,
        created_at,
        updated_at
    from source
)
select * from renamed