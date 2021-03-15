"leader key
let mapleader =" "
let maplocalleader =","

" Plug Configuration {{{
call plug#begin('~/.config/nvim/plugged')

"Utilities {{{

"Unix utilities rename, move, sudowrite, etc
Plug 'tpope/vim-eunuch'

" Comment every language
Plug 'tpope/vim-commentary'

" Utilities for diagnosing viewing messages echoed in nvim
Plug 'tpope/vim-scriptease'

" Repeat plugins custom mappings like surround.
Plug 'tpope/vim-repeat'

" Surroun parentheses, brackets, etc
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Undotree visualization
Plug 'mbbill/undotree'

" Title case motion
Plug 'christoomey/vim-titlecase' 

" Rename file utility
Plug 'qpkorr/vim-renamer'

" Using vim inside firefox
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Popup window api (required by some plugins)
Plug 'nvim-lua/popup.nvim'

" Focusing (centers the text and hides all the things)
Plug 'junegunn/goyo.vim'

" Markdown Previewing
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Scramble arguments around <leader>ar and <leader>al
Plug 'AndrewRadev/sideways.vim'

"}}}

" Language specific {{{

" Python semantic highlighthing
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Nginx filetype format
Plug 'vim-scripts/nginx.vim' 

"}}}

" Navigations and Searching File, Buffers, etc. {{{

" fzf based
Plug 'junegunn/fzf'                             "fuzzy search
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } "fuzze search functions e.g Files, Buffers

" Search all the things
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-lua/plenary.nvim'

" Navigation "s" to find things
Plug 'justinmk/vim-sneak'
"}}}

" Terminal {{{

" Helper functions for terminal (specially the drop command)
Plug 'skywind3000/vim-terminal-help'

" }}}

" {{{ Beautify, colors, statusline, tabline, rice
" Themes, colorschemes, icons
Plug 'mhartington/oceanic-next'

" Statusline
Plug 'itchyny/lightline.vim'

" Highlits Colors RED, BLUE #040404
Plug 'norcalli/nvim-colorizer.lua' 

" Startup page with recent files, sesions, and others.
Plug 'mhinz/vim-startify'

" Icons, use them for file tree and telescope
Plug 'kyazdani42/nvim-web-devicons'
"}}}

" LSP Stuff and Treesitter {{{

" Configurations
Plug 'neovim/nvim-lspconfig'

" Completion plugin
Plug 'nvim-lua/completion-nvim'

" Completion plugin addon, to find in buffers
Plug 'steelsojka/completion-buffers'

" Treesitter configuration and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


"}}}

"Snippets {{{

" Useful snippets
Plug 'honza/vim-snippets'
" Snippets engine
Plug 'SirVer/ultisnips'

"}}}

" Git {{{

" Git integration/wrapper
Plug 'tpope/vim-fugitive'

" Git signs in the gutter (left side)
Plug 'airblade/vim-gitgutter'

" Nice message commiter
Plug 'rhysd/committia.vim'
" }}}

" Checkout {{{

" Used and recommended by tpope
"Plug 'guns/vim-sexp'

" Switch things like [ ] [x] or ture false ...
Plug 'AndrewRadev/switch.vim'

" }}}

call plug#end()

" }}}

" Options/Variables {{{
set history=5000            "Number of items in history for command line
set number rnu              "Number and relative number
set exrc                    "Source .initrc in the opened directory
set autoindent              "Automatic indenting when using <CR> and O
set cmdheight=1
filetype plugin indent on
syntax on                   "Syntax Highlighting
set encoding=utf-8
set showcmd                 "show command in bottom bar
set cursorline              "highlight current line
set wildmenu                "visual autocomplete for commands
set wildchar=<Tab>          "Character to trigger command line expansion > completion
set wildmode=longest,full  "Complete longest common string, then each full match
set wildoptions+=pum        "Command line completion using PopUpMenu pum
set winblend=50             "Pseudo-transparent pum window
set completeopt=menuone,noinsert,noselect
set pumheight=30
set pumwidth=15
set showmatch               "highlight matching [{()}]
set display=lastline        "show as much as possible of a wrapped line no just @
set background=dark
set incsearch               "search as characters are entered
set hlsearch                "highlight matches
set ignorecase              "ignore case when searching
set smartcase               "dont ignore case if a capital letter present
set path+=**
set wildignore=*.pyc,*pycache*,*~
set wildignore+=__pycache__
set tabstop=4               "number of visual space per tab
set softtabstop=4           "number of spaces on tab when editing
set shiftwidth=4
set expandtab
set noswapfile              "no swap files
set nobackup                "no backup
set nowritebackup
set undodir=~/.vim/undodir  "save all changes here
set undofile
set hidden
set noequalalways           " I don't like my windows changing all the time
set splitright              " Prefer windows splitting to the right
set splitbelow              " Prefer windows splitting to the bottom
set scrolloff=10            " Make it so there are always ten lines below my cursor
set termguicolors           " Enables 24-bit RGB color in the |TUI|.
set foldmethod=marker       " Folding
set foldlevel=256           " Foldlevel (Most files will have all folds open
set nrformats-=octal        " Number format used with <C-a> remove octal format
set modeline

