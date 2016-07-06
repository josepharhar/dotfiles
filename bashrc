PS1="\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \$ "

# Amazon PS1 clone
#PS1="\[\e[1;32m\][\[\e[1;33m\h \[\e[1;36m\w\[\e[1;32m] \[\e[1;0m"
# Cal Poly PS1
#PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

bind 'set completion-ignore-case on'

alias reload=". $HOME/.bashrc"

source $HOME/dotfiles/anyshrc.sh
