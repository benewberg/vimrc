" vim: ft=vim

"""" Plugin Installation
call plug#begin('~/.config/nvim/plugged')
"
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'  " gcc to comment a line; 3gcj to comment 3 lines down, etc"
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'benmills/vimux'
Plug 'ayu-theme/ayu-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'rhysd/committia.vim'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'
Plug 'bkad/CamelCaseMotion'
" Plug 'vim-scripts/confirm-quit'
" Plug 'janko/vim-test'

call plug#end()

""" General Settings
set mouse=a
set ignorecase
set cursorline
set colorcolumn=101
set textwidth=100
set formatoptions-=t
set expandtab tabstop=4 shiftwidth=4 smarttab
set number relativenumber
set lazyredraw
set nowrap
filetype plugin on  " Allow filetype plugins to be enabled

""" Plugin Settings
"""" Tmuxline
let g:tmuxline_preset = {
    \'a': '#S',
    \'win': ['#I', '#W'],
    \'cwin': ['#I', '#W#F'],
    \'y': ["%F", "%H:%M"],
    \'z': ['#h'],
    \'options': {
        \'status-justify': 'left'
        \}}
let g:tmuxline_theme = 'powerline'

"""" YouCompleteMe
let g:ycm_python_binary_path = '/usr/bin/python'
let g:loaded_python3_provider = 1
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

"""" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extension#ale#enabled = 1
let g:airline_them = 'wombat'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_section_x = '' 
let g:airline_section_y = '%{getcwd()}' 
set noshowmode
set ttimeoutlen=10  " Set the escape key timeout to very little
" comment out the below section if you don't have a patched font installed (eg a nerd font)
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_symbols.branch = '\ue725'
"let g:airline_symbols.dirty = '\ue702'
"let g:airline_left_sep = '\ue0b8'
"let g:airline_left_alt_sep = '\ue0b9'

""" indentLine
let g:indentLine_char = '¦'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']  " This will indent using a diff char per level
let g:indentLine_color_gui = '#4c4c4b'  " Ensure the indent char is gray

"""" auto-pairs
let g:AutoPairsCenterLine = 0

"""" SimplyFold
set foldlevel=999
let g:SimplyFold_fold_import = 0

"""" FastFold
let g:fastfold_force = 1
let g:fastfold_savehook = 0

"""" FZF
" File searching with ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
let g:ackprg = 'ag --vimgrep'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
cnoreabbrev Ack Ack!

"""" Ale
" Linting settings
let g:ale_linters = {
\   'python': ['flake8']
\}
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 0
let g:ale_enabled = 0  "turned off by default
let g:ale_python_flake8_options = '--ignore=E501'  " suppress line length warnings

"""" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_add_search_history = 0

"""" ConfirmQuit
" cnoremap <silent> q<CR>  :call confirm_quit#confirm(9, 'last')<CR>
" let g:confirm_quit_nomap = 1  " Prefer not to use the default mappings

"""" WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=500

"""" GitGutter
" Allow git-gutter to display the changes to the file faster (default in vim
" is 4000, or 4 seconds)
set updatetime=100

"""" VimTest
let test#python#runner = 'nose'
let test#strategy = 'vimux'
let test#python#nose#options = {
    \'file': '-sv --nologcapture --with-id',
    \'nearest': '-sv --with-id',
    \'suite': '-sv',
\}

"""" ayu
set termguicolors
let ayucolor='mirage'
colorscheme ayu

""" Key Bindings
"""" Change leader to space key (KEEP THIS ABOVE OTHER LEADER MAPPINGS)
" This has to be higher in the file than any <Leader> mappings, since it resets any leader mappings
" defined above it
let mapleader = ' '

"""" WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_map.d = 'which_key_ignore'

"""" Split Navigation
nnoremap <C-j> <C-W><down>
nnoremap <C-k> <C-W><up>
nnoremap <C-l> <C-W><right>
nnoremap <bs> <C-W><left>

""" CamelCaseMotion
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" omap <silent> iw <Plug>CamelCaseMotion_iw

"""" Linting
let g:which_key_map.a = {
    \'name': '+ale',
    \'t': [':ALEToggle', 'Toggle ALE'],
    \'p': ['<Plug>(ale_previous_wrap)', 'previous error'],
    \'n': ['<Plug>(ale_next_wrap)', 'next error']
    \}

