base:
  '*':
    - common
  'roles:webserver':
    - match: grain
    - webserver
  'roles:appserver*':
    - match: grain
    - appserver
