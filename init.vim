call plug#begin('~/.vim/plugged')
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Linter
Plug 'neomake/neomake'
" Completers
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'aufgang001/vim-nerdtree_plugin_open'
" Tags
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
" LaTeX & Markdown
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'
" Matlab
Plug 'daeyun/vim-matlab', {'do': ':UpdateRemotePlugins'}
Plug 'vim-scripts/MatlabFilesEdition'
" Scala
Plug 'derekwyatt/vim-scala'
" Python
Plug 'zchee/deoplete-jedi'
" C family
Plug 'justmao945/vim-clang'
Plug 'tweekmonster/deoplete-clang2'
" REPL
Plug 'jpalardy/vim-slime'
Plug 'hkupty/iron.nvim'
" Fold
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
" Appearance
Plug 'sjl/badwolf'
Plug 'danilo-augusto/vim-afterglow'
Plug 'chriskempson/base16-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Icons
Plug 'ryanoasis/vim-devicons'
" Formatters
Plug 'tell-k/vim-autopep8'
Plug 'godlygeek/tabular'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/vim-easy-align'
Plug 'tweekmonster/impsort.vim'
" VCS
Plug 'mhinz/vim-signify'
Plug 'juneedahamed/vc.vim'
" Notes
Plug 'xolox/vim-notes'
" Undotree
Plug 'mbbill/undotree'
" Fuzzy finder
Plug 'kien/ctrlp.vim'
" Documentation
Plug 'rizzatti/dash.vim'
" Surround
Plug 'tpope/vim-surround'
" Comments
Plug 'scrooloose/nerdcommenter'
" Sublime-like multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Ninja-like moving
Plug 'easymotion/vim-easymotion'
call plug#end()

" Python providers for Neovim
let g:python_host_prog = $HOME.'/.pyenv/versions/py27/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/py36/bin/python'

" Untouchable
cmap w!! w !sudo tee % > /dev/null
set nocompatible
filetype plugin indent on
if !has('nvim') | set encoding=utf-8 | endif
set backspace=2 mouse=a clipboard=unnamed laststatus=2 hid
set ignorecase smartcase incsearch
set splitbelow splitright
set wrap linebreak nolist
set noerrorbells novisualbell
set cursorline number nuw=2
set shortmess=a
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set scrolloff=2 sidescrolloff=5
set grepprg=grep\ -nH\ $*

" Syntax & Colors
syntax enable
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
if has('nvim') | set termguicolors | endif
colo badwolf
hi Normal guibg=None guifg=None
hi LineNr guibg=None

" Backup, Undo, Swap
call mkdir($HOME.'/.vim/backup', 'p')
call mkdir($HOME.'/.vim/undo', 'p')
set backupdir=~/.vim/backup/
set undodir=~/.vim/undo/
set shada=h,'10,<100,s100,@10,:20,/20,n~/.vim/.shada
set undofile backup writebackup
set noswapfile
func! BExt()
    let myvar = strftime("%Y-%m-%d-%H-%M-%s")
    let myvar = "set backupext=_".myvar
    exe myvar
endfunc
func! KeepRecentBackupsOnly()
    let l:old = sort(split(glob(&backupdir.'*'.expand('%:t').'*'), '\n'))[:-11]
    for l:file in l:old
        call delete(l:file)
    endfor
endfunc
func! DeleteOldBackups()
    " Delete after three days
    let l:delay = (60 * 60 * 24 * 10)
    let l:backups = split(glob(&backupdir.'*'), '\n')
    let l:now = localtime()

    for l:file in l:backups
        if (l:now - getftime(l:file)) > l:delay
            call delete(l:file)
        endif
    endfor
endfunc
au VimLeave * :sil call DeleteOldBackups()
au BufWritePre * call KeepRecentBackupsOnly()

" Autopep8
let g:autopep8_disable_show_diff = 1

" Iron
aug AugIron
    au!
    au Filetype python nmap <buffer> <cr> <Plug>(iron-send-motion)
    au Filetype python vmap <buffer> <cr> <Plug>(iron-send-motion)
    au Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
aug END

" Neomake
aug AugAll
    au!
    au BufWrite * Neomake
    au BufWritePre * %s/\s\+$//e
    au BufWritePre * :sil call BExt()
aug END

