{% from "stunnel/map.jinja" import stunnel with context -%}
stunnel:
  pkg.installed:
    - name: {{ stunnel.lookup.package }}

{{ stunnel.lookup.conf_dir }}:
  file.directory:
    - user: {{ stunnel.lookup.default_user }}
    - group: {{ stunnel.lookup.default_group }}
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

/etc/init.d/stunnel4:
  file.absent: []

{{ stunnel.lookup.init_file }}:
  file.managed:
    - template: jinja
    - source: salt://stunnel/templates/{{ salt['grains.get']('init') }}.jinja

{% if salt['grains.get']('init') == 'systemd' %}
systemd_daemon_reload:
  module.wait:
    - name: service.systemctl_reload
    - sudo: True
    - onchanges:
      - file: {{ stunnel.lookup.init_file }}
{% endif %}

{{ stunnel.lookup.log_dir }}:
  file.directory:
    - user: {{ stunnel.lookup.default_user }}
    - makedirs: True

stunnel_service:
  service.running:
    - enable: True
    - name: {{ stunnel.lookup.service }}
