#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xset s off

xset +fp /usr/share/fonts/local
xset fp rehash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && source "$f"
  done
  unset f
fi

# Load config files
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# No beep
xset -b
