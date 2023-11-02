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
if [ ${machine} == "Mac" ]; then
    # === XCODE === 
    xcode-select --install

    # === HOMEBREW ===
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    sudo chown $(whoami) /usr/local/Homebrew
    sudo chown $(whoami) /usr/local/Cellar
    sudo chown $(whoami) /usr/local/Caskroom
    sudo chown $(whoami) /usr/local/share/
    sudo chown $(whoami) /usr/local/share/*
    sudo chown $(whoami) /usr/local/lib
    sudo chown $(whoami) /usr/local/lib/*
    sudo chmod -R g+rwx /usr/local/*
    brew install cmake
    brew upgrade cmake
    brew reinstall cmake

    # === KARABINER ===
    # non-us backslash = backslash
    # right_command = right control
    brew cask install karabiner-elements
    brew cask reinstall karabiner-elements
    mkdir -p ~/.config/karabiner/assets/complex_modifications/
    cp ./karabiner_complex_modifications_kinesis_mac.json ~/.config/karabiner/assets/complex_modifications/mods.json

    # === NEOVIM ===
    # VIM Plugin Manager
    brew install neovim
    brew unlink neovim
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    brew reinstall neovim
    brew install python3
    brew reinstall python3
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code
    brew cask reinstall font-fira-code
    mkdir -p ~/.config/nvim/
    cp ./.vimrc ~/.config/nvim/init.vim
    cp ./coc-settings.json ~/.config/nvim/coc-settings.json
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    sudo -H pip install --user pynvim
    sudo -H pip3 install --user pynvim
    npm install -g neovim
    nvim -E -c ":PlugInstall" -c qa!
    nvim -E -c ":source ~/.vimrc" -c qa!

    # === FZF ===
    brew install fzf
    brew reinstall fzf
    $(brew --prefix)/opt/fzf/install

    # === TMUX ===
    brew install tmux
    brew reinstall tmux
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp ./.tmux.conf ~/.tmux.conf
    cp ./.tmux.conf.local ~/.tmux.conf.local
    tmux source-file ~/.tmux.conf

    # === ITERM2 ===
    brew cask install iterm2
    brew cask reinstall iterm2
    mkdir -p ~/iterm2
    cp ./iterm2.plist ~/iterm2/iterm2.plist

    # === AMETHYST ===
    brew cask install amethyst
    brew cask reinstall amethyst
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
    # gestures
    cp ./.GlobalPreferences.plist ~/Library/Preferences/.GlobalPreferences.plist

    # === BROWSER ===
    # Extensions: GoogleAdOptOut,DarkReader,Vimium,UblockOrigin
fi
