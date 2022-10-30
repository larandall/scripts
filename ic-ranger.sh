#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install Ranger config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -d $HOME/.config/ranger || test -L $HOME/.config/ranger
                then
                    while true; do
                        read -p "$HOME/.config/ranger already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -d $HOME/.config/ranger
                                    then
                                        while true; do
                                        read -p "Backup old version?" yn3
                                        case $yn3 in
                                            [Yy]* ) mv $HOME/.config/ranger $HOME/.config/ranger.backup; break ;;
                                            *) break;;
                                        esac
                                        done
                                    fi
                                    ln -sfn $SOURCED/ranger $HOME/.config/ranger
                                    echo "Created link to $HOME/.config/ranger."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/ranger $HOME/.config/ranger
                    echo "Created link to $HOME/.config/ranger."
                fi
                if command -v  ranger > /dev/null 2>&1;
                then
                    echo "Ranger installed. Config ready"
                else
                    echo "Install ranger to use ranger config"
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
