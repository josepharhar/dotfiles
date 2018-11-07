if [ `uname` = 'Darwin' ]; then
  JARHAR_OSX=1
elif [ `uname -o` = 'Cygwin' ]; then
  JARHAR_CYGWIN=1
else
  JARHAR_LINUX=1
fi

# ls aliases
if [ -z "$JARHAR_OSX" ]; then
  alias ls="ls --color=auto -h"
else
  alias ls="ls -h -G"
fi
alias la="ls -A"
alias ll="ls -l"
alias lal="ls -Al"
alias l="ll"

# ssh aliases
alias ssa="ssh -o StrictHostKeyChecking=no -A"
alias ssx="DISPLAY=:0.0 ssh -CY"
alias sse="ssa jarhar@192.168.248.130"
alias ssr="ssa jarhar@192.168.0.133"

# git aliases
alias gits="git status"
alias g="git"
alias clag="clear && git lag"
clgs() {
  if [[ "$PWD" =~ "$CHROMIUM_DIR" ]]; then
    # git lag is slow for chromium, use dag instead
    clear && git dag ; git status
  else
    clear && git lag ; git status
  fi
}
alias amend="git add . && git commit --amend --no-edit"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcbt="git checkout -t origin/master -b"
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
alias gpd="git push origin --delete"
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
alias gfmt="git diff -U0 --no-color HEAD^ | clang-format-diff.py -i -p1"

# open all files from a list, works with aliases - "vimo gdfnh"
vimo () {
  vim `eval $1`
}

# keychain aliases
kcstr () {
  if [ -x "$(command -v keychain)" ] && [ -f $HOME/.ssh/id_rsa ] && [ -z "$SSH_AUTH_SOCK" ]; then
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
alias ipt-nuke="sudo iptables -X && sudo iptables -t nat -F && sudo iptables -t nat -X && sudo iptables -t mangle -F && sudo iptables -t mangle -X && sudo iptables -P INPUT ACCEPT && sudo iptables -P FORWARD ACCEPT && sudo iptables -P OUTPUT ACCEPT"

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
alias m="make"
alias duu="du -sh *"
alias tailf="tail +1f" # https://unix.stackexchange.com/questions/139866/how-do-i-cat-and-follow-a-file
alias upd="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias oldest="find -type f -printf '%T+ %p\n' | sort | head -n 30"
alias ssync="rsync -a --progress --delete -v -e \"ssh -T -o Compression=no\"" # https://gist.github.com/KartikTalwar/4393116
alias csync="rsync -a --progress --delete -v -c -n"

# https://stackoverflow.com/a/17168847
# usage: hexsearch "\x20\x3e\xaa" os.img
alias hexsearch="grep -obUaP"

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
mkmv() {
  if [ "$#" -eq 2 ]; then
    mkdir "$2"
    mv "$1" "$2"
  else
    echo "Usage: mkmv <filename> <new dirname>"
  fi
}
jcmp() {
  #find $1 -type f -exec sh -c 'md5sum "{}" ; stat --printf="%y\n" "{}" ;' \; | paste -d " " - - | sort -k 2
  find $1 -type f -exec sh -c 'md5sum "{}" ; stat --printf="%y\n" "{}" ;' \; | paste -d " " - -
}

# Windows
if ! [ -z "$JARHAR_CYGWIN" ]; then
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

if [ -f shrc.sh ]; then
  source shrc.sh
fi

# Add pip local installs to path
if [ -d "$HOME/.local/bin" ]; then
  PATH=$PATH:$HOME/.local/bin
fi

if [ -x "$(command -v clang-format-3.8)" ]; then
  alias clang-format="clang-format-3.8"
fi

alias reload="source $HOME/$SHDOTFILE && echo \"$SHDOTFILE reloaded\""

if [ -d "$HOME/dotfiles/bin" ]; then
  PATH=$PATH:$HOME/dotfiles/bin
fi

# Chromium
export CHROMIUM_DIR="${HOME}/chromium/src"
export CHROMIUM_PATH="${HOME}/chromium/src/out/release/chrome"
alias gsync="gclient sync --with_branch_heads --with_tags"
alias anc="autoninja -C"
alias ancr="anc out/release"
alias ancrc="ancr chrome"
alias ancrcr="ancrc && out/release/chrome"
alias ltestr="anc out/release chrome blink_tests && python third_party/blink/tools/run_web_tests.py --fully-parallel -t release"
alias ltest="ltestr --no-retry-failures"
alias ltesta="ltest http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias ltestar="ltestr http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias csd="cd ${CHROMIUM_DIR}/third_party/blink/renderer/devtools"
alias csdt="cd ${CHROMIUM_DIR}/third_party/WebKit/LayoutTests/http/tests/devtools"
alias snap='mkdir -p userdata && chrome-linux/chrome --user-data-dir=userdata'
