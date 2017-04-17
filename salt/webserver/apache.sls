install-apache:
  pkg.installed:
    - name: apache2
check-apache-service:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - apache: /etc/apache2/sites-available/static-host.conf
      - file: create-apps-host
    - require:
      - pkg: install-apache
enable-proxy-module:
  apache_module.enabled:
    - name: proxy_http
enable-rewrite-module:
  apache_module.enabled:
    - name: rewrite
disable-default-site:
  apache_site.disabled:
    - name: 000-default.conf
/etc/apache2/sites-available/static-host.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          this: '*:80'
          DocumentRoot: /var/www/static
          ProxyRequests: 'off'
          ProxyPass: '/static/ http://{{ pillar['webIP'] }}:80/static/'
          ProxyPassReverse: '/static/ http://{{ pillar['webIP'] }}:80/static/'
          Location:
            this: /var/www/static
            Order: Deny,Allow
            Allow from: All
create-apps-host:
  file.managed:
    - name: /etc/apache2/sites-available/apps-host.conf
    - source: salt://webserver/apps-vhost.conf.jinja
    - template: jinja
    - require:
        - apache: /etc/apache2/sites-available/static-host.conf
enable-static-host:
  apache_site.enabled:
    - name: static-host
    - require:
        - apache: /etc/apache2/sites-available/static-host.conf
enable-apps-host:
  apache_site.enabled:
    - name: apps-host
    - require:
        - file: create-apps-host
