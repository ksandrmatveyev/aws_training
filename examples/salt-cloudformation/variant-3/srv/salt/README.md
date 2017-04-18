<b>top.sls</b><br>
Set states for all minions (common) and depending on grains (roles, which set using cloudformation)<br>
<b>common</b><br>
Install java<br>
<b>webserver</b><br>
 - install apache<br>
 - check if running<br>
 - enable proxy and rewrite modules (I used proxy module instead rewrite module or mod_jk, because I'd like to set apache as proxy, also I'd try something new for me)<br>
 - disable default hello apache site (don't need it)<br>
 - create static directory for static content<br>
 - dowload content from s3 (used cmd.run because I have no idea how right and simple dowload several files. Because file.managed and s3.get can download only one file. Also I found a <a href='https://github.com/saltstack/salt/issues/39903' target=_blank>bug</a> with s3://-links in last salt version. We can use them only once, next time we get 'hsm' error even if delete file from filesystem)<br>
 - create virtualhost for static with reverse proxy settings. Used state.apache<br>
 - create virtualhost for apps with revers proxy settings. Used file with Jinja template and grains<br>
<b>Note</b>: It can be done with one file, I want to try doing it with state.apache. For apps host have already used file with Jinja template<br>
 - enable sites and reload apache<br>
<b>appserver</b><br>
 - install tomcat7 and tomcat7-admin (for managing of deploy)<br>
 - check if running<br>
 - add proxy host and port to tomcat configuration (it must be done if we use mod_proxy)  using file with Jinja template<br>
 - delete war file if exists (only for testing s3 dowloading)<br>
 - download war from s3 depending on pillars (also used module.run s3.get,because file.managed get s3://-links error)<br>
 - undeploy war<br>
 - deploy war using state.tomcat<br>
 - change content of application with message
