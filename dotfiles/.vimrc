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

"Use Pathogen to load plugins
execute pathogen#infect()
filetype plugin indent on

"CtrlP installation
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
map <C-b> :CtrlPBuffer<CR>

" Comment or uncomment lines from mark a to mark b.
function! CommentMark(docomment, a, b)
  if !exists('b:comment')
    let b:comment = CommentStr() . ' '
  endif
  if a:docomment
    exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
  else
    exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
  endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
  call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
  call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
  if &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
    return '//'
  elseif &ft == 'vim'
    return '"'
  elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R'
    return '#'
  elseif &ft == 'lisp'
    return ';'
  endif
  return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>
