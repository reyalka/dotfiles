#!/bin/bash

backup_dir="$HOME/.config_backup"

directories=("$HOME/dotfiles/config"/*)

if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

for dir in "${directories[@]}"; do
  dir_name=$(basename "$dir")

  if [ -e "$dir" ]; then
    if [ -e "$backup_dir/$dir_name" ]; then
      echo "$backup_dir/$dir_name already exists."
      read -r -p "Remove $backup_dir/$dir_name? [y/N] " response

      if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        rm -rf "$backup_dir/$dir_name"
      else
        echo "Skip $dir_name"
        continue
      fi
    fi

    cp -r "$dir" "$backup_dir/$dir_name"
  fi

  ln -s "$dir" "$HOME/.config/$dir_name"
done

if [ ! command -v fisher ] &>/dev/null; then
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | bash && fisher install jorgebucaran/fisher
fi
fish -c "fish update"