"""" Buffers
let g:which_key_map.b = {
    \'name': '+buffers',
    \'p': [':bp', 'previous'],
    \'n': [':bn', 'next'],
    \'k': [':bufdo bd', 'kill all'],
    \'d': [':bd', 'kill current'],
    \'c': [':bp \| bd #', 'kill keep split'],
    \}

"""" Commenting 
let g:which_key_map.c = {
    \'name': '+commenting',
    \'t': [':Commentary', 'toggle comment'],
    \'b': [":'<,'>Commentary", 'comment block']
    \}

"""" Git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'p': [':GitGutterPrevHunk', 'previous hunk'],
    \'n': [':GitGutterNextHunk', 'next hunk'],
    \'d': [':GitGutterUndoHunk', 'delete hunk'],
    \'h': [':call VimuxRunCommandInDir("clear; git_author", 1)', 'history'],
    \'l': {
        \'name': '+log',
        \'a': [':Glog %', 'All commits for file'],
        \'r': [':Glog -n 5 %', 'Recent (5) commits for this file'],
        \},
    \}

"""" Highlighting
let g:which_key_map.h = [":let @/=''", 'no highlights']

"""" Motion
let g:which_key_map.m = {
    \'name': '+motion',
    \'j': ['<Plug>(easymotion-j)', 'EasyMotion Line Down'],
    \'k': ['<Plug>(easymotion-k)', 'EasyMotion Line Up'],
    \'s': ['<Plug>(easymotion-sn)', 'EasyMotion Sneak'],
    \'w': ['<Plug>(easymotion-wl)', 'EasyMotion Word']
    \}

"""" Searching
let g:which_key_map.s = {
    \'name': '+search',
    \'f': {
        \'name': '+file_name_search',
        \'p': [':FZF ~/Projects/Python', 'python'],
        \'c': [':FZF ~/Projects/Cpp', 'cpp'],
        \'q': [':FZF ~/Projects/Qt', 'cpp'],
        \'r': [':FZF ~/Projects/R', 'R'],
        \'a': [':FZF ~/Projects/Arduino', 'arduino'],
        \'d': [':FZF ~/Dropbox/Documents/SQLite/Databases', 'databases'],
        \'h': [':FZF', 'here'],
    \},
    \'r': {
        \'name': '+file_content_search_regex',
        \'h': [':Rg', 'here'],
    \},
    \'c': {
        \'name': '+file_content_search',
        \'h': [':Ag!', 'here'],
    \}
    \}

"""" Tests
let g:which_key_map.t = {
    \'name': '+tests',
    \'n': [':TestNearest', 'Run test nearest cursor'],
    \'f': [':TestFile', 'Run current test file'],
    \'s': [':TestSuite', 'Run current test suite'],
    \}

"""" Vimux
let g:which_key_map.v = {
    \'name': '+vimux',
    \'o': [':call VimuxOpenRunner()', 'open'],
    \'i': [':call VimuxInspectRunner()', 'inspect'],
    \'q': [':VimuxCloseRunner', 'close']
    \}

"""" Write
let g:which_key_map.w = [':w', 'write']

"""" Completion
let g:which_key_map.y = {
    \'name': '+youcompleteme',
    \'d': [':YcmCompleter GoToDefinition', 'GoToDefinition'],
    \'r': [':YcmCompleter GoToReferences', 'GoToReferences'],
    \}

"""" General Bindings
map <F1> :w <CR>
map <F4> :bp <CR> 
map <F5> :bn <CR>
map <F12> :bd <CR>
nnoremap Y y$
nnoremap U <c-r>

" Force vim's search to always remain centered on the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

""" Text expansions
iabbrev lbreak;; # ---------------------------------------------------------------------------------------------------
iabbrev break;; # -----------------------------------------------------------------------------------------------

""" Custom Functions
let g:CustomEditorStateNormal = 1
function! ToggleNormalMode()
    if g:CustomEditorStateNormal
        set nonumber norelativenumber
        set nolist
        IndentLinesDisable
        let g:CustomEditorStateNormal = 0
    else
        set number relativenumber
        set list
        IndentLinesEnable
        let g:CustomEditorStateNormal = 1
    endif
endfunction

" Commands to edit or reload this file
command! EditConf :edit ~/.config/nvim/init.vim
command! ReloadConf :so ~/.config/nvim/init.vim

""" Misc
" Highlight .sqli files as sql
autocmd BufRead *sqli set ft=sql

" Toggle to keep cursor centered on screen
"nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
