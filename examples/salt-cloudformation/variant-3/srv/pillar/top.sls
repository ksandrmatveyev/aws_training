base:
  '*':
    - default
  'roles:webserver*':
    - match: grain
    - web
  'roles:appserver*':
    - match: grain
    - app