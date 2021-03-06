" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------- Pre-Plugin Setup -----------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'

function! AirlineInit()
  " Disable git hunks & branch
  let g:airline_section_b = airline#section#create(['branch'])
  " Disable filetype, virtualenv
  let g:airline_section_x = airline#section#create_right(['tagbar'])
  " Disable fileencoding, fileformat
  let g:airline_section_y=""
  " Disable windowswap and line %
  let g:airline_section_z = airline#section#create(['linenr', ':%3v '])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:polyglot_disabled = ['liquid']

" ALE
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:ale_linters = {
	\	'javascript': ['prettier-eslint'],
	\ }
let g:ale_fixers = {
  \ 'javascript': ['prettier-eslint'],
  \ }

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" ----------------------------------------- Plugins ----------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

" Themes
Plug 'chriskempson/base16-vim'
Plug 'reedes/vim-colors-pencil'

" Languages
Plug 'fatih/vim-go'
Plug 'mmalecki/vim-node.js'
Plug 'sheerun/vim-polyglot' " Covers lots: https://github.com/sheerun/vim-polyglot#language-packs

" Tools
Plug 'scrooloose/nerdcommenter'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-surround'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
" Plug 'tpope/vim-endwise' " conflicts with tab completion, inserting garbage
Plug 'tpope/vim-repeat'
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'gabesoft/vim-ags'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline-themes'
Plug 'sebdah/vim-delve'
Plug 'PeterRincker/vim-searchlight'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'arcticicestudio/nord-vim'

" Writing
Plug 'plasticboy/vim-markdown'
Plug 'reedes/vim-pencil'

call plug#end()

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" ----------------------------------------- Base Settings ----------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
"
" ------------------------------------------ Basic Setup -----------------------------------

set nocompatible      " break free of vi compatibility
set number            " show line numbers
set ruler             " show line and column number
set showmode          " show current mode down the bottom
set visualbell        " no sounds because I'm deaf ;_;
set hidden            " aLlow modified buffers to be hidden
let mapleader = ";"
set noshowmode        " don't show mode in status line

" -------------------------------------------- Wrapping ------------------------------------

set textwidth=100               " wrap at 100 chars
set wrap                        " soft wrap by default
set linebreak                   " wrap lines at words by default
set whichwrap+=<,>,[,],b,s      " wrap cursor movements to next / previous lines
set backspace=indent,eol,start  " backspace through everything in insert mode
set formatoptions-=t            " don't hard-wrap text when typing
set formatoptions+=c            " hard-wrap comments when typing, though
set formatoptions+=r            " insert comment leader when hitting Enter in insert mode
set formatoptions-=o            " don't insert comment leader when hitting 'o' or 'O' in normal mode
set formatoptions+=n            " format numbered lists by indenting following lines
set formatoptions+=q            " format comments with 'gq'
set formatoptions+=j            " handle comments nicely when joining lines

" ------------------------------------------- Whitespace -----------------------------------

set tabstop=2                     " a tab is two spaces
set softtabstop=2                 " a soft tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set smartindent                   " auto indent new lines
set smarttab                      " use shiftwidth to determine tab behavior at beginning of line

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" ----------------------------------------- Pretty Colors ----------------------------------

syntax enable
set background=dark
colorscheme nord
set termguicolors

" normal, visual, and showmatch in insert modes: block cursor
set guicursor=n-v-c-sm:block
" insert and visual selection modes: 25% vertical bar
set guicursor+=i-ci-ve:ver25
" replace, operator-pending modes: 20% horizontal bar
set guicursor+=r-cr-o:hor20
" nice blinking speed
set guicursor+=a:blinkwait200-blinkon200-blinkoff200
" highlight cursor line in normal mode
set cursorline
" Highlight selected search result using vim-searchlight
highlight link Searchlight Incsearch

" ------------------------------------------- Searching ------------------------------------

set hlsearch    " highlight matches
set incsearch   " incremental searching

" --------------------------------------- Wildcard Searching -------------------------------

