if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

tyok_git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  if [ "${INDEX#?? }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi

  if [ "${INDEX# M }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX#AM }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX# T }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX#R  }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX#UU }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX# D }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif [ "${INDEX#AD }" != "$INDEX" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi

  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi

  echo $STATUS
}

function tyok_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(tyok_git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function tyok_rbenv_version() {
  ver=$(rbenv version-name 2> /dev/null)
  echo "${ver}"
}

PROMPT='
%{${fg[green]}%}%n %{${fg_bold[blue]}%}:: %{${fg_bold[magenta]}%}%3~ %{${fg_bold[black]}%}$(tyok_rbenv_version) %{$reset_color%}$(tyok_git_prompt_info)
%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

# RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%}› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_ADDED="…"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}!"
ZSH_THEME_TERM_TITLE_IDLE="%c"
ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%c%<<" #15 char left truncated PWD

# vim: ft=zsh:
