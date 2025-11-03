#!/usr/bin/env bash

set -e

echo "Starting Doom Emacs + LaTeX setup..."

OS="$(uname)"
IS_MACOS=false
IS_LINUX=false

if [[ "$OS" == "Darwin" ]]; then
    IS_MACOS=true

elif [[ "$OS" == "Linux" ]]; then
    IS_LINUX=true

else
    echo "Unsupported OS: ${OS}. Only for Linux and MacOS "
    exit 1
fi

install_if_missing() {
    local cmd=$1
    local install_cmd=$2
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Installing $cmd..."
        eval "$install_cmd"
    else
        echo "$(${cmd}) already installed."
    fi
}

setup_latex() {
    echo "Setting up LaTeX..."

    if command -v latex >/dev/null 2>&1 && command -v dvipng >/dev/null 2>&1; then
        echo "LaTeX and dvipng already installed."
        return
    fi

    if $IS_MACOS; then
        install_if_missing "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        brew install --cask mactex
        export PATH="/Library/TeX/texbin:$PATH"
        if ! grep -q "/Library/TeX/texbin" ~/.zshrc 2>/dev/null; then
            echo 'export PATH="/Library/TeX/texbin:$PATH"' >>~/.zshrc
        fi
    elif $IS_LINUX; then
        sudo apt update
        sudo apt install -y texlive-latex-base dvipng
    fi

    echo "Installing dvipng via tlmgr (if needed)..."
    if command -v tlmgr >/dev/null 2>&1; then
        sudo tlmgr update --self
        sudo tlmgr install dvipng
    fi
}

setup_doom() {
    echo "Setting up Doom Emacs..."

    if $IS_MACOS; then
        install_if_missing "emacs" "brew install --cask emacs"
    elif $IS_LINUX; then
        sudo apt update
        sudo apt install -y emacs git
    fi

    if [ ! -d "$HOME/.emacs.d" ]; then
        git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
    fi

    # Setting up Doom using ~/.config/emacs as config dir
    "$HOME/.emacs.d/bin/doom" install
    "$HOME/.emacs.d/bin/doom" sync
    "$HOME/.emacs.d/bin/doom" doctor
}

# === Run all steps ===

setup_latex
setup_doom

echo "🎉 Done! Config loaded from ~/.config/emacs, and LaTeX is ready!"
