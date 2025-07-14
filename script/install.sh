#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Install fonts
install_fonts() {
    local os=$(detect_os)
    log_info "Installing Nerd Fonts..."
    
    case $os in
        "macos")
            if command -v brew >/dev/null 2>&1; then
                log_info "Using Homebrew to install fonts on macOS..."
                brew tap homebrew/cask-fonts 2>/dev/null || true
                brew install --cask font-jetbrains-mono-nerd-font font-fira-code-nerd-font
                log_success "Fonts installed via Homebrew"
            else
                log_warning "Homebrew not found. Please install Homebrew first or install fonts manually."
                log_info "Visit: https://www.nerdfonts.com/font-downloads"
            fi
            ;;
        "linux")
            log_info "Installing fonts on Linux..."
            
            # Create fonts directory
            fonts_dir="$HOME/.local/share/fonts"
            mkdir -p "$fonts_dir"
            
            # Download and install JetBrains Mono Nerd Font
            if ! fc-list | grep -i "jetbrains.*mono.*nerd" >/dev/null; then
                log_info "Downloading JetBrains Mono Nerd Font..."
                curl -fLo "$fonts_dir/JetBrainsMono.zip" \
                    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
                
                if [ -f "$fonts_dir/JetBrainsMono.zip" ]; then
                    cd "$fonts_dir"
                    unzip -o JetBrainsMono.zip
                    rm JetBrainsMono.zip
                    log_success "JetBrains Mono Nerd Font installed"
                else
                    log_error "Failed to download JetBrains Mono Nerd Font"
                fi
            else
                log_info "JetBrains Mono Nerd Font already installed"
            fi
            
            # Download and install FiraCode Nerd Font
            if ! fc-list | grep -i "fira.*code.*nerd" >/dev/null; then
                log_info "Downloading FiraCode Nerd Font..."
                curl -fLo "$fonts_dir/FiraCode.zip" \
                    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
                
                if [ -f "$fonts_dir/FiraCode.zip" ]; then
                    cd "$fonts_dir"
                    unzip -o FiraCode.zip
                    rm FiraCode.zip
                    log_success "FiraCode Nerd Font installed"
                else
                    log_error "Failed to download FiraCode Nerd Font"
                fi
            else
                log_info "FiraCode Nerd Font already installed"
            fi
            
            # Refresh font cache
            if command -v fc-cache >/dev/null 2>&1; then
                log_info "Refreshing font cache..."
                fc-cache -fv "$fonts_dir" >/dev/null 2>&1
                log_success "Font cache refreshed"
            fi
            ;;
        *)
            log_warning "Unsupported OS. Please install Nerd Fonts manually:"
            log_info "Visit: https://www.nerdfonts.com/font-downloads"
            log_info "Recommended: JetBrains Mono Nerd Font, FiraCode Nerd Font"
            ;;
    esac
}

# Main installation
main() {
    log_info "Starting dotfiles installation..."
    
    # Install fonts first
    install_fonts
    
    # Clone repo if it doesn't exist
    if [ ! -d ~/dotfiles ]; then
        log_info "Cloning dotfiles repository..."
        git clone https://github.com/reyalka/dotfiles.git ~/dotfiles/
        log_success "Repository cloned"
    else
        log_info "Dotfiles directory already exists, skipping clone"
    fi
    
    # Create config directories
    mkdir -p ~/.config
    
    # Create symlinks
    log_info "Creating configuration symlinks..."
    ln -svf ~/dotfiles/stylua.toml ~/.config/
    ln -svf ~/dotfiles/config/nvim ~/.config/
    ln -svf ~/dotfiles/config/fish ~/.config/
    ln -svf ~/dotfiles/config/wezterm/ ~/.config/
    ln -svf ~/dotfiles/config/aqua/ ~/.config/
    ln -svf ~/dotfiles/config/zellij/ ~/.config/
    ln -svf ~/dotfiles/config/lazygit/ ~/.config/
    ln -svf ~/dotfiles/config/starship.toml ~/.config/
    ln -svf ~/dotfiles/config/.zshrc ~/
    
    log_success "Dotfiles installation completed!"
    log_info "You may need to restart your terminal or reload your shell configuration."
}

# Run main function
main "$@"

