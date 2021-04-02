if [ `uname` = 'Darwin' ]; then
  JARHAR_OSX=1
elif [ `uname -o` = 'Cygwin' ]; then
  JARHAR_CYGWIN=1
elif [ `uname -o` = 'Msys' ]; then
  JARHAR_MSYS=1
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
alias sse="ssa jarhar@192.168.56.132"
alias ssr="ssa jarhar@surface.arhar.net"

# git aliases
alias gits="git status"
alias g="git"
alias clag="clear && git lag"
clgs() {
  if [[ "$PWD" =~ "$HOME/chrom" || "$PWD" =~ "$HOME/cro" ]]; then
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
alias gg="git grep -i"
remote() {
  git remote remove ${2:-origin} || true
  git remote add ${2:-origin} git://github.com/josepharhar/$1 && \
  git remote set-url ${2:-origin} --push git@github.com:josepharhar/$1
}
clone() {
  git clone git://github.com/josepharhar/${1} && \
  cd $1 && \
  remote $1 && \
  git fetch
}

# open all files from a list, works with aliases - "vimo gdfnh"
vimo () {
  vim `eval $@`
}

# keychain aliases
kcstr () {
  if [ -x "$(command -v keychain)" ] && [ -f $HOME/.ssh/id_rsa ] && [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(keychain --eval --quiet)
  fi
}
if ! [ -z "$JARHAR_MSYS" ]; then
  kcadd() {
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_rsa
  }
elif ! [ -z "$JARHAR_OSX" ]; then
  kcadd() {
    ssh-add ~/.ssh/id_rsa
  }
else
  kcadd () {
    eval $(keychain --eval --quiet id_rsa $HOME/.ssh/id_rsa)
  }
fi

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
#alias mc="java -Xms512M -Xmx6G -jar"
alias shut="sudo /sbin/shutdown -h now"
alias sus="sudo /usr/sbin/pm-suspend"
alias grep="grep --color=auto -i" # -i ignores case
alias grepa="grep -rni '.' -e"
alias asdf="echo \"dotfiles loaded\""
#alias eclipse="SWT_GTK3=0 eclipse"
#alias db="mysql jarhar"
#alias bb="mvn -T 4 spring-boot:run"
alias clang-format-file="clang-format-3.8 -style=Chromium -i"
alias cctags="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
#alias make="make -j4"
alias mkcdmake="mkdir build && cd build && cmake .. && make -j4"
alias rmrf="rm -rf"
if [ -z "$JARHAR_OSX" ]; then
  alias findf="find . ! -readable -prune -o -type f -print"
else
  alias findf="find . -type f"
fi
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
alias ck="c && !!"
alias npr="npm run"
alias nps="npm start"

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
  #find $1 -type f -exec sh -c 'md5sum --tag "{}" ; stat --printf="%y\n" "{}" ;' \; | paste -d " " - -
  find $1 -type f | sort | xargs -I {} sh -c 'md5sum --tag "{}" ; TZ=UTC stat --printf "%y\n" "{}" ;' | paste -d " " - -
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

# 471 config
#export GLM_INCLUDE_DIR=$HOME/glm
#export GLFW_DIR=$HOME/glfw
#export GLEW_DIR=$HOME/glew-2.0.0
#export EIGEN3_INCLUDE_DIR=$HOME/eigen-3.2.6

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

#if [ -x "$(command -v clang-format-3.8)" ]; then
#  alias clang-format="clang-format-3.8"
#fi

alias reload="source $HOME/$SHDOTFILE && echo \"$SHDOTFILE reloaded\""

[ -d "/sbin" ] && export PATH=$PATH:/sbin
[ -d "/usr/sbin" ] && export PATH=$PATH:/usr/sbin
[ -d "$HOME/depot_tools" ] && export PATH=$PATH:$HOME/depot_tools
[ -d "$HOME/dotfiles/bin" ] && export PATH=$PATH:$HOME/dotfiles/bin
[ -d "$HOME/homebrew/bin" ] && export PATH=$PATH:$HOME/homebrew/bin
[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin

# Chromium
export CHROMIUM_DIR="${HOME}/chromium/src"
export CHROMIUM_SRC="${HOME}/chromium/src"
export CHROMIUM_ALT_DIR="${HOME}/chromium.alt/src"
if [ -z "$JARHAR_OSX" ]; then
  export RELATIVE_CHROMIUM_PATH="out/Release/chrome"
else
  export RELATIVE_CHROMIUM_PATH="out/Release/Chromium.app/Contents/MacOS/Chromium"
fi
export CHROMIUM_PATH="${HOME}/chromium/src/${RELATIVE_CHROMIUM_PATH}"
#alias gsync="gclient sync --with_branch_heads --with_tags"
alias gsync="gclient sync -D"
alias anc="autoninja -C"
alias ancr="anc out/Release"
alias ancrc="ancr chrome"
alias ancrt="ancr chrome content_shell blink_tests wpt_tests_isolate content_browsertests browser_tests interactive_ui_tests"
alias ancdt="anc out/Debug chrome content_shell blink_tests wpt_tests_isolate content_browsertests browser_tests interactive_ui_tests"
alias ancrcr="ancrc && ${RELATIVE_CHROMIUM_PATH}"
alias cr="${RELATIVE_CHROMIUM_PATH}"
alias lanc="GOMA_DISABLED=true anc"
alias lancr="GOMA_DISABLED=true ancr"
alias lancrc="GOMA_DISABLED=true ancrc"
alias lancrt="GOMA_DISABLED=true ancrt"
alias lancrcr="GOMA_DISABLED=true ancrcr"
#alias bb="autoninja -C ${CHROMIUM_DIR}/out/Release chrome && ${CHROMIUM_PATH}"
alias bb="ancrcr"
alias bbd="anc out/Debug chrome && out/Debug/chrome"
alias lbb="lancrcr"
alias ltestr="anc out/Release blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Release"
alias ltest="ltestr --no-retry-failures"
alias ltestd="anc out/Debug blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Debug --no-retry-failures"
alias lltest="GOMA_DISABLED=true ltest"
alias ltesta="ltest http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias ltestar="ltestr http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias csd="cd ${CHROMIUM_DIR}/third_party/blink/renderer/devtools"
alias csdt="cd ${CHROMIUM_DIR}/third_party/blink/web_tests/http/tests/devtools"
if [ -z "$JARHAR_OSX" ]; then
  alias snap='mkdir -p userdata && chrome-linux/chrome --user-data-dir=userdata'
else
  alias snap='mkdir -p userdata && chrome-mac/Chromium.app/Contents/MacOS/Chromium --user-data-dir=userdata'
fi
brt() {
  ancr browser_tests && out/Release/browser_tests --gtest_filter="$1"
}
alias bbt="ltest"
alias bbs="ancrcr"
alias lbbt="GOMA_DISABLED=true ltest"
alias lbbs="GOMA_DISABLED=true ancrcr"
alias dtfix="(csd && npx eslint front_end --fix && npm run closure && git cl format --js)"
alias npc="npr tsc"
alias changeidhook="curl -Lo .git/hooks/commit-msg http://chromium-review.googlesource.com/tools/hooks/commit-msg && chmod +x .git/hooks/commit-msg"
alias xvfb="xvfb-run -a -s \"-screen 0 1024x768x24\""
alias throttle="sudo dnctl pipe 1 config bw 1000Kbyte/s"
alias nothrottle="sudo dnctl pipe 1 config bw 0"
if ! [ -z "$JARHAR_OSX" ]; then
  # r508527 is the oldest one that i can still open devtools on with my mac
  alias bisect="python tools/bisect-builds.py -g 508527 -a mac64 --use-local-cache --"
#else
  #alias bisect="python tools/bisect-builds.py -a mac64 --use-local-cache --"
fi

# old chrome aliases
##alias gng="gn gen out/Default --args='is_chromecast=true is_debug=true"
#alias gng="gn gen out_chromecast_desktop/debug --args='is_chromecast=true is_debug=true use_goma=true chromecast_branding=\"internal\"'"
#alias chrtest="ninja -j1024 -C out/Release cast_shell_browser_test && out/Release/cast_shell_browser_test --test-launcher-bot-mode --enable-local-file-accesses --ozone-platform=cast --no-sandbox --test-launcher-jobs=1 --test-launcher-summary-output=asdf.log"

