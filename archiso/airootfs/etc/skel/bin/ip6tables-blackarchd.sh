#!/usr/bin/bash

##RESET
ip6tables --flush ;

##PRESET
ip6tables -P INPUT DROP ;
ip6tables -P OUTPUT DROP ;
ip6tables -P FORWARD DROP ;

## ipv6-ICMP NEW
ip6tables -A INPUT -p ipv6-icmp --icmpv6-type 8 -m conntrack --ctstate NEW -j ACCEPT ;

##INPUT
ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT ;
ip6tables -A INPUT -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_INPUT -j ACCEPT ;
ip6tables -A INPUT -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
ip6tables -A INPUT -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
##OUTPUT
ip6tables -A OUTPUT -m owner --uid-owner 1000:2000 -j ACCEPT ;
ip6tables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT ;
ip6tables -A OUTPUT -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_OUTPUT -j ACCEPT ;
ip6tables -A OUTPUT -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
ip6tables -A OUTPUT -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
##FORWARD
ip6tables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT ;
ip6tables -A FORWARD -m hashlimit --hashlimit 1/s --hashlimit-burst 4 --hashlimit-htable-expire 120000 --hashlimit-mode srcip,dstport --hashlimit-name t_hashlinit_FORWARD  -j ACCEPT ;
ip6tables -A FORWARD -m limit --limit 1/s --limit-burst 4 -j ACCEPT ;
ip6tables -A FORWARD -m recent --rcheck --seconds 150 --hitcount 5 -j ACCEPT ;
ip6tables-save > /etc/iptables/ip6tables.rules ;
