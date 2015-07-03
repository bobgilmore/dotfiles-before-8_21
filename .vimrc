set encoding=utf-8

" From tpope/pathogen.vim

execute pathogen#infect()
execute pathogen#helptags()

" End tpope/pathogen.vim

" From https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" Leader
let mapleader = "\<Space>"

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Switch on highlighting the last used search pattern.
if (&t_Co > 2)
  syntax enable
endif

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

let g:Powerline_symbols = 'fancy'

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Markdown files end in .md
au BufRead,BufNewFile *.md set filetype=markdown

" Enable spellchecking for Markdown
au BufRead,BufNewFile *.md setlocal spell

" Automatically wrap at 80 characters for Markdown
" au BufRead,BufNewFile *.md setlocal textwidth=80

" end from

filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

au BufRead,BufNewFile *.go set filetype=go

set hlsearch
set number
set ignorecase
set smartcase
set title
set wildmode=list:longest " Activate tab auto-completion for file paths
set showcmd

" more...
set hidden
let NERDTreeShowHidden=1

map <C-n> :NERDTreeToggle<CR>

" The Silver Searcher.  From
" http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
  " command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" From http://andrew.stwrt.ca/posts/vim-ctags
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" From https://github.com/Lokaltog/powerline/issues/39
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim

set cursorline
set relativenumber
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" Allow ;w => :w
nnoremap ; :

" toggle between number and relativenumber
function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

" From https://upcase.com/videos/onramp-to-vim-configuration
set scrolloff=4
set backspace=indent,eol,start

" Ditto.  Make scrolling through wrapped lines tolerable
nmap k gk
nmap j gj
