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
zstyle ':completion:*:(vim|vi):*' ignored-patterns '*.(o|out|exe|swap|swp|~|stackdump|class)'
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
HISTSIZE=16000                 # spots for duplicates/uniques
SAVEHIST=15000                 # unique events guarenteed
HISTFILE=$HOME/.zsh_history
setopt histignoredups          # ignore duplicates of the previous event
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# non-zsh configuration
source $HOME/dotfiles/anyshrc.sh

# Keychain
kcstr
