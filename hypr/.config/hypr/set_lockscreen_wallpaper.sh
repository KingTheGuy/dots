#!/bin/bash

WALLPAPER=$(tail -n1 ~/.eww_wallpaper)

config=" \n
background {\n
    monitor =\n
    path = $WALLPAPER # supports png, jpg, webp (no animations, though)\n
    color = rgba(25, 20, 20, 1.0)
    \n
    # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations\n
    blur_passes = 2 # 0 disables blurring\n
    blur_size = 3\n
    noise = 0.0117\n
    contrast = 0.8916\n
    brightness = 0.3172\n
    vibrancy = 0.1696\n
    vibrancy_darkness = 0.0\n
}\n
general {\n
    hide_cursor = true\n
}
\n
label {\n
    monitor =\n
    text = cmd[update:1000] echo "$(date +%I)\n∙∙\n$(date +%M)\n∙∙\n$(date +%S)" \n
    # color = rgba(200, 200, 200, 1.0)\n
    color = rgba(235, 249, 221, 1)\n
    font_size = 14\n
    font_family = Share Tech Mono
    \n
    position = 50, 0\n
    halign = left\n
    valign = center\n
}\n
label {\n
    monitor =\n
    text = cmd[update:5000] echo "$(date +"%r" | cut -d ' ' -f2)"\n
    # color = rgba(200, 200, 200, 1.0)\n
    color = rgba(235, 249, 221, 1)\n
    font_size = 14\n
    font_family = Share Tech Mono
    \n
    position = 50, -85\n
    halign = left\n
    valign = center\n
}
\n
label {\n
    monitor =\n
    text = cmd[update:5000] echo "$(date +%m)\n——\n$(date +%d)\n——\n$(date +%g)"  \n
    # color = rgba(200, 200, 200, 1.0)\n
    color = rgba(235, 249, 221, 1)\n
    font_size = 14\n
    font_family = Share Tech Mono
    \n
    position = -50, 0\n
    halign = right\n
    valign = center\n
}\n
label {\n
    monitor =\n
    text = cmd[update:5000] echo "$(date +%a)"\n
    # color = rgba(200, 200, 200, 1.0)\n
    color = rgba(235, 249, 221, 1)\n
    font_size = 14\n
    font_family = Share Tech Mono
    \n
    position = -45, -85\n
    halign = right\n
    valign = center\n
}
\n
label {\n
    monitor =\n
    text = $USER\n
    # color = rgba(200, 200, 200, 1.0)\n
    color = rgba(235, 249, 221, 1)\n
    font_size = 20\n
    font_family = Share Tech Mono
    \n
    position = 0, 80\n
    halign = center\n
    valign = center\n
}
\n
input-field {\n
    monitor =\n
    size = 10%, 10%\n
    outline_thickness = 3\n
    inner_color = rgba(0, 0, 0, 0.0) # no fill
    \n
    # outer_color = rgba(33ccffee) rgba(00ff99ee) 45deg\n
    outer_color = rgba(0, 0, 0, 0.0) # no fill\n
    # check_color = rgba(250, 250, 250, 0.5) # no fill\n
    check_color = rgba(235, 249, 221, 1)\n
    # check_color = rgba(00ff99ee) rgba(ff6633ee) 120deg\n
    # fail_color = rgba(250, 250, 250, 0.5) # no fill\n
    fail_color = rgba(235, 249, 221, 1)\n
    # fail_color = rgba(ff6633ee) rgba(ff0066ee) 40deg
    \n
    font_family = Share Tech Mono\n
    # font_color = rgb(143, 143, 143)\n
    font_color = rgba(235, 249, 221, 1)\n
    fade_on_empty = false\n
    placeholder_text = locked\n
    rounding = 15
    \n
    position = 0, -20\n
    halign = center\n
    valign = center\n
}\n
"

echo -e $config > /tmp/hyprlock.conf


if [[ $1 == "suspend" ]]; then
    hyprlock -c /tmp/hyprlock.conf &
    sleep 1
    loginctl suspend
else
    hyprlock -c /tmp/hyprlock.conf
fi
