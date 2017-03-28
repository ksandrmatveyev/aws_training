#AWS Task:

1. Register your own account at https://aws.amazon.com (please note that you will have to attach your credit card to your account)
2. Create manually base AWS infra which contains the following resources:
            · Create resources stack which consists of:
                        - two EC2 instances distributed across Availability Zones;
                        - S3 bucket;
                        - two Elastic IP (attached to each instance);
                        - custom security group attached to every instance;
                        - EBS volumes any size attached as root device (of type magnetic);
                        - Elastic Load Balancer for instances created (ELB port 80 to instance port 80);
            · Modify configuration in the following way:
                        - make instances autoscaled - for this stop existing static servers and instead create Launch Configuration and Auto Scaling Group (no Elastic IPs needed this time);
                        - create IAM Instance Profile and attach it to auto-scaled instances;
                        - place some files into S3 bucket and make sure you are able to access these files from your EC2 instances
            · Create stack consists of:
                        - VPC;
                        - Internet Gateway;
                        - three Private and three public Subnets;
                        - Public Route Table and Public Route;
                        - Private Route Table and Private Route;
                        - NAT instance.

Notes: instance type should be t1.micro or t2.micro, AMI - official CentOS 6 image.
<b>cloudformation templates folder<b>: Examples
<hr>
<b>task-all-in-one.json</b>: Final<br>
1) VPC with 3 Private and 3 Pulic Subnets accros availability zones
2) Public Route Table with Public Route (to Internet Gateway) nd Private Route Table with Private Route (to NAT Instance) 
3) Public Auto Scaling Group (desired/min/max 2 instances, access to created S3 bucket through Instance Profile, installed nginx) behind Load Balancer
4) Private Instance (for testing), that available only from public subnets (SSH) and has access to internet through NAT Instance 

<hr>
Issue:<br>
AssociatePublicIpAddress field can not be specified without a subnet id<br>
Solution:<br>
need to specify conditional "VPCZoneIdentifier" for AutoScalingGroup, even if we have already specified "AvailabilityZones"