" Highlight yank text
lua vim.cmd[[ au TextYankPost * silen! lua require'vim.highlight'.on_yank()]]
" au TextYankPost * silent! lua vim.highlight.on_yank()

" Sintax highlithing for Lua inside vimscript files.
let g:vimsyn_embed = 1

"Colorshcme
colorscheme OceanicNext

" Show command changes preview like substitue
set inccommand=split
" Show out of place tabs and spaces
set list

" Others
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=yes

" Wrap Lines
" Make it so that long lines wrap smartly
set wrap
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak
"}}}

" Mappings {{{
" If j or k used wihtout a count do gj for long lines, if a count
" is given mark the position and do v:count . j
nnoremap <expr>j (v:count > 0 ? "m'" . v:count . "j" : 'gj')
nnoremap <expr>k (v:count > 0 ? "m'" . v:count . "k" : 'gk')
"nnoremap <silent><leader>j j
"nnoremap <silent><leader>k k

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
" Thanks tjdevries on github
" nnoremap gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
" nnoremap gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

"Save quick
nnoremap <C-S> <ESC>:write<CR>
inoremap <C-S> <ESC>:write<CR>

"Exit quick
nnoremap ZXX :qall!<CR>

" Use arrow keys to scroll
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
" Switch between tabs
nnoremap <Right> gt
nnoremap <Left>  gT

"Split navigations
nnoremap <m-j> <C-W><C-J>
nnoremap <m-k> <C-W><C-K>
nnoremap <m-l> <C-W><C-L>
nnoremap <m-h> <C-W><C-H>
" Quick window commands
nnoremap <leader>w <C-W>

" Sizing window horizontally
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>
" Sizing window vertically
"  Taller and Shorter
nnoremap <A-t> <C-W>5+
nnoremap <A-s> <C-W>5-

" Modify behavior <c-o> is done in another tab, making
" it easy to go back to pervious state
nnoremap <c-w>o :tab split<CR>
nnoremap <leader>wo :tab split<CR>

" Easier Mark Usage
nnoremap ' `

" copy selection too gui-clipboard
" xnoremap Y "+y

" Make Y consistent with C and D.
nnoremap Y y$

" Yank the whole buffer
nnoremap <leader>yb :%yank<CR>

"Quick opening command line mode
" nnoremap q; q:
"Quick editing vimrc
nnoremap <leader>vr  :sp $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>sof :source %<cr>

" Quick Spell Configuration
nnoremap <leader>spe  :setlocal spell spelllang=en<CR>
nnoremap <leader>sps  :setlocal spell spelllang=es<CR>

"Quick find
" inoremap jk <esc> 
nnoremap ,f :find 
nnoremap ,t :tabfind 
nnoremap ,vf :vert sfind 
nnoremap ,sf :sfind 
nnoremap ,b :buffer 
nnoremap ,sb :sbuffer 
nnoremap ,vb :vert sbuffer 

" More manageable brace expansions
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" Move last copy item to the + register
nnoremap ,sr :let @+ = @0<CR>

" Quick delete previous buffer
nnoremap <leader>bdd :bd #<CR>
nnoremap <leader>BDD :bd! #<CR>

" Create file in non existant and go to it.
noremap <leader>gf :e <cfile><cr>

" Save as Root
command! -nargs=0 Sroot :w !sudo tee %

" Fast switching to alternate file
nnoremap <silent><BS> :buffer#<CR>

