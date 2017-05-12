#!/bin/bash
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE &&\
sudo iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT &&\
sudo iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT
