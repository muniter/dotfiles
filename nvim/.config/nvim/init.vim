"leader key
let mapleader =" "

" Specify a directory for plugins
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" General Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Code completion
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "Python semantyc highlighting
Plug 'preservim/nerdtree'                       "Nerd tree
Plug 'mbbill/undotree'                          "Undo tree
Plug 'tpope/vim-fugitive'                       "Git integration/wrapper
Plug 'tpope/vim-surround'                       "Surroun parentheses, brackets, etc
Plug 'tpope/vim-repeat'                         "Repeat plugins custom mappings like surround.
Plug 'danro/rename.vim'                         "Rename files with vim
Plug 'christoomey/vim-tmux-navigator'           "Easy pane switching with tmux
Plug 'vim-airline/vim-airline'                  "airline
Plug 'vim-airline/vim-airline-themes'           "airline
Plug 'chrisbra/colorizer'                       "Color highlighting
Plug 'honza/vim-snippets'                       "Some useful snippets
Plug 'vim-scripts/nginx.vim'                    "Nginx filetype forma t
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "firefox vim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } "markdown preview
Plug 'junegunn/fzf'                             "fuzzy search
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } "fuzze search functions e.g Files, Buffers
"
call plug#end()

"General things
set number rnu
set autoindent              "Automatic indenting when using <CR> and O
set cmdheight=2
filetype plugin indent on
syntax on                   "Syntax Highlighting
set encoding=utf-8
set showcmd                 "show command in bottom bar
set cursorline              "highlight current line
set wildmenu                "visual autocomplete for commands
set showmatch               "highlight matching [{()}]
set display=lastline        "show as much as possible of a wrapped line no just @
set background=dark
colorscheme selenized_bw
set incsearch               "search as characters are entered
set hlsearch                "highlight matches
set ignorecase              "ignore case when searching
set smartcase               "dont ignore case if a capital letter present
set path+=**
set wildignore=*.pyc
set foldenable              "enable folding
set foldlevelstart=10       "10 nested fold max
set foldmethod=indent       "fold based indent level
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
set splitbelow
set splitright

" Others
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=yes

"REMAPS
tnoremap JK <C-\><C-N>
tnoremap <C-J> <C-\><C-N><C-W><C-J>
tnoremap <C-K> <C-\><C-N><C-W><C-K>
tnoremap <C-L> <C-\><C-N><C-W><C-L>
tnoremap <C-H> <C-\><C-N><C-W><C-H>

"Save quick
nnoremap <C-S> <ESC>:write<CR>
inoremap <C-S> <ESC>:write<CR>

"Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>w <C-W>

"Quick editing vimrc
nnoremap <leader>vr  :tabnew $MYVIMRC<cr>
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

"Quick small terminal
command! -nargs=0 Term :10sp +term
" New Tab Terminal
command! -nargs=0 TTerm :tabnew +term

"Change abbreviation for vertical
cnoreabbrev v vert

"Fast switching to alternate file
nnoremap <BS> :buffer#<CR>

" Window management
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 6/5)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 5/6)<CR>

"Inserting a New line
map <Leader>o o<Esc>

"Pasting after adding a space
map <Leader>p a<space><Esc>p

"Remove highlight after search
nnoremap <leader><leader> :nohlsearch<CR>

"Extensions
nnoremap <C-p> :Files<CR>

"Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"NerdTREE
nnoremap <silent><leader>pt :NERDTreeToggle<CR>
nnoremap <silent><leader>pv :NERDTreeFind<CR>

"UndoTREE
nnoremap <silent><leader>pu :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1

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

    augroup AutoCmd
        "MARKDOWN
        autocmd Filetype markdown nnoremap <leader>bb 0i**<Esc>A**<Esc>0
        autocmd Filetype markdown nnoremap <leader>bi 0i*<Esc>A*<Esc>0
        autocmd Filetype markdown nnoremap <leader>bs 0i**<Esc>f>a**<Esc>0
        autocmd Filetype markdown nnoremap <leader>bsa :%s/<\(H.*\)>/<\*\*\1\*\*>
        autocmd Filetype markdown nnoremap <leader>mpa :.,$sm/\(^[^\*].*\n\{1,2\}\)\(\*\*\)/\1### Pregunta\r\2
        autocmd Filetype markdown nnoremap <leader>mra :.,$s/\v(^###.*$(\n{1,2}\*\*.+)+(\n{1,3}))(\w)/\1### Respuesta\r\4
        autocmd Filetype markdown nnoremap <leader>mcb :%s/\v\<[^\>]+\>//g
        autocmd Filetype markdown nnoremap <leader>mcs :.,$s/\v\\//g
        autocmd Filetype markdown nnoremap <leader>mca :.,$s/\v\*//g
        autocmd Filetype markdown nnoremap <leader>mpt 0i## Preguntas<CR>### Pregunta<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>met 0i## Enseñanza<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>mit 0i## Introducción<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>mot 0i## Oración<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>mpp 0i### Pregunta<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>mrr 0i### Respuesta<CR><Esc>0
        autocmd Filetype markdown nnoremap <leader>mtt 0i### Testimonio<CR><Esc>0
    augroup END

    " Yaml configuration
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Jsonc configuration
    autocmd FileType json syntax match Comment +\/\/.\+$+

    augroup Vimrc
        autocmd! bufwritepost init.vim source %
    augroup END
    " Required for operations modifying multiple buffers like rename.
    set hidden

"--------------------- Coc ---------------------"

"Default extensions to add
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-python', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-snippets', 'coc-markdownlint', 'coc-marketplace']
" Here coc will store all the data, instead of polluting .config
let g:coc_data_home ="~/.config/nvim/plugged/coc.nvim/data"

imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<c-j>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> c<TAB> <Plug>(coc-range-select)
xmap <silent> c<TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>cp  :<C-u>CocListResume<CR>

"--------------------- Coc End ---------------------"
