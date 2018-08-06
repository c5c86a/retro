#!/bin/bash 
#
# collects: a - b  - c
# current time like "Mon, 06 Aug 2018 01:16:27 +0300"
# {title} - {protocol}://{hostname}{port}/{path}/{args} - Google Chrome
#
# Requires:
# sudo apt-get install -y xprintidle xdotool
# chrome extension url in title with the above settings
# neovim configuration:
# " Limitations:
# " escape characters: http://vim.wikia.com/wiki/Automatically_set_screen_title
# " an ssh changes the title but an exit doesn't
# augroup termTitle
#   au!
#   autocmd BufEnter * let &titlestring = "%y %F"
#   autocmd BufEnter * set title
# augroup END

gather(){
  # milliseconds since last user interaction with keyboard or mouse
  msec_since_last_x=$(xprintidle)

  if [ "$msec_since_last_x" -lt "40" ]; then
    echo "$(date -R) - $(xdotool getwindowfocus getwindowname)" >> collected.txt
  fi
}

while :
do
  gather
  sleep 2
done
