<b>NetworkStack</b><br>
 - Defined VPC with one public subnet (I suppose for task it is not main idea. If I had more time, I'd design more real situation)<br>
 - Attached Internet Gateway, Route Table with Route to this gateway, Association of Subnet with Route Table<br>
 - Public Security Group, which allow 80(apache),8080(tomcats),443(for salt install),22(ssh),4505-4506 (salt-master/minion ports),ping (for testing)<br>
<b>IAMBucketAccess</b><br>
 - Names of buckets as parameters<br>
 - Instance Profile for acccess to "deployment" bucket with WARs,Salt States, Salt Key Pairs<br>
 - Instance Profile for access to "content" bucket with static content for apache and to "deployment" bucket<br>
<b>Note</b>: Can't use several instance profiles with one instance or several instance roles with one instance profile (<a href='http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html#w1ab2c19c12d512c13' target=_blank>for now</a>)<br>
<b>MasterStack</b><br>
get VPCId, Subnet name, InstanceProfile through prameters<br>
install salt-master, aws cli, dowload salt pillars (from s3 deployment bucket)<br>
b>Used</b> simple <b>auto_accept</b> property in salt-master's config<br>
<b>AppStack</b><br>
get VPCId, Subnet name, InstanceProfile through prameters<br>
get local IPs of salt-master through prameter<br>
app-minions: install salt-minion, aws cli, configure minions (set local IP of salt-master (must be changed,because by default hostname "salt") and write role to grains depending on instance goal)<br>
pass local IPs of app-minions through otputs<br>
<b>WebStack</b><br>
get VPCId, Subnet name, InstanceProfile through prameters<br>
get local IPs of salt-master through prameter<br>
get local IPs of app-minions through prameters and set them as web-minion grains<br>
web-minion: install salt-minion, aws cli, configure minion (set local IP of salt-master (must be changed,because by default hostname "salt") and write role to grains depending on instance goal)<br>
<b>Note</b>: Didn't use minion IDs (It's necessary if we want use predefined keys,they must named as minion ID. Also minion ID is a hostname by default. That's why we can changing them instead of using hard-reading EC2 hostnames). <b>Used</b> simple <b>auto_accept</b> property in salt-master's config<br>