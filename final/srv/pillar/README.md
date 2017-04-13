#top.sls<br>
common pillar and depending on grains roles<br>
#default.sls<br>
deployment bucket, local IP for web-minion, name of war file<br>
#app.sls<br>
credentials for tomcat (must be set as pillars or as grains. Otherwise state.tomcat doesn't work), versions of war file and messages for apps (used jinja template. Different versions and messages for different app-minions)<br>
#web.sls<br>
content bucket, local IPs of app-minions