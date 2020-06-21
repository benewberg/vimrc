" vim: ft=vim

" ---------------------
"  plugin installation
" ---------------------
call plug#begin('~/.config/nvim/plugged')

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'benewberg/ayu-vim'
Plug 'liuchengxu/vim-which-key'
Plug 'machakann/vim-sandwich'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/incsearch.vim'
Plug 'voldikss/vim-floaterm'
Plug 'pechorin/any-jump.vim'

call plug#end()

" ----------------
"  general config
" ----------------
set mouse=a
set ignorecase
set cursorline
set colorcolumn=100
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
set noshowmode  " not necessary with a statusline set
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

"  ayu
set termguicolors
let ayucolor='mirage'
colorscheme ayu
" make the line numbers more visible (must be called after colorscheme)
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Extension settings
let g:coc_global_extensions = [
    \'coc-python',
    \'coc-json',
    \'coc-git',
    \'coc-pairs',
    \'coc-yank',
    \]

"  custom statusline -- make sure colorscheme is set before this
set showtabline=2
set laststatus=2
set statusline=
set statusline+=%#NormalColorText#%{(mode()=='n')?g:currentmode[mode()]:''}
set statusline+=%#InsertColorText#%{(mode()=='i')?g:currentmode[mode()]:''}
set statusline+=%#VisualColorText#%{(IsVisualMode())?g:currentmode[mode()]:''}
set statusline+=%#ReplaceColorText#%{(mode()=='R')?g:currentmode[mode()]:''}
set statusline+=%#NormalColorText#%{(IsOtherMode())?g:currentmode[mode()]:''}
set statusline+=%#DiffAdd#
set statusline+=%{StatuslineGitBranch()}
set statusline+=%{StatuslineReadonly()}
set statusline+=\ %m
set statusline+=%#Directory#
set statusline+=%=
set statusline+=%{StatuslineCurrentDirectory()}
set statusline+=%#Pmenu#
set statusline+=%{StatuslinePercentOfFile()}
set statusline+=%#TabLine#
set statusline+=\ %3l:%-2v
hi NormalColorText guibg=#bbe67e guifg=#212733 gui=BOLD
hi InsertColorText guibg=#80d4ff guifg=#212733 gui=BOLD
hi VisualColorText guibg=#ffae57 guifg=#212733 gui=BOLD
hi ReplaceColorText guibg=#f07178 guifg=#212733 gui=BOLD

let g:currentmode={
    \ 'n': '  NORMAL ',
    \ 'no': '  N-OPERATOR PENDING ',
    \ 'v': '  VISUAL ',
    \ 'V': '  V-LINE ',
    \ '': '  V-BLOCK ',
    \ 's': '  SELECT ',
    \ 'S': '  S-LINE ',
	\ '' : '  S-BLOCK ',
    \ 'i': '  INSERT ',
    \ 'R': '  REPLACE ',
    \ 'Rv': '  V-REPLACE ',
    \ 'c': '  COMMAND ',
    \ 'cv': '  VIM EX ',
    \ 'ce': '  EX ',
    \ 'r': '  PROMPT ',
    \ 'rm': '  MORE ',
    \ 'r?': '  CONFIRM ',
    \ '!': '  SHELL ',
    \ 't': '  TERMINAL '
    \}

