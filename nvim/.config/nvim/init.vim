"leader key
let mapleader =" "
let maplocalleader =","

" Plug Configuration {{{
" General Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" General Plugins
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "Python semantyc highlighting
Plug 'mbbill/undotree'                          "Undo tree
Plug 'tpope/vim-fugitive'                       "Git integration/wrapper
Plug 'tpope/vim-surround'                       "Surroun parentheses, brackets, etc
Plug 'tpope/vim-repeat'                         "Repeat plugins custom mappings like surround.
Plug 'tpope/vim-scriptease'                     "Utilities for diagnosing viewing messages echoed in nvim
Plug 'tpope/vim-commentary'                     "Comment every language
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "This game will make you go so fast, you'll need some coconut oil.
Plug 'danro/rename.vim'                         "Rename files with vim
Plug 'christoomey/vim-tmux-navigator'           "Easy pane switching with tmux
Plug 'itchyny/lightline.vim'
" Highlits Colors RED, BLUE #040404
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-scripts/nginx.vim'                    "Nginx filetype forma t
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "firefox vim
Plug 'junegunn/fzf'                             "fuzzy search
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } "fuzze search functions e.g Files, Buffers
Plug 'junegunn/goyo.vim'
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'airblade/vim-gitgutter'                   " Signs in the side for changes/additions/deletions
" Information on variables, LSP, and others.
Plug 'liuchengxu/vista.vim'
" }}}
" Colors/Themes {{{
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
" }}}
" Startup {{{
Plug 'mhinz/vim-startify'
" }}}
" Tags {{{
"Plug 'jsfaint/gen_tags.vim'
Plug 'majutsushi/tagbar'
" }}}
" Language Specific {{{
" Markdown
"Plug 'plasticboy/vim-markdown'
"Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } "markdown preview
" }}}
" LSP {{{
" Configurations for neovim built in lsp.
Plug 'neovim/nvim-lsp'                        "Nvim lsp configuration examples
Plug 'nvim-lua/lsp-status.nvim'               "Status lsp integration
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
"}}}
"Snippets {{{
Plug 'honza/vim-snippets'                       "Some useful snippets
Plug 'SirVer/ultisnips'
"}}}
" Future User Reference {{{
" Allows for focusing in a small part of a buffer, to show or explain
" something
Plug 'chrisbra/NrrwRgn'
" Git
Plug 'rhysd/committia.vim'      " Sweet message committer
Plug 'rhysd/git-messenger.vim'  " Floating windows are awesome :)
" HTML expanding abreviation
"Plug 'mattn/emmet-vim'
" }}}
" Games {{{
Plug 'norcalli/typeracer.nvim'
" }}}
" Investigate {{{
" Easy changing spelling.
" TODO Investigate this snippets providers
" TODO add comment what this is
"Plug 'tweekmonster/spellrotate.vim'
"Plug 'guns/vim-sexp' "Used and recommended by tpope
" }}}
" Testing {{{
" Todo.txt
Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'
" Org mode
Plug 'dhruvasagar/vim-dotoo'
" One line expressions to multi line
Plug 'AndrewRadev/splitjoin.vim'
" Tabulate things
Plug 'godlygeek/tabular'
"TODO Use this
" Scramble arguments around <leader>ar and <leader>arl
Plug 'AndrewRadev/sideways.vim'
" This plugin move to node, probably won't use anymore
"Plug 'yuki-ycino/fzf-preview.vim'
" Switches expressions
Plug 'AndrewRadev/switch.vim'
" }}}
call plug#end()
" }}}

" Options/Variables {{{
set number rnu
set autoindent              "Automatic indenting when using <CR> and O
set cmdheight=1
filetype plugin indent on
syntax on                   "Syntax Highlighting
set encoding=utf-8
set showcmd                 "show command in bottom bar
set cursorline              "highlight current line
set wildmenu                "visual autocomplete for commands
"set wildmode-=list
"set wildmode+=longest
"set wildmode+=full
"" Makes floating PopUpMenu for completing stuff on the command line.
""     Very similar to completing in insert mode.
"set wildoptions+=pum
set completeopt=menuone,noinsert,noselect
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
" Highlight yank text
lua vim.cmd[[ au TextYankPost * silen! lua require'vim.highlight'.on_yank()]]

