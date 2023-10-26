{% macro as_timestamp_utc(column_name) %}
  {% set database_type = var('database_type', default='postgres') %}
  
  {% if database_type == 'postgres' %}
    to_timestamp({{ column_name }},'YYYY-MM-DD HH24:MI:SS.MS') :: timestamp at TIME zone 'UTC'
  {% elif database_type == 'databricks' %}
    from_utc_timestamp(to_timestamp({{ column_name }}, 'yyyy-MM-dd HH:mm:ss.SSS'), 'UTC')
  {% else %}
    {{ log("Unsupported database_type: " + database_type, info=True) }}
  {% endif %}
{% endmacro %}