<b>Cloudformation.json</b><br>
1) Parameters for:<br>
 - local IPs of instances<br>
 - Names of buckets (for better support)<br>
 - Minion IDs (If we want use predefined keys, predefined keys must named as minion ID. Also minion ID is a hostname by default. That's why I use them instead of hard-reading EC2 hostnames)<br>
2) Defined VPC with one public subnet (I suppose for task it is not main idea. If I had more time, I'd design more real situation)<br>
3) Attached Internet Gateway, Route Table with Route to this gateway, Association of Subnet with Route Table<br>
4) Public Security Group, which allow 80(apache),8080(tomcats),443(for salt install),22(ssh),4505-4506 (salt-master/minion ports),ping (for testing)<br>
5) Instance Profile for acccess to "deployment" bucket with WARs,Salt States, Salt Key Pairs<br>
6) Instance Profile for access to "content" bucket with static content for apache<br>

<b>Note</b>: Can't use several instance profiles with one instance or several instance roles with one instance profile (<a href='http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html#w1ab2c19c12d512c13' target=_blank>for now</a>)<br>

7) Salt-master instance: install salt-master, aws cli, download and auto-accept predefined public keys (the same public key for all future minions), dowload salt states with pillars (keys,states and pillars from s3 deployment bucket)<br>
8) 3 salt-minions: install salt-minion, aws cli, key pairs (the same for all instances), configure minions (set local IP of salt-master (must be changed,because by default hostname "salt") and write role to grains depending on instance goal)<br>

<b>SRV folder</b><br>
salt - salt states with top<br>
pillar - with top