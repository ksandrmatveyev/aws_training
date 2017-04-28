# linux Task<br>
Gateway machine<br>
	- interfaces<br>
		○ with access to internet<br>
		○ 192.168.10.50/24<br>
		○ 10.0.0.45/24<br>
	- iptables<br>
		○ app1 and app2 machines can access each other<br>
Application machines (app1 and app2)<br>
	- interfaces<br>
		○ app1 subnet 192.168.10.0/24<br>
		○ app2 subnet 10.0.0.0/24<br>
default gateway: Gateway machine<br>

#Solution<br>
Up 3 machines with predefined but not configured network interfaces:
	gateway
	app1
	app2 
Configured Gateway:
	enable ipv4 forwarding using file, which added "sysctl.d" folder
	added two network interfaces (192.168.10.50 and 10.0.0.45) using files, which added to "interfaces.d" folder
	restart VM
	added iptables rules:
		-A FORWARD -i eth1 -o eth2 -j ACCEPT
		-A FORWARD -i eth2 -o eth1 -j ACCEPT
Configured APP1:
	added network interface (ip 192.168.10.51 with gateway 192.168.10.50) using file, which added to "interfaces.d" folder
	restart VM
Configured APP2:
	added network interface (ip 10.0.0.46 with gateway 10.0.0.45) using file, which added to "interfaces.d" folder
	restart VM
Ran ping or ssh

