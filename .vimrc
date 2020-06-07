"==============================================================================
" INITIAL SETUP
"
" - TMUX: Reduce escape delay
" add 'set -sg escape-time 1'
" reload tmux: ctrl+w ':source-file ~/.tmux.conf'
"==============================================================================

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
set guifont=Hack\ Nerd\ Font\ Mono\ 12

" keep visual mode when indenting
" use shift+< or shift+>
vnoremap < <gv
vnoremap > >gv

set incsearch

" MAP Leader (as <leader>, press SPACE once, DO NOT HOLD)
let mapleader="\<Space>"

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=1

set wrap
set colorcolumn=80
set textwidth=80
set formatoptions-=t
set wrapmargin=0
set breakindent
let &showbreak='    '

highlight ColorColumn ctermbg=0 guibg=#303030

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
" down
  nnoremap n j
  vnoremap n j
" up
  nnoremap e k
  vnoremap e k
" right
  nnoremap i l
  vnoremap i l
" left = h

" Copy to clipboard
  nnoremap Y "*y

" move up/down 10 lines
  nnoremap 7 10j
  nnoremap 8 10k
"
" Go back after GoTo definition
  nnoremap <leader>o <C-o><CR>

" Unmapping accidental normal mode keys
  nnoremap E <NOP>
  nnoremap s <NOP>
  vnoremap s <NOP>
  nnoremap S <NOP>
  nnoremap A <NOP>
  nnoremap S <NOP>
  nnoremap S <NOP>
  nnoremap M <NOP>
  nnoremap j <NOP>
  nnoremap k <NOP>

" VIM plugin manager
call plug#begin('~/.config/nvim/plugged')

" type :VimBeGood to play
Plug 'ThePrimeagen/vim-be-good'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" VIM theme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'patstockwell/vim-monokai-tasty'
Plug 'arzg/vim-rust-syntax-ext'

Plug 'mhinz/vim-signify'
" Airline Stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/promptline.vim'
Plug 'powerline/powerline'
Plug 'edkolev/tmuxline.vim'

" TMUX stuff
Plug 'christoomey/vim-tmux-navigator'

" Rust
Plug 'rust-lang/rust.vim'
nnoremap <leader>CB :CargoBuild<CR>
nnoremap <leader>CC :CargoClean<CR>
nnoremap <leader>CD :CargoDoc<CR>
nnoremap <leader>CR :CargoRun<CR>
nnoremap <leader>CT :CargoTest<CR>
nnoremap <leader>CU :CargoUpdate<CR>

Plug 'dense-analysis/ale'

"==============================================================================
" VIM autocomplete suggestions
"==============================================================================
" You will need to install racer via cargo
Plug 'racer-rust/vim-racer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" GoTo code navigation.
nmap <leader>do <Plug>(rust-doc)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gb <C-o>
nmap <leader>gr <Plug>(coc-references)
nnoremap <leader>cr :CocRestart<CR>
map <leader>CM :CocList marketplace<CR>
" :coc-rls
" :coc-marketplace
" :coc-rust-analyzer

set wildmode=longest,list,full

Plug 'sheerun/vim-polyglot'

"==============================================================================
" File/content search
"==============================================================================
" :Files = fuzzzy search file by path and name
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <leader><BS> :Files<CR>
" find text
Plug 'easymotion/vim-easymotion'
" activate = s
" search forward = /
" search backward = ?
" search current visible = g/
" clear search
map s <Plug>(easymotion-overwin-f)
" repeat search
map sr <Plug>(easymotion-repeat)
map /// :let @/ = ""<CR>
Plug 'haya14busa/incsearch.vim'
map f/  <Plug>(incsearch-forward)
map f?  <Plug>(incsearch-backward)
map fg/ <Plug>(incsearch-stay)
Plug 'haya14busa/incsearch-fuzzy.vim'
map / <Plug>(incsearch-fuzzy-/)
map ? <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)
Plug 'haya14busa/incsearch-easymotion.vim'
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" Text replace
Plug 'tpope/vim-abolish'
" REPLACE
" map <leader>a :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}
"
" SUBSTITUTION
" map <leader>s  :%Subvert/facilit{y,ies}/building{,s}/g
"                :Subvert/blog{,s}/post{,s}/g
"                :Subvert/address{,es}/reference{,s}/g
"                :Subvert/child{,ren}/adult{,s}/g
"                :Subvert/di{e,ce}/spinner{,s}/g
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

Plug 'godlygeek/tabular'

" Matching Parentesis
Plug 'frazrepo/vim-rainbow'
" Matching Indent
Plug 'yggdroot/indentline'
Plug 'Yggdroot/hiPairs'

