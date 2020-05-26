#!/bin/bash

# Get Host Type
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}
if [ ${machine} == "Mac"];
    # BREW
    brew install neovim
    :

# TMUX


# VIM


