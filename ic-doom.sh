#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
FORCE="$1"

while true; do
    read -p "Do you want to install Doom Emacs? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.config/doom || test -L $HOME/.config/doom
                then
                    while true; do
                        read -p "$HOME/.config/doom already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.config/doom
                                    then
                                       while true; do
                                           read -p "Backup old version?" yn3
                                           case $yn3 in
                                               [Yy]* ) mv $HOME/.config/doom $HOME/.config/doom.backup; break ;;
                                               *) break;;
                                           esac
                                       done
                                    fi
                                    ln -sf $SOURCED/doom $HOME/.config/doom
                                    echo "Created link to $HOME/.config/doom"; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/doom $HOME/.config/doom
                    echo "Created link to $HOME/.config/doom"
                fi
                if test -e $HOME/.config/emacs
                then
                    echo "Doom Emacs folder already exists at $HOME/.config/emacs"
                else
                    git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.config/emacs
                    echo "Installed Doom Emacs to $HOME/.config/emacs"
                fi
                if test -e $HOME/.config/emacs || test -L $HOME/.config/emacs
                then
                    echo "$HOME/.config/emacs already exists, but may not be linked to Doom Emacs"
                    while true; do
                        read -p "Do you wish to replace? " yn4
                        case yn4 in
                            [Yy]* ) if test -L $HOME/.config/emacs
                                    then
                                        ln -sfn $HOME/.config/emacs $HOME/.config/emacs
                                    else
                                        mv $HOME/.config/emacs/ $HOME/.config/emacs.backup
                                        ln -sn $HOME/.config/emacs $HOME/.config/emacs
                                    fi
                                    echo "Doom Emacs config fully installed. Run doom install or doom sync."; break;;
                            *) break;;
                        esac
                    done
                else ln -sfn $HOME/.config/emacs $HOME/.config/emacs
                     echo "Doom Emacs config fully installed. Run doom install or doom sync."
                fi
                if command -v  emacs > /dev/null 2>&1;
                then
                    echo "Emacs installed. Run doom install or doom sync."
                else
                    echo "Install emacs to use Doom Emacs"
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
