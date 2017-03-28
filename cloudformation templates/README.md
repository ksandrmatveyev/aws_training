# aws_training
<b>template1.json</b>: Two public EC2 instances, that can use only created s3 bucket 
1) VPC ("myVPC" 10.0.0.0/16) and 3 public subnets (10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24 with different availability zones) in it.
2) Internet Gateway and attaching it to VPC
3) Route Table with Route (destination 0.0.0.0/0)
4) Subnets association (with Route Table) 
5) Security Group for public instances (allow 80 and 22)
6) S3 Bucket ("myS3Bucket")
7) IAM Role ("InstRole" with "Service": "ec2.amazonaws.com")
8) Policy ref. IAMRole ("RolePolicies", which allow show list of s3 buckets, but use only "myS3Bucket")
9) InstanceProfile ref. IAMrole ("InstanceS3Profile")
10) Two EC2 Instances (with mapping of 10gb magnetic volumes, ref. Instance Profile for managing S3 Bucket) in VPC with Elastic IPs

<b>template2.json</b>: Two public EC2 instances behind Load Balancer, that can use all s3 buckets
1) Security Group for public instances (allow 80 and 22)
2) S3 Bucket ("myS3Bucket")
3) IAM Role ("InstRole" with "Service": "ec2.amazonaws.com")
4) Policy ref. IAMRole ("RolePolicies", which allow managing of all s3 Buckets)
5) InstanceProfile ref. IAMrole ("InstanceS3Profile")
6) Two EC2 Instances (with mapping of 10gb magnetic volumes, ref. Instance Profile for managing S3 Buckets, default VPC, different availability zones) with Elastic IPs
7) Load Balancer (listening port 80)

<b>template3.json</b>: Two public EC2 instances behind Load Balancer
1) Security Group for public instances (allow 80 and 22)
2) S3 Bucket ("myS3Bucket")
3) Two EC2 Instances (with mapping of 10gb magnetic volumes, ref. Instance Profile for managing S3 Buckets, default VPC, different availability zones) with Elastic IPs
4) Load Balancer (listening port 80)

<b>template4.json</b>: 1 public EC2 instance, 1 private EC2 instance (allowing to internet through NAT Instance). Both can use created s3 bucket
1) VPC ("VPC" 10.0.0.0/16), public subnet (10.0.0.0/24) and private subnet (10.0.1.0/24).
2) Public: Internet Gateway, attaching it to VPC, Route Table with Route (destination 0.0.0.0/0), Subnet association (with Route Table),Security Group for public instances (allow 80 and 22)
3) Private: Route Table with Route (destination 0.0.0.0/0 throw Nat Instance), Subnet association (with Route Table),Security Group for private instances (inbound 22 from 10.0.0.0/24, outbound ping,80,443 to 0.0.0.0/0)
4) Security Group for Nat Instance (inbound 80,443,ping from 10.0.1.0/24 and 22 0.0.0.0/0, outbound 80,443,ping from 0.0.0.0/0 and 22 10.0.1.0/24)
6) S3 Bucket ("myS3Bucket")
7) IAM Role ("InstRole" with "Service": "ec2.amazonaws.com")
8) Policy ref. IAMRole ("RolePolicies", which allow show list of s3 buckets, but use only "myS3Bucket")
9) InstanceProfile ref. IAMrole ("InstanceS3Profile")
10) EC2 Instance (with mapping of 10gb magnetic volumes, ref. Instance Profile for managing S3 Bucket) in public subnet with Elastic IP
11) EC2 Instance (with mapping of 10gb magnetic volumes, ref. Instance Profile for managing S3 Bucket) in private subnet with Elastic IP
12) NAT Instance in public subnet

<b>template5.json</b>: 3 public subnets with auto scaling instances behind load balancer
1) VPC ("myVPC" 10.0.0.0/16) and 3 public subnets (10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24 with different availability zones) in it.
2) Internet Gateway and attaching it to VPC
3) Route Table with Route (destination 0.0.0.0/0)
4) Subnets association (with Route Table) 
5) Security Group for public instances (allow 80 with Load Balancer Security Group as source and allow 22)
6) S3 Bucket ("myS3Bucket")
7) IAM Role ("InstRole" with "Service": "ec2.amazonaws.com")
8) Policy ref. IAMRole ("RolePolicies", which allow show list of s3 buckets, but use only "myS3Bucket")
9) InstanceProfile ref. IAMrole ("InstanceS3Profile")
10) Load Balancer with cross-zone
11) Auto Scaling Group with max/min/desired capacity 2
12) Launch Configuration with installing NGINX, opening ports on firewall, custom root EBS volumes and Instance Profile for access to s3 bucket

<hr>
<b>Check how S3 works from instances</b>
install awscli #on instance<br>
ec2instance$ aws s3 ls<br>
ec2instance$ aws s3 sync s3://<path_to_file> . <br>

<hr>
<b>Check how NAT works</b>
 local_machine$ ssh -i awskeytest.pem ec2-user@nat_instance<br>
 nat_instance$ create awskeytest.pem<br>
 nat_instance$ ping google.by #test ping -1 route in nat instance security group<br>
 private_instance$ ssh -i awskeytest.pem centos@private_instance<br>
 private_instance$ ping google.by  #test ping -1 route in private instance security group<br>
 private_instance$ curl ipinfo.io/ip # check, if get nat instance public ip, mean works<br>
 
 <hr>
 <b>Issues</b>
 I1. An error occurred (InsufficientCapabilitiesException) when calling the CreateStack operation: Requires capabilities : [CAPABILITY_IAM]<br>
 S1. use --capabilities CAPABILITY_IAM flag with aws cloudformation clis<br>
 I2. Can't attach new root volumes<br>
 S2. use "BlockDeviceMappings" or manually: stop instance->deattach old volume->attach new