"Quickfix Window
" quickfix window (in quickfix: toggles between qf & loc list)
nnoremap <silent><expr> <M-q> '@_:'.(&bt!=#'quickfix'<bar><bar>!empty(getloclist(0))?'lclose<bar>botright copen':'cclose<bar>botright lopen')
      \.(v:count ? '<bar>wincmd L' : '').'<CR>'
nnoremap <q :colder<CR>
nnoremap >q :cnewer<CR>
nnoremap <l :lolder<CR>
nnoremap >l :lnewer<CR>

" Inserting a New line
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j
"Split the current line at the cursor position
nnoremap gj i<c-j><esc>k$
" quick Help
nnoremap vK <C-\><C-N>:help <C-R><C-W><CR>

"Change local window directory to current file directory
nnoremap cd :lcd %:p:h<bar>pwd<cr>
" Modify <c-g> to show complete path
nnoremap <c-g> 1<c-g>

"Sideways
nnoremap <leader>al :SidewaysLeft<cr>
nnoremap <leader>ar :SidewaysRight<cr>

"Session Management
nnoremap <leader>zs :SSave<CR>
nnoremap <leader>zl :SLoad

" Rg in files
" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
" mark position before search
nnoremap / ms/

"{{{ Goyo nvim
nnoremap <M-f> :Goyo<CR>
"}}}

"{{{ Telescope 
" Search current-working-directory _or_ current-file-directory
"nnoremap <silent><expr> <M-/> v:count ? ':<C-U>call <SID>fzf_search_fulltext()<CR>' : ':<C-U>Files<CR>'
" nnoremap <silent><expr> <M-/> v:count ? ':<C-U>Rg<CR> ' : ':<C-U>Files<CR>'
" nnoremap <silent><expr> <M-?> v:count ? 'mS:<C-U>Lines<CR>' : ':<C-U>Buffers<CR>'
nnoremap <silent><leader>gi :Files ~/notes/idmji<CR>
nnoremap <silent><leader>gn :Files ~/notes<CR>
nnoremap <silent><leader>gj :Files ~/notes/<CR>journal 
nnoremap <silent><leader>gc :Files ~/.config<CR>
" Search MRU files
nnoremap <silent>       <M-\> :History<cr>
nmap                    g/    <M-/>
"}}}

"{{{ Markdown Previewer
"Do not close the previewer when changing buffer
let g:mkdp_auto_close = 0
"}}}

" {{{ Terminal Related
" Escaping terminal Mode
tnoremap <M-c> <C-\><C-N>
nnoremap <M-c> <Esc>
" Movement
tnoremap <M-j> <C-\><C-N><C-W><C-J>
tnoremap <M-k> <C-\><C-N><C-W><C-K>
tnoremap <M-l> <C-\><C-N><C-W><C-L>
tnoremap <M-h> <C-\><C-N><C-W><C-H>
" Quick horizontal smal terminal
"nnoremap <silent><M-t><M-t> :Term<CR>

"Quick small terminal
command! -nargs=0 Term :15sp +term
" New Tab Terminal
command! -nargs=0 TTerm :tabnew +term

" Paste
tnoremap <A-p> <C-\><C-n>pi
" Paste 0 register
tnoremap <A-0> <C-\><C-n>"0pi
" Paste + clipboard register register
tnoremap <A-v> <C-\><C-n>"+pi

" }}}

"}}}

"{{{ Insert Mode and Helpers
"Move arround in insert mode
inoremap <M-l> <Right>
inoremap <M-h> <Left>
" Abbreviations
iabbrev c] - [ ]
iabbrev <expr> dts] strftime("%Y-%m-%d")                " Date time small
iabbrev <expr> dtt] strftime("%Y-%m-%d %H:%M:%S")       " Date time time
let g:switch_mapping = "-"
let g:switch_custom_definitions = [['[ ]', '[X]']]
"}}}

" Functions {{{
function! Fzf_on_current_file_directory()
    let l:path = expand('%:h')
    execute(':FzfPreviewDirectoryFiles' . ' ' . l:path)
endfunction

function! Fzf_grep_on_current_file_directory()
    let l:wd = execute(':pwd')
    let l:path = expand('%:h')
    execute (':cd' . l:path)
    let l:grep = input('FzfPreviewProjectGrep: ')
    execute(':FzfPreviewProjectGrep' . ' ' . l:grep)
    execute (':cd' . l:path)
endfunction

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" }}}

" Plugins Configuration {{{
lua require('init')

let g:fzf_preview_command = 'tail {-1}'

" UndoTree
let g:undotree_SetFocusWhenToggle = 1
nnoremap <leader>ut <cmd>UndotreeToggle<CR>
nnoremap <leader>utf <cmd>UndotreeFocus<CR>

" Startify {{{
" Add a command to open a terminal
let g:startify_commands = [
    \ {'t': 'term'},
    \ ]
" }}}

"Firenvim {{{
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

"}}}

"{{{ vim-sandwich 

" vim-surround mappings.
runtime macros/sandwich/keymap/surround.vim

"}}}

"Function to not lose work from firenvim
function! Firenvim_Backup(timer) abort
            silent! write! /tmp/my_backup
        endfunction

"Detect when firenvim is active
function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set laststatus=0
    "Saves every 1s firenvim backup
    call timer_start(1000, 'Firenvim_Backup', {'repeat': -1})
  endif
endfunction

"
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

let g:lightline = {
      \ 'colorscheme': 'default',
      \ }
" TreeSitter {{{
nnoremap <leader>tsf :set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
" }}}
"Titlecase
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

