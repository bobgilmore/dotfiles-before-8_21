" From tpope/pathogen.vim

execute pathogen#infect()
execute pathogen#helptags()

" End tpope/pathogen.vim

" From https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" Leader
let mapleader = " "

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

set hlsearch
set number
set ignorecase
set smartcase
set title
set wildmode=list:longest " Activate tab auto-completion for file paths

" more...
set hidden
let NERDTreeShowHidden=1

map <C-n> :NERDTreeToggle<CR>
