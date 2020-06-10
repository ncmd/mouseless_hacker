# pier
cat ~/pier.toml > ./pier.toml
# espanso
cp -r ~/Library/Preferences/espanso ./espanso
# tmux
cat ~/.tmux.conf > ./.tmux.conf
cat ~/.tmux.conf.local > ./.tmux.conf.local
# neovim
cat ~/.vimrc > ./.vimrc
# zsh
cat ~/.zshrc > ./.zshrc
# iterm2
cat ~/go/src/iterm/com.googlecode.iterm2.plist > ./iterm2.plist
# alacritty (Only if iterm2 not avaliable)
cat ~/.config/alacritty/alacritty.yml > ./alacritty.yml
# vim coc
cat ~/.config/nvim/coc-settings.json > ./coc-settings.json
# karabiner
cat ~/.config/karabiner/assets/complex_modifications/1585362245.json > karabiner_complex_modifications.json
# amethyst
cat ~/Library/Preferences/com.amethyst.Amethyst.plist > com.amethyst.Amethyst.plist
# Mac keyboard
cat ~/Library/Preferences/.GlobalPreferences.plist > ./.GlobalPreferences.plist
# chrome vimium
cat ~/vimium-options.json > ./vimium-options.json
# lulu
cat ~/lulu_rules.plist > ./lulu_rules.plist
git add .
git commit -m "Updated configuration"
git push
