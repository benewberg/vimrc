" vim: ft=vim

" ---------------------
"  plugin installation
" ---------------------
call plug#begin('~/.config/nvim/plugged')

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mengelbrecht/lightline-bufferline' | Plug 'benewberg/lightline.vim'  " fork for slightly modified ayu_mirage colors
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'ayu-theme/ayu-vim'
Plug 'rhysd/committia.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'machakann/vim-sandwich'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/incsearch.vim'
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
set ttimeoutlen=10  " set the escape key timeout to very little
let g:python3_host_prog="/home/ben/.virtualenvs/neovim/bin/python3"
set updatetime=100  " make the git gutter updates show up quicker

" -----------------
"  plugin settings
" -----------------
"  fzf
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.6}}
let g:fzf_colors = {
    \'fg': ['fg', 'Normal'],
    \'hl': ['fg', 'Constant'],
    \'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \'bg+': ['bg', 'CursorLine', 'CursorColumn'],
    \'hl+': ['fg', 'Statement'],
    \'info': ['fg', 'PreProc'],
    \'prompt': ['fg', 'Conditional'],
    \'pointer': ['fg', 'Exception'],
    \'marker': ['fg', 'Keyword'],
    \'spinner': ['fg', 'Label'],
    \'header': ['fg', 'Comment']}
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

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

" Extension settings
let g:coc_global_extensions = [
    \'coc-python',
    \'coc-snippets',
    \'coc-json',
    \'coc-git',
    \'coc-pairs',
    \'coc-lists',
    \'coc-yank',
    \]

"  lightline
set showtabline=2  " force the tabline to always show
let g:lightline = {}
let g:lightline.active = {'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'modified']],
                         \'right': [['lineinfo'], ['percent'], ['cwd']]}
let g:lightline.colorscheme = 'ayu_mirage'
let g:lightline.component = {'lineinfo': ' %3l:%-2v'}
let g:lightline.component_function = {'readonly': 'LghtlineReadonly', 'gitbranch': 'LightlineFugitive',
                                     \'cwd': 'LightlineCurrentDirectory'}
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = {'left': '', 'right': '' }
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'  " show only file name
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction
function! LightlineCurrentDirectory() abort
    return getcwd()
endfunction

"  indentLine
let g:indentLine_char = '┆'

"  ayu
set termguicolors
let ayucolor='mirage'
colorscheme ayu
" make the line numbers more visible (must be called after colorscheme)
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"  WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=1000

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
let g:floaterm_wintitle = 0
function! _FloatermPathCmd(cmd, path)
    call floaterm#new(a:cmd . ' ' . expand(a:path), {}, {}, v:true)
endfunction

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

"  single
let g:which_key_map[':'] = [':e ~/dotfiles/nvim/init.vim', 'open init']
let g:which_key_map[';'] = [':so ~/dotfiles/nvim/init.vim', 'source init']
let g:which_key_map['h'] = ['Helptags', 'help']

"  buffers
let g:which_key_map.b = {
    \'name': '+buffers',
    \'d': [':bd', 'delete'],
    \'l': ["Buffers", 'list'],
    \'m': ["History", 'mru'],
    \}

"  change dir
let g:which_key_map.c = {
    \'name': '+cd',
    \'a': [':cd $PATH_PROG_ARDUINO', 'Arduino'],
    \'c': [':cd $PATH_PROG_CPP', 'cpp'],
    \'d': [':cd $PATH_DROPBOX_DB', 'databases'],
    \'h': [':cd %:p:h', 'here (this buffer)'],
    \'p': [':cd $PATH_PROG_PYTHON', 'python'],
    \'q': [':cd $PATH_PROG_QT', 'Qt'],
    \'r': [':cd $PATH_PROG_R', 'R'],
    \}

"  fuzzy finding
let g:which_key_map.f = {
    \'name': '+find',
    \'f': ["Files", 'files'],
    \'l': ["Lines", 'lines'],
    \'r': ["Rg", 'rg'],
    \}

"  git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Gblame', 'blame'],
    \'c': [':Gcommit', 'commit'],
    \'d': [":call CocAction('runCommand', 'git.showCommit')", 'commit diff'],
    \'g': ['Git', 'git status'],
    \'i': ['<Plug>(coc-git-chunkinfo)', 'hunk info'],
    \'j': ['<Plug>(coc-git-nextchunk)', 'next hunk'],
    \'k': ['<Plug>(coc-git-prevchunk)', 'previous hunk'],
    \'l': ['BCommits', 'list of commits'],
    \'r': [":exe 'Git reset -p'", 'unstage (reset) hunks'],
    \'s': [":call CocAction('runCommand', 'git.chunkStage')", 'stage hunk'],
    \'t': [":call CocAction('runCommand', 'git.toggleGutters')", 'toggle gutters'],
    \'u': [":call CocAction('runCommand', 'git.chunkUndo')", 'undo hunk'],
    \}

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
    \'d': [":call _FloatermPathCmd('nosetests -v', '%:p:h')", "dir"],
    \'f': [":call _FloatermPathCmd('nosetests -v', '%:p')", "file"],
    \}

"  misc
let g:which_key_map.z = {
    \'name': '+misc',
    \'<': [":set nonumber norelativenumber nolist | :exe 'IndentLinesDisable'", 'ed state off'],
    \'>': [":set number relativenumber list | :exe 'IndentLinesEnable'", 'ed state on'],
    \'/': [":let @/=''", 'no highlights']
    \}

"  vim-sandwich
" use tpope's vim-surround key mappings; this allows us not to clash with vim-sneak
runtime macros/sandwich/keymap/surround.vim

"  general bindings
noremap <F1> :w<CR>
inoremap <F1> <esc>:w<CR>
nnoremap Y y$
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

" -----------------
"  custom commands
" -----------------
autocmd BufRead *sqli set ft=sql  " highlight .sqli files as sql
autocmd BufEnter * set fo-=c fo-=r fo-=o  " stop annoying auto commenting on new lines

" ---------------
"  custom abbrev
" ---------------
iabbrev lbreak;; # ---------------------------------------------------------------------------------------------------
iabbrev break;; # -----------------------------------------------------------------------------------------------
iabbrev current;; from nose.plugins.attrib import attr
            \<CR>@attr('current')

" ------------
"  cheatsheet
" ------------
"  fugitive
" ~    the tilde will go back in time thru revisions on the current line in a Gblame

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
