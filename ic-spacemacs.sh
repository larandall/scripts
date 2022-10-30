#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install spacemacs? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.spacemacs || test -L $HOME/.spacemacs
                then
                    while true; do
                        read -p "$HOME/.spacemacs already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.spacemacs
                                    then
                                       while true; do
                                           read -p "Backup old version?" yn3
                                           case $yn3 in
                                               [Yy]* ) mv $HOME/.spacemacs $HOME/.spacemacs.backup; break ;;
                                               *) break;;
                                           esac
                                       done
                                    fi
                                    ln -sf $SOURCED/.spacemacs $HOME/.spacemacs
                                    echo "Created link to $HOME/.spacemacs"; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/.spacemacs $HOME/.spacemacs
                    echo "Created link to $HOME/.spacemacs"
                fi
                if test -e $HOME/.spacemacs.d
                then
                    echo "Spacemacs folder already exists at $HOME/.spacemacs.d"
                else
                    git clone https://github.com/syl20bnr/spacemacs $HOME/.spacemacs.d
                    echo "Installed spacemacs to $HOME/.spacemacs.d"
                fi
                if test -e $HOME/.emacs.d || test -L $HOME/.emacs.d
                then
                    echo "$HOME/.emacs.d already exists, but may not be linked to spacemacs"
                    while true; do
                        read -p "Do you wish to replace? " yn4
                        case yn4 in
                            [Yy]* ) if test -L $HOME/.emacs.d
                                    then
                                        ln -sfn $HOME/.spacemacs.d $HOME/.emacs.d
                                    else
                                        mv $HOME/.emacs.d/ $HOME/.emacs.d.backup
                                        ln -sn $HOME/.spacemacs.d $HOME/.emacs.d
                                    fi
                                    echo "Spacemacs config fully installed."; break;;
                            *) break;;
                        esac
                    done
                else ln -s $HOME/.spacemacs.d $HOME/.emacs.d/
                     echo "Spacemacs config fully installed."
                fi
                if command -v  emacs > /dev/null 2>&1;
                then
                    echo "Emacs installed. Spacemacs Ready"
                else
                    echo "Install emacs to use spacemacs"
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done

if test -e $HOME/.spacemacs.d
then
    if test -L  $HOME/.spacemacs.d/private
    then
        echo ""
    else
        while true; do
            read -p "Do you want to install spacemacs custom layers? " yn
            case $yn in
                [Nn]* ) break;; 
                [Yy]* ) ln -sfn $SOURCED/spacemacs-private $HOME/.spacemacs.d/private
                        echo "Created link to $HOME/.spacemacs/private."; break ;;
                * ) echo "Please answer yes or no";;
            esac
        done
    fi
fi
