" vim: ft=vim

" ---------------------
"  plugin installation
" ---------------------
call plug#begin('~/.config/nvim/plugged')

Plug '~/.fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline-themes' | Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'ayu-theme/ayu-vim'
Plug 'rhysd/committia.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'janko/vim-test'
Plug 'machakann/vim-sandwich'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/incsearch.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'voldikss/vim-floaterm'

call plug#end()

" ----------------
"  general config
" ----------------
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
filetype plugin on  " allow filetype plugins to be enabled
set hidden  " allow to switch buffers without saving
set nostartofline  " don't move cursor to start of line when switching buffers
set inccommand=nosplit  " visually show live substitutions
set clipboard=unnamedplus
set noshowmode  " not necessary with a statusline plugin
set ttimeoutlen=10  " Set the escape key timeout to very little

" -----------------
"  plugin settings
" -----------------
"  coc.nvim
set nobackup
set nowritebackup  " some servers have issues with backup files, see #649.
set shortmess+=c  " don't pass messages to |ins-completion-menu|.
set signcolumn=yes  " always show the signcolumn, otherwise it would shift the text each time

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Extension settings
let g:coc_global_extensions = [
    \'coc-python',
    \'coc-snippets',
    \'coc-json',
    \'coc-git',
    \'coc-pairs',
    \'coc-lists',
    \'coc-floaterm',
    \]

" coc-git
set updatetime=100

"  vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'ayu_mirage'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_section_x = '' 
let g:airline_section_y = '%{getcwd()}' 
" comment out the below section if you don't have a patched font installed (eg a nerd font)
" if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
" endif
" let g:airline_left_sep = '\uE0B8'
" let g:airline_left_alt_sep = '\UE0B9'

"  indentLine
let g:indentLine_char = '┆'

"  WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=1000

"  vim-test
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

"  ayu
set termguicolors
let ayucolor='mirage'
colorscheme ayu
" make the line numbers more visible (must be called after colorscheme)
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"  vim-sneak
let g:sneak#label = 1  " for a lighter-weight easymotion feel
highlight Sneak guifg=#212733 guibg=#FFC44C ctermfg=black ctermbg=cyan

"  incsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1  " auto turn off highlighting when navigating off

"  floaterm
let g:floaterm_autoclose = 1
let g:floaterm_width = 0.9
let g:floaterm_height = 0.7

" --------------
"  key mappings
" --------------
" Change leader to space key (KEEP THIS ABOVE OTHER LEADER MAPPINGS)
" This has to be higher in the file than any <Leader> mappings, since it resets any leader mappings
" defined above it
let mapleader = ' '

"  WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

"  buffers
let g:which_key_map.b = {
    \'name': '+buffers',
    \'d': [':bd', 'delete'],
    \'l': [":exe 'CocList -A -N buffers'", 'list'],
    \'m': [":exe 'CocList -A -N mru'", 'MRU'],
    \}

"  change dir
let g:which_key_map.c = {
    \'name': '+cd',
    \'a': [':cd ~/Projects/Arduino', 'Arduino'],
    \'c': [':cd ~/Projects/Cpp', 'cpp'],
    \'d': [':cd ~/Dropbox/Documents/SQLite/Databases', 'databases'],
    \'h': [':cd %:p:h', 'here (this buffer)'],
    \'p': [':cd ~/Projects/Python', 'python'],
    \'q': [':cd ~/Projects/Qt', 'Qt'],
    \'r': [':cd ~/Projects/R', 'R'],
    \}

"  fuzzy finding
let g:which_key_map.f = {
    \'name': '+find',
    \'f': [":exe 'CocList -A -N files'", 'file name'],
    \'g': [":exe 'CocList -A -N -I grep'", 'grep (rg)'],
    \'x': [":call _FloatermFZF('~/Projects/Python/')", 'python (experimental)']
    \}

