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

gitacc_config="\n# git account switch\nsource ~/.git-acc\n"

cp ./git-acc.sh ~/.git-acc

if [ "$(grep -xn "$gitacc_config" $profile)" != "" ]; then
    Echo_Color g "You have already added git-acc config in $profile !!\nOnly update your git-acc!"
else
    printf "" >> ~/.gitacc
    echo $gitacc_config >> $profile
    echo "$(cat ./logout.script)" >> $logout_profile
fi

source $HOME/.git-acc
echo "Done!! Now can use! Enjoy~~~"
