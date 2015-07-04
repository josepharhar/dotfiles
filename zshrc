autoload -U colors && colors
#PROMPT_COLOR=${PROMPT_COLOR:-green}
#PS1="%{${fg[$PROMPT_COLOR]}%}%B%n@%m] %b%{${fg[default]}%}"
#RPROMPT="%{${fg[$PROMPT_COLOR]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"

PS1="%{${fg[green]}%}%B%m${fg[white]}] %b%{${fg[default]}%}"
RPROMPT="%{${fg[green]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"

#local ret_status="%(?:%{$fg_bold[green]%}$ :%{$fg_bold[red]%}$ %s)"

#robbyrussel theme prompt
#PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

#PROMPT='%{$fg_bold[cyan]%}%M%{$fg_bold[white]%} ${ret_status}'

#ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

typeset -ga precmd_functions
typeset -ga preexec_functions

source $HOME/dotfiles/auto_title_screens
source $HOME/dotfiles/anyshrc

