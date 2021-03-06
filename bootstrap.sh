#!/bin/bash

set -e

DOTFILES=$HOME/dev/src/github.com/tysonmote/dotfiles

function banner() {
  echo "***"
  echo "*** $1"
  echo "***"
}

banner "Installing basics"

brew install git lua mercurial openssl python python3 subversion

banner "Linking git config"

ln -s $DOTFILES/git/gitignore $HOME/.gitignore
ln -s $DOTFILES/git/gitconfig.segment $HOME/.gitconfig

banner "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

banner "Linking zsh config"

ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/tyson.zsh-theme $HOME/.oh-my-zsh/themes/

banner "Installing Go"

brew install go

banner "Installing Ruby"

brew install rbenv ruby-build
rbenv install 2.6.3
rbenv global 2.6.3

banner "Installing Node.js"

brew install n
n 12
npm -g install typescript prettier-eslint

banner "Installing NeoVim"

brew install neovim
pip3 install neovim
npm install -g neovim
sudo pip3 install --upgrade pynvim
sudo gem install neovim
npm install -g vscode-json-languageserver

banner "Configuring NeoVim"

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p $HOME/.config/nvim/
ln -s $DOTFILES/vim/init.vim $HOME/.config/nvim/
ln -s $DOTFILES/vim/snippets $HOME/.config/nvim/
nvim +PlugInstall +qall
nvim +GoUpdateBinaries +qall

banner "Installing extras"

brew install awscli cscope ctags jq parallel pcre postgresql redis sqlite the_silver_searcher fzf fd bat htop diff-so-fancy tldr

