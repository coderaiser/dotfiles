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

" replace last character with ";"
let @e = 'Ar;j^'

" replace a lot spaces with one in var
let @r = 'j^eeldwi '

" -> "ap to paste macros from buffer

if expand('%:t') =~ '\(^package\.json$\)\|\(^\.babel\)'
    set tabstop=2
    set shiftwidth=2
endif

if expand('%:t') =~ '^\.\?\(jshint\|jscs\|eslint\|babel\)'
    set syntax=javascript
endif

if expand('%:t') =~ '.service$'
    set syntax=dosini
endif

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

