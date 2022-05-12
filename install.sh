#!/bin/bash
mkdir -p ~/.config
cp  ~/my-dot-file/zshrc_double_system ~/.zshrc
ln -s ~/my-dot-file/nvim ~/.config/nvim
mkdir -p ~/.zsh
cp zsh-plug.sh ~/.zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
