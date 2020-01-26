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
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'ayu-theme/ayu-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'rhysd/committia.vim'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'psliwka/vim-smoothie'
Plug 'machakann/vim-sandwich'

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
"""" YouCompleteMe
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:loaded_python3_provider = 1
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_key_detailed_diagnostics = ''

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
let g:indentLine_char = '┆'
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

"""" WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=1000

"""" GitGutter
" Allow git-gutter to display the changes to the file faster (default in vim
" is 4000, or 4 seconds)
set updatetime=100

"""" VimTest
let test#python#runner = 'nose'
let test#strategy = {
    \'file': 'dispatch',
    \'last': 'dispatch',
    \'nearest': 'dispatch',
    \'suite': 'dispatch_background',
\}
let test#python#nose#options = {
    \'file': '-sv --with-id',
    \'last': '-sv',
    \'nearest': '-sv --with-id',
    \'suite': '-sv',
\}

"""" Dispatch
let g:dispatch_no_maps = 1

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

"""" Split Navigation
nnoremap <C-j> <C-W><down>
nnoremap <C-k> <C-W><up>
nnoremap <C-l> <C-W><right>
nnoremap <bs> <C-W><left>

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
    \'d': [':bd', 'kill current'],
    \}

"""" Git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'p': [':GitGutterPrevHunk', 'previous hunk'],
    \'n': [':GitGutterNextHunk', 'next hunk'],
    \'d': [':GitGutterUndoHunk', 'delete hunk'],
    \'l': {
        \'name': '+log',
        \'a': [':Glog %', 'All commits for file'],
        \'r': [':0Glog -n 5 --color', 'Recent (5) commits for this file'],
        \},
    \}

"""" Highlighting
let g:which_key_map.h = [":let @/=''", 'no highlights']

"""" Motion
let g:which_key_map.m = {
    \'name': '+motion',
    \'s': ['<Plug>(easymotion-sn)', 'EasyMotion Sneak'],
    \}

"""" Quickfix
let g:which_key_map.q = {
    \'name': '+quickfix-test',
    \'o': [':Copen | :call Equal("horizontal")', 'open horizontal'],
    \'c': [':cclose', 'close']
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
    \'f': [':TestFile', 'Run current test file'],
    \'l': [':TestLast', 'Run last run test'],
    \'n': [':TestNearest', 'Run test nearest cursor'],
    \'s': [':TestSuite', 'Run current test suite'],
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

function! Equal(type)
    if a:type ==? 'horizontal'
        let l:total = str2float(&lines)
    elseif a:type ==? 'vertical'
        let l:total = str2float(&columns)
    else
        echom 'Unknown arg ' . a:type
        return
    endif

    let l:half = string(round(total / 2))
    execute ':resize ' . half
endfunction

" Commands to edit or reload this file
command! EditConf :edit ~/.config/nvim/init.vim
command! ReloadConf :so ~/.config/nvim/init.vim

""" Misc
" Highlight .sqli files as sql
autocmd BufRead *sqli set ft=sql

""" Help
"""" vim-commentary
" gc{motion}            comment or uncomment lines that {motion} moves over
" [count]gcc            comment or uncomment [count] lines

"""" vim-surround
" ds"           delete the surrounding double-quotes
" cs])          change the surrounding square-brackets to parens
" cs)}          change the surrounding parens to curly-brackets (with no spaces)
" cs){          change the surrounding parens to curly-brackets (with spaces)
" ysW"          surround the word (incl. punctuation) with double-quotes
" ysiw'         surround the inner word with single-quotes

"""" quickfix
" :copen        open the quickfix window
" :cclose       close the quickfix window
" :cw           open the quickfix window if errors, otherwise close it
