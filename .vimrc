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
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
set scrolloff=25
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
highlight CursorLine guibg=#30ffff ctermbg=darkgrey
highlight LineNr ctermfg=black ctermbg=grey
highlight clear LineNr
highlight clear SignColumn
set hlsearch
hi Search guibg=LightBlue
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
  nnoremap u i
  vnoremap u i
    " undo
  nnoremap U u
  vnoremap U u
    " redo
  noremap <leader>r <C-r>
  nnoremap n j
  vnoremap n j
  nnoremap e k
  vnoremap e k
  nnoremap i l
  vnoremap i l
    " jump up/down 10 lines
    " Backspace once
  map <leader>, 10j
  map <leader>. 10k
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
Plug 'edkolev/tmuxline.vim'

    " TMUX stuff
Plug 'christoomey/vim-tmux-navigator'

    " Rust 
Plug 'rust-lang/rust.vim'
Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'
Plug 'vim-syntastic/syntastic'

    " GraphQL
Plug 'jparise/vim-graphql'

    " VIM autocomplete suggestions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

    " File/content search
    " :Rg = find content
Plug 'jremmen/vim-ripgrep'
    " :Files = fuzzzy search file by path and name
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <leader><BS> :Files<cr>
    " fuzzy search cli
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim'
    " :CtrlP = find file
    " :CtrlPBuffer = find buffer
    " :CtrlPMixed = both
Plug 'ctrlpvim/ctrlp.vim'

    " Find text
Plug 'easymotion/vim-easymotion'

    " VIM Docs fuzzy search
Plug 'sunaku/vim-shortcut'
map <leader>s :Shortcuts<cr>

    " Auto-format file on save
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
   " Move current line up/down with 'shift+up/down'
Plug 'vim-scripts/upAndDown'
Plug 'Shougo/denite.nvim'
Plug 'yuttie/comfortable-motion.vim'

    " Tabs
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"   - t = Open selected to new tab
"   - s = Open as Vertical Split window
"   - i = Open as Horizontal Split window
"   - Toggle nerdtree explorer
map <leader>b <plug>NERDTreeTabsToggle<CR>
"   - CD nerdtree to current file
map <leader>cd :NERDTreeFind<CR>

    " Outside VIM(Chrome/Brave)
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

    " Debugger
Plug 'puremourning/vimspector'
call plug#end()

    "Activate Plug features
let g:rainbow_active = 1
let g:airline#extensions#tabline#enabled = 1
let g:vimspector_enable_mappings = 'HUMAN'
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

    " Nerdtree, remap directional keys to arrow keys
autocmd FileType nerdtree noremap <buffer> e <Up>
autocmd FileType nerdtree noremap <buffer> n <Down>
autocmd FileType nerdtree noremap <buffer> h <Left>
autocmd FileType nerdtree noremap <buffer> i <Right>

    " VIM Activate theme
colorscheme monokai
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"==============================================================================
" NON-Plugin Commands
"==============================================================================

" WINDOWS
" :vsp = vertical split
  map <leader>m :vsp<CR> 
" :sp = horizontal split
  map <leader>N :sp<CR> 
" :q! = close window 
  " map <leader>d :q!<CR> 
  map <leader>d :q!<CR> 

set splitbelow
set splitright
" WINDOW NAVIGATION
" - move down
nnoremap <leader>n <C-W><C-J>
" - move up 
nnoremap <leader>e <C-W><C-K>
" - move right
nnoremap <leader>i <C-W><C-L>
" - move left
nnoremap <leader>h <C-W><C-H>

" TABS
" - Select next/previous
map <leader>w :tabnext<CR>
map <leader>q :tabprevious<CR>

endif
