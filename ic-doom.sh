#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install Doom Emacs? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.doom.d || test -L $HOME/.doom.d
                then
                    while true; do
                        read -p "$HOME/.doom.d already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.doom.d
                                    then
                                       while true; do
                                           read -p "Backup old version?" yn3
                                           case $yn3 in
                                               [Yy]* ) mv $HOME/.doom.d $HOME/.doom.d.backup; break ;;
                                               *) break;;
                                           esac
                                       done
                                    fi
                                    ln -sf $SOURCED/.doom.d $HOME/.doom.d
                                    echo "Created link to $HOME/.doom.d"; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/.doom.d $HOME/.doom.d
                    echo "Created link to $HOME/.doom.d"
                fi
                if test -e $HOME/.doomemacs.d
                then
                    echo "Doom Emacs folder already exists at $HOME/.doomemacs.d"
                else
                    git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.doomemacs.d
                    echo "Installed Doom Emacs to $HOME/.doomemacs.d"
                fi
                if test -e $HOME/.emacs.d || test -L $HOME/.emacs.d
                then
                    echo "$HOME/.emacs.d already exists, but may not be linked to Doom Emacs"
                    while true; do
                        read -p "Do you wish to replace? " yn4
                        case yn4 in
                            [Yy]* ) if test -L $HOME/.emacs.d
                                    then
                                        ln -sfn $HOME/.doomemacs.d $HOME/.emacs.d
                                    else
                                        mv $HOME/.emacs.d/ $HOME/.emacs.d.backup
                                        ln -sn $HOME/.doomemacs.d $HOME/.emacs.d
                                    fi
                                    echo "Doom Emacs config fully installed. Run doom install or doom sync."; break;;
                            *) break;;
                        esac
                    done
                else ln -sfn $HOME/.doomemacs.d $HOME/.emacs.d
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
