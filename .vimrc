set enc=utf-8
set list
set listchars=trail:·,eol:¬
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set fileformats=unix
colorscheme desert
syntax on

" o, O: preserve whitespaces
inoremap <Return> <Space><BS><Return>

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

if expand('%:t') == "package.json"
    set tabstop=2
    set shiftwidth=2
endif

if expand('%:t') =~ '^\.\(jshint\|jscs\|eslint\)'
    set syntax=javascript
endif

