#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Check for necessary commands
for cmd in curl git make; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd is not installed. Please install it before running this script."
        exit 1
    fi
done

# Backup existing .zshrc
backup_existing_zshrc() {
    if [ -f "$HOME/.zshrc" ]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
        echo "Existing .zshrc backed up to .zshrc.backup"
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh is already installed!"
    fi
}

# Function to remove existing Zsh configuration
remove_existing_zshrc() {
    rm -f ~/.zshrc
}

# Function to install Powerlevel10k theme
install_powerlevel10k() {
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    else
        echo "Powerlevel10k is already installed!"
    fi
}

# Function to install Stow from source
install_stow() {
    if ! command -v stow &> /dev/null; then
        echo "Installing Stow from source..."

        # Download Stow
        curl -O https://mirror.leitecastro.com/gnu/stow/stow-latest.tar.gz
        tar -xzf stow-latest.tar.gz

        # Extract the directory name from the tarball
        STOW_DIR=$(basename stow-* | head -n 1)

        # Navigate into the extracted directory, exit if it fails
        cd "$STOW_DIR" || exit 1

        # Check for missing Perl modules
        if ! perl -MTest::Output -e '1'; then
            echo "Warning: Test::Output module is missing. You can install it with cpan Test::Output."
        fi

        ./configure --prefix="$HOME/.local"  # Install to local directory
        make
        make install  # No sudo needed here
        cd .. || exit 1  # Go back to the previous directory
        rm -rf "$STOW_DIR" stow-latest.tar.gz  # Clean up downloaded files

        # Add local bin to PATH if not already done
        if ! grep -q "$HOME/.local/bin" "$HOME/.bashrc"; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            echo "Added $HOME/.local/bin to PATH in .bashrc. Please restart your terminal or run 'source ~/.bashrc'."
        fi
    else
        echo "Stow is already installed!"
    fi
    source ~/.bashrc
}

# Function to symlink dotfiles using Stow
symlink_dotfiles() {
    echo "Symlinking dotfiles with stow..."
    stow --target="$HOME" nvim
    stow --target="$HOME" zsh
    stow --target="$HOME" tmux
    echo "Dotfiles installation complete!"
}

# Function to install packages from Brewfile
install_brew_packages() {
    brew bundle --file=~/dot_files/brew/Brewfile
}

# Function to install Neovim AppImage
install_neovim_appimage() {
    APPIMAGE_DIR="$HOME/Applications"
    APPIMAGE_NAME="nvim.appimage"
    APPIMAGE_RENAMED="nvim"
    APPIMAGE_URL="https://github.com/neovim/neovim/releases/latest/download/$APPIMAGE_NAME"

    # Create Applications directory if it doesn't exist
    mkdir -p "$APPIMAGE_DIR"

    # Download Neovim AppImage if it doesn't exist
    if [ ! -f "$APPIMAGE_DIR/$APPIMAGE_RENAMED" ]; then
        echo "Downloading Neovim AppImage to $APPIMAGE_DIR..."
        curl -L -o "$APPIMAGE_DIR/$APPIMAGE_NAME" "$APPIMAGE_URL"
        chmod +x "$APPIMAGE_DIR/$APPIMAGE_NAME"  # Make it executable
        mv "$APPIMAGE_DIR/$APPIMAGE_NAME" "$APPIMAGE_DIR/$APPIMAGE_RENAMED"  # Rename to 'nvim'
        echo "Neovim AppImage has been renamed to 'nvim'."
    else
        echo "Neovim AppImage is already installed!"
    fi
}


# Function to reload Tmux environment to install plugins
reload_tmux_plugins() {
    if command -v tmux &> /dev/null && [ -n "$TMUX" ]; then
        echo "Installing tmux plugins..."
        ~/.tmux/plugins/tpm/bin/install_plugins
        tmux source-file ~/.tmux.conf
    fi
}

# Main script execution
install_oh_my_zsh
remove_existing_zshrc
install_powerlevel10k
install_stow
symlink_dotfiles
install_brew_packages
install_neovim_appimage  # Install Neovim AppImage
reload_tmux_plugins

echo "Setup complete!"

