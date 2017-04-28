<b># linux Task</b><br>
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

<b>#Solution</b><br>
Up 3 machines with predefined but not configured network interfaces:<br>
	○ gateway<br>
	○ app1<br>
	○ app2<br>
Configured Gateway:<br>
	○ enable ipv4 forwarding using file, which added "sysctl.d" folder<br>
	○ added two network interfaces (192.168.10.50 and 10.0.0.45) using files, which added to "interfaces.d" folder<br>
	○ restart VM<br>
	○ added iptables rules:<br>
		○ ○ -A FORWARD -i eth1 -o eth2 -j ACCEPT<br>
		○ ○ -A FORWARD -i eth2 -o eth1 -j ACCEPT<br>
Configured APP1:<br>
	○ added network interface (ip 192.168.10.51 with gateway 192.168.10.50) using file, which added to "interfaces.d" folder<br>
	○ restart VM<br>
Configured APP2:<br>
	○ added network interface (ip 10.0.0.46 with gateway 10.0.0.45) using file, which added to "interfaces.d" folder<br>
	○ restart VM<br>
Ran ping or ssh<br>

