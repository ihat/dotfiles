# Convenient stuff
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias ls="ls -G"
alias ll="ls -GAhl"
alias empties="find . -empty -type d -maxdepth 2"
alias mate="open -a /Applications/TextMate.app"
alias e="/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs -nw"
alias emacs="/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs -nw"

alias pg="ps ax | grep -v grep | grep -i "
alias ip="ifconfig | grep 'inet '"

alias profile='mate -w ~/.bash_profile && . ~/.bash_profile'

alias df='df -h'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias f='find . -iname'
alias g='grep -i'  # Case insensitive grep
alias gr='grep -r' # Recursive grep
alias m='less'
alias systail='tail -f /var/log/system.log'
alias top='top -o cpu'
# Shows most used commands, from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$3}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
alias v='/usr/local/bin/vim'


# Square
alias sq="cd \$SQUARE_HOME/web"
alias risk="cd \$SQUARE_HOME/risk"
alias conn="cd \$SQUARE_HOME/connections"
#
# TextMate
alias tm="open -a /Applications/TextMate.app"

# Rails
alias sc="./script/console"
alias sd="./script/dbconsole"
alias ss="./script/server"
alias rc="rake && cuke && rake jasmine:ci && say 'derp' || say 'fail'"
alias rmp="rake db:migrate db:test:prepare"
alias migrate="rake db:migrate"
alias reset_db="rake db:migrate:reset"

function rlog {
  if [ -z "$1" ]; then
    tail -f -n80 ./log/development.log
  else
    tail -f -n80 ./log/$1.log
  fi
}

# Git
alias g="git"
alias ch="git diff --ignore-space-at-eol | mate"
alias chc="git diff --cached --ignore-space-at-eol | mate"
alias dmp="git fetch && git diff origin/ci-master-latest..origin/production-latest --stat"
alias gaa="git add --all && git status"
alias gadd="git add --all && git status"
alias gb='git branch -v'
alias gca='git commit -v --all'
alias gcam='git commit --amend'
alias gcb='git checkout -b'
alias gch="git log ORIG_HEAD.. --stat --no-merges"
alias rtd="git log --abbrev-commit --no-merges --reverse --pretty=format:'%C(yellow)%h%Creset %C(bold)%s%Creset %an' origin/production-latest..origin/ci-master-distributed-latest"
alias gci='git commit -v'
alias gcia='git commit -v --all'
alias gcv='git commit -v'
alias gdc='git diff --cached | mate'
alias gdh='git diff HEAD | mate'
alias gdm='git diff origin/master | mate'
alias git-user="mate ~/.gitconfig"
alias gmm="git merge master"
alias gps="git pull && git submodule update --init"
alias grm="git status | grep 'deleted:' | sed -e 's/^#.deleted: *//' | xargs -n1 git rm"
alias gs='git status'
alias gss='git status --short --branch'
alias gu="mate ~/.gitconfig"
alias grim="git rebase --interactive master"
alias gdb="git push -f origin HEAD:dogfood-build"
alias gbr="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname)' | cut -d / -f 3-"
alias grc="git rebase --continue"
alias gl="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset'"

function gh {
	if [ -n "$1" ]; then
	  open "https://git.squareup.com/square/${1}"
	else
	  open "https://git.squareup.com/organizations/square"
	fi
}

function gap {
  if [ -z "$1" ]; then
    git add --patch
  else
    git add --patch $@
  fi
}

function git-authorize {
  touch .git/hooks/post-commit
  chmod +x .git/hooks/post-commit
  echo "echo 'Committed by:'" >> .git/hooks/post-commit
  echo "git lastauthor"       >> .git/hooks/post-commit
}

# gco      => git checkout master
# gco bugs => git checkout bugs
function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $@
  fi
}

function revs {
  sq
  for branch in master staging production; do
    rev_local=$(git rev-parse "$branch")
    rev_origin=$(git rev-parse "origin/$branch")

    rev_color="\e[0;32m"
    if [ "$rev_local" != "$rev_origin" ]; then
      rev_color="\e[0;31m"
    fi

    perl -le "print \"$rev_color$rev_local\e[0m \e[33;1m$branch\e[0m\""
    perl -le "print \"$rev_color$rev_origin\e[0m \e[33;1morigin/$branch\e[0m\""
    echo
  done
}

function ub {
  branch="${1:-master}";
  cd $SQUARE_HOME/web;
  git fetch &&
  git co "$branch" &&
  git reset --hard "origin/$branch" &&
  git submodule update --init &&
  revs
}

function rf {
  sq &&
  rake db:drop db:create db:migrate RAILS_ENV="development" && 
  rake spec:db:fixtures:load RAILS_ENV="development" &&
  rake db:drop db:create db:migrate RAILS_ENV="test" && 
  rake spec:db:fixtures:load RAILS_ENV="test" &&
  rake db:drop db:create db:migrate RAILS_ENV="cucumber" && 
  rake spec:db:fixtures:load RAILS_ENV="cucumber" &&
  (echo; echo "Restarting Nginx..."; script/nginx-reload)
}

# Testing
function cuke {
  if [ -z "$1" ]; then
    rake cucumber
  else
    rake cucumber FEATURE=$@
  fi
}

function cukey {
  if [ -z "$1" ]; then
    rake cucumber CUCUMBER_FORMAT=pretty
  else
    rake cucumber CUCUMBER_FORMAT=pretty FEATURE=$@
  fi
}

function cuke-local {
  rake cucumber:localdev
}

# Other
function fl {
    N=$1
    shift;
    awk $@ "{print \$${N:-1}}";
}

alias colorslist="set | egrep 'COLOR_\w*'"  # Lists all the colors, uses vars in .bashrc_non-interactive

alias npc="no_prompt_colors"
function no_prompt_colors() {
  export PS1=$(echo "$PS1" | perl -ple 's/\\\[.*?\\\]//g') # strip out sequences
}

alias R='R --no-save --no-restore-data --quiet'
alias clj='~/clj'
alias tmux="TERM=screen-256color-bce tmux"
