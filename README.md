# Notes

## Plugins
1. promptline
  * Use this fork to get true colors working: https://github.com/plexigras/promptline.vim
  * In init.vim: `Plug 'plexigras/promptline.vim'`
  * `:PlugInstall` 
  * `:PromptlineSnapshot! $HOME/dotfiles/bash/promptline.sh airline clear`

2. tmuxline
  * https://github.com/edkolev/tmuxline.vim
  * In init.vim: `Plug 'edkolev'/tmuxline.vim'`
  1. `:PlugInstall`
  2. `:Tmuxline airline_insert`
  3. `:TmuxlineSnapshot! $HOME/dotfiles/tmux/.tmux-line.conf`
  4. In $HOME/.tmux.conf: `if-shell "[ -f ~/.no-powerline ]" "" "source-file $HOME/dotfiles/tmux/.tmux-line.conf"`

3. vim-floaterm
  * https://github.com/voldikss/vim-floaterm
  * In init.vim: `Plug 'voldikss/vim-floaterm'`
  1. `:PlugInstall`
  * For more advanced fun with fzf and others, install `nvr`:
  1. `cd $HOME/.virtualenvs/neovim/bin`
  2. `./pip3 install neovim-remote` 
