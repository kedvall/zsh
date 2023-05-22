# Backup current ZSH/OMZ files if they are not already symlinks
if ! [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.pre-symlink" || true
fi
if ! [ -f "$ZSH/custom/custom.zsh" ]; then
    cp "$ZSH/custom/custom.zsh" "$ZSH/custom/.custom.zsh.pre-symlink" || true
fi
if ! [ -f "$HOME/.direnvrc" ]; then
    cp "$HOME/.direnvrc" "$HOME/.direnvrc.pre-symlink" || true
fi

# Remove the old files
rm "$HOME/.zshrc"
rm "$ZSH/custom/custom.zsh"
rm "$HOME/.direnvrc"

# Create symlinks to version controlled files
ln -s "$HOME/.zsh_config/zshrc" "$HOME/.zshrc"
ln -s "$HOME/.zsh_config/custom.zsh" "$ZSH/custom/custom.zsh"
ln -s "$HOME/.zsh_config/direnvrc" "$HOME/.direnvrc"
