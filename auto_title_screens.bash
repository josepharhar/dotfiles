precmd_auto_title_screens ()
{
  local TITLE=${PWD:t}
  # 'screen' sets STY as well, so for users who override the TERM
  # environment variable, checking STY is nice
  if [[ $TERM == "screen" || -n $STY ]]; then
      echo -ne "\ek$TITLE\e\\"
  fi
  if [[ $TERM == "xterm" ]]; then
      echo -ne "\e]0;$TITLE\a"
  fi
}

PROMPT_COMMAND="precmd_auto_title_screens;${PROMPT_COMMAND:-}"
