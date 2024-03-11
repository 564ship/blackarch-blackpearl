#!/usr/bin/env bash
iso_name="blackarch-linux"
iso_label="BLACKARCH_$(date +%Y%m)"
iso_publisher="BlackArch Linux <https://www.blackarch.org/>"
iso_application="BlackArch Linux ISO"
iso_version="$(date +%Y.%m.%d)"
install_dir="blackarch"
buildmodes=('iso')
##systemd-boot
bootmodes=(
  'bios.syslinux.mbr' 'bios.syslinux.eltorito'
  'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
  'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito'
)
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-b' '1M' '-comp' 'zstd'
  '-Xcompression-level' '22 -T0 --ultra -zstd=wlog=30,clog=23,hlog=22,slog=29,mml=3,strat=9'
  '-not-reproducible' '-one-file-system' '-xattrs' '-wildcards' '-noappend' '-progress'
  '-e'
    'dev' 'sys' 'proc' 'run' 'tmp' 'boot'
    'usr/man'
    'usr/share/archiso'
    'usr/share/bash-completion'
    'usr/share/doc'
    'usr/share/gtk-doc'
    'usr/share/guile'
    'usr/share/help'
    'usr/share/info'
    'usr/share/licenses'
    'usr/share/man'
    'usr/share/zoneinfo-leaps'
    'var/cache/pacman/pkg'
    'var/lib/pacman/sync'
    'var/log/journal'
    'etc/group-'
    'etc/passwd-'
    'etc/gshadow'
    'etc/shadow-'
)
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/etc/passwd"]="0:0:640"
  ["/etc/group"]="0:0:640"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
)
