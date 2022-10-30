#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"


while true; do
    read -p "Do you want to install tmux config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -d $HOME/.tmux.conf || test -L $HOME/.tmux.conf
                then
                    while true; do
                        read -p "$HOME/.tmux.conf already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -d $HOME/.tmux.conf
                                    then
                                        while true; do
                                            read -p "Backup old version?" yn3
                                            case $yn3 in
                                                [Yy]* ) mv $HOME/.tmux.conf $HOME/.tmux.conf.backup;
                                                        if test -e $HOME/.tmux.conf.local;
                                                        then mv $HOME/.tmux.conf.local $HOME/.tmux.conf.local.backup;
                                                        fi; break ;;
                                                *) break;;
                                            esac
                                        done
                                    fi
                                    ln -sfn $SOURCED/tmux/.tmux.conf $HOME/.tmux.conf
                                    ln -sfn $SOURCED/tmux/.tmux.conf.local $HOME/.tmux.conf.local
                                    echo "Created link to $HOME/.tmux.conf."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/tmux/.tmux.conf $HOME/.tmux.conf
                    ln -s $SOURCED/tmux/.tmux.conf.local $HOME/.tmux.conf.local
                    echo "Created link to $HOME/.tmux.conf."
                fi
                if command -v  tmux > /dev/null 2>&1;
                then
                    echo "Tmux installed. Config ready"
                else
                    echo "Install Tmux to use tmux config"
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
