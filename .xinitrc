#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Bind the right Alt key to Mod4
xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group

exec dwm

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

# xrandr --auto --dpi 96
# setxbmap pl
# xrdb -load $XDG_CONFIG_HOME/X11/Xresources
# setxkbmap -option keypad:pointerkeys
# echo "GPU $(glxinfo | grep -Fxq 'OpenGL vendor string: NVIDIA Corporation' && echo 'NVIDIA' || echo 'INTEL')" >> "$TMPFLAGS"
# [ -x "$(command -v prime-offload)" ] && prime-offload

# exec i3


# from xprofile -------------
# Fix Gnome Apps Slow  Start due to failing services
# Add this when you include flatpak in your system
# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# mpd &			# music player daemon-you might prefer it as a service though
# remaps &		# run the remaps script, switching caps/esc and more; check it for more info
# setbg &			# set the background with the `setbg` script
# #xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &	# Uncomment to use Xresources colors/settings on startup
# xcompmgr &		# xcompmgr for transparency
# dunst &			# dunst for notifications
# xset r rate 300 50 &	# Speed xrate up
# unclutter &		# Remove mouse when idle
