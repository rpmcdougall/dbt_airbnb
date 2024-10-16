{% macro op_incremental_load_reviews() %}
{% set sample_sql %}
    select * from {{source("airbnb", "raw_reviews")}} limit 10
{% endset %}
{% set results = run_query(sample_sql) %}
{% for review in results.rows.values() %}
    {% set inc_sql %}
        {% set current_ts = run_query('select current_timestamp(2)') %}
        {% set ts_value = current_ts.columns[0].values()[0]%}
        {% set reviewer_name = 'reviewer ' ~ ts_value %}   
        {% set inc_comment ='incremental data comment ' ~ ts_value %}
            insert into {{source("airbnb", "raw_reviews")}} (listing_id, date, reviewer_name, comments, sentiment)
                    values('{{review[0]}}', '{{ts_value}}', '{{reviewer_name}}', '{{inc_comment}}', '{{review[4]}}')
    {% endset %}
    {%do log(inc_sql)%}
{% endfor %}
{% do log("incremental load inserted", info=True) %}    
{% endmacro %}