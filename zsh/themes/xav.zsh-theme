project_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/~\/Development\/\([^\/]*\)/\\1/" -e "s/SQUARE_HOME\///"
}

git_stash_count() {
  local stash_count=$(git stash list 2> /dev/null | wc-l)
  if
}

git_prompt_info() {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(git status 2> /dev/null)"
  local remote_pattern="# Your branch is (.*) (of|by)"
  local diverge_pattern="# Your branch and (.*) have diverged"
  local stashct="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"

  if [[ ! ${gitst} =~ "working directory clean" ]]; then
    state="${PR_RED}⚡"
  fi

  if [[ ${stashct} -gt 0 ]]; then
    stashst=":${PR_BLUE}$stashct "
  else
    stashst=" "
  fi

  if [[ ${gitst} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${PR_YELLOW}↑"
    else
      remote="${PR_YELLOW}↓"
    fi
  fi

  if [[ ${gitst} =~ ${diverge_pattern} ]]; then
    remote="${PR_YELLOW}↕"
  fi

  if [[ -n $ref ]]; then
    echo "$stashst${PR_CYAN}(${ref#refs/heads/}$remote$state${PR_CYAN})%{\e[0m%}"
  fi
}

# expand functions in the prompt
setopt prompt_subst


export PROMPT=$'%{\e[0;%(?.32.31)m%}>%{\e[0m%} '
export RPROMPT=$'`project_pwd``git_prompt_info`'
