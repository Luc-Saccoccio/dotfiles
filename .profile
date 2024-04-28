# Profile file. Runs on login. Environmental variables are set here


# Defaults Programs
export EDITOR="/usr/bin/nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export PAGER="less -r"
export MANPAGER="man-pager"

# Hardware Acceleration
# export LIBVA_DRIVER_NAME="nouveau"
# export VDPAU_DRIVER="nouveau"
# export MOZ_DISABLE_RDD_SANDBOX=1
# export MOZ_X11_EGL=1

# Path & MAN
export PATH=/home/luc/.local/share/opam/default/bin:/home/luc/.local/share/cargo/bin:/home/luc/.local/share/go/bin:/home/luc/.local/share/gem/ruby/3.0.0/bin:/home/luc/.local/bin:/home/luc/.local/share/elan/bin:$PATH
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH


# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
# export XDG_RUNTIME_DIR="/run/user/$UID"

# Useful directories
export WALLPAPER="/home/luc/images/wallpapers"
export TEXMFHOME="$XDG_DATA_HOME/texmf"

# FZF
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout=reverse --preview-window right:70%"

# NNN
export NNN_LOCKER="binarix"
# export NNN_OPENER="/home/luc/.config/nnn/plugins/nuke"
export NNN_PLUG='p:preview-tui;P:preview-tabbed'

# Haskell
export GHCUP_USE_XDG_DIRS="yes"

# Cleanup
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export ELAN_HOME="$XDG_DATA_HOME/elan"
export FCEUX_HOME="$XDG_CONFIG_HOME/fceux"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export HISTFILE="$XDG_CACHE_HOME/bash/history"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export LESSHISTFILE="/dev/null"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsyncrc"
export MINETEST_USER_PATH="$XDG_DATA_HOME/minetest"
export OPAMROOT="$XDG_DATA_HOME/opam"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PULSE_COOKIE="$HOME/.cache/pulse-cookie"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYTHONSTARTUP="/etc/python/pythonrc"
export QT_QPA_PLATFORMTHEME=gtk2
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite_history"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export TERMINFO="$HOME/.locah/share/terminfo"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
export W3M_DIR="$XDG_DATA_HOME/w3m"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export XAUTHORITY="$XDG_CONFIG_HOME/X11/Xauthority"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export ZDOTDIR="$HOME/.config/zsh"

# FIXME
# export XDG_RUNTIME_DIR="/run/user/1000"
