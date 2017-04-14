<b>Final task2</b><br>
final folder<br>
<b>Examples</b><br>
Variants of aws cloudformation templates and salt states<br>
<b>Issues</b><br>
1) Unable to resolve host .....<br>
a. We must add to /etc/hosts: <br>
127.0.0.1 hostname <br>
or <br>
ip hostname<br>
b. EnableDNSNames in VPC Cloudformation Template<br>

2) I must set ip of salt-master to minion configurations, but:<br>
 - master ip will be shown after creating master instance<br>
 - on master instance we must accept keys from minions, but look above<br>
a. May be we must create one more network interface for instance, but we can't use Public IP "The associatePublicIPAddress parameter cannot be specified when launching with multiple network interfaces"(doesn't work)<br>
b. Hardcoded ip (works)<br>
c. May be use WaitCondition or CreatePolicy, but:<br>
 - first, we need deploy master instance to see its ip<br>
 - second, deploy minion instances and set master ip  to minion config<br>
 - third, after configuring minions run "salt-key"<br>

3) Salt can't be installed<br>
a. Open 443 port, because using apt repo salt install via https<br>
4) Can't use several instance profiles with one instance or several instance roles with one instance profile (<a href='http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html#w1ab2c19c12d512c13' target=_blank>for now</a>)<br>
5) <a href='https://github.com/saltstack/salt/issues/39903' target=_blank>Issue</a> with state.file, which used s3:// links (salt version 2016.11.3). Can be pathed or use another state (as I use cmd.run)<br>