" auto-Python: intrusive for collaboration with people who don't respect
" PEP8, even if they should...
aug AugPython
    au!
    au BufWritePre *.py :sil call Autopep8()
    au BufWritePre *.py :sil ImpSort!
    au BufRead,BufNewFile *.py setlocal cc=80
aug END

" Slime
let g:slime_target = 'tmux'
let g:slime_python_ipython = 1
let g:slime_dont_ask_default =  1
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '0'}
let g:slime_no_mappings = 1
vmap <cr> <Plug>SlimeRegionSend
nmap <cr> <Plug>SlimeParagraphSend
nmap <C-s> <Plug>SlimeLineSend


" General shortcuts
nnoremap § :w<cr>
nnoremap Y y$
nnoremap P A<space><esc>$p
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
nnoremap <leader>sp :setlocal spell!<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <silent> <C-l> :nohl<cr>:mode<cr>

" Markdown
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=3

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring=1
let g:deoplete#sources#jedi#statement_length=200
" Dash
nmap <silent> <leader>d <Plug>DashSearch

" Notes
let g:notes_directories = ['~/Documents/Notes']

" Matlab
let g:matlab_auto_mappings   = 0
let g:matlab_server_launcher = 'vim'
let g:matlab_server_split    = 'horizontal'
au Filetype matlab call SetMatlabCommands()
func! SetMatlabCommands()
    nnoremap <buffer><silent> <leader>n :MatlabLaunchServer<cr>
    vnoremap <buffer><silent> <leader>r <esc>:MatlabCliRunSelection<cr>
    nnoremap <buffer><silent> <leader>r :MatlabCliRunCell<cr>
    nnoremap <buffer><silent> <leader>h :MatlabCliHelp<cr>
    nnoremap <buffer><silent> <leader>x :MatlabCliCancel<cr>
    nnoremap <buffer><silent> <leader>c :MatlabNormalModeCreateCell<cr>
    nnoremap <buffer><silent> <leader>v :MatlabCliViewVarUnderCursor<cr>
endfunc

" NERDTree
let NERDTreeIgnore = ['\.pyc$']
let g:nerdtree_plugin_open_cmd = 'open'
nmap ± :NERDTreeTabsToggle<cr> :wincmd p<cr>

" Completion
let g:SuperTabDefaultCompletionType = '<tab>'
let g:UltiSnipsExpandTrigger        = '<C-o>'
let g:UltiSnipsJumpBackwardTrigger  = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger   = '<tab>'

" Neomake (as linter)
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_cpp_enabled_markers = ['clang']
let g:neomake_cpp_clang_args = ['-std = c++11', '-Wextra', '-Wall', '-fsanitize = undefined', '-g']

" Vim-devicons
if exists('g:loaded_webdevicons') | call webdevicons#refresh() | endif
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" LaTeX
let g:tex_flavor ='latex'
let g:vimtex_fold_enabled=1
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : 'build',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-pdf',
            \   '-xelatex',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
let g:vimtex_compiler_callback_hooks   = ['UpdateSkim']
let g:vimtex_compiler_progname         = $HOME.'/.pyenv/versions/py36/bin/nvr'
let g:vimtex_view_general_options      = '-b -r -g @line @pdf @tex'
let g:vimtex_view_general_viewer       = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_quickfix_open_on_warning  = 0
let g:vimtex_quickfix_mode             = 2
let g:vimtex_complete_close_braces     = 1
func! UpdateSkim(status)
    if !a:status | return | endif
    let l:cmd = [g:vimtex_view_general_viewer, '-b -r -g']
    call jobstart(l:cmd + [line('.'), b:vimtex.out(), expand('%:p')])
endfunc
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
            \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
            \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
            \ 're!\\hyperref\[[^]]*',
            \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
            \ 're!\\(include(only)?|input){[^}]*',
            \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
            \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
            \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
            \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
            \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
            \ 're!\\[A-Za-z]*',
            \ ]

" Tags
let g:easytags_async = 1
let g:easytags_file = '~/.vim/tags'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {'n': 'N', 'i' : 'I', 'R': 'R', 'v': 'V', 'V': 'V'}
if !exists('g:airline_symbols') |
    let g:airline_symbols = {} |
endif
let g:airline_left_sep           = ''
let g:airline_right_sep          = ''
let g:airline_left_alt_sep       = '|'
let g:airline_right_alt_sep      = '|'
let g:airline_symbols.linenr     = ''
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.linenr     = ''
let g:airline_symbols.whitespace = ''

