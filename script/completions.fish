#!/usr/bin/env fish

function notify
    set -l mode $argv[1]
    set -l message $argv[2]
    switch $mode
        case succsess
            echo (set_color green --bold)"✔︎ "(set_color normal)$message(set_color normal)
        case error
            echo (set_color red --bold)"✖︎ "$message(set_color normal)
        case info
            echo (set_color blue --bold)" "(set_color normal)$message(set_color normal)
        case progress
            echo (set_color yellow --bold)"󰊾 "$message"... "(set_color normal)
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

function add_completion
    set -l name $argv[1]
    set -l command $argv[2]
    set -l output_file ~/dotfiles/config/fish/completions/$name.fish

    notify progress "Adding completions for $name"

    if exist $name
        eval $command >$output_file
        if test $status -eq 0
            notify succsess "Completions for $name added"
        else
            notify error "Something went wrong while adding completions for $name"
        end
    end
end

add_completion zellij "zellij setup --generate-completion fish"
add_completion eza "curl -s https://raw.githubusercontent.com/eza-community/eza/main/completions/fish/eza.fish"
add_completion bun "curl -s https://raw.githubusercontent.com/oven-sh/bun/main/completions/bun.fish"
add_completion brew "curl -s https://raw.githubusercontent.com/Homebrew/brew/master/completions/fish/brew.fish"
add_completion wezterm "wezterm shell-completion --shell fish"
add_completion lefthook "lefthook completion fish"
add_completion volta "volta completions fish"
add_completion just "just --completions fish"
