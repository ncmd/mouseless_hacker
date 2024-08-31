#!/bin/bash

# https://colemak.com/Unix

# method1
setxkbmap us -variant colemak

#method2
wget https://colemak.com/pub/unix/colemak-1.0.tar.gz
tar -xzf colemak-1.0.tar.gz
cd colemak-1.0
setxkbmap us; xmodmap xmodmap/xmodmap.colemak && xset r 66
# switch back
# setxkbmap us; xset -r 66