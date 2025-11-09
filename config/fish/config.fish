if status is-interactive
    # Commands to run in interactive sessions can go here
end
function jump-to-git-root
    set _root_dir (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -gt 0
        echo 'Not a Git repo!' >&2
        return 1
    end

    set _pwd (pwd)
    if test $_pwd = $_root_dir
        # Handle submodules:
        # If parent dir is also managed under Git then we are in a submodule.
        # If so, cd to nearest Git parent project.
        set _root_dir (git -C (dirname $_pwd) rev-parse --show-toplevel 2>/dev/null)
        if test $status -gt 0
            return 0
        end
    end

    # Make `cd -` work.
    set OLDPWD $_pwd
    cd $_root_dir
end

# Make short alias
alias gr jump-to-git-root
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file=$tmp

    set cwd (cat $tmp)
    if test -n "$cwd" -a "$cwd" != (pwd)
        cd $cwd
    end

    rm -f $tmp
end

if test "$ALACRITTY" = "true"
    function theme
        ln -sf $HOME/.config/alacritty/themes/themes/{$argv[1]}.toml $HOME/.config/alacritty/active.toml
    end


    function toggle_theme
      set -l ALACRITTY_THEME (defaults read -g AppleInterfaceStyle 2>/dev/null; or echo "Light")
      if test "$ALACRITTY_THEME" = "Dark"
        theme "gruvbox_dark"
      else
        theme "gruvbox_material_hard_light"
      end
    end
end

alias ll 'eza -al'

alias la 'eza -A'
alias l eza 
alias ls eza 

alias ra 'yazi'
alias vs code
#alias vim="NVIM_APPNAME=pagernvim nvim"
alias nv "NVIM_APPNAME=nvchad nvim"
#alias lm="NVIM_APPNAME=lazyvim nvim"
alias make 'make -j8'
alias lg lazygit
alias p 'proxychains4 -q'
# alias tmux="TERM=screen-256color-bce tmux"
alias zj "zellij"


set -x COLORTERM truecolor
set -x EDITOR nvim

starship init fish | source
zoxide init fish | source

function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
bind -M insert ctrl-n down-or-search
end
if set -q ALACRITTY && test "$ALACRITTY" = true
    function theme
        ln -sf $HOME/.config/alacritty/themes/themes/$argv[1].toml $HOME/.config/alacritty/active.toml
    end

    # 获取 macOS 系统外观模式（Dark / Light）
    set alacritty_theme (defaults read -g AppleInterfaceStyle 2>/dev/null; or echo "Light")

    if test "$alacritty_theme" = Dark
        theme github_dark
    else
        theme github_light
    end
end
