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
if [ ${machine} == "Mac"]; then
    # === HOMEBREW ===
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # === KARABINER ===
    # non-us backslash = backslash
    # right_command = right control
    brew install karabiner-elements
    cp ./karabiner_complex_modifications_kinesis.json ~/.config/karabiner/assets/complex_modifications/mods.json

    # === NEOVIM ===
    # VIM Plugin Manager
    brew install neovim
    brew install python3
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code
    cp ./.vimrc ~/.config/nvim/init.vim
    cp ./coc-settings.json ~/.config/nvim/coc-settings.json
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    pip install pynvim
    pip3 install pynvim
    npm install -g neovim
    nvim -c ":PlugInstall"
    nvim -c ":source ~/.vimrc"

    # === RUST ===
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup component add rls rust-analysis rust-src
    rustup toolchain add nightly
    rustup toolchain add stable
    cargo install --force cargo-make
    cargo install pier
    brew tap federico-terzi/espanso
    brew install espanso
    cp -r ./espanso ~/Library/Preferences/espanso

    # === FZF ===
    brew install fzf
    $(brew --prefix)/opt/fzf/install

    # === TMUX ===
    brew install tmux
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp ./.tmux.conf ~/.tmux.conf
    cp ./.tmux.conf.local ~/.tmux.conf.local
    tmux source-file ~/.tmux.conf

    # === ITERM2 ===
    brew install iterm2
    mkdir ~/iterm2
    cp ./iterm2.plist ~/iterm2/iterm2.plist

    # === AMETHYST ===
    brew install amethyst
    cp ./com.amethyst.Amethyst.plist ~/Library/Preferences/com.amethyst.Amethyst.plist

    # === ZSH ===
    cp ./.zshrc ~/.zshrc
    source ~/.zshrc

    # === MAC KEYBOARD/MOUSE ===
    # swap esc with capslock
    # swap mission control
    # swap spotlight
    # create application shortcuts
    # key repeat set to max
    # mouse sensitivity
    cp ./.GlobalPreferences.plist ~/Library/Preferences/.GlobalPreferences.plist

fi
