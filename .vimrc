autocmd BufReadPost * call SetFileTypeOptions()

" vim hex view :%!xxd

set enc=utf-8
set list
set listchars=trail:·,eol:¬
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set fileformats=unix
set backupcopy=yes

colorscheme desert
syntax on

" o, O: preserve whitespaces
inoremap <Return> <Space><BS><Return>

" replace last character with ";"
let @e = 'Ar;'

" replace a lot spaces with one in var
let @r = '^eeldwi '

" @e + @r
let @g = '@r@ej^'

" replace : es5 -> es6 =>
let @f = '/function(dw$i=> '

" replace spaces: "     " -> " "
let @s = '/  dwi j^'

" replace var with const
let @c = 'dwiconst j^'

" change sinon to stub
let @j = 'jbbdbdb'

" -> "ap to paste macros from buffer
" <Ctr-v><Esc> - to put ^[

function SetFileTypeOptions()
    if expand('%:t') =~ '\(^package\.json$\)\|\(^\.gitlab-ci\)'
        set tabstop=2
        set shiftwidth=2
    endif

    if expand('%:t') =~ '^\.\?\(jshint\|jscs\|eslint\|babel\|lintstagedrc\|remarkrc\)'
        set syntax=javascript
    endif
    
     if expand('%:t') =~ '\.ya\?ml$'
        set tabstop=2
        set shiftwidth=2
    endif

    if expand('%:t') =~ '.service$'
        set syntax=dosini
    endif

    if filereadable(glob("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
endfunction

execute pathogen#infect()
call pathogen#helptags()

map <C-n> :NERDTreeToggle<CR>

set splitbelow
