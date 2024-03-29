# Welcome message
cat << EOF
No gods, no masters. Property is theft. Anarchy is order !
EOF

autoload -U colors && colors
setopt PROMPT_SUBST
# Prompt
## Base
PS1='%B%{$fg[red]┌─<%}%{$fg[blue]%}%n%{$fg[magenta]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}in %{$fg[green]%}%~%{$fg[red]%}>
└─<'
## Git
PS1+='%{$fg[magenta]%}$(smartpath 2> /dev/null)%{$fg[red]%}'
## End
PS1+='>──%{$fg[yellow]%}»%b '

# ZSH History
HISTFILE=~/.cache/zshistory
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_SPACE

# Load aliases
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Yank to system register
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Handle specials keys (ctrl+arrows, home, end, del)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -v '^?' backward-delete-char
bindkey "^[[P" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line

export KEYTIMEOUT=1

# ZSH Vi indicator
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

source /home/luc/.config/zsh/completions
source /usr/share/fzf/key-bindings.zsh

# opam configuration
test -r /home/luc/.opam/opam-init/init.zsh && . /home/luc/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# ghcup configuration
[ -f "/home/luc/.local/share/ghcup/env" ] && source "/home/luc/.local/share/ghcup/env" # ghcup-env
# vim: ft=zsh
