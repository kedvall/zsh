# Backup current ZSH/OMZ files
cp "$HOME/.zshrc" "$HOME/.zshrc.pre-symlink"
cp "$ZSH/custom/custom.zsh" "$ZSH/custom/.custom.zsh.pre-symlink"

# Remove the old files
rm "$HOME/.zshrc"
rm "$ZSH/custom/custom.zsh"

# Create symlinks to version controlled files
ln -s "$HOME/.zsh_config/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.zsh_config/custom.zsh" "$ZSH/custom/custom.zsh"
