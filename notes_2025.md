# bluetooth
```
sudo rmmod btusb
sudo modprobe btusb
sudo btmon
```

# system
- remove all shortcuts
- install gnome-tweaks
- change super key to backspace???
```
sudo apt install gnome-tweaks
```

# startup apps
- tilix

# xkeysnail
- system settings
  - autologin
```
sudo groupadd -f uinput
sudo gpasswd -a $USER uinput
echo "$USER ALL = (root) NOPASSWD: /usr/local/bin/xkeysnail" | sudo tee /etc/sudoers.d/xkeysnail
echo "xhost +SI:localuser:root" > ~/.xsessionrc

cat <<EOF | sudo tee /etc/udev/rules.d/70-xkeysnail.rules
KERNEL=="uinput", GROUP="uinput", MODE="0660", OPTIONS+="static_node=uinput"
KERNEL=="event[0-9]*", GROUP="uinput", MODE="0660"
EOF
```

- create bash script
```
xhost +SI:localuser:root
sudo xkeysnail /usr/local/sbin/xkeysnail_config.py -q
```

# tilix
- profile
- startup command: ``tmux``
- tmux new-session -s "tmp" /home/user/xkey.sh

# installing nvim
- download release
```
chmod +x neovim.appimage
sudo mv neovim.appimage /usr/local/bin/nvim
```

# nvim plugins
```
mkdir ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```

# rerun
```
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
rvm install 3.2.1 (might not need?)
sudo apt-get install ruby-dev 
gem install rerun
chown the path
```

# fzf
- download from releases
- cp to /usr/local/sbin or /bin

