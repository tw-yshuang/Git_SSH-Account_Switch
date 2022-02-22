#!/usr/bin/env bash

case $SHELL in
    *zsh )
    profile=~/.zshrc
    logout_profile=~/.zlogout
    ;;
    *bash )
    profile=~/.bashrc
    logout_profile=~/.bash_logout
    ;;
    * )
    Echo_Color r "Unknown shell, need to manually add pyenv config on your shell profile!!"
    ;;
esac

cp ./git-acc.sh ~/.git-acc
printf "" >> ~/.gitacc
printf "\n# git account switch\nsource ~/.git-acc\n" >> $profile
echo "$(cat ./logout.script)" >> $logout_profile

echo "Done!! Please logout"
