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
alias gad="git status -s | cut -c4- | xargs git add"
alias amend="gad && git commit --amend --no-edit"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcbt="git checkout -t origin/main -b"
alias gre="git reset"
alias greh="git reset --hard"
alias grei="git rebase -i"
alias grea="git rebase-update --no-fetch"
alias gb="git branch"
alias gbd="git branch -D"
alias gba="git branch -a"
alias gbv="git branch -v"
alias gbav="git branch -a -v"
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
  git remote add ${2:-origin} https://github.com/josepharhar/$1 && \
  git remote set-url ${2:-origin} --push git@github.com:josepharhar/$1
}
clone() {
  git clone https://github.com/josepharhar/${1} && \
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
alias less="less -R -i"
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
alias duuu="du -sh * | sort -rh"
alias tailf="tail +1f" # https://unix.stackexchange.com/questions/139866/how-do-i-cat-and-follow-a-file
alias upd="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias oldest="find -type f -printf '%T+ %p\n' | sort | head -n 30"
alias ssync="rsync -a --progress --delete -v -e \"ssh -T -o Compression=no\"" # https://gist.github.com/KartikTalwar/4393116
alias csync="rsync -a --progress --delete -v -c -n"
alias ck="c && !!"
alias npr="npm run"
alias nps="npm start"
# WSL port forwarding https://stackoverflow.com/questions/64513964/wsl-2-which-ports-are-automatically-forwarded
alias wslf="netsh interface portproxy set v4tov4 listenport=8000 listenaddress=0.0.0.0 connectport=8000 connectaddress=\$(wsl hostname -I)"

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
[ -d "$HOME/wattsi/bin" ] && export PATH=$PATH:$HOME/wattsi/bin
[ -d "$HOME/.cargo/bin" ] && export PATH=$PATH:$HOME/.cargo/bin

# nvm.sh significantly slows down shell startup time
nvminit() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
eval "$(fnm env)"

jpg_add_edit() {
  for file in *.jpg; do
    newname="${file%.jpg}_edit.jpg"
    echo "$file -> $newname"
    mv "$file" "$newname"
  done
}

slowdown() {
  noglob ffmpeg -i $1 -af asetrate=44100*0.5,aresample=44100 $1.0.5.mp3
}

# Chromium
export CHROMIUM_DIR="${HOME}/chromium/src"
export CHROMIUM_SRC="${HOME}/chromium/src"
export CHROMIUM_ALT_DIR="${HOME}/chromium.alt/src"
if [ -z "$JARHAR_OSX" ]; then
  export RELATIVE_CHROMIUM_PATH="chrome"
else
  export RELATIVE_CHROMIUM_PATH="Chromium.app/Contents/MacOS/Chromium"
fi
export CHROMIUM_PATH="${HOME}/chromium/src/out/Release/${RELATIVE_CHROMIUM_PATH}"
#alias gsync="gclient sync --with_branch_heads --with_tags"
alias gsync="gclient sync -D"
alias anc="autoninja -C"
alias ancr="anc out/Release"
alias ancrc="ancr chrome"
alias ancrt="ancr chrome content_shell blink_tests wpt_tests_isolate content_browsertests browser_tests interactive_ui_tests components_browsertests"
alias ancd="anc out/Debug chrome content_shell"
alias ancdt="anc out/Debug chrome content_shell blink_tests wpt_tests_isolate content_browsertests browser_tests interactive_ui_tests components_browsertests unit_tests"
alias ancrcr="ancrc && out/Release/${RELATIVE_CHROMIUM_PATH}"
alias cr="out/Release/${RELATIVE_CHROMIUM_PATH} --enable-experimental-web-platform-features"
alias lanc="GOMA_DISABLED=true anc"
alias lancr="GOMA_DISABLED=true ancr"
alias lancrc="GOMA_DISABLED=true ancrc"
alias lancrt="GOMA_DISABLED=true ancrt"
alias lancrcr="GOMA_DISABLED=true ancrcr"
#alias bb="autoninja -C ${CHROMIUM_DIR}/out/Release chrome && ${CHROMIUM_PATH}"
alias bb="ancrcr --enable-experimental-web-platform-features --use-mock-keychain --disable-features=DialMediaRouteProvider"
alias cbb="cr --enable-experimental-web-platform-features --use-mock-keychain --disable-features=DialMediaRouteProvider"
alias bbd="anc out/Debug chrome && out/Debug/${RELATIVE_CHROMIUM_PATH} --enable-experimental-web-platform-features"
alias bcs="autoninja -C out/Release content_shell && out/Release/content_shell --enable-experimental-web-platform-features"
alias bcsd="autoninja -C out/Debug content_shell && out/Debug/content_shell --enable-experimental-web-platform-features"
alias lbb="autoninja --offline -C out/Release chrome && ${CHROMIUM_PATH} --enable-experimental-web-platform-features"
alias ltestr="anc out/Release blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Release --no-show-results"
alias ltest="ltestr --no-retry-failures"
alias ltestd="anc out/Debug blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Debug --no-retry-failures --no-show-results"
alias lltestd="anc --offline out/Debug blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Debug --no-retry-failures --no-show-results"
alias ltestdr="anc out/Debug blink_tests content_shell && ./third_party/blink/tools/run_web_tests.py --fully-parallel -t Debug --no-show-results"
alias cltestd="./third_party/blink/tools/run_web_tests.py --fully-parallel -t Debug --no-show-results --no-retry-failures"
alias cltest="./third_party/blink/tools/run_web_tests.py --fully-parallel -t Release --no-show-results --no-retry-failures"
alias lltest="GOMA_DISABLED=true ltest"
alias ltesta="ltest http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias ltestar="ltestr http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias csd="cd ${CHROMIUM_DIR}/third_party/blink/renderer/devtools"
alias csdt="cd ${CHROMIUM_DIR}/third_party/blink/web_tests/http/tests/devtools"
alias ltestdar="ltestdr http/tests/devtools http/tests/inspector-protocol inspector-protocol"
alias wptest="autoninja -C out/Debug headless_shell_wpt && ./third_party/blink/tools/run_wpt_tests.py -t Debug --no-show-results --no-retry-failures"
alias cwptest="./third_party/blink/tools/run_wpt_tests.py -t Debug --no-show-results --no-retry-failures"
#alias csd="cd ${CHROMIUM_DIR}/third_party/blink/renderer/devtools"
alias csd="cd third_party/blink/renderer/devtools"
#alias csdt="cd ${CHROMIUM_DIR}/third_party/blink/web_tests/http/tests/devtools"
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
  alias bisect="./tools/bisect-builds.py -g 508527 -a mac64 --use-local-cache --"
#else
  #alias bisect="python tools/bisect-builds.py -a mac64 --use-local-cache --"
fi
#export NINJA_SUMMARIZE_BUILD=1
export NINJA_STATUS="[%r processes, %f/%t @ %o/s : %es ] "
cluster() {
  anc out/cluster chrome content_shell && (cd ~/clusterfuzz && xvfb ./reproduce.sh -t "$1" -b ~/chromium/src/out/cluster)
}
# TODO add ln -s third_party/inspector-protocol from chromium/src/third_party/inspector-protocol to devtools-frontend/src/third_party/inspector-protocol
alias updateprotocol="(cp third_party/blink/public/devtools_protocol/browser_protocol.pdl third_party/devtools-frontend/src/third_party/blink/public/devtools_protocol/browser_protocol.pdl && cd third_party/devtools-frontend/src && npm run generate-protocol-resources)"
alias push0="git push origin HEAD:refs/for/main"
alias push1="git push origin HEAD:refs/for/main%l=Commit-Queue+1"
alias push2="git push origin HEAD:refs/for/main%l=Commit-Queue+2"

# old chrome aliases
##alias gng="gn gen out/Default --args='is_chromecast=true is_debug=true"
#alias gng="gn gen out_chromecast_desktop/debug --args='is_chromecast=true is_debug=true use_goma=true chromecast_branding=\"internal\"'"
#alias chrtest="ninja -j1024 -C out/Release cast_shell_browser_test && out/Release/cast_shell_browser_test --test-launcher-bot-mode --enable-local-file-accesses --ozone-platform=cast --no-sandbox --test-launcher-jobs=1 --test-launcher-summary-output=asdf.log"

