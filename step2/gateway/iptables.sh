#!/bin/bash
iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT &&\
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT &&\
iptables -A FORWARD -i eth1 -o eth0 -j REJECT &&\
iptables -A FORWARD -i eth0 -o eth1 -j REJECT &&\
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
