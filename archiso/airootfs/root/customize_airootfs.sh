#!/bin/bash

# exit on error and undefined variables
set -eu ;

# fix iptables global (v4/v6 both)
rm -f /etc/iptables/empty.rules ;
ln -snf /etc/iptables/blackarch-v4v6.rules /etc/iptables/empty.rules ;

# optimize png,jpg images
if [ -f /usr/bin/oxipng ] ; then
    find / -type f -name '*.*' 2> /dev/null |grep -E '[pP][nN][gG]$' |xargs -I@ -P$(($(nproc) + 2)) oxipng -o 6 --strip all --alpha '@' ||true ;
fi ;

if [ -f /usr/bin/jpegoptim ] ; then
    find / -type f -name '*.*' 2> /dev/null |grep -E '[jJ][pP][eE]?[gG]$' |xargs -I@ -P$(($(nproc) + 2)) jpegoptim -m40 --strip-all '@' ||true ;
fi ;

# imagemagick grayscaled mogrify (but to svg completely something wrong)
# those parallel should 'nproc'
if [ -f /usr/bin/MagickCore-config ] ; then
    find / -type f -name '*.*' 2> /dev/null |grep -E -e '[xX][pP][mM]$' -e '[pP][nN][gG]$' -e '[jJ][pP][eE]?[gG]$' |xargs -I@ -P$(($(nproc) + 2)) mogrify -depth 2 -colorspace gray -normalize '@' ||true ;
fi ;

