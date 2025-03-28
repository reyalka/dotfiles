#!/usr/bin/env fish

function notify
    set -l mode $argv[1]
    set -l message $argv[2]
    switch $mode
        case succsess
            echo "$(set_color green --bold)✔︎ $(set_color normal)$message$(set_color normal)"
        case error
            echo "$(set_color red --bold)✖︎ $message$(set_color normal)"
        case info
            echo "$(set_color blue --bold) $(set_color normal)$message$(set_color normal)"
        case progress
            echo "$(set_color yellow --bold)󰊾 $message...$(set_color normal)"
    end
end

function exist
    set -l command $argv[1]
    if type $command >/dev/null
        return 0
    else
        notify info "$command is not installed. Skip it"
        return 1
    end
end

notify progress "Adding completions for zellij"
exist zellij && zellij setup --generate-completion fish >~/dotfiles/config/fish/completions/zellij.fish \
    && notify succsess "Completions for zellij added" \
    || notify error "Somthing went wrong while adding completions for zellij"

notify progress "Adding completions for eza"
exist eza && curl https://raw.githubusercontent.com/eza-community/eza/main/completions/fish/eza.fish >~/dotfiles/config/fish/completions/eza.fish \
    && notify succsess "Completions for eza added" \
    || notify error "Somthing went wrong while adding completions for eza"

notify progress "Adding completions for bun"
exist bun && curl https://raw.githubusercontent.com/oven-sh/bun/main/completions/bun.fish >~/dotfiles/config/fish/completions/bun.fish \
    && notify succsess "Completions for bun added" \
    || notify error "Somthing went wrong while adding completions for bun"

notify progress "Adding completions for brew"
exist brew && curl --silent https://raw.githubusercontent.com/Homebrew/brew/master/completions/fish/brew.fish >~/dotfiles/config/fish/completions/brew.fish \
    && notify succsess "Completions for brew added" \
    || notify error "Somthing went wrong while adding completions for brew"

notify progress "Adding completions for wezterm"
exist wezterm && wezterm shell-completion --shell fish >~/dotfiles/config/fish/completions/wezterm.fish \
    && notify succsess "Completions for wezterm added" \
    || notify error "Somthing went wrong while adding completions for wezterm"

notify progress "Adding completions for lefthook"
exist lefthook && lefthook completion fish >~/dotfiles/config/fish/completions/lefthook.fish \
    && notify succsess "Completions for lefthook added" \
    || notify error "Somthing went wrong while adding completions for lefthook"

notify progress "Adding completions for volta"
exist volta && volta completions fish >~/dotfiles/config/fish/completions/volta.fish \
    && notify succsess "Completions for volta added" \
    || notify error "Somthing went wrong while adding completions for volta"

notify progress "Adding completions for just"
exist just && just --completions fish >~/dotfiles/config/fish/completions/just.fish \
    && notify succsess "Completions for just added" \
    || notify error "Somthing went wrong while adding completions for just"
