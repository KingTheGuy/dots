#!/bin/bash
# grep "^Super" autostart \
#     | sed 's/-\(-\w\+\)\+//g;s/$mod/Win/g;s/Mod1/Alt/g;s/exec //;s/bindsym //;s/^\s\+//;s/^\([^ ]\+\) \(.\+\)$/\2: \1/;s/^\s\+//' \
#     | tr -s ' ' \
#     | rofi -dmenu

# cat autostart | grep keybind | rofi -demnu

# cat autostart | grep -v -e "#" \
#   | grep keybind \
#   | cut -d 'keybind' -f '1' \
#   | rofi -dmenu

# cat autostart | grep keybind \
#   | awk -F"keybind " '{print $2}' \
#   | rofi -dmenu

# herbstclient list_keybinds | rofi -dmenu

herbstclient list_keybinds | sed "s/\<Mod4\>/Super/g" \
  | rofi -dmenu
