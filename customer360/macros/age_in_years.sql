{% macro age_in_years(date_column) %}
  {% set database_type = var('database_type', default='postgres') %}

  {% if database_type == 'postgres' %}
    date_part('year', age(current_date, {{ date_column }}))
  {% elif database_type == 'databricks' %}
    year(current_date) - year({{ date_column }})
  {% else %}
    {{ log("Unsupported database_type: " + database_type, info=True) }}
  {% endif %}
{% endmacro %}