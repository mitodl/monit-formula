{% from "monit/map.jinja" import monit with context %}

monit_service_running:
  service.running:
    - name: {{ monit.service }}
    - enable: True
