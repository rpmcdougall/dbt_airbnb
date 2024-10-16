{% macro op_scd_update_listings_price() %}
{% set sql %}
    update {{source('airbnb', 'raw_listings')}} as listings set listings.price = to_varchar(to_decimal(uniform(100::float, 900::float, random()), 10, 2)), updated_at = current_timestamp(3) where id=3176;
    update {{source('airbnb', 'raw_listings')}} as listings set listings.price = to_varchar(to_decimal(uniform(100::float, 900::float, random()), 10, 2)), updated_at = current_timestamp(3) where id=7071;
    update {{source('airbnb', 'raw_listings')}} as listings set listings.price = to_varchar(to_decimal(uniform(100::float, 900::float, random()), 10, 2)), updated_at = current_timestamp(3) where id=9991;
{% endset %}
{%do log(sql)%}
{% do run_query(sql) %}
{% do log("scd load inserted", info=True) %}
{% endmacro %}