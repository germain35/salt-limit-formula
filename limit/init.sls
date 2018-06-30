{%- from "limit/map.jinja" import limit with context -%}

{%- for name, params in limit.get('rules', {}).items() %}

limit_{{ name }}:
  {%- if params.get('enabled', True) %}
  file.managed:
    - name: {{limit.conf_dir}}/99-salt-{{ name }}.conf
    - source: salt://limit/files/limits.conf
    - template: jinja
    - defaults:
        limit_name: {{ name }}
        {%- if params.get('domain', False) %}
        limit_domain: {{ params.domain }}
        {%- endif %}
  {%- else %}
  file.absent:
    - name: {{limit.conf_dir}}/99-salt-{{ name }}.conf
  {%- endif %}

{%- endfor %}
