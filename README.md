<b>AWS Task:</b><br>

1. Register your own account at https://aws.amazon.com (please note that you will have to attach your credit card to your account)<br>
2. Create manually base AWS infra which contains the following resources:<br>
            · Create resources stack which consists of:<br>
                        - two EC2 instances distributed across Availability Zones;<br>
                        - S3 bucket;<br>
                        - two Elastic IP (attached to each instance);<br>
                        - custom security group attached to every instance;<br>
                        - EBS volumes any size attached as root device (of type magnetic);<br>
                        - Elastic Load Balancer for instances created (ELB port 80 to instance port 80);<br>
            · Modify configuration in the following way:<br>
                        - make instances autoscaled - for this stop existing static servers and instead create Launch Configuration and Auto Scaling Group (no Elastic IPs needed this time);<br>
                        - create IAM Instance Profile and attach it to auto-scaled instances;<br>
                        - place some files into S3 bucket and make sure you are able to access these files from your EC2 instances<br>
            · Create stack consists of:<br>
                        - VPC;<br>
                        - Internet Gateway;<br>
                        - three Private and three public Subnets;<br>
                        - Public Route Table and Public Route;<br>
                        - Private Route Table and Private Route;<br>
                        - NAT instance.<br>

Notes: instance type should be t1.micro or t2.micro, AMI - official CentOS 6 image.
<hr>
<b>task-all-in-one.json</b>: Final<br>
1) VPC ("myVPC" 10.0.0.0/16) with 3 Private(10.0.3.0/24, 10.0.4.0/24, 10.0.5.0/24) and 3 Pulic Subnets (10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24) accros availability zones (a,b,c)<br>
2) Internet Gateway attached to VPC<br>
3) Public Route Table with Public Route (to Internet Gateway) nd Private Route Table with Private Route (to NAT Instance) <br>
4) Public and Private Subnets Association<br>
5) NAT Security Group (Allow inbound HTTP/HTTPS traffic from servers in the private subnets. Allow outbound HTTP/HTTPS/ICMP access to the Internet)<br>
6) NAT Instance based on Amazon Linux AMI special for vpc-nat<br>
7) Private Intance based on centos 6 with custom root volume (magnetic)<br>
8) Private Intance Security Group (Allow SSH from Public Subnets only and allow access to internet through NAT Instance)<br>
9) IAM Role, IAM Policy, IAM InstanceProfile for s3 bucket managing<br>
10) S3 Bucket<br>
11) Cross-zone Elastic Load Balancer with Security Group (allow 80) 
12) Public Auto Scaling Group, that has desired/min/max 2 instances based on centos 6, installed nginx, custom root volumes (magnetic), access to created S3 bucket through Instance Profile) behind Load Balancer (public)<br>
<hr>
Issue:<br>
AssociatePublicIpAddress field can not be specified without a subnet id<br>
Solution:<br>
need to specify conditional "VPCZoneIdentifier" for AutoScalingGroup, even if we have already specified "AvailabilityZones"
<hr>
<b>cloudformation templates folder</b>: Examples<br>