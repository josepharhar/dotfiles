autoload -U colors && colors
PS1="%{${fg[green]}%}%B[%{${fg[blue]}%}%m %{${fg[cyan]}%}%(7~,.../,)%6~%{${fg[green]}%}] %b%{${fg[default]}%}"
#RPROMPT="%B%(7~,.../,)%6~%b}"

autoload -U compinit
compinit
zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*:(vim|vi):*' ignored-patterns '*.(o|out|exe|swap|swp|~|stackdump)';

typeset -ga precmd_functions
typeset -ga preexec_functions

alias reload=". $HOME/.zshrc"

source $HOME/dotfiles/auto_title_screens
source $HOME/dotfiles/anyshrc
