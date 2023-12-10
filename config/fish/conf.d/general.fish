set -g fish_prompt_pwd_dir_length 10
starship init fish | source

# path
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/go/bin 
fish_add_path $HOME/.deno/bin
