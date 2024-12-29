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

# global variables
set -Ux EDITOR /bin/nvim
set -Ux BUN_INSTALL "$HOME/.bun"
set -Ux GOPATH $HOME/.go
set -Ux AQUA_GLOBAL_CONFIG ~/.config/aqua/aqua.yaml
set -Ux GPG_TTY (tty)

# path
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.deno/bin
fish_add_path /usr/local/zig
fish_add_path $HOME/.local/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.moon/bin
fish_add_path (set -q AQUA_ROOT_DIR; and echo $AQUA_ROOT_DIR; or set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo $HOME/.local/share)/aquaproj-aqua/bin

# brew settings
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

abbr -a -- cl clear
abbr -a -- t touch
abbr -a -- tr tree
abbr -a -- mr mkdir
abbr -a -- px 'pnpm dlx'
abbr -a -- yx 'yarn dlx'
abbr -a -- vrc 'nvim /home/reyalka/.config/fish/config.fish'
abbr -a -- p pkill
abbr -a -- q exit
abbr -a -- nv nvim
abbr -a -- nvi nvim
abbr -a -- nivm nvim
abbr -a -- nvim-startuptime 'vim-startuptime --vimpath nvim'
abbr -a -- mt mate-terminal
abbr -a -- lg lazygit
abbr -a -- ss starship
abbr -a -- zl zellij

alias .. __bd
alias . dot
alias ll "eza -alT --icons -L 1"
alias dt "eza --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"

function ide
    set -l session_name (string split '/' (pwd))[-1]
    set -l sessions (string split '\n' (zellij list-sessions --short -no-formatting 2>/dev/null))
    zellij --layout ide --session $session_name 2>/dev/null \
        || zellij attach $session_name
end

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

function dot
    if test (count $argv) -eq 0
        eval (history | head -n 1 | string trim)
    else
        source $argv
    end
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
