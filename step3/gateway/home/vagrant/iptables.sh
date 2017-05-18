#! /bin/bash
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE &&\
sudo iptables -A FORWARD -i eth1 -o eth0 -j REJECT &&\
sudo iptables -A FORWARD -i eth0 -o eth1 -j REJECT &&\
sudo iptables -A FORWARD -i eth2 -o eth0 -m string --string "google.com" --algo kmp -j LOG --log-prefix "iptables: access denied " --log-level 7 &&\
sudo iptables -A FORWARD -i eth2 -o eth0 -m string --string "google.com" --algo kmp -j DROP &&\
sudo iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT &&\
sudo iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