" Edit Surroundings
" highlight word in visual mode -> shift+S -> {char} = {char}word{char}
" cs'<a> = 'word' -> <a>word</a>
" cs]{ = [word] -> {word}
Plug 'tpope/vim-surround'
" Comment in normal mode with 'gcc'
" Comment block in visual mode with 'gc'
Plug 'tomtom/tcomment_vim'
" remap to <leader>c
map <leader>cc gcc

let @/='\<DELETE ME\>'
" move selected lines down one line
" Repeat command
Plug 'tpope/vim-repeat'

"==============================================================================
" Tabs
"==============================================================================

Plug 'preservim/nerdtree'
"   - C = cd to directory
"   - U = move up directory
"   - I = show hidden files
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

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

" Resize current window
map H :vertical resize +5<CR>
map I :vertical resize -5<CR>
" Resize all evenly
map = <C-w>=<CR>

" :vsp = vertical split
map <leader>mm :vsp<CR>
" :sp = horizontal split
map <leader>NN :sp<CR>
" :q! = close window
map <leader>dd :q!<CR>
map <leader>DD :qa!<CR>
" :q! = close window
map <leader>ss :w<CR><C-c>

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
Plug 'rhysd/rust-doc.vim'
map <leader>df :RustDocFuzzy<Space>
map <leader>dm :RustDocModule<Space>

" Sessions
Plug 'tpope/vim-obsession'
" :mksession = create session as Session.vim in cwd
map <leader>mk :mksession!<CR>
"
" :Obsess = start record session
" :Obsess! = end record session

Plug 'kshenoy/vim-signature'
" mark
nnoremap ma ma
nnoremap mt mt
nnoremap mm <NOP>
" remove mark
"   m
map mx m-
" next and previous mark
nnoremap mn ]`
nnoremap me [`
" View all marks
"   m/

Plug 'jparise/vim-graphql'

" Have same bash shortcuts in Insert mode
Plug 'tpope/vim-rsi'

call plug#end()

"==============================================================================
"Activate Plug features
"==============================================================================

" Rust Docs
let g:rust_doc#downloaded_rust_doc_dir = '~/rust-docs/'

let g:racer_cmd = "~/.cargo/bin/racer"

let g:racer_experimental_completer = 1
let g:racer_insert_paren = 0

let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.rs' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['Gold1', 'MediumOrchid1', 'FireBrick3', 'DodgerBlue1' ]
let g:rainbow_ctermfgs = ['lightblue', 'green', 'yellow', 'red']

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

let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "MODIFIED",
    \ "Staged"    : "STAGED",
    \ "Untracked" : "UNTRACKED",
    \ "Renamed"   : "RENAMED",
    \ "Unmerged"  : "UNMERGED",
    \ "Deleted"   : "DELETED",
    \ "Dirty"     : "DIRTY",
    \ "Clean"     : "CLEAN",
    \ 'Ignored'   : 'IGNORED',
    \ "Unknown"   : "UNKNOWN"
    \ }


" Ale
let g:ale_linters = {'rust': ['analyzer']}

" Rustfmt autosave
let g:rustfmt_autosave = 0
" Nerdtree, remap directional keys to arrow keys
autocmd FileType nerdtree noremap <buffer> e <Up>
autocmd FileType nerdtree noremap <buffer> n <Down>
autocmd FileType nerdtree noremap <buffer> h <Left>
autocmd FileType nerdtree noremap <buffer> i <Right>

" Vim incsearch with easymotion
let g:incsearch#auto_nohlsearch = 1
map N  <Plug>(incsearch-nohl-N)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
"==============================================================================
" VIM Activate theme
"==============================================================================
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
colorscheme vim-monokai-tasty

set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" CUSTOM VIM COLORS
" hi Search guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold
" hot key for what color is this
nmap <leader>wc :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>

hi NERDTreeDir guifg=#FFFFFF guibg=#000000 gui=bold ctermfg=white ctermbg=NONE cterm=bold
hi NERDTreeGitStatusModified guifg=#66D9EF guibg=#000000 gui=bold ctermfg=lightblue ctermbg=NONE cterm=bold
hi NERDTreeGitStatusIgnored guifg=#F92672 guibg=#000000 gui=bold ctermfg=red ctermbg=NONE cterm=bold
hi NERDTreeGitStatusDirDirty guifg=#66D9EF guibg=#000000 gui=bold ctermfg=green ctermbg=NONE cterm=bold
hi NERDTreeGitStatusUntracked guifg=#A7ED1A guibg=#000000 gui=bold ctermfg=green ctermbg=NONE cterm=bold

