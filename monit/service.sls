{% from "monit/map.jinja" import monit_app with context %}

monit_service_running:
  service.running:
    - name: {{ monit_app.service }}
    - enable: True
