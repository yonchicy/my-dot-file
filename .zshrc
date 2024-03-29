# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# ------------------------------------------------------------------
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='exa -algF'
alias la='exa -A'
alias l='exa -F'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


function jump-to-git-root {
  local _root_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [[ $? -gt 0 ]]; then
    >&2 echo 'Not a Git repo!'
    exit 1
  fi
  local _pwd=$(pwd)
  if [[ $_pwd = $_root_dir ]]; then

    # Handle submodules:
    # If parent dir is also managed under Git then we are in a submodule.
    # If so, cd to nearest Git parent project.
    _root_dir="$(git -C $(dirname $_pwd) rev-parse --show-toplevel 2>/dev/null)"
    if [[ $? -gt 0 ]]; then
      return 0

    fi
  fi

  # Make `cd -` work.
  OLDPWD=$_pwd
  cd $_root_dir
}

# Make short alias
alias gr=jump-to-git-root
function joshuto-a() { 
	ID="$$" 
	mkdir -p /tmp/$USER 
	OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID" 
	env joshuto --output-file "$OUTPUT_FILE" $@ 
	exit_code=$? 
 
	case "$exit_code" in 
		# regular exit 
		0) 
			;; 
		# output contains current directory 
		101) 
			JOSHUTO_CWD=$(cat "$OUTPUT_FILE") 
			cd "$JOSHUTO_CWD" 
			;; 
		# output selected files 
		102) 
			;; 
		*) 
			echo "Exit code: $exit_code" 
			;; 
	esac 
}


# -------------------------------------------------------------



source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
bindkey ',' autosuggest-accept
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
FZF_COMPLETION_TRIGGER=';'


export NVIM_APPNAME=lazyvim
alias ls=exa
alias ra='joshuto-a'
alias vs=code
alias vim=nvim
alias lm="NVIM_APPNAME=lazyvim nvim"
alias nv="NVIM_APPNAME=nvchad nvim"
alias make='make -j8'
alias lg=gitui
alias fd=fdfind
alias tmux="TERM=screen-256color-bce tmux"
alias zj="zellij"



export EDITOR="nvim"
[[ -s /home/yonchicy/.autojump/etc/profile.d/autojump.sh ]] && source /home/yonchicy/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
 
eval $(starship init zsh)
eval "$(zoxide init zsh)"



