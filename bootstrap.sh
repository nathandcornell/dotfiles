#!/bin/bash
#
# Bootstrap script for Nate's dotfiles
# Usage: curl -fsSL https://raw.githubusercontent.com/nathandcornell/dotfiles/master/bootstrap.sh | bash
#
# This script installs Homebrew, Git, and then clones and sets up the dotfiles repository.
# It's designed to be run on a fresh macOS installation with no prerequisites.

set -euo pipefail

# Configuration
DOTFILES_REPO="https://github.com/nathandcornell/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# Output helpers
info() {
    printf "${BLUE}info${RESET}: %s\n" "$@"
}

success() {
    printf "${GREEN}success${RESET}: %s\n" "$@"
}

warn() {
    printf "${YELLOW}warning${RESET}: %s\n" "$@"
}

error() {
    printf "${RED}error${RESET}: %s\n" "$@" >&2
    exit 1
}

# Detect OS and architecture
detect_platform() {
    local os arch

    os="$(uname -s)"
    arch="$(uname -m)"

    if [[ "$os" != "Darwin" ]]; then
        error "This script only supports macOS. Detected: $os"
    fi

    case "$arch" in
        arm64)
            HOMEBREW_PREFIX="/opt/homebrew"
            ;;
        x86_64)
            HOMEBREW_PREFIX="/usr/local"
            ;;
        *)
            error "Unsupported architecture: $arch"
            ;;
    esac

    info "Detected macOS on $arch architecture"
    info "Homebrew prefix: $HOMEBREW_PREFIX"
}

# Install Xcode Command Line Tools if needed
install_xcode_clt() {
    if xcode-select -p &>/dev/null; then
        info "Xcode Command Line Tools already installed"
        return
    fi

    info "Installing Xcode Command Line Tools..."

    # Create a temporary file that triggers the CLT installer
    local placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    touch "$placeholder"

    # Find the latest CLT package
    local clt_package
    clt_package=$(softwareupdate -l 2>/dev/null | \
        grep -B 1 "Command Line Tools" | \
        grep -o "Label: .*" | \
        sed 's/Label: //' | \
        head -1)

    if [[ -n "$clt_package" ]]; then
        softwareupdate -i "$clt_package" --verbose
    else
        # Fall back to interactive installation
        warn "Could not find CLT package via softwareupdate"
        info "Opening interactive Xcode CLT installer..."
        xcode-select --install

        echo ""
        printf "${YELLOW}Please complete the Xcode Command Line Tools installation in the popup window.${RESET}\n"
        printf "Press ${BOLD}ENTER${RESET} when the installation is complete..."
        read -r
    fi

    rm -f "$placeholder"

    if ! xcode-select -p &>/dev/null; then
        error "Xcode Command Line Tools installation failed"
    fi

    success "Xcode Command Line Tools installed"
}

# Install Homebrew if needed
install_homebrew() {
    if command -v brew &>/dev/null; then
        info "Homebrew already installed"
        return
    fi

    info "Installing Homebrew..."

    # Download and run the Homebrew installer
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"

    if ! command -v brew &>/dev/null; then
        error "Homebrew installation failed"
    fi

    success "Homebrew installed"
}

# Initialize Homebrew environment for current session
init_homebrew_env() {
    if [[ -x "$HOMEBREW_PREFIX/bin/brew" ]]; then
        eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
    fi
}

# Install Git via Homebrew if needed
install_git() {
    if command -v git &>/dev/null; then
        info "Git already installed: $(git --version)"
        return
    fi

    info "Installing Git via Homebrew..."
    brew install git

    if ! command -v git &>/dev/null; then
        error "Git installation failed"
    fi

    success "Git installed: $(git --version)"
}

# Clone the dotfiles repository
clone_dotfiles() {
    if [[ -d "$DOTFILES_DIR" ]]; then
        if [[ -d "$DOTFILES_DIR/.git" ]]; then
            info "Dotfiles already cloned at $DOTFILES_DIR"
            info "Pulling latest changes..."
            git -C "$DOTFILES_DIR" pull --ff-only || warn "Could not pull latest changes"
            return
        else
            error "$DOTFILES_DIR exists but is not a git repository"
        fi
    fi

    info "Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

    success "Dotfiles cloned to $DOTFILES_DIR"
}

# Initialize git submodules
init_submodules() {
    info "Initializing git submodules..."
    git -C "$DOTFILES_DIR" submodule update --init --recursive

    success "Submodules initialized"
}

# Run the dependencies script
run_dependencies() {
    local deps_script="$DOTFILES_DIR/dependencies.sh"

    if [[ ! -f "$deps_script" ]]; then
        error "Dependencies script not found: $deps_script"
    fi

    info "Running dependencies.sh..."
    chmod +x "$deps_script"
    "$deps_script"

    success "Dependencies installed"
}

# Run the setup script
run_setup() {
    local setup_script="$DOTFILES_DIR/setup.sh"

    if [[ ! -f "$setup_script" ]]; then
        error "Setup script not found: $setup_script"
    fi

    info "Running setup.sh..."
    chmod +x "$setup_script"
    "$setup_script"

    success "Setup complete"
}

# Print final instructions
print_completion() {
    echo ""
    printf "${GREEN}${BOLD}Dotfiles installation complete!${RESET}\n"
    echo ""
    echo "Next steps:"
    echo "  1. Create ~/.gitconfig-user.inc from the example:"
    echo "     cp $DOTFILES_DIR/gitconfig-user.inc.example ~/.gitconfig-user.inc"
    echo "     Then edit it with your name and email."
    echo ""
    echo "  2. Restart your terminal or run:"
    echo "     source ~/.zshrc"
    echo ""
    echo "  3. (Optional) Install additional packages from brew-packages.local:"
    echo "     xargs brew install < $DOTFILES_DIR/brew-packages.local"
    echo ""
}

# Main installation flow
main() {
    echo ""
    printf "${BOLD}Nate's Dotfiles Bootstrap${RESET}\n"
    echo "========================="
    echo ""

    # Pre-flight checks
    detect_platform

    # Installation steps
    install_xcode_clt
    install_homebrew
    init_homebrew_env
    install_git
    clone_dotfiles
    init_submodules
    run_dependencies
    run_setup

    print_completion
}

main "$@"
