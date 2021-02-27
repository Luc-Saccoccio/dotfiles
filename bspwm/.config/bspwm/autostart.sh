#!/bin/bash

# ┏━━━┓━━━━━┏┓━━━━━━━━━━┏┓━━━━━━━━━━┏┓━━━━━
# ┃┏━┓┃━━━━┏┛┗┓━━━━━━━━┏┛┗┓━━━━━━━━┏┛┗┓━━━━
# ┃┃━┃┃┏┓┏┓┗┓┏┛┏━━┓┏━━┓┗┓┏┛┏━━┓━┏━┓┗┓┏┛┏━━┓
# ┃┗━┛┃┃┃┃┃━┃┃━┃┏┓┃┃━━┫━┃┃━┗━┓┃━┃┏┛━┃┃━┃━━┫
# ┃┏━┓┃┃┗┛┃━┃┗┓┃┗┛┃┣━━┃━┃┗┓┃┗┛┗┓┃┃━━┃┗┓┣━━┃
# ┗┛━┗┛┗━━┛━┗━┛┗━━┛┗━━┛━┗━┛┗━━━┛┗┛━━┗━┛┗━━┛
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#######
# TMP #
#######
mkdir /tmp/qutebrowser

##################
# Usual cleaning #
##################
rm -f ~/.python_history
rm -f ~/.lesshst ~/.wget-hsts
xdg-xmenu > ~/.cache/xmenu &

##########
# Basics #
##########

systemctl --user import-environment DISPLAY # To permit to dunst to work
setxkbmap -layout fr # Put the keyboard in azerty
xmodmap "$HOME/.Xmodmap" # Custom keyboard mappings
xsetroot -cursor_name left_ptr # Basic cursor and not a cross
pgrep sxhkd || sxhkd & # Start Simple Hotkey Daemon
"$HOME/.fehbg" # Restore last wallpaper
# "$HOME"/.local/bin/random-wall # Random wallpaper
xrdb ~/.Xresources # colors


#########################
# Programs to autostart #
#########################

pgrep picom || picom -b --dbus & # Compositor
pgrep polybar || "$HOME"/.config/polybar/launch.sh & # Polybar
echo > Images/wallpapers/.wall-list # Recreate wall list
pgrep xautolock || xautolock -locker "$HOME/.local/bin/i3lock-blue.sh" -time 15 & # Autolock
pgrep mpd || mpd & # Music Player Daemon
"$HOME"/.local/bin/pulse-volume-watcher.py | xob & # Volume Watcher

###########
# Applets #
###########

pgrep nm-applet || nm-applet & # Network Manager
pgrep clipmenud || clipmenud & # Dmenu clipboard
pgrep udiskie || udiskie -t & # Udiskie automount

####################
# GUI Applications #
####################

pgrep Discord || discord & # Discord
sleep 2; pgrep vimus    || st -n "vimus" -c"vimus" -e vimus & bspc rule -a vimus:vimus desktop='^1' &
sleep 2; pgrep newsboat || st -n "newsboat" -c "newsboat" -e newsboat & bspc rule -a newsboat:newsboat desktop='^10' &
sleep 2; pgrep calcurse || st -n "calcurse" -c "calcurse" -e calcurse & bspc rule -a calcurse:calcurse desktop='^9' &
"$HOME"/.local/bin/updates & # Check for updates
