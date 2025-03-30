set shell := ["fish", "-c"]

[private]
@defualt: help

# show help
@help:
    echo "Usage: just [RECIPE]"
    echo ""
    just --list --unsorted

# format lua, fish, yaml files
format:
    stylua ./ -f ./stylua.toml
    fish_indent -w ./**/*.fish
    yamlfmt ./

alias fmt := format

# generate completions for fish shell
generate-completions:
    fish ./script/completions.fish
