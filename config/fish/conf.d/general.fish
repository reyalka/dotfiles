set -g fish_prompt_pwd_dir_length 10
starship init fish | source

# path
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/go/bin 
fish_add_path $HOME/.deno/bin
fish_add_path /usr/local/zig
set -x GOPATH $HOME/go

# global variables
set -Ux EDITOR /usr/local/bin/nvim

# brew settings
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

