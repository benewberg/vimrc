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
Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'
Plug 'ayu-theme/ayu-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'rhysd/committia.vim'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'
Plug 'janko/vim-test'
Plug 'psliwka/vim-smoothie'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-startify'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/incsearch.vim'
Plug 'rhysd/git-messenger.vim'

call plug#end()

""" General Config
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

""" python config
" let g:python_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/usr/bin/python3'

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
"let g:airline_left_sep = '\ue0b8'
"let g:airline_left_alt_sep = '\ue0b9'

""" indentLine
let g:indentLine_char = '┆'

"""" auto-pairs
let g:AutoPairsCenterLine = 0

"""" SimplyFold
set foldlevel=999
let g:SimplyFold_fold_import = 0

"""" FastFold
let g:fastfold_force = 1
let g:fastfold_savehook = 0

"""" FZF
let g:fzf_layout = {'window': 'call FloatingFZF()'}

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
let g:ale_completion_enabled = 0
let g:ale_enabled = 0  "turned off by default
let g:ale_python_flake8_options = '--ignore=E501'  " suppress line length warnings

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
    \'file': 'floating',
    \'last': 'floating',
    \'nearest': 'floating',
    \'suite': 'neovim'
\}
let test#python#nose#options = {
    \'file': '-sv',
    \'last': '-sv',
    \'nearest': '-sv',
\}
function! OnTestExit(job_id, code, event) dict
    if a:code == 0
        close
    endif
endfunction
function! TermTest(cmd)
    call termopen(a:cmd, {'on_exit': 'OnTestExit'})
endfunction
function! FloatingTest(cmd)
    let buf = nvim_create_buf(v:false, v:true)
    let width = &columns - 4
    let height = (&lines / 2) - 2
    let offset = (&lines / 2) - 1
    let opts = {
        \'relative': 'editor',
        \'row': offset,
        \'col': 2,
        \'width': width,
        \'height': height,
        \'style': 'minimal'
        \}
    call nvim_open_win(buf, v:true, opts)
    call TermTest(a:cmd)
endfunction
let g:test#custom_strategies = {'floating': function('FloatingTest')}

"""" Dispatch
let g:dispatch_no_maps = 1

"""" ayu
set termguicolors
let ayucolor='mirage'
colorscheme ayu
" make the line numbers more visible (must be called after colorscheme)
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"""" vim-startify
let g:startify_session_persistence = 1
let g:startify_custom_header = ['    benvim    ']

"""" vim-sneak
let g:sneak#label = 1  " for a lighter-weight easymotion feel

"""" incsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1  "auto turn off highlighting when navigating off

""" Key Bindings
"""" Change leader to space key (KEEP THIS ABOVE OTHER LEADER MAPPINGS)
" This has to be higher in the file than any <Leader> mappings, since it resets any leader mappings
" defined above it
let mapleader = ' '

"""" WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

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

"""" Fuzzy Finding
let g:which_key_map.f = {
    \'name': '+find',
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

"""" Git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'p': [':GitGutterPrevHunk', 'previous hunk'],
    \'n': [':GitGutterNextHunk', 'next hunk'],
    \'d': [':GitGutterUndoHunk', 'delete hunk'],
    \'s': [':Gstatus', 'status'],
    \'c': [':Gcommit', 'commit'],
    \'t': [':GitGutterLineHighlightsToggle', 'toggle highlights'],
    \'m': [':GitMessenger', 'message preview'],
    \'l': {
        \'name': '+log',
        \'a': [':Glog %', 'All commits for file'],
        \'r': [':0Glog -n 5 --color', 'Recent (5) commits for this file'],
        \},
    \}

"""" Highlighting
let g:which_key_map.h = [":let @/=''", 'no highlights']

"""" Sneak
let g:which_key_map.s = {
    \'name': '+sneak',
    \'s': ['<Plug>Sneak_s', 'forward sneak'],
    \'S': ['<Plug>Sneak_S', 'backward sneak'],
    \'f': ['<Plug>Sneak_f', 'forward 1-char sneak'],
    \'F': ['<Plug>Sneak_F', 'backward 1-char sneak'],
    \}

"""" Tests
let g:which_key_map.t = {
    \'name': '+tests',
    \'f': [':TestFile', 'Run current test file'],
    \'l': [':TestLast', 'Run last run test'],
    \'n': [':TestNearest', 'Run test nearest cursor'],
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
nnoremap Y y$
nnoremap U <c-r>
nmap <Tab> :bn<CR>
nmap <S-Tab> :bp<CR>

"""" Split Navigation
nnoremap <C-j> <C-W><down>
nnoremap <C-k> <C-W><up>
nnoremap <C-l> <C-W><right>
nnoremap <bs> <C-W><left>

"""" incsearch
" zz appended to center the searcn on the screen
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

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

function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    let width = &columns - 4
    let height = (&lines / 2) - 2
    let offset = (&lines / 2) - 1
    let opts = {
        \'relative': 'editor',
        \'row': offset,
        \'col': 2,
        \'width': width,
        \'height': height,
        \'style': 'minimal'
        \}
    call nvim_open_win(buf, v:true, opts)
endfunction

" Commands to edit or reload this file
command! EditConf :edit ~/.config/nvim/init.vim
command! ReloadConf :so ~/.config/nvim/init.vim

""" Misc
" Highlight .sqli files as sql
autocmd BufRead *sqli set ft=sql
autocmd BufEnter * set fo-=c fo-=r fo-=o  " stop annoying auto commenting on new lines

""" Help
"""" vim-commentary
" gc{motion}            comment or uncomment lines that {motion} moves over
" [count]gcc            comment or uncomment [count] lines

"""" vim-sandwich recipes
" sdb"          delete the surrounding _whatever_
" sd"           delete the surrounding double-quotes
" sr[(          change the surrounding square-brackets to parens
" saiw"         add double-quotes to the inner-word object
" saW"          add double-quotes to the word (incl. punctuation)

"""" quickfix
" :copen        open the quickfix window
" :copen 40     open the quickfix window with 40 lines of display
" :cclose       close the quickfix window
" :cw           open the quickfix window if errors, otherwise close it

"""" git-messenger
" :GitMessenger         open a floating window preview of the git message under the cursor
" :GitMessenger (x2)    place the cursor inside the floating window preview
" o                     go back to the commit prior to the current commit while in the git floating message preview
" d                     view the diff of the commit while inside the git floating message window
