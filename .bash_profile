source ~/git-prompt.sh
#PROMPT_COMMAND='echo -ne "\033]0;${C9_USER}@${C9_PROJECT}: ${PWD/#$HOME/~}\007"'
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]${PWD/#$HOME/~}\[\033[00m\]$(__git_ps1 " (%s)") $ '                                                                       
PS1='\u@\h:\w$ '
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    alias ls='ls -G'
elif [ "$(uname)" == "Linux" ]; then
    # Do something under Linux platform
    alias ls='ls --color'
fi

alias ls='ls -GF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