" Folding
set foldmethod=marker
set foldlevel=0
set modelines=1

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

""Conceal
"augroup Bible
"    autocmd BufReadPost reina_valera_1960.md :syntax match Concealed '^\d*\.\I\{3\}\.\d*\.' conceal
"    autocmd BufReadPost reina_valera_1960.md :set concealcursor=n
"augroup END

"}}}

" Mappings {{{
" For long, wrapped lines
nnoremap <silent><expr>j (v:count > 0 ? 'j' : 'gj')
nnoremap <silent><expr>k (v:count > 0 ? 'k' : 'gk')

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
" Thanks tjdevries on github
nnoremap gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
nnoremap gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

"REMAPS
tnoremap JK <C-\><C-N>
tnoremap <m-esc> <C-\><C-N>
tnoremap <C-J> <C-\><C-N><C-W><C-J>
tnoremap <C-K> <C-\><C-N><C-W><C-K>
tnoremap <C-L> <C-\><C-N><C-W><C-L>
tnoremap <C-H> <C-\><C-N><C-W><C-H>

"Save quick
nnoremap <C-S> <ESC>:write<CR>
inoremap <C-S> <ESC>:write<CR>

" Use arrow keys to scroll
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
" Switch between tabs
nnoremap <Right> gt
nnoremap <Left>  gT

"Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>w <C-W>

" Sizing window horizontally
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>
" Sizing window vertically
"  Taller and Shorter
nnoremap <A-t> <C-W>5+
nnoremap <A-s> <C-W>5-

" Easier Mark Usage
nnoremap ' `

" copy selection too gui-clipboard
xnoremap Y "+y

"Quick editing vimrc
nnoremap <leader>vr  :sp $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

"Quick find
inoremap jk <esc> 
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

"Quick small terminal
command! -nargs=0 Term :10sp +term
" New Tab Terminal
command! -nargs=0 TTerm :tabnew +term
" Create file in non existant and go to it.
noremap <leader>gf :e <cfile><cr>

" Save as Root
command! -nargs=0 Sroot :w !sudo tee %

" Fast switching to alternate file
nnoremap <silent><BS> :buffer#<CR>
" Switch to alternate file
"nnoremap <silent><expr> <s-tab> <C-^>
"nnoremap <silent><expr> <tab> (v:count > 0 ? '<C-w>w' : ':call <SID>switch_to_alt_win()<CR>')

" go to the previous window (or any other window if there is no 'previous' window).
func! s:switch_to_alt_win() abort
  let currwin = winnr()
  wincmd p
  if winnr() == currwin "window didn't change; no previous window.
    wincmd w
  endif
endf

