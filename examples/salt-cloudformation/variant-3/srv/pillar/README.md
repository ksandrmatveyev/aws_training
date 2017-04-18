<b>top.sls</b><br>
common pillar and depending on grains roles<br>
<b>default.sls</b><br>
deployment bucket, name of war file<br>
<b>app.sls</b><br>
credentials for tomcat (must be set as pillars or as grains. Otherwise state.tomcat doesn't work), versions of war file and messages for apps (used jinja template. Different versions and messages for different app-minions)<br>
<b>web.sls</b><br>
content bucket