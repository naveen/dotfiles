# @(#) .bashrc
# author: naveen
# date 20080922 (revised osx)
# updated 20111106 (vespa)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Using this, consecutive duplicate commands, invocations
# of ls, executions of the mutt mail client without any
# additional parameters, plus calls to the bg, fg and exit
# built-ins will not be appended to the history list. 
HISTIGNORE="&:ls:ls *:mutt:[bf]g:exit:vi"
export HISTIGNORE

##############################################################################
# git
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
} 

##############################################################################
# my infamous two-line ps1
# (naveen@applesauce ~path/to/file) [gitbranch]
# $
PS1='\[\033[01;37m\](\u@\h \w)$(parse_git_branch)\n$ \[\033[00m\]' # white, rounded, git status

##############################################################################
# aliases
alias ls='ls -FG'
alias l='ls -aFG'
alias ll='ls -alFG'

alias rm='rm -i'
alias .='pwd'
alias ..='cd ..'

# force grep into color mode; short alias for recursive grep
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
function gr() { grep -nr $@ *; }

##############################################################################
# defaults
EDITOR=vi;   	export EDITOR
PAGER=less;  	export PAGER # git diff expects 'less' for best output
PATH=$PATH:$HOME/bin:/usr/local/sbin
