xrandr --output DP-1 --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-2 --off --output DP-3 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-4 --mode 1920x1080 --pos 5120x0 --rotate normal --scale 1.2x1.2
feh --bg-fill ~/Pictures/Wallpapers/dwm_dark.png
picom -I 1 -O 1 -e 1 &
flameshot &
dwm
