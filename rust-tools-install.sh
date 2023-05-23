#!/bin/bash
mkdir -p $HOME/tools
git clone https://github.com/kamiyaa/joshuto $HOME/tools/joshuto
git clone https://github.com/BurntSushi/ripgrep.git $HOME/tools/ripgrep
cargo install fd-find
git clone --depth 1 git@github.com:lotabout/skim.git ~/.skim
cargo install gitui
