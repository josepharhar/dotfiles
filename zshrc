autoload -U colors && colors

PS1="%{${fg[cyan]}%}%B[%{${fg[green]}%}%m%{${fg[cyan]}%}] %b%{${fg[default]}%}"
RPROMPT="%{${fg[cyan]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"

typeset -ga precmd_functions
typeset -ga preexec_functions

source $HOME/dotfiles/auto_title_screens
source $HOME/dotfiles/anyshrc
