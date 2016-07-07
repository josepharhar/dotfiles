PS1="\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \$ "

# Amazon PS1 clone
#PS1="\[\e[1;32m\][\[\e[1;33m\h \[\e[1;36m\w\[\e[1;32m] \[\e[1;0m"
# Cal Poly PS1
#PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

bind 'set completion-ignore-case on'

alias reload=". $HOME/.bashrc && echo \"dotfiles reloaded\""

# History
shopt -s histappend # append history into history file
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # immediatly insert history into history file
HISTFILESIZE=16000             # spots for duplicates/uniques
HISTSIZE=15000                 # unique events guarenteed
HISTCONTROL="${HISTCONTROL:-}:ignoredups" # ignore duplicates of the previous event

# bind -m vi

source $HOME/dotfiles/auto_title_screens.bash
source $HOME/dotfiles/anyshrc.sh
