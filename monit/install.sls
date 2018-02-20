{% from "monit/map.jinja" import monit with context %}

include:
  - .service

monit:
  pkg.installed:
    - pkgs: {{ monit.pkgs }}
    - require_in:
        - service: monit_service_running
