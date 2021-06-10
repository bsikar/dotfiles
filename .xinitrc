xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --mode 2560x1440 --pos 2560x0 --rotate normal --output DisplayPort-3 --mode 1920x1080 --pos 5120x0 --rotate normal
feh --bg-fill ~/Pictures/Wallpapers/dwm_dark.png
picom -I 1 -O 1 -e 1 &
flameshot &
dwm
