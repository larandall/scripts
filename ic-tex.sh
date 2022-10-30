#!/usr/bin/env bash
WORKINGD=$PWD
SOURCED="$HOME/Dropbox/Resources/dotfiles"
BIBD="$HOME/Dropbox/bib/"
LATEXD="$HOME/Dropbox/Resources/latex/"
TEXHOME=`kpsewhich -var-value TEXMFHOME`
FORCE="$1"

if kpsewhich article.sty
   then
       while true; do
           read -p "Do you want to install bibliography files? " yn
           case $yn in
               [Nn]* ) break;; 
               [Yy]* ) if test -e $TEXHOME/bibtex/bib || test -L $TEXHOME/bibtex/bib

                       then echo ""
                       else
                           mkdir -p $TEXHOME/bibtex/bib
                       fi

                       if test -e $TEXHOME/bibtex/bib/mybib || test -L $TEXHOME/bibtex/bib/mybib
                       then
                           while true; do
                               read -p "$TEXHOME/bibtex/bib/mybib already exists. Replace? " yn2
                               case $yn2 in
                                   [Yy]* ) if test -e $TEXHOME/bibtex/bib/mybib
                                           then
                                               while true; do
                                                   read -p "Backup old version?" yn3
                                                   case $yn3 in
                                                       [Yy]* ) mv  $TEXHOME/bibtex/bib/mybib $TEXHOME/bibtex/bib/mybib.backup; break ;;
                                                       *) break;;
                                                   esac
                                               done
                                           fi 
                                           ln -sfn $BIBD/ $TEXHOME/bibtex/bib/mybib
                                           echo "Created link to $TEXHOME/bibtex/bib/mybib."; break;;
                                   *) break;;
                               esac 
                           done
                       else
                           ln -sfn $BIBD/mybib $TEXHOME/bibtex/bib/mybib
                           echo "Created link to $TEXHOME/bibtex/bib/mybib."
                       fi; break;;
               * ) echo "Please answer yes or no";;
           esac
       done

       while true; do
           read -p "Do you want to install additional latex files? " yn
           case $yn in
               [Nn]* ) break;;
               [Yy]* ) if test -e $TEXHOME/tex/latex || test -l $TEXHOME/tex/latex
                       then echo ""
                       else
                           mkdir $TEXHOME/tex/latex
                       fi

                       if test -e $TEXHOME/tex/latex/commonstuff || test -L $TEXHOME/tex/latex/commonstuff
                       then
                           while true; do
                               read -p "$TEXHOME/tex/latex/commonstuff already exists. Replace? " yn2
                               case $yn2 in
                                   [Yy]* ) if test -e $TEXHOME/tex/latex/commonstuff
                                           then
                                               while true; do
                                                   read -p "Backup old version?" yn3
                                                   case $yn3 in
                                                       [Yy]* ) mv  $TEXHOME/tex/latex/commonstuff $TEXHOME/tex/latex/commonstuff.backup; break ;;
                                                       *) break;;
                                                   esac
                                               done
                                           fi 
                                           ln -sfn $LATEXD/commonstuff $TEXHOME/tex/latex/commonstuff
                                           echo "Created link to $TEXHOME/tex/latex/commonstuff."; break;;
                                   *) break;;
                               esac 
                           done
                       else
                           ln -sfn $LATEXD/commonstuff $TEXHOME/tex/latex/commonstuff
                           echo "Created link to $TEXHOME/tex/latex/commonstuff."
                       fi; break;;
               * ) echo "Please answer yes or no";;
           esac
       done
       if kpsewhich MinionPro.sty
       then
          echo "Minion Pro already installed"
       else
           while true; do
               read -p "Do you want to install Minion Pro fonts? " yn
               case $yn in
                   [Nn]* ) break;;
                   [Yy]* ) $SOURCED/archminion.sh ; break ;;
                   * ) echo "Please answer yes or no"
               esac
           done
       fi
else
    echo "Please install latex to do any further installations."
fi
