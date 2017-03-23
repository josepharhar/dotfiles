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
alias clag="clear && git lag"
alias clgs="clear && git lag ; gits"
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
alias gcm="git commit -m"
alias gpf="git push -f origin"
delete-submodule() {
  rm -rf $1
  git submodule deinit $1
  git rm $1
  git rm --cached $1
  rm -rf .git/modules/$1
}
gdff() {
  git diff ${1}^ $1
}
alias gfp="git fetch -p"

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

# iptables aliases
alias ipt-list="sudo iptables -t nat -L --line-numbers"
alias ipt-delete="sudo iptables -t nat -D PREROUTING"
ipt-map() {
  # $1 is incoming port, $2 is local destination port
  sudo iptables -t nat -A PREROUTING -p tcp --dport $1 -j REDIRECT --to-port $2
}
# this requires ubuntu 16.04 package "iptables-persistent" to be installed
alias ipt-save="sudo sh -c 'iptables-save > /etc/iptables/rules.v4'"

# other aliases
alias c="clear"
alias cl="c && l"
alias ..="cd .."
alias less="less -R"
alias lef="less +F"
alias mc="java -Xms512M -Xmx6G -jar"
alias shut="sudo /sbin/shutdown -h now"
alias sus="sudo /usr/sbin/pm-suspend"
alias grep="grep --color=auto -i" # -i ignores case
alias grepa="grep -rni '.' -e"
alias asdf="echo \"dotfiles loaded\""
#alias eclipse="SWT_GTK3=0 eclipse"
alias db="mysql jarhar"
alias bb="mvn -T 4 spring-boot:run"
alias clang-format-file="clang-format-3.8 -style=Chromium -i"
alias cctags="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias make="make -j4"
alias mkcdmake="mkdir build && cd build && cmake .. && make -j4"
alias rmrf="rm -rf"
alias findf="find . ! -readable -prune -o -type f -print"
alias cmakevs="cmake -G \"Visual Studio 14 2015 Win64\""
alias cmakevsd="cmakevs -DCMAKE_BUILD_TYPE=RelWithDebInfo"
alias cmakevsr="cmakevs -DCMAKE_BUILD_TYPE=Release"
alias cmakevsdd="cmakevs -DCMAKE_BUILD_TYPE=Debug"

# functions
hex2dec() {
  echo $((16#$1))
}
dec2hex() {
  printf "%x\n" $1
}
java-format() {
  if [ ! -f $HOME/dotfiles/bin/google-java-format.jar ]; then
    wget "https://github.com/google/google-java-format/releases/download/google-java-format-1.1/google-java-format-1.1-all-deps.jar" -O $HOME/dotfiles/bin/google-java-format.jar
  fi
  java -jar $HOME/dotfiles/bin/google-java-format.jar --replace "$@"
}
mkcd() {
  mkdir $1 && cd $1
}
ioerr() {
  $1 2>&1 | $2
}
zgs() {
  if [ "$#" -eq 2 ]; then
    find . -type f -print | grep -P "$2" | xargs -I% sh -c 'echo % >&2; zgrep -HP "'"$1"'" %' | awk -F '.gz:' '{ print $2,": ",$1}' | sort > ~/thing
  elif [ "$#" -eq 1 ]; then
    find . -type f -print0 | xargs -0 -I% sh -c 'echo % >&2; zgrep -HP "'"$1"'" %' | awk -F '.gz:' '{ print $2,": ",$1}' | sort > ~/thing
  else
    echo "Usage: zgs search_regex [file_name_pattern]"
  fi
}

# Windows
if [ `uname -o` = 'Cygwin' ]; then
  alias ping="ping -t"
  PATH="$PATH:/c/Program Files (x86)/MSBuild/14.0/Bin"
  alias msbuild="MSBuild.exe"
fi

# Disable X Beep
if [ -x "xset" ] && [ -n "$DISPLAY" ]; then
  xset b off
fi

# Add sbin folders to path
PATH=$PATH:/sbin:/usr/sbin
# Add Chromium depot_tools to path
if [ -d "$HOME/depot_tools" ]; then
  PATH=$PATH:$HOME/depot_tools
fi

# 471 config
export GLM_INCLUDE_DIR=$HOME/glm
export GLFW_DIR=$HOME/glfw
export GLEW_DIR=$HOME/glew-2.0.0
export EIGEN3_INCLUDE_DIR=$HOME/eigen-3.2.6

if [ -x lesspipe ]; then
  eval "$(lesspipe)"
fi

# Create bin directory for storing files
mkdir -p $HOME/dotfiles/bin
