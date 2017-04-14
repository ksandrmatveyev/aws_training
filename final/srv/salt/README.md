<b>top.sls</b><br>
Set states for all minions (common) and depending on grains (roles, which set using cloudformation)<br>
<b>common.sls</b><br>
Install java<br>
<b>webserver.sls</b><br>
 - install apache<br>
 - check if running<br>
 - enable proxy and rewrite modules (I used proxy module instead rewrite module or mod_jk, because want our apache must working as proxy, also I want try something new for me)<br>
 - disable default hello apache site (don't need it)<br>
 - create static directory for static content<br>
 - dowload content from s3 (used cmd.run because I have no idea how right and simple dowload several files. Because file.managed and s3.get can download only one file. Also I found a bug with s3://-links in last salt version. We can use them only once, next time we get 'hsm' error even if delete file from filesystem)<br>
 - create virtualhost for static with reverse proxy settings<br>
 - create virtualhost for apps with revers proxy settings<br>
<b>Note</b>: It can be done with one file, I want to try doing it with state.apache. For apps host have already used file.managed<br>
 - enable sites and reload apache<br>
<b>appserver.sls</b><br>
 - install tomcat7 and tomcat7-admin (for managing of deploy)<br>
 - check if running<br>
 - add proxy host and port to tomcat configuration (it must be done if we use mod_proxy)  using file.blockreplace<br>
 - delete war file if exists (only for testing s3 dowloading)<br>
 - download war from s3 depending on pillars (also used cmd.run, s3://-links error)<br>
 - deploy war using state.tomcat<br>
 - change content of application with message
