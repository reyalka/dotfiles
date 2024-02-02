if status is-interactive
    # Commands to run in interactive sessions can go here
end
# pnpm
set -gx PNPM_HOME "/home/reyalka/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

starship init fish | source
set -g fish_prompt_pwd_dir_length 10
starship init fish | source

# path
set -x GOPATH $HOME/.go
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin 
fish_add_path $HOME/.deno/bin
fish_add_path /usr/local/zig

# global variables
set -Ux EDITOR /usr/local/bin/nvim

# brew settings
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set -x alias_path "$HOME/dotfiles/config/fish/conf.d/aliases.fish"

abbr cl "clear"
abbr t "touch"
abbr tr "tree"
abbr mr "mkdir"
abbr dt "eza --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"
abbr px "pnpm dlx"
abbr yx "yarn dlx"
abbr vrc "nvim $alias_path"
abbr p "pkill"
abbr sb "pkill brave"
abbr q "exit"
abbr nv "nvim"
abbr nvi "nvim"
abbr nvim-startuptime "vim-startuptime --vimpath nvim"
abbr gt "gnome-terminal"
abbr mt "mate-terminal"
abbr lg "lazygit"

alias .. "__bd"
alias ll "eza -alT --icons -L 1"

function rmcd
    set current (pwd)
    cd ../
    rm -rf $current
end

function clcd
    set current (pwd)
    cd ../
    rm -rf $current
    mkdir $current
    cd $current
end

function cr
    if test -d $argv
        echo "$argv has already created"
    else
        mkdir $argv -p
    end
    cd $argv
end

function bg
    $argv 1>/dev/null 2>&1 &
end

function __bd
    for i in (seq 1 $argv)
        cd ..
    end
end

