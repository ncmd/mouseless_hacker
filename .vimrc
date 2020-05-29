    " INITIAL SETUP
    " - FIRENVIM: Chrome/Brave
    "   If on Mac OS X, install VimMode.spoon + Hammerspoon:
    "   bash <(curl -s https://raw.githubusercontent.com/dbalatero/VimMode.spoon/vim-mode-v2/bin/installer)
    "
    " - TMUX: Reduce escape delay
    " add 'set -sg escape-time 1'
    " reload tmux: ctrl+w ':source-file ~/.tmux.conf'

syntax on
    " Allow paste into vim
set mouse=
set cursorline
set nonumber
set hidden
    " no error sounds
set noerrorbells
    " tabs always 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
    " keep visual mode when indenting
vnoremap < <gv
vnoremap > >gv

set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
set scrolloff=0
set autoread

" MAP Leader (as <leader>, press SPACE once, DO NOT HOLD)
let mapleader="\<Space>"

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=1

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

    " VimBeGood helper
highlight CursorLine guibg=#303030 ctermbg=darkgrey
highlight LineNr ctermfg=black ctermbg=grey
highlight clear LineNr
highlight clear SignColumn
set hlsearch
hi Search guibg=LightBlue
    " trailing spaces
let @/='\s\+$'
let @/='\<DELETE ME\>'
    " highlight wholeline
let @/ = '.*'.@/.'.*'
sign define wholeline linehl=ErrorMsg
sign place 1 name=wholeline line=123

    " vim-numbertoggle
set number relativenumber
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
    " COLEMAK setup
  nnoremap <>
  nnoremap u i
  vnoremap u i
    " undo
  nnoremap U u
  vnoremap U u
    " redo
  noremap <leader>r <C-r>
    " down
  nnoremap n j
  vnoremap n j
    " up
  nnoremap e k
  vnoremap e k
    " right
  nnoremap i l
  vnoremap i l
    " left =nn h
    " VIM plugin manager
call plug#begin('~/.config/nvim/plugged')

   " type :VimBeGood to play
Plug 'ThePrimeagen/vim-be-good'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
    " VIM theme
Plug 'crusoexia/vim-monokai'
    " Airline Stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'

    " TMUX stuff
Plug 'christoomey/vim-tmux-navigator'

    " Rust
Plug 'phildawes/racer'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'vim-syntastic/syntastic'
Plug 'dense-analysis/ale'

    " GraphQL
Plug 'jparise/vim-graphql'

    " VIM autocomplete suggestions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
nnoremap <leader>cocr :CocRestart<CR>
    " :coc-marketplace
    " :coc-rls

set wildmode=longest,list,full

Plug 'sheerun/vim-polyglot'

"==============================================================================
" File/content search
"==============================================================================
    " :Rg = find content
Plug 'jremmen/vim-ripgrep'
    " :Files = fuzzzy search file by path and name
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <leader><BS> :Files<CR>
    " fuzzy search cli
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim'
    " :CtrlP = find file
    " :CtrlPBuffer = find buffer
    " :CtrlPMixed = both
Plug 'ctrlpvim/ctrlp.vim'
    " Find text
Plug 'easymotion/vim-easymotion'
    " Default = <leader><leader>f

    " Text replace
Plug 'tpope/vim-abolish'
    " REPLACE
    "map <leader>a :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
    " SUBSTITUTION
    "map <leader>s  :%Subvert/facilit{y,ies}/building{,s}/g
    "               :Subvert/blog{,s}/post{,s}/g
    "               :Subvert/address{,es}/reference{,s}/g
    "               :Subvert/child{,ren}/adult{,s}/g
    "               :Subvert/di{e,ce}/spinner{,s}/g
    " COERSION
    " FOO_BAR -> foo_bar = crs (snake_case)
    " fooBar -> FooBar = crm (MixedCase)
    " foo_bar -> fooBar = crc (camelCase)
    " fooBar -> FOO_BAR = cru (UPPERCASE)
    " foo-bar -> foo-bar = cr- (dash-case)
    " fooBar -> foo.bar = cr. (dot.case)
    " fooBar -> foo bar = cr<space> (space case)
    " fooBar -> Foo Bar = crt (Title Case)
"==============================================================================
" Auto-format file on save
"==============================================================================
Plug 'Chiel92/vim-autoformat'
Plug 'godlygeek/tabular'

    " Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

    " Matching Parentesis
Plug 'luochen1990/rainbow'
    " Edit Surroundings
    " cs'<a> = 'word' -> <a>word</a>
    " cs]{ = [word] -> {word}
Plug 'tpope/vim-surround'
    " Comment in normal mode with 'gcc'
    " Comment block in visual mode with 'gc'
Plug 'tomtom/tcomment_vim'

   " Move selected line up/down with <leader>,/<leader>.
" move selected lines up one line
" move selected lines down one line
xnoremap N :m-2<CR>gv=gv
xnoremap E :m'>+<CR>gv=gv
    " Repeat command
