#!/bin/sh

PS1="\[\e[90m\]\h:\u:\$PWD\\$ \[\e[m\]" && export PS1
LANG=C && export LANG

[ -d "$HOME/bin" ] && export PATH=$HOME/bin:$PATH
[ -d "$HOME/.local/bin" ] && export PATH=$HOME/.local/bin:$PATH

XXXX_HOME=`ls -d /app/XXXX /XXXX 2>/dev/null |tail -1` && [ -n "$XXXX_HOME" ] && export PATH=$XXXX_HOME/bin:$PATH
export XXXX_HOME=/XXXX 
export PATH="${XXXX_HOME}/bin:${PATH}"

T=LOGO which figlet >/dev/null && figlet `hostname` && echo ''

alias ll='ls -rtl' && alias llh='ls -alh'
alias lsport='sudo netstat -ntlp'
alias govms='cd /vms 2>/dev/null ||cd /*/vms 2>/dev/null '
alias godom="cd /app 2>/dev/null ||cd `pwd` 2>/dev/null "
alias doenv=' . ./setEnv.sh 2>/dev/null || . /vms/setEnv.sh 2>/dev/null ' 
#alias ps='ps -e -o user,pid,ppid,pcpu,vsz,rss,bsdstart,bsdtime,cmd '

