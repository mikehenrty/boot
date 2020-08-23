" Use vim-plug.
call plug#begin('~/.vim/plugged')
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'cespare/vim-toml'
call plug#end()

set nocompatible

set number
syntax on
colorscheme ir_black
set mouse=a

"don't use safe writes
set nobackup
set nowritebackup

"add .jsm extension for javascript
au BufNewFile,BufRead *.jsm set filetype=javascript

" set filetypes as typescript.tsx
au BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
au BufNewFile,BufRead *.ts set filetype=typescript

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

" Add fzf (fuzzy find)
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" This is the default extra key bindings
let g:fzf_action = { 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
map <C-p> :Files<CR>
map ; :Buffers<CR>

" Python configure maximum line checking
let g:pymode_options_max_line_length = 88

" Configure :Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
map <C-f> :Ack!<Space>

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
