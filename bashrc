PS1="\[\033[01;33m\]\u@\h\[\033[00m\] \[\033[01;96m\]\w\[\033[01;32m\] \$ \[\033[00m\]"

# Amazon PS1 clone
#PS1="\[\e[1;32m\][\[\e[1;33m\h \[\e[1;36m\w\[\e[1;32m] \[\e[1;0m"
# Cal Poly PS1
#PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

bind 'set completion-ignore-case on'

# History
shopt -s histappend # append history into history file
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # immediatly insert history into history file
HISTFILESIZE=400000000 # "Don't lose any history! Lest we be doomed to repeat work." -eriq-augustine
HISTSIZE=15000 # unique events guarenteed
HISTCONTROL="${HISTCONTROL:-}:ignoredups:ignorespace" # ignore duplicates of the previous event

# bind -m vi

export SHDOTFILE=".bashrc"

#source $HOME/dotfiles/auto_title_screens.bash
source $HOME/dotfiles/anyshrc.sh

set -o vi
