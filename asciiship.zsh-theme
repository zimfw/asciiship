# vim:et sts=2 sw=2 ft=zsh

zmodload zsh/datetime

prompt_asciiship_preexec() {
  prompt_asciiship_preexec_s=${EPOCHSECONDS}
}

prompt_asciiship_precmd() {
  if (( prompt_asciiship_preexec_s )); then
    local -ri elapsed_s=$(( EPOCHSECONDS - prompt_asciiship_preexec_s ))
    local -ri s=$(( elapsed_s%60))
    local -ri m=$(( (elapsed_s/60)%60 ))
    local -ri h=$(( elapsed_s/3600 ))
    unset prompt_asciiship_preexec_s
    local elapsed_time
    if (( h > 0 )); then
      elapsed_time=${h}h${m}m
    elif (( m > 0 )); then
      elapsed_time=${m}m${s}s
    elif (( s > 2 )); then
      elapsed_time=${s}s
    else
      # Don't show elapsed time
      unset prompt_asciiship_elapsed_time
      return
    fi
    prompt_asciiship_elapsed_time=" took %B%F{yellow}${elapsed_time}%f%b"
  else
    # Clear previous when hitting ENTER with no command to execute
    unset prompt_asciiship_elapsed_time
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_asciiship_preexec
add-zsh-hook precmd prompt_asciiship_precmd

VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format 'HEAD %F{green}(%c)'
  zstyle ':zim:git-info:action' format ' %F{yellow}(${(U):-%s})'
  zstyle ':zim:git-info:stashed' format '\\\$'
  zstyle ':zim:git-info:unindexed' format '!'
  zstyle ':zim:git-info:indexed' format '+'
  zstyle ':zim:git-info:ahead' format '>'
  zstyle ':zim:git-info:behind' format '<'
  zstyle ':zim:git-info:keys' format \
      'status' '%S%I%i%A%B' \
      'prompt' ' on %%B%F{magenta}%b%c%s${(e)git_info[status]:+" %F{red}[${(e)git_info[status]}]"}%f%%b'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1='
%(!.%B%F{red}%n%f%b in .${SSH_TTY:+"%B%F{yellow}%n%f%b in "})${SSH_TTY:+"%B%F{green}%m%f%b in "}%B%F{cyan}%~%f%b${(e)git_info[prompt]}${VIRTUAL_ENV:+" via %B%F{yellow}(${VIRTUAL_ENV:t})%b%f"}${prompt_asciiship_elapsed_time}
%B%(1j.%F{blue}*%f .)%(?.%F{green}.%F{red}%? )%#%f%b '
unset RPS1
