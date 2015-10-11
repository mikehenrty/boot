set nocompatible

set number
syntax on
colorscheme ir_black
set mouse=a

"add .jsm extension for javascript
au BufNewFile,BufRead *.jsm set filetype=javascript

"display tabs and trailing spaces
set list
set listchars=tab:⋅\ ,trail:⋅,nbsp:⋅

set wrap "dont wrap lines
set linebreak "wrap lines at convenient points

"disable swap file creation
set noswapfile

set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set lazyredraw
set showmatch

"prettify search
set incsearch
set hlsearch

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"configure viminfo
set viminfo='10,\"100,:20,n~/.viminfo

"use the same yank buffer for all windows
set clipboard=unnamedplus

"make ! commands use my shell config
set shellcmdflag=-ic

"use undo history
set undofile
set undodir=~/.vimundo/

"use better tab completion for file names
set wildmode=longest:full
set wildmenu

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
hi StatusLineNC ctermbg=244 ctermfg=Black
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
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
map <C-b> :CtrlPBuffer<CR>
