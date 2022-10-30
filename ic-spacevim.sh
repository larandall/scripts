#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

while true; do
    read -p "Do you want to install SpaceVim? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.SpaceVim.d || test -L $HOME/.SpaceVim.d
                then
                    while true; do
                        read -p "$HOME/.SpaceVim.d already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -d $HOME/.SpaceVim.d
                                    then
                                        while true; do
                                            read -p "Backup old version?" yn3
                                            case $yn3 in
                                                [Yy]* ) mv $HOME/.SpaceVim.d $HOME/.SpaceVim.d.backup; break ;;
                                                *) break;;
                                            esac
                                        done
                                    fi
                                    ln -sfn $SOURCED/SpaceVim.d $HOME/.SpaceVim.d
                                    echo "Created link to $HOME/.SpaceVim.d"; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/SpaceVim.d $HOME/.SpaceVim.d
                    echo "Created link to $HOME/.SpaceVim.d"
                fi
                if test -d $HOME/.SpaceVim
                then
                    echo "SpaceVim already installed"
                else
                    curl -sLf https://spacevim.org/install.sh | bash
                    echo "Installed SpaceVim"
                fi
                if command -v  vim > /dev/null 2>&1;
                then
                    echo "Vim installed. SpaceVim Ready"
                else
                    echo "Install vim to use spacevim"
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done
