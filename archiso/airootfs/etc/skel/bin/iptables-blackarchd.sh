#!/usr/bin/bash

##RESET
iptables --flush ;

##PRESET
iptables -P INPUT DROP ;
iptables -P OUTPUT DROP ;
iptables -P FORWARD DROP ;

## ipv4-ICMP NEW
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT ;

##INPUT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT ;
iptables -A INPUT -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_INPUT -j ACCEPT ;
iptables -A INPUT -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
iptables -A INPUT -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
##OUTPUT
iptables -A OUTPUT -m owner --uid-owner 1000:2000 -j ACCEPT ;
iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT ;
iptables -A OUTPUT -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_OUTPUT -j ACCEPT ;
iptables -A OUTPUT -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
iptables -A OUTPUT -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
##FORWARD
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT ;
iptables -A FORWARD -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_FORWARD  -j ACCEPT ;
iptables -A FORWARD -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
iptables -A FORWARD -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
iptables-save > /etc/iptables/iptables.rules ;
