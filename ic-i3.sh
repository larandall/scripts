#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install i3 config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.config/i3 || test -L $HOME/.config/i3
                then
                    while true; do
                        read -p "$HOME/.config/i3 already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.config/i3
                                    then
                                      while true; do
                                        read -p "Backup old version?" yn3
                                        case $yn3 in
                                            [Yy]* ) mv $HOME/.config/i3 $HOME/.config/i3.backup; break ;;
                                            *) break;;
                                        esac
                                      done
                                    fi 
                                    ln -sfn $SOURCED/i3 $HOME/.config/i3
                                    echo "Created link to $HOME/.config/i3."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/i3 $HOME/.config/i3
                    echo "Created link to $HOME/.config/i3."
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
