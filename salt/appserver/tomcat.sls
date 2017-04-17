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
delete-war-if-exists:
  file.absent:
    - name: /home/ubuntu/{{ pillar['war-name'] }}.war
copy-from-s3deploy:
  module.run:
    - name: s3.get
    - bucket: {{ pillar['s3bucketdeployment'] }}
    - path: war/{{ pillar['war-version'] }}/{{ pillar['war-name'] }}.war
    - local_file: /home/ubuntu/{{ pillar['war-name'] }}.war
undeploy-war:
  tomcat.undeployed:
    - name: /{{ pillar['war-name'] }}
    - timeout: 300
    - require:
      - module: copy-from-s3deploy
      - service: check-tomcat-service
deploy-war:
  tomcat.war_deployed:
    - name: /{{ pillar['war-name'] }}
    - war: '/home/ubuntu/{{ pillar['war-name'] }}.war'
    - timeout: 300
    - require:
      - module: copy-from-s3deploy
      - service: check-tomcat-service
      - tomcat: undeploy-war
change-file:
  file.replace:
    - name: /var/lib/tomcat7/webapps/awstask2/WEB-INF/classes/greeting.txt
    - pattern: 'hello Gradle'
    - repl: '{{ pillar['war-message'] }}<br>'
