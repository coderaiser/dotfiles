source ~/.nvm/nvm.sh
nvm i 6

PS1='\u@\h:\w$ '
if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -G'
    which docker-machine > /dev/null && eval "$(docker-machine env default)" 2> /dev/null
elif [ "$(uname)" == "Linux" ]; then
    alias ls='ls --color'
fi

alias ls='ls -GF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias cloudcmd='node ~/cloudcmd/bin/cloudcmd.js'
alias iocmd='node ~/iocmd/bin/iocmd.js'

alias docker-rm-c='docker rm `docker stop $(docker ps -aq)`'
alias docker-rm-untagged='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="node_modules/.bin:$PATH"

lso() { ls -l "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'; }

function amend-date() {
    if [ $# -eq 0 ]; then
        echo "amend-date [hours]";
    elif ! [[ $1 =~ ^[-+0-9]+$ ]]; then
        echo "date should be number";
    else
        git commit --amend --no-edit --date="$(date --date="$1 hours")";
    fi
}

alias git-log='git log --pretty=format:"%C(Yellow)%h %Cgreen%ad %Creset%s" --date=format:%H:%M:%d.%m.%y'
alias jekyll-build='docker run -it -v /home/coderaiser/cloudcmd-io:/srv/jekyll -p 4000:4000 jekyll/jekyll'