# DO NOT include kernel-src already builded (troublesome!)
find /usr/src -mindepth 1 -type d -name 'build' -or -name 'patches' -or -name 'src' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/lib/modules -mindepth 3 -maxdepth 3 |grep -v -e 'include' -e 'tools' -e '\.config' -e 'System.map' -e 'Module.symvers' |grep -v -e '/kernel/' -e '/updates/' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/lib/modules/*/ -mindepth 1 -maxdepth 1 -type f |grep -e 'vm*x*' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# remove archiso hooks for copy kernel(vmlinux) during calamares process (but no renew 'mkinitcpio -P')
find /etc/mkinitcpio.d -type f -name "*.preset" |xargs -I@ sed -i "/PRESETS/s/\'archiso\'//g" '@' ;

# DANGER: single listing remove all firmwares excepts nl80211(netlink),wireless
# THIS MAY ONLY EFFECTIVE ON SPECIFIC BUILDED KERNEL FROM ARCHLINUX-REPOSITORIES !!
# (have a possibility a process of initramfs cannot stat)
# edit or comment out line if cause problems.
# examples XXX folder's depth-zero files must single listing.
#find /usr/lib/firmware/XXX -mindepth 0 -type f |xargs -I@ -P1 rm -rf '@' ||true ;
# v excepts method.
find /usr/lib/firmware -mindepth 1 -maxdepth 1 -type d |grep -v -e 'ath*k$' -e 'brcm' -e 'e100' -e 'rtl*' -e 'rtw*' -e 'RTL8*' -e 'iwl*' -e 'ipw*' |xargs -I@ -P30 rm -rf '@' ||true ;
# depth zero files but remains realtek&intel-wireless seems not bad.
find /usr/lib/firmware -mindepth 1 -maxdepth 1 -type f |grep -v -e 'ath*k$' -e 'brcm' -e 'e100' -e 'rtl*' -e 'rtw*' -e 'RTL8*' -e 'iwl*' -e 'ipw*' |xargs -I@ -P30 rm -rf '@' ||true ;
# remove remained-bloat.
find /usr/lib/firmware/edgeport -mindepth 0 -type f |xargs -I@ -P1 rm -rf '@' ||true ;
find /usr/lib/firmware/microchip -mindepth 0 -type f |xargs -I@ -P1 rm -rf '@' ||true ;
find /usr/lib/firmware/rockchip -mindepth 0 -type f |xargs -I@ -P1 rm -rf '@' ||true ;
# should static link, remove depth-one links.
find /usr/lib/firmware -mindepth 1 -maxdepth 1 -type l |xargs -I@ -P30 rm -rf '@' ||true ;

# unneed (waste time when 'archiso' runs)
find /usr/lib -mindepth 1 -maxdepth 1 -type d |grep -e 'bellagio*' -e 'gobject*' -e 'gprof*' -e 'guile*' -e 'girepository.*' -e 'gobject.*' -e 'ffmpeg.*' -e 'ruby*' -e 'itcl*' -e 'tcl.*' -e 'tdbc*' -e 'geoclue.*' -e 'lilo*' -e 'grub*' -e 'openmpi*' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
# delete gz on man(manual-pages) excepts man5
#find '/usr/share/man' -type f -name '*.gz' |grep -v 'man5' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# delete pcf.gz on fonts
find /usr/share/fonts -type f -name "*ISO*-1*.pcf.gz" |grep -vE "[[:alnum:]]*-1" |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# delete background (vs kde, gnome)
find /usr/share/backgrounds -mindepth 1 -maxdepth 1 -type d -! -name 'xfce' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# set locale
if [ -f /usr/bin/locale-gen ]; then
    #sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen ;
    locale-gen ;
fi ;

# delete complex locale (remains uk(en_GB),eu,ja,nb,sv only)
find /usr/share/locale -mindepth 1 -maxdepth 1 -type d |grep -v -e 'en$' -e 'en_GB' -e 'en_US' -e 'ja$' -e 'sv$' -e 'uk$' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
#find /usr/share/locale -mindepth 1 -maxdepth 1 -type d |grep -e '^ca' -e '^de' |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/X11/locale -mindepth 1 -maxdepth 1 -type d |grep -v -e 'C$' -e '8859-1$' -e 'en$' -e 'en_' -e 'ja$' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# delete include
find /usr/include -mindepth 2 -maxdepth 2 |grep -v \
                          -e '/asm/' -e '/bits/' -e '/blockdev/' -e '/bsd/' -e '/c++/' \
                          -e '/dnet/' -e '/dns/' -e '/gnu/' -e '/net/' -e '/sys/' \
                         |rev |cut -d '/' -f2- |rev |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/include -mindepth 1 -maxdepth 1 -type f |grep -v \
                          -e 'complex.h' -e 'ctype.h' -e 'features.h' \
                          -e 'fenv.h' -e 'inttypes.h' -e 'limits.h' \
                          -e 'math.h' -e 'regex.h' -e 'search.h' \
                          -e 'stdint.h' -e 'stdio.h' -e 'stdlib.h' \
        -e 'tgmath.h' -e 'utils.h' -e 'wchar.h' -e 'wctype.h' \
                          |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;

# delete complex xml
find /usr/share/xml/docbook -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/xml/pskc -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;

# delete zsh site-functions (OR some fixes from them)
find /usr/share/zsh/site-functions -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;

# delete optional weakness from make-deps
find /usr/share/licenses -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/poppler -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/vala -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/wayland-protocols -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/share/WebP -mindepth 1 -maxdepth 1 |xargs -I@ -P30 rm -rf '@' ||true ;

# unneeded dirs {.git}, files {*.patch} because no compile in most cases
find / -type d -name '\.git' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find / -type d -name '\.github' |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find / -type f -name "*.patch" |sort -V |uniq |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/lib32 -type f |xargs -I@ -P30 rm -rf '@' ||true ;
find /usr/lib32 -type l |xargs -I@ -P30 rm -rf '@' ||true ;

echo "removing unnecessary parallel, wait about 30 sec. (Please see script)" ;
sleep 30 ;

# copy config files to skel
if [ -d /usr/share/blackarch/config ] ; then
    # /etc
    #echo 'BlackArch Linux' > /etc/arch-release ;

    # setup user
    #useradd -m -g users -G wheel,power,audio,video,storage -s /bin/zsh liveuser ;
    #echo "liveuser:blackarch" | chpasswd ;
    #ln -snf /usr/share/icons/blackarch-icons/apps/scalable/distributor-logo-blackarch.svg /home/liveuser/.face ;
    #mkdir -p /home/liveuser/Desktop ;
    #chown -R liveuser:users /home/liveuser/Desktop ;
    #chmod -R 755 /home/liveuser/Desktop ;

    #if [ -f /usr/bin/calamares ] ; then
    #    ln -snf /usr/share/applications/calamares.desktop /home/liveuser/Desktop/calamares.desktop ;
    #    sed -i -e "s|Install System|Install BlackArch|g" /usr/share/applications/calamares.desktop ;
    #    ln -snf /usr/share/applications/xfce4-terminal-emulator.desktop /home/liveuser/Desktop/terminal.desktop ;
    #fi ;
    #find /home/liveuser/Desktop/ -name "*.desktop" |xargs -n1 chmod +x ||true ;

    # vim
    if [ -f /home/liveuser ] ; then
        if [ -f /usr/bin/vim ] ; then
            cp -r /usr/share/blackarch/config/vim/vim /home/liveuser/.vim ;
            cp /usr/share/blackarch/config/vim/vimrc /home/liveuser/.vimrc ;
        fi ;
    fi ;

    cat /usr/share/blackarch/config/bash/bashrc > /etc/skel/.bashrc ;
    cat /usr/share/blackarch/config/bash/bash_profile > /etc/skel/.bash_profile ;
    cat /usr/share/blackarch/config/zsh/zshrc > /etc/skel/.zshrc ;
fi ;

# disable pc speaker beep
#echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf ;

# disable network stuff ??
#rm -f /etc/udev/rules.d/81-dhcpcd.rules ;
#systemctl disable dhcpcd sshd rpcbind.service ;

# font configuration
ln -snf /etc/fonts/conf.avail/* /etc/fonts/conf.d ;
rm -f /etc/fonts/conf.d/05-reset-dirs-sample.conf ;
rm -f /etc/fonts/conf.d/09-autohint-if-no-hinting.conf ;

# create the user directory for live session
if [ ! -d /root ]; then
    mkdir -p /root ;
    chmod 700 /root && chown -R root:root /root ;
fi ;

# copy files over to home
cp -r /etc/skel/. /root/. ;

# remove special (not needed) files
rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf ;
rm -f /root/{.automated_script.sh,.zlogin} ;

# setting root password
echo "root:blackarch" |chpasswd ;

# repo + database
#curl -s https://blackarch.org/strap.sh |sh ;

# enabling all mirrors
#sed -i "s|#Server|Server|g" /etc/pacman.d/mirrorlist ;

# pacman init
pacman -Syy --noconfirm ;
pacman-key --init ;
pacman-key --populate ;

# pacman db cache
pacman -Fyy ;
pacman-db-upgrade ;

# set timezone
ln -snf /usr/share/zoneinfo/UTC /etc/localtime ;

# storing the system journal in RAM
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf ;

# default releng configuration
sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf ;
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf ;
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf ;

# enable useful services and display manager
enabled_services=('dbus' 'ip6tables' 'iptables'
       'systemd-networkd' 'systemd-resolved' 'systemd-timesyncd'
       'NetworkManager'
       'choose-mirror' 'pacman-init')
systemctl enable ${enabled_services[@]} ;
#masking_services=('tor' 'systemd-timesync')
#systemctl mask ${masking_services[@]} ;
systemctl set-default graphical.target ;

# temporary fixes for ruby based tools
if [ -f /usr/bin/whatweb ] ; then
    pushd /usr/share/whatweb ;
    rm -f Gemfile.lock ;
    bundle config build.nokogiri --use-system-libraries ;
    bundle install --path vendor/bundle;
    rm -f Gemfile.lock ;
    popd ;
fi ;

# change default jdk ??
#archlinux-java set java-20-openjdk ;

# Temporary fix for calamares
#pacman -U --noconfirm https://archive.archlinux.org/packages/d/dosfstools/dosfstools-4.1-3-x86_64.pkg.tar.xz ;

# GDK Pixbuf
if [ -f /usr/bin/gdk-pixbuf-query-loaders ] ; then
    gdk-pixbuf-query-loaders --update-cache ||true ;
fi ;

# final line searching cost dynamic programs
echo "show with frequency, currently all-visible deps from your PKGM they are not static linking" ;
find /{usr,}/{include,slib,lib,libexec,sbin,bin,src,share} -mindepth 1 -perm /+x -executable -type f 2> /dev/null \
        |grep -vE ".+[[:alpha:]]{2,}$" |xargs -I@ -P30 realpath '@' |xargs -I@ -P30 objdump -x '@' 2> /dev/null \
        |grep -B -0 -A 20 -E "file format|NEEDED|required from" \
        |grep -vE "^,|^--|no symbols|INI|SYM|LIBC|file format|align 2|address|Idx|.(bss|text|rodata|data|hash)|__ksym | 0x00 | (|R_{[[:alnum:]],}) |(architecture|Sections|Program Header|Version References):" \
        |grep -vE '^( |      |$|\\.|\\n|[[:alnum:]])' |sort -u \
        |xargs -I@ -P 30 pacman -Qo '@' 2> /dev/null \
        |rev |cut -d" " -f2 |rev |sort |uniq -c |sort -n ||true ;
sleep 15 ;

# delete pacman local cache
if [ -f /usr/bin/yay ] ; then
    yes |yay -Scc ;
fi ;
yes |pacman -Scc ;

# flush io cache
sync ;
