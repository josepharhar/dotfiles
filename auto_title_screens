precmd_auto_title_screens ()
{
  local TITLE=${PWD:t}
  # 'screen' sets STY as well, so for users who override the TERM
  # environment variable, checking STY is nice
  setopt UNSET # Avoid errors from undefined STY for users with 'NOUNSET'
  if [[ $TERM == "screen" || -n $STY ]]; then
      echo -ne "\ek$TITLE\e\\"
  fi
  if [[ $TERM == "xterm" ]]; then
      echo -ne "\e]0;$TITLE\a"
  fi
  setopt LOCAL_OPTIONS # restore value of UNSET
}

# if you are running a command, make your screen title the command you're
# running
preexec_auto_title_screens ()
{
  local CMDS
  local CMD
  set -A CMDS $(echo $1)
  #Use first word from command line, but treat sudo and ssh specially
  if [[ $CMDS[1] == "sudo" ]]; then
      CMD="sudo $CMDS[2]"
  elif [[ $CMDS[1] == "ssh" ]]; then
      #Try to find target host for ssh
      CMD="ssh"
      local SKIP=1 #skip first arg
      for c in $CMDS; do
          if [[ $SKIP == 1 ]]; then
              SKIP=0
          elif [[ $c =~ "^-[1246AaCfgkMNnqsTtVvXxY]+" ]]; then
              #Option with no argument
          elif [[ $c =~ "^-.*" ]]; then
              #skip next entry after option that expects an argument
              SKIP=1
          else
              # found host name, strip out user name
              CMD=`echo $c | sed 's/.*@\(.*\)/\1/'`
              break
          fi
      done;
  else
      CMD=$CMDS[1]
  fi
  setopt UNSET # Avoid errors from undefined STY for users with 'NOUNSET'
  if [[ $TERM == "screen" || -n "$STY" ]]; then
    echo -ne "\ek$CMD\e\\"
  fi
  if [[ $TERM == "xterm" ]]; then
    echo -ne "\e]0;$CMD\a"
  fi
  setopt LOCAL_OPTIONS # restore value of UNSET
}

preexec_functions+='preexec_auto_title_screens'
precmd_functions+='precmd_auto_title_screens'
