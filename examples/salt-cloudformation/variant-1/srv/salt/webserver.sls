install-apache:
  pkg.installed:
    - name: apache2
check-apache-service:
  service.running:
    - name: apache2
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
create-directory:
  file.directory:
    - name: /var/www/static
copy-all-from-s3content:
  cmd.run:
    - name: 'aws s3 sync s3://{{ pillar['s3bucketcontent'] }} /var/www/static/'
    - require:
      - file: create-directory
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
    - contents: |
        <VirtualHost *:80>
        ProxyRequests off
        ProxyPreserveHost On
        ProxyPass /app1 http://{{ pillar['app1IP'] }}:8080/{{ pillar['war-name'] }} retry=0 timeout=5
        ProxyPassReverse /app1 http://{{ pillar['app1IP'] }}:8080/{{ pillar['war-name'] }}
        ProxyPass /app2 http://{{ pillar['app2IP'] }}:8080/{{ pillar['war-name'] }} retry=0 timeout=5
        ProxyPassReverse /app2 http://{{ pillar['app2IP'] }}:8080/{{ pillar['war-name'] }}
        </VirtualHost>
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
restart-apache-service:
  cmd:
    - run
    - name: service apache2 reload
