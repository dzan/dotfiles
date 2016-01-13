"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'mhinz/vim-signify'

Plug 'NLKNguyen/papercolor-theme'
Plug 'bling/vim-airline'

Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', { 'for': ['markdown', 'md'] }

Plug 'fatih/vim-go'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }

Plug 'Lokaltog/vim-easymotion'            " better navigation
Plug 'majutsushi/tagbar'

call plug#end()
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Code layout and style.
syntax on
filetype plugin indent on   " detect plugins and indentation based on filetype

colorscheme PaperColor
set background=light
set colorcolumn=85          " mark the eol column to keep our formatting tight

" Indenting
set tabstop=4             " a tab is four spaces
set expandtab             " don't use tabs, insert spaces Ctrl-V Tab inserts a real tab

set autoindent            " always set autoindenting on
set copyindent            " copy the previous indentation on autoindenting
set shiftwidth=4          " number of spaces to use for autoindenting
set shiftround            " use multiple of shiftwidth when indenting with '<' and '>'

" Handling search behaviour.
set ignorecase              " ignore case when searching
set smartcase               " ignore case if search pattern is all one case
set incsearch
set showmatch
set hlsearch

" Enable line number.
set number
set relativenumber           " dislay relative line numbers for movement cmd

" Show hidden characters.
set list
set listchars=tab:▸\ ,eol:¬

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     Key bindings                                      
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let mapleader = ","

" Plugin windows
"nnoremap <F2> :NERDTreeTabsToggle<CR>
"nnoremap <F3> :NERDTreeFind<CR>
nnoremap <F4> :TagbarToggle<CR>
"nnoremap <F6> :GundoToggle<CR>

" smash escape
inoremap jk <esc>
inoremap kj <esc>

" yank filename.c:linenumber to the system clipboard
nnoremap <leader>y :let @+=expand('%:t') . ':' . line(".")<CR>

" Force correct usage
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap j gj
nnoremap k gk

" Disable Help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Window management key rebinds
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
"""""""""""" Fzf """""""""""" 
"
let g:fzf_layout = { 'up': '~40%' }
"let g:fzf_layout = { 'window': 'enew' }

nmap <space> [fzf]
nnoremap [fzf] <nop>

nnoremap <silent> [fzf]f :<C-u>Files<cr>
nnoremap <silent> [fzf]m :<C-u>History<cr>
nnoremap <silent> [fzf]t :<C-u>Tags<cr>
nnoremap <silent> [fzf]/ :<C-u>Ag<space>

"""""""""""" Startify """""""""""" 
"
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
nnoremap <F1> :Startify<cr>

"""""""""""" Goyo/Limelight """""""""""" 
"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"""""""""""" Instant Markdown """""""""""" 
"
let g:instant_markdown_autostart = 0

"""""""""""""" Signify """""""""""""" 
"
let g:signify_mapping_toggle_highlight = '<leader>sh'   "use Signify plugin to highlight the changes

nmap <leader>sn <plug>(signify-next-jump)               "jump to next hunk using Signify
nmap <leader>sp <plug>(signify-prev-jump)               "jump to previous hunk using Signify
"}}}