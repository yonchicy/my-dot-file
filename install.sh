#!/bin/bash
mkdir -p ~/.config
cp  ~/my-dot-file/.zshrc ~/.zshrc
cp  ~/my-dot-file/.vimrc ~/.vimrc
cp  $HOME/my-dot-file/config/* ~/.config/ -r
rm -rf $HOME/.config/nvim 
ln -s $HOME/my-dot-file/LazyVim $HOME/.config/nvim
mkdir -p $HOME/.zsh
cp $HOME/my-dot-file/zsh-plug.sh $HOME/.zsh
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install starship
curl -sS https://starship.rs/install.sh | sh
git clone https://github.com/neovim/neovim.git

cd $HOME/.zsh && bash zsh-plug.sh
