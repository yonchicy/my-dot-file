# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
bindkey ',' autosuggest-accept
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk


alias
alias ls='lsd'
alias ll='ls -alh'
alias l='ls -alh'
alias vs=code
alias vi=vim
alias v=vim
alias fd=fdfind
alias tmux="TERM=screen-256color-bce tmux"
# export PATH="$PATH:/root/.cargo/bin/:/home/yang/tool/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14/bin"
export EDITOR="vim"
export PAGER="most"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPTATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yang/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yang/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yang/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yang/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PYTHONPATH=$PYTHONPATH:/home/yang/nao/naoqi-sdk-2.1.4.13-linux32
export PYTHONPATH=$PYTHONPATH:/home/yang/nao/pynaoqi-python2.7-2.1.4.13-linux32
