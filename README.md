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


