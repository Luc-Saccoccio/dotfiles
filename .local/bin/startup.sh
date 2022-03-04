#!/bin/sh

xsetroot -cursor_name left_ptr
xrdb ~/.Xresources
dwmblocks &
# random-wall
picom -b &
"$HOME"/.local/bin/pulse-volume-watcher.py | xob &
systemctl --user import-environment DISPLAY
setxkbmap -layout fr -variant azerty
xmodmap "$HOME/.Xmodmap"
"$HOME/.fehbg"
pgrep nm-applet || nm-applet &
pgrep clipmenud || clipmenud &
pgrep udiskie || udiskie -t &
pgrep xscreensaver || xscreensaver &
echo > Images/wallpapers/.wall-list