function! IsVisualMode()
  return (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# '  V-BLOCK ')
endfunction

function! IsOtherMode()
  return (!(mode() =~# '\v(n|no|v|V|R|i)') && !(IsVisualMode()))
endfunction

function! StatuslineGitBranch()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? '   '.branch : ''
  endif
  return = ''
endfunction

function! StatuslineReadonly()
  if &readonly || !&modifiable
    return '    '
  else
    return ''
endfunction

function! StatuslineCurrentDirectory() abort
  return getcwd()." "
endfunction

function! StatuslinePercentOfFile()
  let current = line('.') + 0.0
  let total = line('$') + 0.0
  return printf('  %.0f%% ', (current / total) * 100)
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"  indentLine
let g:indentLine_char = ''

"  any-jump
let g:any_jump_disable_default_keybindings = 1
let g:any_jump_window_style_minimal = 1

"  WhichKey
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
set timeoutlen=1000

"  vim-sneak
let g:sneak#label = 1  " for a lighter-weight easymotion feel

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
let mapleader = ' '

"  WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

"  single
let g:which_key_map[':'] = [':e ~/dotfiles/nvim/init.vim', 'open init']
let g:which_key_map[';'] = [':so ~/dotfiles/nvim/init.vim', 'source init']
let g:which_key_map['b'] = ["Buffers", 'buffers']
let g:which_key_map['h'] = ['Helptags', 'help']
let g:which_key_map['q'] = [':bd', 'delete buffer']

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
    \'~': [':cd ~', 'home'],
    \}

"  find
let g:which_key_map.f = {
    \'name': '+find',
    \'l': ["Lines", 'lines'],
    \'r': ["Rg", 'rg'],
    \}

"  git
let g:which_key_map.g = {
    \'name': '+git',
    \'b': [':Git blame', 'blame'],
    \'c': [':Git commit', 'commit'],
    \'d': [":call CocAction('runCommand', 'git.showCommit')", 'commit diff'],
    \'g': ['Git', 'git status'],
    \'i': ['<Plug>(coc-git-chunkinfo)', 'hunk info'],
    \'j': ['<Plug>(coc-git-nextchunk)', 'next hunk'],
    \'k': ['<Plug>(coc-git-prevchunk)', 'previous hunk'],
    \'l': ['BCommits', 'list of commits'],
    \'r': [":Git reset -p", 'unstage (reset) hunks'],
    \'s': [":call CocAction('runCommand', 'git.chunkStage')", 'stage hunk'],
    \'t': [":call CocAction('runCommand', 'git.toggleGutters')", 'toggle gutters'],
    \'u': [":call CocAction('runCommand', 'git.chunkUndo')", 'undo hunk'],
    \}

"  jump to
let g:which_key_map.j = {
    \'name': '+jump',
    \'b': ['AnyJumpBack', 'jump back'],
    \'d': ['<Plug>(coc-definition)', 'definition'],
    \'j': ['AnyJump', 'jump'],
    \'p': [":call CocAction('doHover')", 'peek'],
    \'r': ['<Plug>(coc-references)', 'references'],
    \}

"  nosetests
let g:which_key_map.n = {
    \'name': '+tests',
    \'c': [":call _FloatermPathCmd('ntac', '%:p')", "marked current"],
    \'d': [":call _FloatermPathCmd('nosetests -v', '%:p:h')", "dir"],
    \'f': [":call _FloatermPathCmd('nosetests -v', '%:p')", "file"],
    \'v': [":call _FloatermPathCmd('ntcov', '%')", "file coverage"],
    \}

"  open
let g:which_key_map.o = {
    \'name': '+open',
    \'f': ["Files", 'files'],
    \'h': ["History", 'history'],
    \}

"  refactor
let g:which_key_map.r = {
    \'name': '+refactor',
    \'f': [":call CocAction('format')", 'format file'],
    \'l': [":call CocAction('runCommand', 'python.enableLinting')", 'linting'],
    \'r': ['<Plug>(coc-rename)', 'rename'],
    \}

"  terminal
let g:which_key_map.t = {
    \'name': '+terminal',
    \'h': [":FloatermHide", "hide"],
    \'k': [":FloatermKill", "kill"],
    \'o': [":FloatermNew", "open new"],
    \'s': [":FloatermShow", "show"],
    \}

"  misc
let g:which_key_map.z = {
    \'name': '+misc',
    \'<': [":set nonumber norelativenumber nolist | :exe 'IndentLinesDisable'", 'ed state off'],
    \'>': [":set number relativenumber list | :exe 'IndentLinesEnable'", 'ed state on'],
    \'/': [":let @/=''", 'no highlights'],
    \}

"  vim-sandwich
" use tpope's vim-surround key mappings; this allows us not to clash with vim-sneak
runtime macros/sandwich/keymap/surround.vim

"  general bindings
noremap <F1> :w<CR>
inoremap <F1> <esc>:w<CR>
nnoremap Y y$
nmap <Tab> <C-^><CR>
nmap <S-Tab> :bn<CR>

"  split navigation
nnoremap <C-j> <C-W><down>
nnoremap <C-k> <C-W><up>
nnoremap <C-l> <C-W><right>
nnoremap <C-h> <C-W><left>

"  incsearch
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
iabbrev lbreak;; # --------------------------------------------------------------------------------------------------
iabbrev break;; # ----------------------------------------------------------------------------------------------
iabbrev current;; from nose.plugins.attrib import attr
            \<CR>@attr('current')

" ------------
"  cheatsheet
" ------------
"  fugitive
" ~    the tilde will go back in time thru revisions on the current line in a Gblame
" (how to stage hunks at a fine grain level) --> 1. use :Git to show status
"                                                2. type dd on the unstaged file
"                                                3. go to the bottom or right split and type dp on the line(s) to stage
"                                                4. in the middle split, delete any lines you don't want to stage that got added in step 3
"                                                5. :wq

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
