## Dotfiles

* Install Zsh
* Install Oh-my-zsh
    * Move setup specific items to `$HOME/.profile`
* Install yarn
* Install language servers for coc-vim 
    * go language server `GO111MODULE=on go get golang.org/x/tools/gopls@latest`
* Install Neovim
    * Install vim-plug `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
    * Open `~/.config/nvim/init.vim`
    * `:PlugInstall`