Plug 'tpope/vim-repeat'
    "silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
    " Clipboard
Plug 'svermeulen/vim-easyclip'
"==============================================================================
" Tabs
"==============================================================================
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"   - t = Open selected to new tab
"   - s = Open as Vertical Split window
"   - i = Open as Horizontal Split window
"   - Toggle nerdtree explorer
map <leader>b <plug>NERDTreeTabsToggle<CR>
"    - CD nerdtree to current file
map <leader>cd :NERDTreeFind<CR>

" - Select next/previous tab
map <leader>w :tabnext<CR>
map <leader>q :tabprevious<CR>

"==============================================================================
" WINDOWS
"==============================================================================
set splitbelow
set splitright
" :vsp = vertical split
map <leader>m :vsp<CR>
" :sp = horizontal split
map <leader>N :sp<CR>
" :q! = close window
map <leader>d :q!<CR>
" :q! = close window
map <leader>s :w<CR><C-c>
" open recently closed split window
nmap <c-s-t> :vs<bar>:b#<CR>

" WINDOW NAVIGATION
" - move down
nnoremap <leader>n <C-W><C-J>
" - move up
nnoremap <leader>e <C-W><C-K>
" - move right
nnoremap <leader>i <C-W><C-L>
" - move left
nnoremap <leader>h <C-W><C-H>

Plug 'shougo/denite.nvim'
Plug 'shougo/deol.nvim'
    " Outside VIM(Chrome/Brave)
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

    " Debugger
Plug 'puremourning/vimspector'

    " GIT
Plug 'tpope/vim-fugitive'

    " Databases
Plug 'tpope/vim-dadbod'
    " :DB mongodb:///test
    " :DB g:prod = postgres://user:pass@db.example.com/production_database
    " :DB g:prod drop table users

    " Sessions
Plug 'tpope/vim-obsession'
    " :mksession = create session as Session.vim in cwd
    " :Obsess = start record session
    " :Obsess! = end record session

call plug#end()

"==============================================================================
"Activate Plug features
"==============================================================================
" Always show syntastic window
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:rainbow_active = 1
let g:airline#extensions#tabline#enabled = 1
let g:vimspector_enable_mappings = 'HUMAN'
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left
let g:NERDDefaultAlign = 'left'
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" Open NERDTree on gvim/macvim startup. (When set to 2, open only if directory was given as startup argument).
let g:nerdtree_tabs_open_on_gui_startup = 1
" Open NERDTree on console vim startup. (When set to 2, open only if directory was given as startup argument).
let g:nerdtree_tabs_open_on_console_startup = 1
" Do not open NERDTree if vim starts in diff mode
let g:nerdtree_tabs_no_startup_for_diff = 1
" On startup, focus NERDTree if opening a directory, focus file if opening a file. (When set to 2, always focus file window after startup).
let g:nerdtree_tabs_smart_startup_focus = 2
" Open NERDTree on new tab creation (if NERDTree was globally opened by :NERDTreeTabsToggle)
let g:nerdtree_tabs_open_on_new_tab = 1
" Unfocus NERDTree when leaving a tab for descriptive tab names
let g:nerdtree_tabs_meaningful_tab_names = 1
" Close current tab if there is only one window in it and it's NERDTree
let g:nerdtree_tabs_autoclose = 0
" Synchronize view of all NERDTree windows (scroll and cursor position)
let g:nerdtree_tabs_synchronize_view = 1
" Synchronize focus when switching windows (focus NERDTree after tab switch if and only if it was focused before tab switch)
let g:nerdtree_tabs_synchronize_focus = 1
" When switching into a tab, make sure that focus is on the file window, not in the NERDTree window. (Note that this can get annoying if you use NERDTree's feature "open in new tab silently", as you will lose focus on the NERDTree.)
let g:nerdtree_tabs_focus_on_files = 1
" When given a directory name as a command line parameter when launching Vim, :cd into it.
let g:nerdtree_tabs_startup_cd = 0
" Automatically find and select currently opened file in NERDTree.
let g:nerdtree_tabs_autofind = 1

" Ale
let g:ale_linters = {'rust': ['analyzer']}

" Rustfmt autosave
let g:rustfmt_autosave = 1
    " Nerdtree, remap directional keys to arrow keys
autocmd FileType nerdtree noremap <buffer> e <Up>
autocmd FileType nerdtree noremap <buffer> n <Down>
autocmd FileType nerdtree noremap <buffer> h <Left>
autocmd FileType nerdtree noremap <buffer> i <Right>

"==============================================================================
" VIM Activate theme
"==============================================================================
colorscheme monokai
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }

"==============================================================================
" NON-Plugin Commands
"==============================================================================
"
" Auto Save Vimrc
map <leader>vimrc :tabe ~/.vim/.vimrc<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

" bug fix to nerdtree + vim-obsession
set sessionoptions-=blank


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

endif
