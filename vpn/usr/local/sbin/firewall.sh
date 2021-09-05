#!/bin/bash
# A very basic IPtables / Netfilter script /etc/firewall/enable.sh

PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

#systemctl set-default multi-user.target
#systemctl set-default graphical.target

#clean up all rules first
#iptables -P INPUT ACCEPT
#iptables -P FORWARD ACCEPT
#iptables -P OUTPUT ACCEPT
#iptables -t nat -F
#iptables -t mangle -F
#iptables -F
#iptables -X

/usr/bin/touch /root/RUNNING_FIREWALL_IPTABLES_NOW

# Flush the tables to apply changes
/sbin/iptables -F

# Default policy to drop 'everything' but our output to internet
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P INPUT   ACCEPT
/sbin/iptables -P OUTPUT  ACCEPT

# Allow established connections (the responses to our outgoing traffic)
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow local programs that use loopback (Unix sockets)
/sbin/iptables -A INPUT -s 127.0.0.0/8 -d 127.0.0.0/8 -i lo -j ACCEPT

/sbin/iptables -t nat -A POSTROUTING -o enp2s0 -j MASQUERADE
/sbin/iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i ztklhsm3zp -o enp2s0 -j ACCEPT

exit 0

