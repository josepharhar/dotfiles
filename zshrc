# Prompt
autoload -U colors && colors
PS1="%B%{${fg[yellow]}%}%n%{${fg[cyan]}%}@%{${fg[yellow]}%}%m %{${fg[cyan]}%}%(7~,.../,)%6~ %{${fg[yellow]}%}%% %b%{${fg[default]}%}"
#PS1="%{${fg[green]}%}%B[%{${fg[yellow]}%}%m %{${fg[cyan]}%}%(7~,.../,)%6~%{${fg[green]}%}] %b%{${fg[default]}%}"
#RPROMPT="%B%(7~,.../,)%6~%b}"

# Autocompletion
autoload -U compinit
compinit
zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*:(vim|vi):*' ignored-patterns '*.(o|out|exe|swap|swp|~|stackdump|class|bak)'
zstyle ':completion:*:(javac):*' file-patterns '*.java'

# Aliases
alias reload=". $HOME/.zshrc && echo \"dotfiles reloaded\""

# Automatic screen titles
typeset -ga precmd_functions
typeset -ga preexec_functions
source $HOME/dotfiles/auto_title_screens.zsh

# History
setopt EXTENDED_HISTORY        # store time in history
setopt HIST_EXPIRE_DUPS_FIRST  # unique events are more useful
setopt HIST_VERIFY             # Make those history commands nice
setopt INC_APPEND_HISTORY      # immediatly insert history into history file
HISTSIZE=116000                 # spots for duplicates/uniques
SAVEHIST=115000                 # unique events guarenteed
HISTFILE=$HOME/.zsh_history
setopt histignoredups          # ignore duplicates of the previous event

# non-zsh configuration
export SHDOTFILE=".zshrc"
source $HOME/dotfiles/anyshrc.sh

# Keychain
kcstr

# vi style command line editing
bindkey -v
bindkey "^?" backward-delete-char
# broken vi mode indicator
#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#function zle-keymap-select {
#  zle reset-prompt
#  zle -R
#}
#zle -N zle-keymap-select
#function vi_mode_prompt_info() {
#  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
#}
#
## define right prompt, regardless of whether the theme defined it
#RPS1='$(vi_mode_prompt_info)'
#RPS2=$RPS1

# fzf
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# .fzf.zsh
## Setup fzf
## ---------
#if [[ ! "$PATH" == */Users/jarhar/fzf/bin* ]]; then
#  export PATH="$PATH:/Users/jarhar/fzf/bin"
#fi
## Auto-completion
## ---------------
#[[ $- == *i* ]] && source "/Users/jarhar/fzf/shell/completion.zsh" 2> /dev/null
## Key bindings
## ------------
#source "/Users/jarhar/fzf/shell/key-bindings.zsh"
if [ -d "$HOME/fzf" ]; then
  export PATH="$PATH:$HOME/fzf/bin"
  source "$HOME/fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/fzf/shell/key-bindings.zsh"
fi
