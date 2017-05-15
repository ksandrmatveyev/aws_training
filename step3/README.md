# step2
Gateway machine
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
  - routing & netfilter
    - machines from private network 1 and 2 can access to each other
    - machines from private network 2 can access to internet
    - restrict access from network 2 to google.com and logging all attempts to do that
  - rsyslog
    - receive logs from all nodes and store in /opt/logs/<ip-or-host>/<date>/<logfile> 
  - SSH
    - write a script to generate new ssh keys and deploy them to the app nodes (from the cron job, every 15 minutes)
    - script should change the ssh-keys if there are no ssh connections
    
Application machines (app1 and app2)
  - DHCP client
  - interfaces
    - all network settings are received from the DHCP server
    - app1 SUBNET 192.168.10.0/26
    - app2 SUBNET 10.0.0.0/26
  - here are events to store and send on log server
    - http requests (from iptables)
    - ssh authorization
    - gateway is not available (write a script to determine this event and run the script from the cron job; every minute)
configure logrotate to compress logs and delete logs older than one week

