cat ~/pier.toml > ./pier.toml
cat ~/.tmux.conf > ./.tmux.conf
cat ~/.vimrc > ./.vimrc
cat ~/.zshrc > ./.zshrc
cat ~/.config/nvim/coc-settings.json > ./coc-settings.json
git add .
git commit -m "Updated configuration"
git push
