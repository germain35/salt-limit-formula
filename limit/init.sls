{%- from "limit/map.jinja" import limit with context -%}

{%- for name, params in limit.items() %}

limit_{{ name }}:
  {%- if params.get('enabled', True) %}
  file.managed:
    - name: {{limit.conf_dir}}/99-salt-{{ name }}.conf
    - source: salt://limit/files/limits.conf
    - template: jinja
    - defaults:
        limit_name: {{ name }}
        limit_domain: {{ params.domain }}
  {%- else %}
  file.absent:
    - name: {{limit.conf_dir}}/99-salt-{{ name }}.conf
  {%- endif %}

{%- endfor %}