" Filetype unique configuration {{{
autocmd FileType markdown nnoremap <leader>pre :MarkdownPreview<CR>
" Yaml configuration
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Jsonc configuration
autocmd FileType json syntax match Comment +\/\/.\+$+
" source vimrc after save
augroup Vimrc
    autocmd! bufwritepost init.vim source %
augroup END
" Required for operations modifying multiple buffers like rename.
set hidden
" }}}

" LSP Configuration {{{
" lua require'nvim_lsp'.pyls.setup({enable=true, on_attach=require'completion'.on_attach, plugins={pycodestyle={ignore={"W191","W1"}, } } })
" lua require'nvim_lsp'.tsserver.setup({enable=true, on_attach=require'completion'.on_attach})
" lua require'nvim_lsp'.sumneko_lua.setup({on_attach=require'completion'.on_attach})
" lua require'nvim_lsp'.jsonls.setup{({on_attach=require'completion'.on_attach})}
" lua require'nvim_lsp'.yamlls.setup{({on_attach=require'completion'.on_attach})}
" lua require'nvim_lsp'.html.setup{({on_attach=require'completion'.on_attach})}
" lua require'nvim_lsp'.cssls.setup{({on_attach=require'completion'.on_attach})}
" lua require'nvim_lsp'.dockerls.setup{({on_attach=require'completion'.on_attach})}

"Allow snippets
"let g:UltiSnipsExpandTrigger = "\<tab>"
"let g:UltiSnipsJumpForwardTrigger ="\<c-j>"
"let g:UltiSnipsJumpBackwardTrigger = "\<c-k>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<c-y>"
" Complete pair [({ when method confirmed
let g:completion_enable_auto_paren = 1
" Change source when current options are empty
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" Character that will trigger completion
let g:completion_trigger_character = ['.']
" Completion chain, can change between and emualte vim modes when there's no
" let g:completion_chain_complete_list = {
"             \'default' : [
"             \    {'complete_items': ['lsp', 'snippet']}
"             \]
"             \}
" matches for LSP or SNIPPET,  <C-X><C-P> will pop up.
let g:completion_chain_complete_list = {
            \'default' : [
            \    {'complete_items': ['lsp', 'snippet']},
            \    {'complete_items': ['buffer']},
            \    {'complete_items': ['buffers']},
            \    {'mode': 'file'},
            \    {'mode': 'line'},
            \    {'complete_items': ['path'], 'triggered_only': ['/']},
            \]
            \}
" TODO: Find good mappings for this
inoremap  <c-0> <Plug>(completion_next_source)
inoremap  <c-9> <Plug>(completion_prev_source)
" imap <expr> <c-j>  pumvisible() ? <Plug>(completion_next_source)":  ""
" imap <expr> <c-k>  pumvisible() ? <Plug>(completion_prev_source)":  ""
"Check if LSP is working on the current buffer
nnoremap <space>lsp <cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>
nnoremap <space>lspr <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

"Binding to use with lsp
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
""" Diagnostics
" Show Diagnostic in floating window
nnoremap <leader>sl      <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>dn     <cmd>lua vim.lsp.structures.Diagnostic.buf_move_next_diagnostic()<CR>
nnoremap <leader>dp     <cmd>lua vim.lsp.structures.Diagnostic.buf_move_prev_diagnostic()<CR>
"Insert mode
inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" Snippets
"lua require'snippets'.use_suggested_mappings()
"inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
"inoremap <c-j> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>
" }}}

" Learning and Practicing {{{
" TODO
" Learn the changelist
" TODO
" g, goes to the last edited place (like `. or '.).
" TODO
" gn Learn it, it selects some word you last search. Watch @norcali
" on 2020-07-10 3:55
" TODO
" Search last search //
" TODO
" Read completopt that's what manages the LSP Completions
" TODO: More advance motions with searching
" /foo<CR>	find "foo"
" c//e<CR>	change until end of match
" bar<Esc>	type replacement
" //<CR>		go to start of next match
" c//e<CR>	change until end of match
" beep<Esc>	type another replacement
" }}}
let g:racer_cmd = "/home/user/.cargo/bin/racer"

" {{{ Functions
com! -bar NextTerminalBuffer     call GoNextTerminalBuffer()
com! -bar PreviousTerminalBuffer call GoNextTerminalBuffer(1)
fu! GoNextTerminalBuffer (...)                                              "{{{
    let backward = get(a:, 1, 0)
    if backward
        let bufnr = buf#previous('&bt=="terminal"')
    else
        let bufnr = buf#next('&bt=="terminal"')
    end
    if bufnr != bufnr('%')
        exe 'b' . bufnr
    end
    startinsert
endfu                                                                       "}}}
" }}}
