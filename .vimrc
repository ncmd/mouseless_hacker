"==============================================================================
" INITIAL SETUP
" If having syntax error, use command:
"  export VIMRUNTIME=/usr/share/vim/vim82
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
set clipboard=unnamedplus
" no error sounds
set noerrorbells
" tabs always 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guifont=Fira\ Code\ 12

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

set undodir=~/.vim/undodir

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
  noremap R <C-r>
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
  vnoremap Y "+y
  nnoremap Y "+y

" Select cursor to rest of line to buffer
  vnoremap u $y
  vnoremap o $"_dP

" move up/down 10 lines
  nnoremap 7 10j
  nnoremap 8 10k
"
" Go back after GoTo definition
  nnoremap <leader>o <C-o><CR>

" blackhole buffer with leader+p
  nnoremap <leader>p "_dP
  vnoremap <leader>p "_dP


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
" disable f1
  nnoremap <F1> <NOP>

" markdown hidden maps
" <leader> = on a line with '- '
" will add a checkbox [ ] | [x]
" Example
" - test line
" - [ ] test line
" blackhole markdown bullet with leader+a
  nnoremap <leader>a <NOP>
  nnoremap <leader>u <NOP>
  nnoremap <leader>v <NOP>
  nnoremap <leader>x <NOP>
  nnoremap <leader>z <NOP>
  nnoremap <leader>e <NOP>

" VIM plugin manager
call plug#begin('~/.config/nvim/plugged')

Plug 'jeffkreeftmeijer/vim-numbertoggle'
" VIM theme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'patstockwell/vim-monokai-tasty'

" Code/git modifications
Plug 'mhinz/vim-signify'

" File history
Plug 'mbbill/undotree'
nnoremap <leader>us :UndotreeShow<CR>

" Airline Stuff
Plug 'itchyny/lightline.vim'
Plug 'edkolev/promptline.vim'
Plug 'powerline/powerline'
Plug 'edkolev/tmuxline.vim'

" TMUX stuff
Plug 'christoomey/vim-tmux-navigator'

" Code Completion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

"==============================================================================
" VIM autocomplete suggestions
"==============================================================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'ray-x/go.nvim'

Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'nvim-treesitter/nvim-treesitter'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'w0rp/ale'

Plug 'andrejlevkovitch/vim-lua-format'
Plug 'mhartington/formatter.nvim'

"love25
Plug 'S1M0N38/love2d.nvim'

" Install following manually:
" :CocInstall coc-svelte
" :CocInstall coc-rls
" :CocInstall coc-elixir

" GoTo code navigation.
nmap <leader>do <Plug>(rust-doc)
nmap <leader>gd <Plug>(coc-definition)
" Go Back to previous file
nmap <leader>gb <C-o>
nmap <leader>gr <Plug>(coc-references)
nmap <leader>ge <Plug>(coc-diagnostic-next-error)
nmap <leader>gi <Plug>(coc-diagnostic-info)
nnoremap <leader>cr :CocRestart<CR>

set wildmode=longest,list,full

"==============================================================================
" File/content search
"==============================================================================
" :Files = fuzzy search file by path and name
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <leader><BS> :Files<CR>

" the_silver_searcher
map <leader>? :Ag<CR>
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

" Markdown parsing
Plug 'gabrielelana/vim-markdown'

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

map <leader>s' ysiw'
map <leader>s" ysiw"
map <leader>s] ysiw]
map <leader>s) ysiw)
map <leader>s} ysiw}
map <leader>s> ysiw>
map <leader>s. ysiw.
map <leader>s, ysiw,
map <leader>s, ysiw,
map <leader>s* ysiw*
nnoremap <leader>std idatetime.strptime(ts, "%Y-%m-%dT%H:%M:%S.%fZ")<Esc>
nnoremap <leader>dts its.strftime("%Y-%m-%dT%H:%M:%S.%fZ")<Esc>
nnoremap <leader>tds idef dt_ts(td): return f"{td.days}d, {td.seconds//3600}h, {(td.seconds%3600)//60}m, {td.seconds%60}s"<Esc>
"==============================================================================
" Auto-format file on save
"==============================================================================

Plug 'godlygeek/tabular'

" Matching Parentesis
Plug 'frazrepo/vim-rainbow'
" Matching Indent
Plug 'yggdroot/indentline'

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
map <leader>x :tabclose<CR>

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
map <leader>ss :%s/\s\+$//e<CR> :w<CR><C-c>

" WINDOW NAVIGATION
" - move down
nnoremap <leader>n <C-W><C-J>
" - move up
nnoremap <leader>e <C-W><C-K>
" - move right
nnoremap <leader>i <C-W><C-L>
" - move left
nnoremap <leader>h <C-W><C-H>

