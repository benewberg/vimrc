" vim: ft=vim
call plug#begin('~/.config/nvim/plugged')
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'jeetsukumaran/vim-markology'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'heavenshell/vim-pydocstring'
Plug 'fisadev/vim-isort'
Plug 'benmills/vimux'
Plug 'mtth/scratch.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'mileszs/ack.vim'
Plug 'tmhedberg/SimplyFold'
Plug 'Konfekt/FastFold'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'

call plug#end()

set mouse=a
set ignorecase
set clipboard+=unnamedplus
set clipboard=unnamedplus
set termguicolors
let ayucolor='mirage'
colorscheme ayu
hi! Whitespace guifg=#b2b2b2
hi! Folded guifg=#00b3b3

" Keep markology from showing, to allow ale to show lint errors
let g:markology_enable = 0

" YouCompleteMe
" let g:ycm_python_binary_path = '/opt/bats/bin/python'
let g:loaded_python3_provider = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<M-n>"
let g:UltiSnipsJumpBackwardTrigger = "<M-p>"
let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/UltiSnips']
let g:UltiSnipsEnableSnipMate = 0

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extension#ale#enabled = 1
let g:airline_them = 'wombat'

" +-----------------------------------------------------------------------------+
" | A | B |                     C                            X | Y | Z |   [...]| 
" +-----------------------------------------------------------------------------+
let g:airline_section_x = ""
let g:airline_section_y = ""
let g:airline_section_z = ""

" indentLine
let g:indentLine_char = '┊'

" auto-pairs
let g:AutoPairsCenterLine = 0

" SimplyFold
set foldlevel=999
let g:SimplyFold_fold_import = 0

" FastFold
let g:fastfold_force = 1
let g:fastfold_savehook = 0

" git-gutter
" allow git-gutter to display the changes to the file faster (default in vim
" is 4000, or 4 seconds)
set updatetime=100

" File searching with ag
let g:ackprg = 'ag --vimgrep'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
cnoreabbrev Ack Ack!

" Linting settings
let g:ale_linters = {
\   'python': ['flake8']
\}
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 0
let g:ale_python_flake8_options = '--ignore=E501'  " suppress line length warnings

" Highlight .sqli files as sql
autocmd BufRead *sqli set ft=sql

set cursorline
set colorcolumn=100
" Allow for gq to auto wrap a line, but don't do it as I'm typing, only on
" command
set textwidth=100
set formatoptions-=t

" Silence pydocstring's keymapping because I don't use it
nmap <silent> <C-_> <Plug>(pydocstring)

" Macro to enclose the entire line in quotes and add a comma to the end and
" move down one line
let @z="$S'A,^j"

map <C-Space> <Leader>c<space>
map <F1> :w <CR>
map <F2> :noh <CR>
map <F3> :bd <CR> 
map <F4> :bp <CR>
map <F5> :bn <CR>
map <F6> :YcmCompleter GoToDefinition <CR>
map <F7> :YcmCompleter GoToReference <CR>
map <F8> :Ag! <CR>
map <F9> :FZF <CR>
map <F10> :FZF ~/Dropbox/Documents/SQLite/Databases
map <F12> :call VimuxRunCommandInDir("clear; ll", 0)<CR>
imap <M-Space> <Esc>
map <C-S> "_d

:set expandtab tabstop=4 shiftwidth=4 smarttab
":set number norelativenumber
set number relativenumber
set lazyredraw
set nowrap

" Vimux stuff
map <Leader>vc :VimuxCloseRunner<CR>
map <Leader>vp :VimuxPromptCommand<CR>
let g:VimuxUseNearest = 0

" Force vim's serach to always remain centered on the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Toggle to keep cursor centered on screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Custom leader commands
map <Leader>at :ALEToggle<CR>
map <Leader>gt :call VimuxRunCommandInDir("clear; git_author", 1)<CR>

" Commands to edit or reload this file
command! EditConf :edit ~/.config/nvim/init.vim
command! ReloadConf :so ~/.config/nvim/init.vim

" Text expansions
iabbrev break;; # ----------------------------------------------------------------------------------------

command! Date :read !date + '\%Y-\%m-\%d'

" Custom Functions
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
