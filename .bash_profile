source ~/.nvm/nvm.sh
nvm i 16
npm set package-lock false

git config --global core.whitespace -trailing-space

export EDITOR="vim"
export VISUAL="$EDITOR"

# vim modes
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

#PS1='\u@\h:\w$ '
PS1='\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ "$(uname)" == "Linux" ]; then
    alias ls='ls --color'
fi

export NODE_OPTIONS="$NODE_OPTIONS --unhandled-rejections=strict"

export HISTCONTROL=ignorespace

alias install-yandex='sudo apt install davfs2';
alias mount-yandex='mkdir -p ~/yandex-disk; sudo mount -t davfs https://webdav.yandex.ru ~/yandex-disk/'

alias ls='ls -GF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias yarni='yarn --no-lockfile --link-duplicates --registry https://registry.npmjs.org'
alias yarnadd='yarn add --no-lockfile --link-duplicates --registry https://registry.npmjs.org'
alias yarn-update='curl -o- -L https://yarnpkg.com/install.sh | bash'
alias yarn-clean="rm -rf ~/.cache/yarn/*"
alias clean-journal='sudo journalctl --vacuum-size=100M';
alias update-madrun='mv .madrun.js .madrun.mjs && putout .madrun.mjs --fix';

alias cloudcmd='node ~/cloudcmd/bin/cloudcmd.mjs'
alias dcloudcmd='NODE_ENV=development cloudcmd'
alias iocmd='node ~/iocmd/bin/iocmd.js'

alias docker-rm-c='docker rm `docker stop $(docker ps -aq)`';

alias node-inspect='node --inspect-brk=0.0.0.0:9111';
alias node='node --experimental-repl-await --throw-deprecation';

function mountram() {
    sudo mount -t tmpfs -o size=400M tmpfs /media/ramdisk
}

function hi() {
    tar zxf node_modules.tar.gz -P -C /media/ramdisk \
    && ln -s /media/ramdisk/node_modules \
    && rm node_modules.tar.gz
}

function bye() {
    tar zcf node_modules.tar.gz node_modules -h \
    && rm -rf node_modules
}

ignore-package-lock() {
    ex -sc '1i|package-lock.json' -cx .gitignore;
    git add .gitignore;
    git commit -m 'feature(gitignore) add package-lock.json';
}

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.deno/bin:$PATH"
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


#alias letsencrypt-auto="certbot-auto renew"
letsencryptauto () {
    sudo service nginx stop;
    certbot-auto renew;
    sudo service nginx start;
}

letsencrypt () {
    sudo service nginx stop;
    sudo docker run -it --rm -p 443:443 -p 80:80 --name certbot \
        -v "/etc/letsencrypt:/etc/letsencrypt" \
        -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
        certbot/certbot renew;
    sudo service nginx start;
    docker rmi certbot/certbot;
}

babel-up () {
    babel-upgrade --write
    git add .
    git commit -am 'feature(package) babel v7.0.0'
}

madrun-install() {
    yarnadd eslint-plugin-node eslint-plugin-putout putout madrun supertape -D;
}

madrun-init () {
    madrun --init;
    putout --fix madrun.js;
    madrun --init;
    cp ~/readify/.eslintrc.json ./
}

alias gitlog='git log --pretty=format:"%C(Yellow)%h %Cgreen%ad %Creset%s" --date=format:"%H:%M:%S %d.%m.%y"'
alias jekyll-build='docker run -it -v `pwd`:/srv/jekyll -p 4000:4000 jekyll/jekyll jekyll serve'
alias longrun="~/longrun/bin/longrun.js"

include ~/.bash_profile.local