set wildmode=longest,list,full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*
set wildignore+=*DS_Store*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.box
set wildignore+=vendor/**


" --------------------------------------- Completion ---------------------------------------

set completeopt=menu,menuone,noselect

" -------------------------------------------- Folding -------------------------------------

set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " don't fold by default

" --------------------------------------------- Splits -------------------------------------

set equalalways  " auto-size splits
set splitbelow
set splitright

" ------------------------------ Backup, swap, and undo history files ----------------------

silent !mkdir ~/.vim/_backup > /dev/null 2>&1
set backupdir=~/.vim/_backup//
silent !mkdir ~/.vim/_temp > /dev/null 2>&1
set directory=~/.vim/_temp//
silent !mkdir ~/.vim/_undo > /dev/null 2>&1
set undodir=~/.vim/_undo//
set undofile
set updatetime=500   " write swap files after 0.5s of inactivity (default 4s)

" --------------------------------------------- Misc. --------------------------------------

set conceallevel=0  " don't auto-hide quotes. christ that's annoying
let loaded_netrwPlugin=1 " disable netrw
set signcolumn=yes " don't flicker in and out when using ALE

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------- Filetypes ------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

filetype plugin indent on                                    " turn on filetype plugins
au BufEnter * if &filetype == "" | setfiletype text | endif  " default to text type

" Remember last location in file, but not for commit messages.
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" ------------------------------------------ git -------------------------------------------

au FileType git,gitsendemail,*commit*,*COMMIT*
  \ | call pencil#init({'wrap': 'hard', 'textwidth': 72})
  \ | setl spell spl=en_us et sw=2 ts=2 noai

" --------------------------------------- Go / vim-go ---------------------------------------

au FileType go setlocal noexpandtab nowrap textwidth=0  " gofmt-approved indentation
au FileType go nmap <leader>c <Plug>(go-callers)
au FileType go nmap <leader>d <Plug>(go-def)
au FileType go nmap <leader>gd <Plug>(go-doc-browser)
au FileType go nmap <leader>t :GoDeclsDir<cr>
au FileType go nmap <leader>l <Plug>(go-lint)
au FileType go nmap <leader>r <Plug>(go-rename)
au FileType go nmap <leader>v <Plug>(go-vet)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>t <Plug>(go-test-func)

" --------------------------------------- JavaScript ---------------------------------------

au FileType javascript let g:ale_fix_on_save = 1

" -------------------------------------------- Makefile ------------------------------------

au FileType make setlocal noexpandtab  " real tabs

" ---------------------------------------- Markdown ----------------------------------------

au FileType markdown setlocal formatoptions+=a " autoformat while typing
au FileType markdown setlocal formatoptions-=l " don't autoformat if it's already too wide
au FileType markdown,mkd call pencil#init()
  \ | setl spell spl=en_us fdl=4 noru nonu nornu
  \ | setl fdo+=search

let g:pencil#textwidth = 80
let g:pencil#conceallevel = 0 " Don't hide style characters, collapse links, etc.
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1 " disable folding
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" --------------------------------------------- Python -------------------------------------

au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 " follow PEP8 for whitespace

let g:python3_host_prog='/usr/local/bin/python3'

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" -------------------------------------------- Mappings ------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

" --------------------------------------- Text Manipulation --------------------------------

" Replace selected text without overwriting buffer
vmap r "_dP

" Redo
nnoremap U <C-R>

" Don't de-select when indenting
vnoremap < <gv
vnoremap > >gv

" Jump to end of pasted text automatically
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" ------------------------------------------- Navigation -----------------------------------

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" ------------------	Tabs / Panes / Windows -----------------------------------------------

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Option - / + to resize vertically
map <M--> 2<C-w>-
map <M-=> 2<C-w>+

" option + movement key to move through panes
nnoremap <silent> <M-k> :wincmd k<CR>
nnoremap <silent> <M-j> :wincmd j<CR>
nnoremap <silent> <M-h> :wincmd h<CR>
nnoremap <silent> <M-l> :wincmd l<CR>

" -------------------------------------------- Plugins -------------------------------------

" vim-ags
map <C-f> :Ags<space>
imap <C-f> <ESC>:Ags<space>

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" fzf
map <silent> <expr> <C-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
imap <C-t> <ESC>:FZF<CR>

" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" ---------------------------------------- Plugin Settings ---------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

" -------------------------------------------- vim-ags -------------------------------------

let g:ags_agcontext = 0
let g:ags_winheight = '20'

" --------------------------------------- auto-pairs ---------------------------------------

let g:AutoPairsCenterLine = 0 " don't scroll my buffer all over the place
let g:AutoPairsMultilineClose = 0 " don't jump lines when trying to close pair manually

" -------------------------------------------- echodoc -------------------------------------

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" ---------------------------------------------- fzf ---------------------------------------

set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }

" --------------------------------------------- vim-go -------------------------------------

let g:go_def_mapping_enabled = 0       " don't break my other key mappings
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1          " format in-place
let g:go_gopls_complete_unimported = 1 " autocomplete unimported packages
let g:go_jump_to_error = 0             " don't jump around on save
let g:go_test_show_name = 1            " show failed test names
let g:go_updatetime = 200              " update on-hover things quickly
let g:go_implements_mode = 'gopls'     " use gopls for :GoImplements

let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" ------------------------------------- LanguageClient -------------------------------------

let g:LanguageClient_echoProjectRoot = 0
let g:LanguageClient_useVirtualText = 'No' " chill with the flashy red errors
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls'],
  \ 'json': ['/usr/local/bin/vscode-json-languageserver', '--stdio'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ 'python': ['/usr/local/bin/pyls'],
  \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
  \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ----------------------------------------- NERDCommenter ----------------------------------

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" -------------------------------------------- NERDTree ------------------------------------

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
let g:NERDTreeAutoDeleteBuffer = 1    " close buffer when deleting file
let g:NERDTreeChDirMode = 2           " change nvim cwd when changing root
let g:NERDTreeMinimalUI = 1
let g:NERDTreeNaturalSort = 1         " sort numbers nicely
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40
let g:NERDTreeHijackNetrw = 0         " fix lots of weird issues
let g:NERDTreeQuitOnOpen = 1          " close on file open

" ------------------------------------------ Rust-------------------------------------------

let g:rustfmt_autosave = 1

" ---------------------------------------- SnipMate ----------------------------------------

let g:snipMate = {}
let g:snipMate.snippet_version = 1

" --------------------------------------------- Tagbar -------------------------------------

nmap <F8> :TagbarToggle<CR>
let g:tagbar_zoomwidth = 0
let g:tagbar_case_insensitive = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------
" -------------------------------------------- Commands ------------------------------------
" ------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------

command! Marked silent !open -a "Marked 2.app" "%:p"

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! BufOnly :call DeleteInactiveBufs()
command! Bonly :call DeleteInactiveBufs()

