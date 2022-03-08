#!/usr/bin/env bash
function Echo_Color(){
    case $1 in
        r* | R* )
        COLOR='\e[31m'
        ;;
        g* | G* )
        COLOR='\e[32m'
        ;;
        y* | Y* )
        COLOR='\e[33m'
        ;;
        b* | B* )
        COLOR='\e[34m'
        ;;
        *)
        echo "$COLOR Wrong COLOR keyword!\e[0m" 
        ;;
        esac
        echo -e "$COLOR$2\e[0m"
    }

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

gitacc_config='# git account switch
source $HOME/.git-acc'

cp ./git-acc.sh ~/.git-acc

if [ "$(grep -xn "$gitacc_config" $profile)" != "" ]; then
    Echo_Color g "You have already added git-acc config in $profile !!\nOnly update your git-acc!"
else
    printf "" >> ~/.gitacc
    printf "$gitacc_config\n" >> $profile
    echo "$(cat ./logout.script)" >> $logout_profile
fi

source $HOME/.git-acc
echo "Done!! Now can use! Enjoy~~~"
