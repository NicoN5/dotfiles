#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES/wezterm" "$HOME/.config/wezterm"
ln -sfn "$DOTFILES/borders" "$HOME/.config/borders"
ln -sfn "$DOTFILES/aerospace" "$HOME/.config/aerospace"
ln -sfn "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES/.nbrc" "$HOME/.nbrc"
ln -sfn "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
