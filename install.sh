#!/bin/bash
mkdir -p ~/.config
cp ~/my-dot-file/.zshrc ~/.zshrc
cp ~/my-dot-file/.vimrc ~/.vimrc
cp $HOME/my-dot-file/config/* ~/.config/ -r
rm -rf $HOME/.config/nvim
ln -s $HOME/my-dot-file/nvims/lazyvim $HOME/.config/lazyvim
git clone https://github.com/NvChad/NvChad ~/.config/nvchad --depth 1
ln -s $HOME/my-dot-file/nvims/nvchad $HOME/.config/nvchad/lua/custom
mkdir -p $HOME/.zsh
cp $HOME/my-dot-file/zsh-plug.sh $HOME/.zsh
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install starship
curl -sS https://starship.rs/install.sh | sh
git clone https://github.com/neovim/neovim.git ~

cd $HOME/.zsh && bash zsh-plug.sh
cargo install zoxide --locked
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