"Quickfix Window
" quickfix window (in quickfix: toggles between qf & loc list)
nnoremap <silent><expr> <M-q> '@_:'.(&bt!=#'quickfix'<bar><bar>!empty(getloclist(0))?'lclose<bar>botright copen':'cclose<bar>botright lopen')
      \.(v:count ? '<bar>wincmd L' : '').'<CR>'
nnoremap <q :colder<CR>
nnoremap >q :cnewer<CR>
nnoremap <l :lolder<CR>
nnoremap >l :lnewer<CR>

" Inserting a New line
map <Leader>o o<Esc>k
map <Leader>O O<Esc>k
"Split the current line at the cursor position
nnoremap gj i<c-j><esc>k$
"Paste last yanked text with P
xnoremap P "0p
" quick Help
nnoremap vK <C-\><C-N>:help <C-R><C-W><CR>

"Change local window directory to current file directory
nnoremap cd :lcd %:p:h<bar>pwd<cr>
" Echo current file location
command! -nargs=0 Pfd :echo(expand('%:p'))

"Sideways
nnoremap <leader>al :SidewaysLeft<cr>
nnoremap <leader>ar :SidewaysRight<cr>

" Rg in files
" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
" mark position before search
nnoremap / ms/

" FZF Usage with Vim
"nnoremap <leader><leader>f :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cword>")), 1, 0)<CR>
"nnoremap <leader><leader>F :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cWORD>")), 1, 0)<CR>
"
"" Finding Files
"nnoremap <space>ff      <cmd>FzfPreviewDirectoryFiles<CR>
"nnoremap <space>fp      <cmd>FzfPreviewProjectFiles<CR>
"nnoremap <space>fcf      <cmd>call Fzf_on_current_file_directory()<CR>
"" Buffers
"nnoremap <space>if      <cmd>FzfPreviewBuffers<CR>
"" Git
"nnoremap <space>gs      <cmd>FzfPreviewGitStatus<CR>
"" Grepping
"nnoremap <space>gg      :FzfPreviewProjectGrep 
"nnoremap <space>gcg      <cmd>call Fzf_grep_on_current_file_directory()<CR>
"" Finding World
"nnoremap <space>gw      <cmd>call execute(':FzfPreviewProjectGrep ' . expand("<cword>"))<CR>
"" Fzf Preview on dotfiles
"nnoremap <space>fdo      <cmd>FzfPreviewDirectoryFiles ~/dotfiles<CR>
"" Netrw toggle
"nnoremap <silent><leader>ft :Lexplore<CR>
" Undotree toggle
nnoremap <silent><leader>ut :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
"" Shrug ¯\_(ツ)_/¯
"inoremap ,shrug ¯\_(ツ)_/¯
"
"function! s:fzf_open_file_at_line(e) abort
"  "Get the <path>:<line> tuple; fetch.vim plugin will handle the rest.
"  execute 'edit' fnameescape(matchstr(a:e, '\v([^:]{-}:\d+)'))
"endfunction
"function! s:fzf_search_fulltext() abort
"  call fzf#run({'source':'git grep --line-number --color=never -v "^[[:space:]]*$"',
"        \ 'sink':function('<sid>fzf_open_file_at_line')})
"endfunction

" Search current-working-directory _or_ current-file-directory
"nnoremap <silent><expr> <M-/> v:count ? ':<C-U>call <SID>fzf_search_fulltext()<CR>' : ':<C-U>Files<CR>'
nnoremap <silent><expr> <M-/> v:count ? ':<C-U>Rg<CR> ' : ':<C-U>Files<CR>'
nnoremap <silent><expr> <M-?> v:count ? 'mS:<C-U>Lines<CR>' : ':<C-U>Buffers<CR>'
nnoremap <silent>gN :Files ~/notes<CR>
" Search MRU files
nnoremap <silent>       <M-\> :History<cr>
nmap                    g/    <M-/>

nnoremap <silent> gO    :call fzf#vim#buffer_tags('')<cr>
nnoremap <silent> z/    :call fzf#vim#tags('')<cr>
"}}}

"{{{ Insert Mode and Helpers
" Abbreviations
iabbrev c] [ ]
iabbrev <expr> dts] strftime("%Y-%m-%d")
iabbrev <expr> dtt] strftime("%Y-%m-%d %H:%M:%S")
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

" }}}

" Plugins Configuration {{{
" Corlscheme
lua require('colorbuddy').colorscheme('gruvbuddy')
" Colorizer
lua require'colorizer'.setup()

let g:fzf_preview_command = 'tail {-1}'

"Firenvim
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

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"Todo.txt

nnoremap <leader>to :e ~/notes/todo.txt<CR>
au filetype todo setlocal omnifunc=todo#Complete
au filetype todo imap <buffer> + +<C-X><C-O>
au filetype todo imap <buffer> @ @<C-X><C-O>
let g:Todo_fold_char='+'

" dotoo
let g:dotoo#agenda#files = ['~/notes/dotoo/*.dotoo']
command! -nargs=0 Agenda :call dotoo#agenda#agenda()<CR>

" Filetype unique configuration {{{
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
lua require'nvim_lsp'.pyls.setup({ enable=true, on_attach=require'completion'.on_attach, plugins={pycodestyle={ignore={"W191","W1"}, } } })
lua require'nvim_lsp'.tsserver.setup({enable=true, on_attach=require'completion'.on_attach})

"Allow snippets
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<c-k>"

"Check if LSP is working on the current buffer
nnoremap <space>lsp <cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>
nnoremap <space>lspr <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

"Binding to use with lsp
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
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
" TODO Concealed With the following I was able to hide
" The start of My bible. But I don't like it always open
" syn match Concealed '^\d*\.\I\{3\}\.\d*\.' conceal
" set conceallevel=2
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
