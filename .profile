# Profile file. Runs on login. Environmental variables are set here


# Defaults Programs
export EDITOR="/usr/bin/nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export PAGER="less -r"
export MANPAGER="man-pager"

# Hardware Acceleration
export LIBVA_DRIVER_NAME="nouveau"
export VDPAU_DRIVER="nouveau"
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_X11_EGL=1

# Path
export PATH=/home/luc/.opam/default/bin:/home/luc/.local/share/cargo/bin:/home/luc/.local/share/go/bin:/home/luc/.local/share/gem/ruby/3.0.0/bin:/home/luc/.TinyTeX/bin/x86_64-linux:/home/luc/.local/bin:$PATH

# Useful directories
export WALLPAPER="/home/luc/Images/wallpapers"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--layout=reverse --preview-window right:70%'

# NNN
export NNN_LOCKER="binarix"
export NNN_PLUG='p:preview-tabbed;P:preview-tui'

# Cleanup
export TERMINFO="$HOME/.locah/share/terminfo"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="/dev/null"
export PULSE_COOKIE="$HOME/.cache/pulse-cookie"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export QT_QPA_PLATFORMTHEME=gtk2
