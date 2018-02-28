{% from "monit/map.jinja" import monit_app with context %}

include:
  - .install
  - .service

monit_config:
  file.managed:
    - name: {{ monit_app.conf_file }}
    - source: salt://monit/templates/conf.jinja
    - template: jinja
    - makedirs: True
    - mode: '0700'
    - context:
        config_includes: {{ monit_app.config_includes }}
        http_access: {{ monit_app.http_access }}
    - watch_in:
      - service: monit_service_running
    - require:
      - pkg: install_monit

monit_modules:
  file.managed:
    - name: {{ monit_app.config_includes }}/modules
    - source: salt://monit/templates/modules.jinja
    - template: jinja
    - context:
        modules: {{ monit_app.get('modules', {}) }}
    - watch_in:
      - service: monit_service_running

{% if monit_app.notification == 'slack' %}
monit_slack_notification:
  file.managed:
    - name: /usr/local/bin/slack.sh
    - source: salt://monit/templates/slack.sh
    - template: jinja
    - mode: '0755'
{% endif %}
