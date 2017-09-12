{% from "stunnel/map.jinja" import stunnel as stunnel_map with context -%}
stunnel:
  pkg.installed:
    - name: {{ stunnel_map.package }}

{{ stunnel_map.conf_dir }}:
  file.directory:
    - user: {{ stunnel_map.default_user }}
    - group: {{ stunnel_map.default_group }}
    - makedirs: True

{{ stunnel_map.pid_dir }}:
  file.directory:
    - user: {{ stunnel_map.default_user }}
    - makedirs: True

{% for service in salt['pillar.get']('stunnel:config:services', {}) %}
{{ stunnel_map.conf_dir }}/stunnel.conf:
  file.managed:
    - template: jinja
    - user: {{ stunnel_map.default_user }}
    - group: {{ stunnel_map.default_group }}
    - mode: 644
    - source: salt://stunnel/templates/config.jinja
    - require:
      - file: {{ stunnel_map.conf_dir }}
{% endfor -%}

{{ stunnel_map.log_dir }}:
  file.directory:
    - user: {{ stunnel_map.default_user }}
    - makedirs: True

{{ stunnel_map.default }}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://stunnel/templates/default.jinja
    - context:
      conf_dir: {{ stunnel_map.conf_dir }}
