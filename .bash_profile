source ~/.nvm/nvm.sh
nvm i 7

export EDITOR="vim"
export VISUAL="$EDITOR"

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

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$PATH:node_modules/.bin"

lso() { ls -l "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'; }

docker-rmi() {
    if [ $# -eq 0 ]; then
        echo "docker-rm [image name]";
    else
        docker rmi -f $(docker images | grep -E "$1" | awk '{print $3}')
    fi
}

docker-rm-untagged() {
    docker rmi $(docker images | grep none);
}


amend-date() {
    if [ $# -eq 0 ]; then
        echo "amend-date [hours]";
    elif ! [[ $1 =~ ^[-+0-9]+$ ]]; then
        echo "date should be number";
    else
        git commit --amend --no-edit --date="$(date --date="$1 hours")";
    fi
}

nvm-patch() {
    # mac os needs extension
    sed -i.bak 's/nvm_die_on_prefix() {/nvm_die_on_prefix() { return;/' ~/.nvm/nvm.sh;
    rm ~/.nvm/nvm.sh.bak;
    source ~/.nvm/nvm.sh
}

nvm-revert() {
    # mac os needs extension
    sed -i.bak 's/nvm_die_on_prefix() { return;/nvm_die_on_prefix() {/' ~/.nvm/nvm.sh
    rm ~/.nvm/nvm.sh.bak;
    source ~/.nvm/nvm.sh
}

include () {
    [[ -f "$1" ]] && source "$1"
}

alias gitlog='git log --pretty=format:"%C(Yellow)%h %Cgreen%ad %Creset%s" --date=format:"%H:%M:%S %d.%m.%y"'
alias jekyll-build='docker run -it -v `pwd`:/srv/jekyll -p 4000:4000 jekyll/jekyll'
alias longrun="~/longrun/bin/longrun.js"

alias letsencrypt='sudo docker run -it --rm -p 443:443 -p 80:80 --name certbot \
        -v "/etc/letsencrypt:/etc/letsencrypt" \
        -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
        quay.io/letsencrypt/letsencrypt:latest auth'

include ~/.bash_profile.local

