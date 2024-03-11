#!/bin/bash
readonly LIBC_LOCALE="C.UTF-8" ;
readonly LC_CTYPE="${LIBC_LOCALE}" ;
readonly LC_NUMERIC="${LIBC_LOCALE}" ;
readonly LC_TIME="${LIBC_LOCALE}" ;
readonly LC_COLLATE="${LIBC_LOCALE}" ;
readonly LC_MONETARY="${LIBC_LOCALE}" ;
readonly LC_MESSAGES="${LIBC_LOCALE}" ;
readonly LC_PAPER="${LIBC_LOCALE}" ;
readonly LC_NAME="${LIBC_LOCALE}" ;
readonly LC_ADDRESS="${LIBC_LOCALE}" ;
readonly LC_TELEPHONE="${LIBC_LOCALE}" ;
readonly LC_MEASUREMENT="${LIBC_LOCALE}" ;
readonly LC_IDENTIFICATION="${LIBC_LOCALE}" ;
readonly LC_ALL="${LIBC_LOCALE}" ;
pacman --noconfirm -Syu --needed base-devel archiso mkinitcpio-archiso git squashfs-tools ;
sleep 10 ;
findmnt ;
echo "[NOTICE] If any problem, please check or reboot now." ;
rm -rf ./work ;
rm -rf ./out ;
sleep 10 ;

# Temporary
rm -f ./archiso/packages_P.x86_64 ;
touch ./archiso/packages_P.x86_64 ;

# selective
cat ./archiso-mktemplate/profile/releng/packages-archiso-mk.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/kernel/packages-kernel-ogo.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/core/packages-unix.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/base/packages-esd.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/toolchain/packages-toolchain.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/dev-lang/packages-python.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/net/packages-nl.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/systemd/packages-systemd.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/blackarch/packages-blackarch-base.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/blackarch/packages-blackarch-tools-min.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/X/packages-xorg.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/gnu/packages-pgp.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/gnu/packages-mountgvfs.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/codecs/packages-codecs.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/audio/packages-paudio.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/extra/packages-wwwbrowse.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/extra/packages-cjkfont.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/extra/packages-vboxaccel.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/extra/packages-nvidiaX.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/wine/package-wine-base.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/packages-cli.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/packages-modernize.x86_64 >> ./archiso/packages_P.x86_64 ;

# Desktop 
#cat ./archiso-mktemplate/profile/desktop/packages-awesome.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-cinnamon.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-dde.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-dwm.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-fluxbox.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-gnome.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-hyprland.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-i3wm.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-kdeplasma.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-lxde.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-lxqt.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-mate.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-openbox.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-sway.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-wayfire.x86_64 >> ./archiso/packages_P.x86_64 ;
cat ./archiso-mktemplate/profile/desktop/packages-xfce.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/profile/desktop/packages-xmonad.x86_64 >> ./archiso/packages_P.x86_64 ;

# Installer (Optional)
#cat ./archiso-mktemplate/profile/calamares/packages-calamares-base.x86_64 >> ./archiso/packages_P.x86_64 ;

# Testing other packages '_onerous' folders if you could contact me...
#cat ./archiso-mktemplate/_onerous/AAA/packages-XXX.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/_onerous/alterlinux/packages-alter.x86_64 >> ./archiso/packages_P.x86_64 ;
#cat ./archiso-mktemplate/_onerous/skk/packages-skk.x86_64 >> ./archiso/packages_P.x86_64 ;

# Sort
cat ./archiso/packages_P.x86_64 |sort |uniq |sed '/^#/d' |sed '/^$/d' > ./archiso/packages.x86_64 ;
rm -f ./archiso/packages_P.x86_64 ;
# locale for both (FreeBSD/Python standard build) compat
LANG=en_GB.UTF-8 sudo mkarchiso -v ./archiso ;
rm -f ./archiso/package.x86_64 ;

# Exit
echo "[NOTICE] Exited. If you are on real host, please reboot now." ;
sleep 10 ;

# this ISO for lowRAM on VMs, should rename it.
find ./out -name 'blackarch*.iso' |xargs -I@ sudo rename x86_64 x86_64-lowMEM '@' ;
sleep 3 ;
