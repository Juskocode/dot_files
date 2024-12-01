#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Function to uninstall packages from Brewfile
uninstall_brew_packages() {
    if [ -f ~/dot_files/brew/Brewfile ]; then
        echo "Uninstalling Brew packages from Brewfile..."
        brew bundle --file=~/dot_files/brew/Brewfile --uninstall
        echo "Brew packages have been uninstalled."
    else
        echo "Brewfile not found. Skipping Brew package uninstallation."
    fi
}
# Function to remove Stow
uninstall_stow() {
    if command -v stow &> /dev/null; then
        echo "Removing Stow..."
        rm -rf "$HOME/.local/bin/stow" "$HOME/.local/share/stow" "$HOME/.local/share/doc/stow"  # Adjust based on Stow installation
        echo "Stow has been removed."
    else
        echo "Stow is not installed."
    fi
}

# Function to remove Oh My Zsh
uninstall_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Removing Oh My Zsh..."
        rm -rf "$HOME/.oh-my-zsh"
        echo "Oh My Zsh has been removed."
    else
        echo "Oh My Zsh is not installed."
    fi
}

# Function to remove Powerlevel10k theme
uninstall_powerlevel10k() {
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo "Removing Powerlevel10k theme..."
        rm -rf "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
        echo "Powerlevel10k theme has been removed."
    else
        echo "Powerlevel10k theme is not installed."
    fi
}

# Function to remove Neovim AppImage
uninstall_neovim_appimage() {
    APPIMAGE_DIR="$HOME/Applications"
    APPIMAGE_NAME="nvim.appimage"

    if [ -f "$APPIMAGE_DIR/$APPIMAGE_NAME" ]; then
        echo "Removing Neovim AppImage..."
        rm -f "$APPIMAGE_DIR/$APPIMAGE_NAME"
        echo "Neovim AppImage has been removed."
    else
        echo "Neovim AppImage is not installed."
    fi
}

# Function to remove symlinks created by Stow
remove_symlinks() {
    echo "Removing symlinks created by Stow..."
    stow --target="$HOME" -D nvim
    stow --target="$HOME" -D zsh
    stow --target="$HOME" -D tmux
    echo "Symlinks have been removed."
}

# Function to clean up .bashrc
cleanup_bashrc() {
    if [ -f "$HOME/.bashrc" ]; then
        echo "Cleaning up .bashrc..."
        sed -i '/export PATH="$HOME\/.local\/bin:$PATH"/d' "$HOME/.bashrc"
        echo "Cleanup complete. Please restart your terminal or run 'source ~/.bashrc'."
    fi
}

# Main script execution
remove_symlinks
uninstall_stow
uninstall_oh_my_zsh
uninstall_powerlevel10k
uninstall_neovim_appimage
cleanup_bashrc

echo "Uninstallation complete!"

