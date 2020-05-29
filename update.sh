cat ~/pier.toml > ./pier.toml
cat ~/.tmux.conf > ./.tmux.conf
cat ~/.tmux.conf.local > ./.tmux.conf.local
cat ~/.vimrc > ./.vimrc
cat ~/.zshrc > ./.zshrc
cat ~/.config/nvim/coc-settings.json > ./coc-settings.json
cat ~/.config/karabiner/assets/complex_modifications/1585362245.json > karabiner_complex_modifications.json
git add .
git commit -m "Updated configuration"
git push
