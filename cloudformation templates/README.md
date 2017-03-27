# aws_training
template1.json
inst2vol_elasIP2_s3_s3access_vpc1_pubsubnet3aval_intqw_routes

template2.json
inst2vol_elasIP2_s3_roots3access_vpc1_pubsubnet3aval_intqw_routes

template3.json
2instance_elasticIPs_s3_volumes_LB

template4.json
2instance_natinstance_elasticIP2_volumes_s3_roots3access_vpc1_pubsubnet
 local_machine$ ssh -i awskeytest.pem ec2-user@nat_instance
 nat_instance$ create awskeytest.pem
 nat_instance$ ping google.by #test ping -1 route in nat instance security group
 private_instance$ ssh -i awskeytest.pem centos@private_instance
 private_instance$ ping google.by  #test ping -1 route in private instance security group
 private_instance$ curl ipinfo.io/ip # check, if get nat instance public ip