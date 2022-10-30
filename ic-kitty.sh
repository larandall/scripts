#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install kitty config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.config/kitty || test -L $HOME/.config/kitty
                then
                    while true; do
                        read -p "$HOME/.config/kitty already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.config/kitty
                                    then
                                      while true; do
                                        read -p "Backup old version?" yn3
                                        case $yn3 in
                                            [Yy]* ) mv $HOME/.config/kitty $HOME/.config/kitty.backup; break ;;
                                            *) break;;
                                        esac
                                      done
                                    fi 
                                    ln -sfn $SOURCED/kitty $HOME/.config/kitty
                                    echo "Created link to $HOME/.config/kitty."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/kitty $HOME/.config/kitty
                    echo "Created link to $HOME/.config/kitty."
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
