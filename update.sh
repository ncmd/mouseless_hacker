cat ~/pier.toml > ./pier.toml
cat ~/.tmux.conf > ./.tmux.conf
cat ~/.tmux.conf.local > ./.tmux.conf.local
cat ~/.vimrc > ./.vimrc
cat ~/.zshrc > ./.zshrc
cat ~/go/src/iterm/com.googlecode.iterm2.plist > ./iterm2.plist
cat ~/.config/alacritty/alacritty.yml > ./alacritty.yml
cat ~/.config/nvim/coc-settings.json > ./coc-settings.json
cat ~/.config/karabiner/assets/complex_modifications/1585362245.json > karabiner_complex_modifications.json
cat ~/Library/Preferences/com.amethyst.Amethyst.plist > com.amethyst.Amethyst.plist
cat ~/Library/Preferences/.GlobalPreferences.plist > ./.GlobalPreferences.plist
git add .
git commit -m "Updated configuration"
git push
