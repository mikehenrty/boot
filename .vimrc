set nocompatible

set number
syntax on
colorscheme ir_black
set mouse=a

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set wrap "dont wrap lines
set linebreak "wrap lines at convenient points

set autoindent
set smartindent
set expandtab
set shiftwidth=2

"configure viminfo
set viminfo='10,\"100,:20,%,n~/.viminfo

"use the same yank buffer for all windows
set clipboard=unnamedplus

"use undo history
set undofile
set undodir=~/.vimundo/

"restore cursor when editing file
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"tell the term has 256 colors
set t_Co=256

hi StatusLine ctermbg=17 ctermfg=244
set laststatus=2
set statusline=
set statusline +=%n            "buffer number
set statusline +=\ %F          "full path
set statusline +=%m            "modified flag
set statusline +=%=%5l         "current line
set statusline +=/%L           "total lines
set statusline +=%4v\          "virtual column number

"CtrlP installation
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 0
