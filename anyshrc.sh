# Aliases
alias gits="git status"
alias ls="ls --color=auto -h"
alias la="ls -A"
alias ll="ls -l"
alias lal="ls -Al"
alias l="ll"
alias c="clear"
alias g="git"
alias ssx="DISPLAY=:0.0 ssh -CY"
alias amend="git add . && git commit --amend --no-edit"
alias clag="c && g lag"
alias cl="c && l"
alias clags="clag ; gits"
alias clgs="clags"
alias less="less -R"
alias lef="less +F"
alias mc="java -Xms512M -Xmx6G -jar"
alias shut="sudo /sbin/shutdown -h now"
alias sus="sudo /usr/sbin/pm-suspend"
alias grepa="grep -rni '.' -e"
alias sse="ssh arhar@Arhar-Arch-VM.local"
alias asdf="echo \"dotfiles loaded\""
alias eclipse="SWT_GTK3=0 eclipse"
alias db="mysql jarhar -h csc-db0 -ujarhar -p"
alias bb="mvn install"

hex2dec () {
   echo $((16#$1))
}

# Disable Beep
if [ -n "$DISPLAY" ]; then
   xset b off
fi

# Add sbin folders to path
PATH=$PATH:/sbin:/usr/sbin
