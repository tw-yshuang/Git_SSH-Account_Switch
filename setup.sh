#!/usr/bin/env bash

function Echo_Color(){
    case $1 in
        r* | R* )
        COLOR='\033[0;31m'
        ;;
        g* | G* )
        COLOR='\033[0;32m'
        ;;
        y* | Y* )
        COLOR='\033[0;33m'
        ;;
        b* | B* )
        COLOR='\033[0;34m'
        ;;
        *)
        echo "$COLOR Wrong COLOR keyword!\033[0m" 
        ;;
        esac
        echo -e "$COLOR$2\033[0m"
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
    Echo_Color r "Unknown shell, need to manually add config on your shell profile!!"
    profile='unknown'
    logout_profile='unknown'
    ;;
esac

gitacc_config='# git account switch
source $HOME/.git-acc'

cp ./git-acc.sh ~/.git-acc

if [ "$profile" = "unknown" ]; then
    echo 'Paste the information down below to your profile:'
    Echo_Color y "$gitacc_config\n"
    
    echo 'Paste the information down below to your profile:'
    Echo_Color y "$(cat ./logout.script)\n"
else
    if [ "$(grep -xn "$gitacc_config" $profile)" != "" ]; then
        Echo_Color g "You have already added git-acc config in $profile !!\nOnly update your git-acc!"
    else
        printf "$gitacc_config\n" >> $profile
        echo "$(cat ./logout.script)" >> $logout_profile
    fi
fi

if ! [ -f ~/.gitacc ]; then
    printf "" >> ~/.gitacc
fi

exec $SHELL
echo "Done!! Now can use! Enjoy~~~"