set -x alias_path "$HOME/dotfiles/config/fish/conf.d/aliases.fish"

abbr pip "python3 -m pip"
abbr cl "clear"
abbr py "python3"
abbr obs "obsidian"
abbr bb "brave-browser"
abbr t "touch"
abbr tr "tree"
abbr mr "mkdir"
abbr dt "eza --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"
abbr px "pnpm dlx"
abbr yx "yarn dlx"
abbr crc "sudo cat $alias_path"
abbr rfrc "source ~/.bashrc"
abbr brc "bat $alias_path"
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

alias .. "_bd"
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

function search
    find $alias_path -type f -print | GREP_COLOR="1;34" xargs grep "^alias $argv" --color=auto
end

function _bd
    for i in (seq 1 $argv)
        cd ..
    end
end