" Sessions
" Plug 'tpope/vim-obsession'
" :mksession = create session as Session.vim in cwd
" map <leader>mk :mksession!<CR>
"
" :Obsess = start record session
" :Obsess! = end record session

" Plug 'kshenoy/vim-signature'
" mark
" nnoremap ma <NOP>
" nnoremap mt <NOP>
" nnoremap mm <NOP>
" remove mark
"   m
" map mx m-
" next and previous mark
nnoremap mn ]`
nnoremap me [`
" View all marks
"   m/

" Have same bash shortcuts in Insert mode
Plug 'tpope/vim-rsi'

call plug#end()

"==============================================================================
"Activate Plug features
"==============================================================================
"" What do we use for linting
" let g:coc_global_extensions = ['coc-solargraph']

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

let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
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
" RUST + LSP
"==============================================================================


" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

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

" hi NERDTreeDir guifg=#FFFFFF guibg=#000000 gui=bold ctermfg=white ctermbg=NONE cterm=bold
" hi NERDTreeGitStatusModified guifg=#66D9EF guibg=#000000 gui=bold ctermfg=lightblue ctermbg=NONE cterm=bold
" hi NERDTreeGitStatusIgnored guifg=#FA023C guibg=#000000 gui=bold ctermfg=red ctermbg=NONE cterm=bold
" hi NERDTreeGitStatusDirDirty guifg=#66D9EF guibg=#000000 gui=bold ctermfg=green ctermbg=NONE cterm=bold
" hi NERDTreeGitStatusUntracked guifg=#A7ED1A guibg=#000000 gui=bold ctermfg=green ctermbg=NONE cterm=bold

" vim-rust-syntax-ext
hi rsModule guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsFuncDef guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsIdentDef guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserMacro guifg=#A7ED1A guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsUserType guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserIdent guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsUserFunc guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsUserMethod guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE
hi rsLibraryType guifg=#5730B3 guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsLibraryMacro guifg=#66D9EF guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsFieldAccess guifg=#66D9EF guibg=#000000 ctermfg=lightblue ctermbg=NONE
hi rsAttribute guifg=#B70444 guibg=#000000 ctermfg=grey ctermbg=NONE
hi rsForeignType guifg=#FFFFFF guibg=#000000 ctermfg=white ctermbg=NONE
hi rsForeignFunc guifg=#A7ED1A guibg=#000000 ctermfg=green ctermbg=NONE

hi op_lv0 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv1 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv2 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv3 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv4 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv5 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv0 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv1 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv2 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv3 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv4 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE
hi op_lv5 guifg=#FA023C guibg=NONE ctermfg=red ctermbg=NONE

hi SignifySignAdd ctermfg=green guifg=#A7ED1A cterm=NONE gui=NONE
hi SignifySignDelete ctermfg=red guifg=#FA023C cterm=NONE gui=NONE
hi SignifySignChange ctermfg=lightblue guifg=#66D9EF cterm=NONE gui=NONE
"
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }
let g:promptline_theme = 'dracula'
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1

let g:signify_sign_add = '►'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '◁'
let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines

let g:indentLine_setColors = 1
let g:indentLine_char_list = [':','¦','|', '┃', '║', '░','▒','█']
let g:indentLine_setConceal = 1
let g:indentLine_enabled = 1

let g:tagbar_type_rust = {
   \ 'ctagstype' : 'rust',
   \ 'kinds' : [
       \'T:types,type definitions',
       \'f:functions,function definitions',
       \'g:enum,enumeration names',
       \'s:structure names',
       \'m:modules,module names',
       \'c:consts,static constants',
       \'t:traits',
       \'i:impls,trait implementations',
   \]
   \}

let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/local/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

set updatetime=100

hi Normal ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE

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
map <leader>FJ :%!python3 -m json.tool<CR>

" require'lspconfig'.pyright.setup{}

endif

" " Ensure LSP config is loaded
" lua << EOF
"   -- Require the 'nvim-lspconfig' module
"   local lspconfig = require('lspconfig')
"
"   -- Set up the Lua Language Server
"   lspconfig.lua_ls.setup{
"     settings = {
"       Lua = {
"         runtime = {
"           version = 'LuaJIT',  -- Use LuaJIT for Lua runtime
"         },
"         diagnostics = {
"           globals = {'vim'},  -- Recognize 'vim' as a global variable
"         },
"         workspace = {
"           library = vim.api.nvim_get_runtime_file("", true),  -- Include Neovim runtime files in the workspace
"         },
"         telemetry = {
"           enable = false,  -- Disable telemetry
"         },
"       },
"     },
"   }
" EOF
" autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
autocmd BufWrite *.lua call LuaFormat()
" lua require'lspconfig'.lua_ls.setup{}
