#!/usr/bin/env bash

# if wmctrl -a "emacs"
# # then 
# #   wmctrl -a "emacs"
# then
#   echo "switching to frame"
# else
#   emacsclient -nca ""
# fi

if pgrep emacs > /dev/null
then
  case $(emacsclient -n -e '(> (length (frame-list)) 1)') in  nil)
    emacsclient -c -n -a ""
    # wmctrl -a emacs
    ;;  t)
    wmctrl -a emacs;; 
  esac
else
  emacsclient -c -n -a "" 
fi
