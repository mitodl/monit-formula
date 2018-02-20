{% from "monit/map.jinja" import monit with context %}

include:
  - .install
  - .service

monit-config:
  file.managed:
    - name: {{ monit.conf_file }}
    - source: salt://monit/templates/conf.jinja
    - template: jinja
    - watch_in:
      - service: monit_service_running
    - require:
      - pkg: monit
