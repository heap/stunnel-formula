{% from "stunnel/map.jinja" import stunnel with context -%}
stunnel:
  pkg.installed:
    - name: {{ stunnel.lookup.package }}

{{ stunnel.lookup.conf_dir }}:
  file.directory:
    - user: {{ stunnel.lookup.default_user }}
    - group: {{ stunnel.lookup.default_group }}
    - makedirs: True

{{ stunnel.lookup.pid_dir }}:
  file.directory:
    - user: {{ stunnel.lookup.default_user }}
    - makedirs: True

{{ stunnel.lookup.conf_dir }}/stunnel.conf:
  file.managed:
    - template: jinja
    - user: {{ stunnel.lookup.default_user }}
    - group: {{ stunnel.lookup.default_group }}
    - mode: 644
    - source: salt://stunnel/templates/config.jinja
    - require:
      - file: {{ stunnel.lookup.conf_dir }}

{{ stunnel.lookup.log_dir }}:
  file.directory:
    - user: {{ stunnel.lookup.default_user }}
    - makedirs: True

{{ stunnel.lookup.default }}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://stunnel/templates/default.jinja
    - context:
      conf_dir: {{ stunnel.lookup.conf_dir }}
