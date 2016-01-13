"###################################################################"
"       Setup                                                       "
"###################################################################"
"{{{
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vundle{{{
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'

" Passive
Plugin 'christoomey/vim-tmux-navigator'     " seamless navigation tmux<>vim
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimproc.vim'
Plugin 'mhinz/vim-startify'
Plugin 'airblade/vim-rooter'

Plugin 'tpope/vim-repeat'

Plugin 'mhinz/vim-signify'
Plugin 'kshenoy/vim-signature'              " display and improve marks
Plugin 'scrooloose/syntastic'

" Active Editing
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

" Active Tools
Plugin 'rking/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'majutsushi/tagbar'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/vimfiler.vim'

Plugin 'ervandew/supertab'

" Navigation / Movement
Plugin 'Lokaltog/vim-easymotion'            " better navigation
Plugin 'vim-scripts/argtextobj.vim'

" Colorschemes
Plugin 'dzan/mustang-vim'
Plugin 'endel/vim-github-colorscheme'
Plugin 'NLKNguyen/papercolor-theme'

" Markdown
Plugin 'suan/vim-instant-markdown'
Plugin 'plasticboy/vim-markdown'

" Java
Plugin 'simonhicks/gradle-vim-syntastic-plugin'

" Go
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"}}}

filetype plugin indent on   " detect plugins and indentation based on filetype
syntax on

set nocompatible            " don't need to be compatile with vi
set modelines=0             " prevent security exploits with modelines
                            " http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
"}}}

"###################################################################"
"       General options                                             "
"###################################################################"
" {{{
set encoding=utf-8
set showcmd                " Show (partial) command in status line.
set showmatch              " Show matching brackets.
set autowrite              " Automatically save before commands like :next and :make
set hidden                 " Hide buffers when they are abandoned
set scrolloff=3            " Number of lines to always preserve between screenedge & cursor
set t_Co=256               " Assume the terminal has only 256 colors, for tmux

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=light
set colorcolumn=85         " Mark the eol column to keep our formatting tight

"colorscheme mustang
colorscheme PaperColor

" Enable line number
set number
set relativenumber           " dislay relative line numbers for movement cmd

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Extra syntax support {{{
" TLA+ syntax highlighting support.
au BufRead,BufNewFile *.tla set filetype=tla
au FileType tla set syntax=tla

" Markdown highlighting
au BufNewFile,BufRead *.md set ft=markdown

" Gradle files groovy syntax hl
au BufNewFile,BufRead *.gradle setf groovy
"}}}

" Indentation {{{
set tabstop=4             " a tab is four spaces
set expandtab             " don't use tabs, insert spaces Ctrl-V Tab inserts a real tab

set autoindent            " always set autoindenting on
set copyindent            " copy the previous indentation on autoindenting
set shiftwidth=4          " number of spaces to use for autoindenting
set shiftround            " use multiple of shiftwidth when indenting with '<' and '>'
"}}}

set foldmethod=marker              " User markers if available to fold
set backspace=indent,eol,start     " allow backspacing over everything in insert mode

" Handling search behaviour {{{
set ignorecase               " ignore case when searching
set smartcase                " ignore case if search pattern is all
set incsearch
set showmatch
set hlsearch
"}}}

" History {{{
set history=1000             " remember more commands and search history
set undolevels=1000          " retain my undo levels
set wildignore=*.swp,*.bak,*.class
set nobackup                 " no backup files!
set noswapfile               " no backup files
set undofile                 " create undo file keeps working after open/close
set undodir=~/.vim/tmp/      " don't leave the undo files everywhere
set backupdir=~/.vim/tmp/    " don't leave the undo files everywhere
"}}}

" Terminal behaviour {{{
set title                    " change the terminal's title
set visualbell               " don't beep
set noerrorbells             " don't beep
set mouse=a                  " enable using the mouse if terminal emulator
                             " supports it (xterm does)
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  " http://sunaku.github.io/vim-256color-bce.html
  set t_ut=
endif

" mac paste to default keyboard also inside tmux
"if $TMUX == ''
"        set clipboard+=unnamed
"endif
set clipboard=unnamedplus
"}}}

" grepping {{{
set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
set grepformat=%f:%l:%c:%m
"}}}

" Hidden characters {{{
set list
set listchars=tab:▸\ ,eol:¬
"}}}

" Line Wrapping {{{
set formatoptions+=1         " When wrapping paragraphs, don't end lines
                             "    with 1-letter words (looks stupid)
"set nowrap                  " don't wrap lines
"}}}

" Misc
au FocusLost * :wa           " save on focus lost

" Window management {{{
set splitbelow               " default new window position
set splitright               " default new window position
"}}}

" Spell Check Toggle bound to F7 none-english-dutch {{{
let b:myLang=0
let g:myLangList=["nospell","nl","en_gb"]
"}}}

"}}}

"###################################################################"
"     Functions                                                     "
"###################################################################"
"{{{
" toggle different spelling languages {{{
function! ToggleSpell()
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
endfunction "}}}

" close window and delete buffer {{{
" https://github.com/bling
function! CloseWindowOrKillBuffer()
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    " never bdelete a nerd tree
    if matchstr(expand("%"), 'NERD') == 'NERD'
        wincmd c
        return
    endif

    if number_of_windows_to_this_buffer > 1
        wincmd c
    else
        bdelete
    endif
endfunction "}}}

" execute command and preserve history and cursor {{{
" https://github.com/bling
function! Preserve(command)
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction "}}}
"}}}

"###################################################################"
"     Key bindings                                                  "
"###################################################################"
"{{{
let mapleader = ","

" smash escape
inoremap jk <esc>
inoremap kj <esc>

" yank filename.c:linenumber to the system clipboard
nnoremap <leader>y :let @+=expand('%:t') . ':' . line(".")<CR>

" Force correct usage
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Disable Help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

set pastetoggle=<F5>                                " when in insert mode, press <F5> to go to
                                                    " paste mode, where you can paste mass data
                                                    " that won't be autoindented

map <S-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Window management key rebinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize current buffer by +/- 5
"nnoremap <C-W><M-J>:vertical resize -5<cr>
"nnoremap <C-W><M-K>:resize +5<cr>
"nnoremap <C-W><M-L>:resize -5<cr>
"nnoremap <C-W><M-H>:vertical resize +5<cr>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Formatting key shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Remove trailing whitespace
" %s/\s\+$//e
nmap <leader>f$ <C-u>:%s/\s\+$//<cr>:let @/=''<CR>
" Remove trailing whitespace
vmap <leader>f$ <C-u>:%s/\s\+$//<cr>:let @/=''<CR>
" Format whole file
nmap <leader>fef <C-u>:call Preserve("normal gg=G")<CR>
" Sort selection
vmap <leader>fs <C-u>:sort<cr>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Git binds - using Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>

autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

nnoremap <silent> <leader>gv :Gitv<CR>
nnoremap <silent> <leader>gV :Gitv!<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Signify git key addendum
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let g:signify_mapping_toggle_highlight = '<leader>gh'   "use Signify plugin to highlight the changes

nmap <leader>gj <plug>(signify-next-jump)               "jump to next hunk using Signify
nmap <leader>gk <plug>(signify-prev-jump)               "jump to previous hunk using Signify
"}}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Tabular align binds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        Map some of the functions to keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nmap <silent> <F7> :call ToggleSpell()<cr>
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>

" Plugin windows
"nnoremap <F2> :NERDTreeTabsToggle<CR>
"nnoremap <F3> :NERDTreeFind<CR>
nnoremap <F4> :TagbarToggle<CR>
nnoremap <F6> :GundoToggle<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        Move lines up and down
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
"" http://reefpoints.dockyard.com/2013/09/26/vim-moving-lines-aint-hard.html
" Normal mode
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==

" Insert mode
"inoremap <C-j> <ESC>:m .+1<CR>==gi
"inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
"}}}
"}}}

"###################################################################"
"     Plugin Configuration                                          "
"###################################################################"
"{{{
"""""""""""""""""""""""""""""""
" Airline-Vim
"""""""""""""""""""""""""""""""
" {{{
let g:airline#extensions#tabline#enabled = 1        " Let airline handle the tabs bar
let g:airline#extensions#tabline#tab_nr_type = 1    " tab number
let g:airline_powerline_fonts = 1                   " user powerline font patch
let g:airline_theme='PaperColor'

set laststatus=2                                    " necesarry for airline to show
" }}}

"""""""""""""""""""""""""""""""
" Startify
"""""""""""""""""""""""""""""""
" {{{
let g:startify_session_dir = '~/.vim/.cache/sessions'
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
nnoremap <F1> :Startify<cr>
" }}}

"""""""""""""""""""""""""""""""
" Ack.vim
"""""""""""""""""""""""""""""""
" {{{
let g:ackprg = "ag --nogroup --column --smart-case --follow"
" }}}

"""""""""""""""""""""""""""""""
" Rainbow Parenthesses
"""""""""""""""""""""""""""""""
" {{{
let g:rbpt_colorpairs = [
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['brown',       'RoyalBlue3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

nnoremap <silent> <leader>r :RainbowParenthesesToggle<cr>
"nnoremap <silent> <leader>:RainbowParenthesesLoadRound<cr>
"nnoremap <silent> <leader>:RainbowParenthesesLoadSquare<cr>
nnoremap <silent> <leader>rç :RainbowParenthesesLoadBraces<cr>
"nnoremap <silent> <leader>:RainbowParenthesesLoadChevrons<cr>
"}}}

"""""""""""""""""""""""""""""""
" Unite
"""""""""""""""""""""""""""""""
" {{{
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Like gitignore but for all our sources.
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'ignore_pattern', join([
            \ '\.git/',
            \ '\.svn/',
            \ 'tags',
            \ ], '\|'))

" Default profile
call unite#custom#profile('default', 'context', {
            \   'ignorecase': 1,
            \   'prompt': '» '
            \ })

" Smartcase for files
call unite#custom#profile('files', 'context', {
            \   'smartcase': 1
            \ })

" more config
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000

" use the silversearcher for grepping
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
let g:unite_source_grep_recursive_opt=''

"" the unite window ( filetype unite ) needs Q, esc and smashesc to exit
function! Unite_settings()
    let b:SuperTabDisabled=1
    nmap <buffer> jk <plug>(unite_exit)
    nmap <buffer> kj <plug>(unite_exit)

    imap <buffer> jk <plug>(unite_exit)
    imap <buffer> kj <plug>(unite_exit)
endfunction
autocmd FileType unite call Unite_settings()

" define a 'unite' leader [unite] and assign space
nmap <space> [unite]
nnoremap [unite] <nop>

" Unite mappings
" <C-u> clears whatever is on the command prompt before entering the new command
" in buffer mappings
nnoremap <silent> [unite]b :<C-u>Unite -toggle -no-split -quick-match buffer<cr>
nnoremap <silent> [unite]o :<C-u>Unite -toggle -no-split -buffer-name=outline outline<cr>
nnoremap <silent> [unite]l :<C-u>Unite -toggle -no-split -start-insert -buffer-name=line line<cr>
nnoremap <silent> [unite]f :<C-u>Unite -toggle -no-split -start-insert -buffer-name=mixed file_mru file_rec/async bookmark<cr>

" global mappings
"nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -default-action=tabopen -buffer-name=files file_rec/async<cr><c-u>
"nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>


nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
"nnoremap <silent> [unite]c :<C-u>Unite -no-quit -buffer-name=search grep:.::<C-R><C-w><CR>
"}}}

"""""""""""""""""""""""""""""""
" Vim-Markdown
"""""""""""""""""""""""""""""""
"{{{
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_folding_disabled=1
"}}}

"""""""""""""""""""""""""""""""
" YCM
"""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
"}}}

"###################################################################"
"     Language Support                                              "
"###################################################################"
"{{{
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" Go stuff
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)

au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)

let g:go_fmt_command = "goimports"
"}}}

"###################################################################"
"     Other stuff                                                   "
"###################################################################"
"{{{
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
"}}}
