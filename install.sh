#!/bin/bash


# Global
HOME=$(pwd)

# Get Host Type
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}
if [ ${machine} == "Mac"];
    # Plugin Manager
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # BREW
    brew install neovim
    brew install python3
    pip install pynvim
    pip3 install pynvim
    npm install -g neovim

    # === RUST ===
    stable rust
    rustup
    cargo
    cargo-make
    # pier
    cargo install pier


    # fzf
    brew install fzf
    $(brew --prefix)/opt/fzf/install
    :

# TMUX


# VIM


