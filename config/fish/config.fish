fish_add_path $HOME/.local/share/aquaproj-aqua/bin
fish_add_path $HOME/.nix-profile/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.deno/bin
fish_add_path /usr/local/zig
fish_add_path $HOME/.local/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.moon/bin
fish_add_path $VOLTA_HOME/bin

# brew
if grep -q Ubuntu /etc/os-release
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

# pnpm
set -gx PNPM_HOME "/home/reyalka/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -g fish_prompt_pwd_dir_length 10

# global variables
set -Ux EDITOR (which nvim)
set -Ux BUN_INSTALL "$HOME/.bun"
set -Ux GOPATH $HOME/.go
set -Ux AQUA_GLOBAL_CONFIG ~/.config/aqua/aqua.yaml
set -Ux VOLTA_HOME "$HOME/.volta"
export GPG_TTY=$(tty)

# path
# starship setting
starship init fish | source

# abbr
abbr -a -- cl clear
abbr -a -- fcp fish_clipboard_copy
abbr -a -- fpt fish_clipboard_paste
abbr -a -- g git
abbr -a -- lg lazygit
abbr -a -- mr mkdir
abbr -a -- mt mate-terminal
abbr -a -- pid "pnpm i --save-exact --save-dev"
abbr -a -- n nvim
abbr -a -- nv nvim
abbr -a -- nvi nvim
abbr -a -- nivm nvim
abbr -a -- nvim-startuptime "vim-startuptime --vimpath nvim"
abbr -a -- p pnpm
abbr -a -- px "pnpm dlx"
abbr -a -- q exit
abbr -a -- ss starship
abbr -a -- t touch
abbr -a -- tr tree
abbr -a -- vrc "nvim /home/reyalka/.config/fish/config.fish"
abbr -a -- yx "yarn dlx"
abbr -a -- zl zellij
# aqua generate --interactive --global
abbr -a -- aqg "aqua g -i -g"
# aqua init --all --link
abbr -a -- aqi "aqua i -a -l"

# alias
alias .. __bd
alias . dot
alias ll "eza -alT --icons -L 1"
alias dt "eza --icons -Ta -I 'node_modules|dist|.git|.next|.obsidian'"
alias proot='cd $(git rev-parse --show-toplevel)'

# functions
function ide
    set -l session_name (string split "/" (pwd))[-1]
    set -l sessions (string split "\n" (zellij list-sessions --short --no-formatting 2>/dev/null))

    switch $argv[1]
        case mini
            set -l mini_session_name "$session_name-mini"
            if contains $mini_session_name $sessions
                zellij attach $mini_session_name
            else
                zellij --new-session-with-layout mini --session $mini_session_name
            end

        case "*"
            if contains $session_name $sessions
                zellij attach $session_name
            else
                zellij --new-session-with-layout ide --session $session_name
            end

    end
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

function toHex
    echo (math --base 16 $argv[1] | string sub -s 3)
end

# do nothin when command not found
function fish_command_not_found
    echo "Command not found: $argv[1]"
end

function note
    $argv && curl -d "Command completed: \"$argv\"" "https://ntfy.sh/$NTFY_COMPLETED"
end


# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
