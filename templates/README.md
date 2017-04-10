# Template1.json<br>
Hardcoded private IPs<br>

# Template2.json<br>
Private IPs, minion ids as parameters<br>
Access to s3 bucket from all instances for getting keypairs:<br>
 downloading minion.pub for salt-master (change name for every minion)
 downloading minion.pub and minion.pem for minions
Note: Key pairs are the same for every minion

# Issues<br>
1) Unable to resolve host .....<br>
a. We must add to /etc/hosts: <br>
127.0.0.1 hostname <br>
or <br>
ip hostname<br>
b. EnableDNSNames in VPC Cloudformation Template<br>
2) I have set ip of salt-master to minion configurations, but:<br>
 - master ip will be shown after creating master instance<br>
 - on master instance we must accept keys from minions, but look above<br>
a. May be we must create one more network interface for instance, but we can't use Public IP "The associatePublicIPAddress parameter cannot be specified when launching with multiple network interfaces"(doesn't work)<br>
b. Hardcoded ip (works)<br>
c. May be use WaitCondition or CreatePolicy, but:<br>
 - first, we need deploy master instance to see its ip<br>
 - second, deploy minion instances and set master ip  to minion config<br>
 - third, after configuring minions run "salt-key"<br>
 3) Salt doesn't install<br>
 a. Open 443 port, because using apt repo salt install via https<br>