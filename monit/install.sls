{% from "monit/map.jinja" import monit_app with context %}

include:
  - .service

install_monit:
  pkg.installed:
    - name: {{ monit_app.pkg }}
    - require_in:
        - service: monit_service_running
