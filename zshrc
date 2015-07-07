autoload -U colors && colors
PS1="%{${fg[cyan]}%}%B[%{${fg[green]}%}%m%{${fg[cyan]}%}] %b%{${fg[default]}%}"
RPROMPT="%{${fg[cyan]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"

autoload -U compinit
compinit
zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true

typeset -ga precmd_functions
typeset -ga preexec_functions

source $HOME/dotfiles/auto_title_screens
source $HOME/dotfiles/anyshrc
