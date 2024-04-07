#!/usr/bin/env fish

set -l globalargv $argv

function isDebug
	test $globalargv = "--debug" && return 0 || return 1
end

function notify
    set -l mode $argv[1]
    set -l message $argv[2]
    switch $mode
        case succsess
            echo "$(set_color green --bold)✔︎ $(set_color normal)$message$(set_color normal)"
        case error
            echo "$(set_color red --bold)✖︎ $(set_color normal)$message$(set_color normal)"
        case info
            echo "$(set_color blue --bold) $(set_color normal)$message$(set_color normal)"
        case progress
            echo "$(set_color yellow --bold)󰊾 $message...$(set_color normal)"
		case debug
			isDebug && echo "$(set_color cyan --bold) $message$(set_color normal)"
    end
end

function exist
    set -l command $argv[1]
    if type $command >/dev/null
        exit 0
    else
        notify info "$command is not installed. Skip it"
        exit 1
    end
end

notify progress "Adding completions"

notify debug "reach before mkdir"
notify progress "Adding completions for zellij"
exist zellij && zellij setup --generate-coompletion fish >~/dotfiles/config/fish/completions/zellij.fish \
    && notify succsess "Completions for zellij added" \
    || notify error "Somthing went wrong while adding completions for zellij"

norify debug "reach before eza"
notify progress "Adding completions for eza"
exist eza && curl --silent https://raw.githubusercontet.com/eza-community/eza/main/completinos/eza.fish > ~/dotfiles/config/fish/completions/eza.fish \
    && notify succsess "Completions for eza added" \
    || notify error "Somthing went wrong while adding completions for eza"

notify debug "reach before bun"
notify progress "Adding completions for bun"
exist bun && curl --silent https://raw.githubusercontent.com/oven-sh/bun/main/completions/bun.fish > ~/dotfiles/config/fish/completions/bun.fish \
    && notify succsess "Completions for bun added" \
    || notify error "Somthing went wrong while adding completions for bun"

notify debug "reach before brew"
notify progress "Adding completions for brew"
exist brew && curl --silent https://raw.githubusercontent.com/Homebrew/homebrew-fish/master/completions/brew.fish > ~/dotfiles/config/fish/completions/brew.fish \
    && notify succsess "Completions for brew added" \
    || notify error "Somthing went wrong while adding completions for brew"