"  git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'c': [':Gcommit', 'commit'],
    \'d': [":call CocAction('runCommand', 'git.showCommit')", 'commit diff'],
    \'g': ['Git', 'git status'],
    \'i': ['<Plug>(coc-git-chunkinfo)', 'chunk info'],
    \'l': [":exe 'CocList -A -N commits'", 'list of commits'],
    \'n': ['<Plug>(coc-git-nextchunk)', 'next chunk'],
    \'p': ['<Plug>(coc-git-prevchunk)', 'previous chunk'],
    \'s': [":call CocAction('runCommand', 'git.chunkStage')", 'stage chunk'],
    \'t': [":call CocAction('runCommand', 'git.toggleGutters')", 'toggle gutters'],
    \'u': [":call CocAction('runCommand', 'git.chunkUndo')", 'undo chunk'],
    \}

"  highlighting
let g:which_key_map.h = [":let @/=''", 'no highlights']

"  jump to
let g:which_key_map.j = {
    \'name': '+jump',
    \'d': ['<Plug>(coc-definition)', 'definition'],
    \'p': [":call CocAction('doHover')", 'peek'],
    \'r': ['<Plug>(coc-references)', 'references'],
    \}

"  refactor
let g:which_key_map.r = {
    \'name': '+refactor',
    \'f': [":call CocAction('format')", 'format file'],
    \'l': [":call CocAction('runCommand', 'python.enableLinting')", 'linting'],
    \'r': ['<Plug>(coc-rename)', 'rename'],
    \}

"  sessions
let g:which_key_map.s = {
    \'name': '+sessions',
    \'l': [":exe 'CocList -N sessions'", 'list'],
    \'s': [":call CocAction('runCommand', 'session.save')", 'save'],
    \}

"  tests
let g:which_key_map.t = {
    \'name': '+tests',
    \'c': [":call _FloatermPathCmd('ntac', '%:p')", "marked current"],
    \'d': [":call _FloatermPathCmd('nt', '%:p:h')", "dir"],
    \'f': [":call _FloatermPathCmd('nt', '%:p')", "file"],
    \}

"  vim-sandwich
" use tpope's vim-surround key mappings; this allows us not to clash with vim-sneak
runtime macros/sandwich/keymap/surround.vim

"  general bindings
map <F1> :w <CR>
nnoremap Y y$
nnoremap U <c-r>
nmap <Tab> :bn<CR>
nmap <S-Tab> :bp<CR>

"  split navigation
nnoremap <C-j> <C-W><down>
nnoremap <C-k> <C-W><up>
nnoremap <C-l> <C-W><right>
nnoremap <C-h> <C-W><left>

"  incsearch
" append 'zz' to each of these to auto-center the search on the screen
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"  text expansions
iabbrev lbreak;; # ---------------------------------------------------------------------------------------------------
iabbrev break;; # -----------------------------------------------------------------------------------------------
iabbrev current;; from nose.plugins.attrib import attr
            \<CR>@attr('current')

" ------------------
"  custom functions
" ------------------
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

"  custom commands
" -----------------
autocmd BufRead *sqli set ft=sql  " highlight .sqli files as sql
autocmd BufEnter * set fo-=c fo-=r fo-=o  " stop annoying auto commenting on new lines
command! EditConf :edit ~/dotfiles/nvim/init.vim
command! ReloadConf :so ~/dotfiles/nvim/init.vim

" ------
"  help
" ------
"  vim-commentary
" [count]gc{motion}     comment or uncomment lines that {motion} moves over
" [count]gcc            comment or uncomment [count] lines
" gcu                   uncomment all adjacent commented lines

"  vim-sandwich recipes
" dss           delete the surrounding _whatever_
" ds"           delete the surrounding double-quotes
" css(          change the surrounding _whatever_ to parens
" cs[(          change the surrounding square-brackets to parens
" ysiw"         add double-quotes to the inner-word object
" ysiW"         add double-quotes to the inner-word object
" dsf           delete the nearest function name and surrounding parens

"  quickfix
" :copen        open the quickfix window
" :copen 40     open the quickfix window with 40 lines of display
" :cclose       close the quickfix window
" :cw           open the quickfix window if errors, otherwise close it

"  Vanilla Vim -- Increment/Decrement number
" <C-a>         increment number under cursor or the next number found on the line
" <C-x>         decrement number under cursor or the next number found on the line

"  Further reading
" https://stevelosh.com/blog/2010/09/coming-home-to-vim/
