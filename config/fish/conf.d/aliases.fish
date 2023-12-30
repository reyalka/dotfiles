set -x alias_path "$HOME/.config/fish/conf.d/aliases.fish"
abbr pip "python3 -m pip"
abbr src "source"
abbr cl "clear"
abbr py "python3"
abbr obs "obsidian"
abbr tg "jest-test-gen"
abbr bb "brave-browser"
abbr t "touch"
abbr tr "tree"
abbr mr "mkdir"
abbr apps "cd ~/apps/"
abbr dt "exa --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"
abbr nd "npm run dev"
abbr pd "pnpm run dev"
abbr px "pnpm dlx"
abbr yd "yarn dev"
abbr ns "npm start"
abbr bd "bun dev"
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
abbr nvimtutor "nvim /tmp/vimtutor.txt"
abbr lg "lazygit"

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
        mkdir $argv
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

alias .. "_bd"

