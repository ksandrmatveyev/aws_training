#!/bin/bash
sudo iptables -A FORWARD -i eth1 -o eth0 -j REJECT &&\
sudo iptables -A FORWARD -i eth0 -o eth1 -j REJECT &&\
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
