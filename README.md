# step1
previous task

# step2
- Gateway machine  
  - DHCP server
    - gateway network is configured manually
    - app machine networks are configured via DHCP
  - DNS server
    - gateway machine has to hostname gateway.training.com
    - gateway hostname should resolved from each private subnet
    - other hostnames have to resolve the default DNS server from public network (Interface1)
  - interfaces
    - Interface1, public network with access to internet
    - Interface2, private network 1, IP: 192.168.10.50, SUBNET MASK: 192.168.10.0/26
    - Interface3, private network 2, IP: 10.0.0.45, SUBNET MASK: 10.0.0.0/26
  - iptables
    - machines from private network 1 and 2 can access to each other
    - machines from private network 2 can access to internet
- Application machines (app1 and app2)
  - DHCP client
  - interfaces
    - all network settings are received from the DHCP server
    - app1 SUBNET 192.168.10.0/26
    - app2 SUBNET 10.0.0.0/26

