
#!/usr/bin/env bash

WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"

while true; do
    read -p "Do you want to install Zsh config? " yn
    case $yn in
        [Nn]* ) break;; 
        [Yy]* ) if test -e $HOME/.zshrc || test -L $HOME/.zshrc
                then
                    while true; do
                        read -p "$HOME/.zshrc already exists. Replace? " yn2
                        case $yn2 in
                            [Yy]* ) if test -e $HOME/.zshrc
                                    then
                                      while true; do
                                        read -p "Backup old version?" yn3
                                        case $yn3 in
                                            [Yy]* ) mv $HOME/.zshrc $HOME/.zshrc.backup; break ;;
                                            *) break;;
                                        esac
                                      done
                                    fi 
                                    ln -sfn $SOURCED/.zshrc $HOME/.zshrc
                                    echo "Created link to $HOME/.zshrc."; break;;
                            *) break;;
                        esac 
                    done
                else
                    ln -s $SOURCED/.zshrc $HOME/.zshrc
                    echo "Created link to $HOME/.zshrc."
                fi
                if test -e $HOME/.oh-my-zsh
                then echo "Oh my ZSH already installed"
                else
                    if which zsh
                    then
                        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
                        echo "Installed Oh-My-ZSH"
                        else
                            "Warning: ZSH not installed: please install and try again"
                        fi
                fi; break;;
        * ) echo "Please answer yes or no";;
    esac
done


