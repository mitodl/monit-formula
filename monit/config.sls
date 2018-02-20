{% from "monit/map.jinja" import monit with context %}

include:
  - .install
  - .service

monit-config:
  file.managed:
    - name: {{ monit.conf_file }}
    - source: salt://monit/templates/conf.jinja
    - template: jinja
    - makedirs: True
    - mode: '0700'
    - context:
        config_includes: {{ monit.config_includes }}
        http_access: {{ monit.http_access }}
    - watch_in:
      - service: monit_service_running
    - require:
      - pkg: monit

monit-modules:
  file.managed:
    - name: {{ monit.config_includes }}/modules
    - source: salt://monit/templates/modules.jinja
    - template: jinja
    - context:
        modules: {{ monit.modules }}
    - watch_in:
      - service: monit_service_running