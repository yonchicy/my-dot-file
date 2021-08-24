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

[[ -s /home/yang/.autojump/etc/profile.d/autojump.sh ]] && source /home/yang/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk


# alias
alias ls='lsd'
alias ll='ls -alh'
alias l='ls -alh'
alias vs=code
alias vi=vim
alias tmux="TERM=screen-256color-bce tmux"
export PATH="$PATH:/root/.cargo/bin/"
export EDITOR="vim"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
