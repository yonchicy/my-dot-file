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
#alias ll='exa -alFg'
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
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
FZF_COMPLETION_TRIGGER=';'


export COLORTERM=truecolor

export BAT_THEME=GitHub
alias logbat='bat --wrap=never -l log'
alias ls=exa
alias ra='joshuto-a'
alias vs=code
#alias vim="NVIM_APPNAME=pagernvim nvim"
#alias nv="NVIM_APPNAME=nvchad nvim"
#alias lm="NVIM_APPNAME=lazyvim nvim"
alias make='make -j8'
alias lg=gitui
alias fd=fdfind
alias p='proxychains4 -q'
# alias tmux="TERM=screen-256color-bce tmux"
alias zj="zellij"



export EDITOR="nvim"
[[ -s /home/yonchicy/.autojump/etc/profile.d/autojump.sh ]] && source /home/yonchicy/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
#setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
#setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
#setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
 
eval $(starship init zsh)
eval "$(zoxide init zsh)"

