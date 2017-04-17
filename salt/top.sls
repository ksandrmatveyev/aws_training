base:
  '*':
    - common.java
  'roles:webserver':
    - match: grain
    - webserver.apache
  'roles:appserver*':
    - match: grain
    - appserver.tomcat
