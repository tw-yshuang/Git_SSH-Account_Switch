#!/usr/bin/env zsh

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
    profile=~/.zshrc
    logout_profile=~/.zlogout
    ;;
esac

match=$(grep -nF "$(cat ./logout.script)" $logout_profile | cut -f1 -d:)
if [ -n "$match" ]; then
    vi +"$(echo $match | head -n1),$(echo $match | tail -n1)d" +wq $logout_profile
fi

gitacc_config='# git account switch
source $HOME/.git-acc'
match=$(grep -nF "$gitacc_config" $profile | cut -f1 -d:)
if [ -n "$match" ]; then
    vi +"$(echo $match | head -n1),$(echo $match | tail -n1)d" +wq $profile
fi

if [ -f "$profile" ] && grep -q "# Auto-load default git account" "$profile" 2>/dev/null; then
    sed -i.bak "/# Auto-load default git account/,/^fi$/d" "$profile"
    rm -f "${profile}.bak"
fi

rm -f ~/.git-acc
rm -f ~/.gitacc