" not usind vim-rust-syntax-ext
" hi rustModPath ctermfg=white
" hi rustIdentifier ctermfg=white
" hi rustTypedef guifg=#62D8F1
" hi rustType guifg=#62D8F1
" hi rustMacro guifg=#62D8F1
" hi rustDerive guifg=#FFFFFF
" hi rustAttribute guifg=#FFFFFF
" hi rustEnum guifg=#62D8F1
" hi rustTrait guifg=#FC1A70
" hi rustStructure guifg=#62D8F1
" hi rustFuncCall guifg=#A7ED1A
" hi rustFuncName guifg=#A4E400
" hi rustKeyword guifg=#B70444
" hi rustAsync guifg=#B70444
" hi rustRepeat guifg=#FC1A70
" hi rustConditional guifg=#ff80bf
" hi rustSelf guifg=#FF9700
" hi rustString guifg=#ff7ab2
" hi rustStringDelimiter guifg=#d9c97c
" hi rustStorage guifg=#ff9580
" hi rustCommentLine guifg=#bebebe

" vim-rust-syntax-ext
hi rsModule guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsFuncDef guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsIdentDef guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserMacro guifg=#A7ED1A guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsUserType guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserIdent guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserFunc guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsUserMethod guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsLibraryType guifg=#66D9EF guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsLibraryMacro guifg=#66D9EF guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsFieldAccess guifg=#66D9EF guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsAttribute guifg=#B70444 guibg=#000000 ctermfg=red ctermbg=NONE
hi rsForeignType guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsForeignFunc guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE

" hi op_lv0 guifg=#F92672 guibg=NONE ctermfg=magenta ctermbg=NONE
" hi op_lv1 guifg=#F92672 guibg=NONE ctermfg=magenta ctermbg=NONE
" hi op_lv2 guifg=#F92672 guibg=NONE ctermfg=magenta ctermbg=NONE
" hi op_lv3 guifg=#F92672 guibg=NONE ctermfg=magenta ctermbg=NONE
" hi op_lv4 guifg=#F92672 guibg=NONE ctermfg=green ctermbg=NONE
" hi op_lv5 guifg=#F92672 guibg=NONE ctermfg=green ctermbg=NONE
" hi op_lv6 guifg=#F92672 guibg=#000000 ctermfg=green ctermbg=NONE
" hi op_lv7 guifg=#F92672 guibg=#000000 ctermfg=green ctermbg=NONE

hi SignifySignAdd ctermfg=green guifg=#A7ED1A cterm=NONE gui=NONE
hi SignifySignDelete ctermfg=red guifg=#F92672 cterm=NONE gui=NONE
hi SignifySignChange ctermfg=lightblue guifg=#66D9EF cterm=NONE gui=NONE
"
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }
let g:promptline_theme = 'dracula'
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1


let g:signify_sign_add    = '█'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '►'
let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines

let g:indentLine_setColors = 1
let g:indentLine_char_list = ['┊','¦','|', '┃', '║', '░','▒','█']
let g:indentLine_setConceal = 1
let g:indentLine_enabled = 1

let g:hiPairs_enable_matchParen = 1
let g:hiPairs_timeout = 1
let g:hiPairs_insert_timeout = 1
let g:hiPairs_stopline_more = 100
let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
            \                  'cterm'   : 'bold',
            \                  'ctermfg' : '0',
            \                  'ctermbg' : 'lightgreen',
            \                  'gui'     : 'bold',
            \                  'guifg'   : 'Black',
            \                  'guibg'   : '#A7ED1A' }

let g:hiPairs_hl_unmatchPair = { 'term'    : 'underline,italic',
            \                    'cterm'   : 'italic',
            \                    'ctermfg' : '15',
            \                    'ctermbg' : '12',
            \                    'gui'     : 'italic',
            \                    'guifg'   : 'White',
            \                    'guibg'   : 'Red' }

" autocmd InsertEnter *
" autocmd InsertLeave *
set updatetime=100
" Update Git signs every time the text is changed
autocmd User SignifySetup
            \ execute 'autocmd! signify' |
            \ autocmd signify TextChanged,TextChangedI * call sy#start()
"==============================================================================
" NON-Plugin Commands
"==============================================================================

" bug fix to nerdtree + vim-obsession
set sessionoptions-=blank

" Source VIMRC
map <leader>FS :source ~/.vimrc<CR>
" Install PLUGINS

map <leader>FI :PlugInstall<CR>
map <leader>FC :PlugClean<CR>
map <leader>FU :PlugUpdate<CR>

endif
