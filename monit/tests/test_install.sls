{% from "monit/map.jinja" import monit with context %}

{% for pkg in monit.pkgs %}
test_{{pkg}}_is_installed:
  testinfra.package:
    - name: {{ pkg }}
    - is_installed: True
{% endfor %}
