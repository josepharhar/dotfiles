# ls aliases
alias ls="ls --color=auto -h"
alias la="ls -A"
alias ll="ls -l"
alias lal="ls -Al"
alias l="ll"

# ssh aliases
alias ssa="ssh -A"
alias ssx="DISPLAY=:0.0 ssh -CY"
alias sse="ssa arhar@Arhar-Arch-VM.local"

# git aliases
alias gits="git status"
alias g="git"
alias clgs="c && git lag ; gits"
alias amend="git add . && git commit --amend --no-edit"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gre="git reset"
alias greh="git reset --hard"
alias grei="git rebase -i"
alias gb="git branch"
alias gbd="git branch -D"
alias gba="git branch -a"
alias gdf="git diff"
alias gdfh="git diff HEAD^"
alias gdfn="git diff --name-only"
alias gdfnh="git diff --name-only HEAD^"

# open all files from a list, works with aliases - "vimo gdfnh"
vimo () {
  vim `eval $1`
}

# keychain aliases
kcstr () {
  if [ -x "$(command -v keychain)" ] && [ -f $HOME/.ssh/id_rsa ]; then
    eval $(keychain --eval --quiet)
  fi
}
kcadd () {
  eval $(keychain --eval --quiet id_rsa $HOME/.ssh/id_rsa)
}

# chrome aliases
#alias gng="gn gen out/Default --args='is_chromecast=true is_debug=true"
alias gng="gn gen out_chromecast_desktop/debug --args='is_chromecast=true is_debug=true use_goma=true chromecast_branding=\"internal\"'"
alias chrtest="ninja -j1024 -C out/Release cast_shell_browser_test && out/Release/cast_shell_browser_test --test-launcher-bot-mode --enable-local-file-accesses --ozone-platform=cast --no-sandbox --test-launcher-jobs=1 --test-launcher-summary-output=asdf.log"

# other aliases
alias c="clear"
alias cl="c && l"
alias less="less -R"
alias lef="less +F"
alias mc="java -Xms512M -Xmx6G -jar"
alias shut="sudo /sbin/shutdown -h now"
alias sus="sudo /usr/sbin/pm-suspend"
alias grep="grep --color=auto"
alias grepa="grep -rni '.' -e"
alias asdf="echo \"dotfiles loaded\""
#alias eclipse="SWT_GTK3=0 eclipse"
alias db="mysql jarhar"
alias bb="mvn spring-boot:run"
hex2dec () {
  echo $((16#$1))
}
dec2hex() {
  printf "%x\n" $1
}
alias ..="cd .."
alias java-format="java -jar /usr/local/bin/java-format.jar"
alias clang-format="clang-format-3.8 -style=Chromium -i"
alias cctags="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
if [ `uname -o` = 'Cygwin' ]; then
  alias ping="ping -t"
fi

# Disable X Beep
if [ -n "$DISPLAY" ]; then
  xset b off
fi

# Add sbin folders to path
PATH=$PATH:/sbin:/usr/sbin
# Add Chromium depot_tools to path
if [ -d "$HOME/depot_tools" ]; then
  PATH=$PATH:$HOME/depot_tools
fi

# iptables notes
# list rules:
#  iptables -t nat -L --line-numbers
# delete rule:
#  iptables -t nat -D PREROUTING/OUTPUT rule#
# map incoming port:
#  iptables -t nat -A PREROUTING -p tcp --dport incomingport# -j REDIRECT --to-port destinationport#

# 471 config
export GLM_INCLUDE_DIR=$HOME/glm
export GLFW_DIR=$HOME/glfw
export GLEW_DIR=$HOME/glew-2.0.0

eval "$(lesspipe)"
