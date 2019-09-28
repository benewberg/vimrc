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
Plug 'tomtom/tcomment_vim'
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
"Plug 'prettier/vim-prettier', {'do': npm install'}
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'liuchengxu/vim-which-key'
Plug 'drewtempelmeyer/palenight.vim'

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
hi! Whitespace guifg=#b2b2b2
hi! Folded guifg=#00b3b3
set termguicolors
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
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extension#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_them = 'wombat'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_section_x = '' 
let g:airline_section_y = '%{getcwd()}' 
set noshowmode
" comment out the below section if you don't have a patched font installed (eg a nerd font)
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_symbols.branch = '\ue725'
"let g:airline_symbols.dirty = '\ue702'
"let g:airline_left_sep = '\ue0b8'
"let g:airline_left_alt_sep = '\ue0b9'

""" indentLine
"let g:indentLine_char = '┊'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']  " This will indent using a diff char per level
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
let g:ale_python_flake8_options = '--ignore=E501'  " suppress line length warnings

"""" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

"""" EasyOperator
let g:EasyOperator_line_do_mapping = 0


"""" WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=100

"""" GitGutter
" Allow git-gutter to display the changes to the file faster (default in vim
" is 4000, or 4 seconds)
set updatetime=100

"""" ayu
let ayucolor='mirage'
colorscheme ayu

"""" palenight
"set background=dark
"colorscheme palenight

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

"""" Linting
let g:which_key_map.a = {
    \'name': '+ale',
    \'e': [':ALEEnable', 'Enable ALE'],
    \'d': [':ALEDisable', 'Disable ALE'],
    \'t': [':ALEToggle', 'Toggle ALE']
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
    \'t': [':TComment', 'toggle-comment'],
    \'b': [":'<,'>TCommentBlock", 'comment block']
    \}

"""" Git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'p': [':GitGutterPrevHunk', 'previous hunk'],
    \'n': [':GitGutterNextHunk', 'next hunk'],
    \'d': [':GitGutterUndoHunk', 'delete hunk'],
    \'h': [':call VimuxRunCommandInDir("clear; git_author", 1)', 'history'],
    \}

"""" Highlighting
let g:which_key_map.h = [':noh', 'no highlights']

"""" Line 
let g:which_key_map.l = {
    \'name': '+easyop-line',
    \'y': ['<Plug>(easyoperator-line-yank)', 'yank'],
    \'d': ['<Plug>(easyoperator-line-delete)', 'delete'],
    \}

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
    \'c': {
        \'name': '+file_content_search',
        \'h': [':Ag', 'here'],
    \}
    \}

"""" Vimux
let g:which_key_map.v = {
    \'name': '+vimux',
    \'o': [':VimuxPromptCommand', 'open'],
    \'c': [':VimuxCloseRunner', 'close']
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
map <F2> :noh <CR>
map <F3> :bd <CR> 
map <F4> :bp <CR>
map <F5> :bn <CR>
map <F6> :YcmCompleter GoToDefinition <CR>
map <F7> :YcmCompleter GoToReferences <CR>
map <F8> :Ag! <CR>
map <F9> :FZF <CR>
map <F10> :FZF ~/Dropbox/Documents/SQLite/Databases
map <F12> :call VimuxRunCommandInDir("clear; ll", 0)<CR>
map Y y$

" Force vim's search to always remain centered on the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

""" Text expansions
iabbrev break;; # ----------------------------------------------------------------------------------------

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
