#!/usr/bin/bash
pacman -Fyy ;
pacman-db-upgrade ;
yes |pacman -Scc ;
echo 3 > /proc/sys/vm/drop_cache ;
sleep 3 ;
sync ;