{% snapshot snp__listings %}

SELECT * FROM {{ source('airbnb', 'raw_listings') }}

{% endsnapshot %}