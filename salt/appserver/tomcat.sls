install-tomcat:
  pkg.installed:
    - pkgs:
      - tomcat7
      - tomcat7-admin
check-tomcat-service:
  service.running:
    - name: tomcat7
    - enable: True
    - require:
      - pkg: install-tomcat
    - watch:
      - file: manage-tomcat-users
      - file: manage-tocmat-configuration
manage-tocmat-configuration:
  file.managed:
    - name: /etc/tomcat7/server.xml
    - source: salt://appserver/server.xml.jinja
    - template: jinja
manage-tomcat-users:
  file.managed:
    - name: /etc/tomcat7/tomcat-users.xml
    - source: salt://appserver/tomcat-users.xml.jinja
    - template: jinja
deploy-war:
  tomcat.war_deployed:
    - name: /{{ pillar['war-name'] }}
    - war: '/vagrant/war/{{ pillar['war-version'] }}/awstask2.war'
    - timeout: 300
    - require:
      - service: check-tomcat-service
change-file:
  file.replace:
    - name: /var/lib/tomcat7/webapps/awstask2/WEB-INF/classes/greeting.txt
    - pattern: 'hello Gradle'
    - repl: '{{ pillar['war-message'] }}<br>'
