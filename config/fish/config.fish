if status is-interactive
    # Commands to run in interactive sessions can go here
end
# pnpm
set -gx PNPM_HOME "/home/reyalka/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# starship init fish | source
set -g fish_prompt_pwd_dir_length 10

# path
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin 
fish_add_path $HOME/.deno/bin
fish_add_path /usr/local/zig
fish_add_path $HOME/.local/bin

# global variables
set -Ux EDITOR /usr/local/bin/nvim
set -x GOPATH $HOME/.go

# brew settings
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

abbr cl "clear"
abbr t "touch"
abbr tr "tree"
abbr mr "mkdir"
abbr px "pnpm dlx"
abbr yx "yarn dlx"
abbr vrc "nvim $(status --current-file)"
abbr p "pkill"
abbr q "exit"
abbr nv "nvim"
abbr nvi "nvim"
abbr nivm "nvim"
abbr nvim-startuptime "vim-startuptime --vimpath nvim"
abbr mt "mate-terminal"
abbr lg "lazygit"

alias .. "__bd"
alias ll "eza -alT --icons -L 1"
alias dt "eza --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"

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

