#!/bin/sh
# A very basic IPtables / Netfilter script /etc/firewall/enable.sh

PATH='/sbin'

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X
#exit 0


# Flush the tables to apply changes
iptables -F

# Default policy to drop 'everything' but our output to internet
iptables -P FORWARD DROP
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT

# Allow established connections (the responses to our outgoing traffic)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow local programs that use loopback (Unix sockets)
iptables -A INPUT -s 127.0.0.0/8 -d 127.0.0.0/8 -i lo -j ACCEPT

# Uncomment this line to allow incoming SSH/SCP conections to this machine,
# for traffic from 192.168.1.1 (you can use also use a network definition as
# source like 192.168.1.0/24).
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 8080 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 2022 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p udp --dport  137 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p udp --dport  138 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport  139 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport  445 -m state --state NEW -j ACCEPT

#10.147.20.0/24 is zero-tier
# Allow UDP 9993 on eth0 (required for ZeroTier)
iptables --append INPUT -s 10.147.20.0/24 --protocol udp --dport 9993 --jump ACCEPT
iptables --append OUTPUT --protocol udp --dport 9993 --jump ACCEPT
iptables -A INPUT  -s 10.147.20.0/24 -p tcp --dport 2022 -m state --state NEW -j ACCEPT




# Edit me Allow to create/ESTABLISH outgoing connections.
#iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p udp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

