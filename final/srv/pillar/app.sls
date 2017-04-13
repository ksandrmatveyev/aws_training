tomcat-manager:
  user: 'tomcat-manager'
  passwd: 'Passw0rd'
{% if grains['roles'] == 'appserver1' %}
war-message: 'Hello. It is APP1'
war-version: '1.0.0'
{% elif grains['roles'] == 'appserver2' %}
war-message: 'Hello. It is APP2'
war-version: '1.0.1'
{% endif %}
