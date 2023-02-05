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
export PATH=/home/luc/.local/share/opam/default/bin:/home/luc/.local/share/cargo/bin:/home/luc/.local/share/go/bin:/home/luc/.local/share/gem/ruby/3.0.0/bin:/home/luc/.TinyTeX/bin/x86_64-linux:/home/luc/.local/bin:/home/luc/.cabal/bin:$PATH
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH

# Useful directories
export WALLPAPER="/home/luc/Images/wallpapers"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--layout=reverse --preview-window right:70%'

# NNN
export NNN_LOCKER="binarix"
export NNN_PLUG='p:preview-tabbed;P:preview-tui'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
# export XDG_RUNTIME_DIR="/run/user/$UID"

# Cleanup
export PYTHONSTARTUP="/etc/python/pythonrc"
export MBSYNCRC="$XDG_CONFIG_HOME"/mbsyncrc
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
export HISTFILE="${XDG_CACHE_HOME}/bash/history"
export XAUTHORITY="$XDG_CONFIG_HOME/X11/Xauthority"
export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export PYLINTHOME="${XDG_CACHE_HOME}"/pylint
export TERMINFO="$HOME/.locah/share/terminfo"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="/dev/null"
export PULSE_COOKIE="$HOME/.cache/pulse-cookie"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export FCEUX_HOME="$XDG_CONFIG_HOME/fceux"
export OPAMROOT="$XDG_DATA_HOME/opam"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite_history"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export ZDOTDIR=$HOME/.config/zsh
export QT_QPA_PLATFORMTHEME=gtk2
export PYTHONSTARTUP="/etc/python/pythonrc"

export HUNT=name=Hilde,host=puffypenguin.cyb.no
