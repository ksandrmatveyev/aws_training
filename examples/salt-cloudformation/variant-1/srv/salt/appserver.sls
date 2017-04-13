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
      - file: add-tomcat-user
      - file: add-proxy-ip
add-proxy-ip:
  file.blockreplace:
    - name: /etc/tomcat7/server.xml
    - marker_start: '<Connector port="8080" protocol="HTTP/1.1"'
    - marker_end: 'URIEncoding="UTF-8'
    - content: |
        connectionTimeout="20000"
        proxyName="{{ pillar['webIP'] }}"
        proxyPort="80"
    - backup: '.bak'
    - show_changes: True
add-tomcat-user:
  file.blockreplace:
    - name: /etc/tomcat7/tomcat-users.xml
    - marker_start: "<tomcat-users>"
    - marker_end: "</tomcat-users>"
    - content: |
        <role rolename="manager-script"/>
        <user username="{{ pillar['tomcat-manager']['user'] }}" password="{{ pillar['tomcat-manager']['passwd'] }}" roles="manager-script"/>
    - backup: '.bak'
    - show_changes: True
deploy-war:
  tomcat.war_deployed:
    - name: /{{ pillar['war-name'] }}
    - war: '/home/ubuntu/{{ pillar['war-name'] }}.war'
    - timeout: 300
    - require:
      - service: check-tomcat-service
change-file:
  file.replace:
    - name: /var/lib/tomcat7/webapps/awstask2/WEB-INF/classes/greeting.txt
    - pattern: 'hello Gradle'
    - repl: '{{ pillar['war-message'] }}<br>'
