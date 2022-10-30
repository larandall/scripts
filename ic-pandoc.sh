#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install pandoc config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.pandoc || test -L $HOME/.pandoc
                then
                    while true; do
                        read -p "$HOME/.pandoc already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.pandoc
                                    then
                                      while true; do
                                        read -p "Backup old version?" yn3
                                        case $yn3 in
                                            [Yy]* ) mv $HOME/.pandoc $HOME/.pandoc.backup; break ;;
                                            *) break;;
                                        esac
                                      done
                                    fi 
                                    ln -sfn $SOURCED/.pandoc $HOME/.pandoc
                                    echo "Created link to $HOME/.pandoc."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/.pandoc $HOME/.pandoc
                    echo "Created link to $HOME/.pandoc."
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
