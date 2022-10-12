#!/usr/bin/env zsh

# remove ~/.zlogout code that related with git-acc
match=$(grep -nF "$(cat ~/./logout.script)" ~/.zlogout | cut -f1 -d:)
vi +"$(echo $match | head -n1),$(echo $match | tail -n1)d" +wq ~/.zlogout

# remove ~/.zlogout code that related with git-acc
gitacc_config='# git account switch
source $HOME/.git-acc'
match=$(grep -nF $gitacc_config ~/.zshrc | cut -f1 -d:)
vi +"$(echo $match | head -n1),$(echo $match | tail -n1)d" +wq ~/.zlogout

# remove .git-acc .gitacc
rm ~/.git-acc
rm ~/.gitacc